import type { NextConfig } from "next";
import path from "path";

const nextConfig: NextConfig = {
  // 상위 디렉터리에 다른 lockfile이 있을 때 워크스페이스 루트 추론 경고를 줄인다.
  turbopack: {
    root: path.join(__dirname),
  },
};

export default nextConfig;
