import { RequestUser } from "../src/common/types/request-user";
import { PushController } from "../src/push/push.controller";
import { PushService } from "../src/push/push.service";

const user: RequestUser = {
  id: "technician-1",
  tenantId: "tenant-1",
  email: "tech@example.invalid",
  role: "technician",
};

describe("PushController", () => {
  it("forwards device token registration to the push service", async () => {
    const service = {
      registerDeviceToken: jest.fn().mockResolvedValue({ id: "token-1" }),
      revokeDeviceToken: jest.fn(),
    } as unknown as PushService;
    const controller = new PushController(service);

    await expect(
      controller.register("tenant-1", user, {
        token: "fcm-token",
        platform: "ios",
      }),
    ).resolves.toEqual({ id: "token-1" });

    expect(service.registerDeviceToken).toHaveBeenCalledWith("tenant-1", user, {
      token: "fcm-token",
      platform: "ios",
    });
  });

  it("forwards device token revocation to the push service", async () => {
    const service = {
      registerDeviceToken: jest.fn(),
      revokeDeviceToken: jest.fn().mockResolvedValue({ revoked: 1 }),
    } as unknown as PushService;
    const controller = new PushController(service);

    await expect(
      controller.revoke("tenant-1", user, { token: "fcm-token" }),
    ).resolves.toEqual({ revoked: 1 });

    expect(service.revokeDeviceToken).toHaveBeenCalledWith("tenant-1", user, {
      token: "fcm-token",
    });
  });
});
