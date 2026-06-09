export interface DispositionUserSummary {
  id: string;
  name: string;
  email: string;
  role: string;
  isActive: boolean;
}

export interface DispositionWorkOrderSummary {
  id: string;
  orderNumber: string;
  title: string;
  status: string;
  priority: string;
  type: string;
  scheduledStart: string | null;
  scheduledEnd: string | null;
  assignedUserId: string | null;
  assignedUserName: string | null;
  customerName: string;
  objectName: string;
  address: string;
  city: string;
  isOverdue: boolean;
}

export interface DispositionSnapshot {
  generatedAt: string;
  tenantId: string;
  user: {
    id: string;
    email: string;
    role: string;
  };
  metrics: {
    total: number;
    open: number;
    scheduled: number;
    inProgress: number;
    completed: number;
    overdue: number;
    unassigned: number;
  };
  technicians: DispositionUserSummary[];
  workOrders: DispositionWorkOrderSummary[];
}

export interface UpdateDispositionWorkOrderRequest {
  assignedUserId?: string | null;
  scheduledStart?: string | null;
  scheduledEnd?: string | null;
  status?: string;
  priority?: string;
}
