import { Request } from "express";

export interface RequestUser {
  id: string;
  tenantId: string;
  email: string;
  role: "admin" | "dispatcher" | "technician" | string;
}

export interface AuthenticatedRequest extends Request {
  user?: RequestUser;
  tenantId?: string;
}
