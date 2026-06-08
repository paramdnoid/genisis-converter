type RawEnv = Record<string, string | undefined>;

export interface BackendEnvironment {
  NODE_ENV: string;
  PORT: number;
  DATABASE_URL: string;
  JWT_ISSUER: string;
  JWT_ACCESS_SECRET: string;
  JWT_REFRESH_SECRET: string;
  JWT_ACCESS_TTL: string;
  JWT_REFRESH_TTL: string;
  UPLOAD_BASE_URL: string;
  LOCAL_UPLOAD_DIR: string;
}

export function envValidation(env: RawEnv): BackendEnvironment {
  const required = ["DATABASE_URL", "JWT_ACCESS_SECRET", "JWT_REFRESH_SECRET"];
  for (const key of required) {
    if (!env[key]) {
      throw new Error(`Missing required backend environment variable: ${key}`);
    }
  }

  return {
    NODE_ENV: env.NODE_ENV ?? "development",
    PORT: Number(env.PORT ?? 3000),
    DATABASE_URL: env.DATABASE_URL ?? "",
    JWT_ISSUER: env.JWT_ISSUER ?? "kaminfeger-local",
    JWT_ACCESS_SECRET: env.JWT_ACCESS_SECRET ?? "",
    JWT_REFRESH_SECRET: env.JWT_REFRESH_SECRET ?? "",
    JWT_ACCESS_TTL: env.JWT_ACCESS_TTL ?? "15m",
    JWT_REFRESH_TTL: env.JWT_REFRESH_TTL ?? "30d",
    UPLOAD_BASE_URL:
      env.UPLOAD_BASE_URL ?? "http://localhost:3000/files/upload",
    LOCAL_UPLOAD_DIR: env.LOCAL_UPLOAD_DIR ?? "./uploads",
  };
}
