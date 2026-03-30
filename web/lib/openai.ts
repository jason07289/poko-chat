import OpenAI from "openai";

/**
 * OpenAI 호출은 Route Handler 등 서버에서만 사용한다.
 * Responses API·function calling 연동은 이 클라이언트를 확장하면 된다.
 */
export function getOpenAI(): OpenAI {
  const apiKey = process.env.OPENAI_API_KEY;
  if (!apiKey) {
    throw new Error("OPENAI_API_KEY is not set");
  }
  return new OpenAI({ apiKey });
}
