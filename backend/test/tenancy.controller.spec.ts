import { RequestUser } from "../src/common/types/request-user";
import { TenancyController } from "../src/tenancy/tenancy.controller";
import { TenancyService } from "../src/tenancy/tenancy.service";

const admin: RequestUser = {
  id: "admin-1",
  tenantId: "tenant-1",
  email: "admin@example.invalid",
  role: "admin",
};

describe("TenancyController", () => {
  it("forwards public tenant signup requests", async () => {
    const service = {
      signup: jest.fn().mockResolvedValue({ tenant: { id: "tenant-1" } }),
      current: jest.fn(),
      updateCurrent: jest.fn(),
    } as unknown as TenancyService;
    const controller = new TenancyController(service);
    const body = {
      tenantName: "Keller Kaminfeger",
      adminEmail: "ada@example.invalid",
      adminPassword: "admin1234",
    };

    await expect(controller.signup(body)).resolves.toEqual({
      tenant: { id: "tenant-1" },
    });
    expect(service.signup).toHaveBeenCalledWith(body);
  });

  it("forwards current tenant reads with the authenticated tenant id", async () => {
    const service = {
      signup: jest.fn(),
      current: jest.fn().mockResolvedValue({ id: "tenant-1" }),
      updateCurrent: jest.fn(),
    } as unknown as TenancyService;
    const controller = new TenancyController(service);

    await expect(controller.current("tenant-1")).resolves.toEqual({
      id: "tenant-1",
    });
    expect(service.current).toHaveBeenCalledWith("tenant-1");
  });

  it("forwards tenant profile updates with the current user", async () => {
    const service = {
      signup: jest.fn(),
      current: jest.fn(),
      updateCurrent: jest.fn().mockResolvedValue({ id: "tenant-1" }),
    } as unknown as TenancyService;
    const controller = new TenancyController(service);

    await expect(
      controller.updateCurrent("tenant-1", admin, { name: "New Name" }),
    ).resolves.toEqual({ id: "tenant-1" });

    expect(service.updateCurrent).toHaveBeenCalledWith("tenant-1", admin, {
      name: "New Name",
    });
  });
});
