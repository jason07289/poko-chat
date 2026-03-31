import OpenAI from "openai";
import type {
  Response,
  ResponseFunctionToolCall,
  ResponseInput,
  ResponseInputItem,
} from "openai/resources/responses/responses";
import type { SupabaseClient } from "@supabase/supabase-js";

import { CHAT_SYSTEM_INSTRUCTIONS, DEFAULT_CHAT_MODEL } from "./constants";
import { executeHabitatTool } from "./dispatch";
import { HABITAT_FUNCTION_TOOLS } from "./tool-definitions";

export type ChatTurn = { role: "user" | "assistant"; content: string };

function isFunctionCall(item: unknown): item is ResponseFunctionToolCall {
  return (
    typeof item === "object" &&
    item !== null &&
    (item as { type?: string }).type === "function_call"
  );
}

function extractAssistantText(response: Response): string {
  if (response.output_text?.trim()) {
    return response.output_text;
  }
  for (const item of response.output ?? []) {
    if (item.type === "message" && item.role === "assistant") {
      for (const c of item.content ?? []) {
        if (c.type === "output_text") return c.text;
        if (c.type === "refusal") return c.refusal;
      }
    }
  }
  return "";
}

export async function runHabitatChat(
  openai: OpenAI,
  supabase: SupabaseClient,
  messages: ChatTurn[],
  model = process.env.OPENAI_CHAT_MODEL?.trim() || DEFAULT_CHAT_MODEL,
): Promise<{ reply: string; responseId: string }> {
  const input: ResponseInput = messages.map(
    (m): ResponseInputItem => ({
      role: m.role,
      content: m.content,
    }),
  );

  let response = await openai.responses.create({
    model,
    instructions: CHAT_SYSTEM_INSTRUCTIONS,
    input,
    tools: HABITAT_FUNCTION_TOOLS,
    tool_choice: "auto",
    // previous_response_id 로 이어 붙이려면 응답이 서버에 저장되어야 함 (store: false 이면 400 not found)
    store: true,
  });

  const maxSteps = 8;
  for (let step = 0; step < maxSteps; step++) {
    if (response.error) {
      throw new Error(response.error.message ?? "OpenAI response error");
    }

    const calls = (response.output ?? []).filter(isFunctionCall);
    if (calls.length === 0) {
      const reply = extractAssistantText(response);
      return { reply, responseId: response.id };
    }

    const outputs: ResponseInputItem[] = [];
    for (const call of calls) {
      const result = await executeHabitatTool(
        supabase,
        call.name,
        call.arguments,
      );
      outputs.push({
        type: "function_call_output",
        call_id: call.call_id,
        output: JSON.stringify(result),
      });
    }

    response = await openai.responses.create({
      model,
      previous_response_id: response.id,
      input: outputs,
      tools: HABITAT_FUNCTION_TOOLS,
      tool_choice: "auto",
      store: true,
    });
  }

  return {
    reply:
      extractAssistantText(response) ||
      "도구 호출이 반복 한도에 도달했습니다. 질문을 나눠 주세요.",
    responseId: response.id,
  };
}
