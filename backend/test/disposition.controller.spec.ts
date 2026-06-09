import { Response } from "express";

import { DispositionController } from "../src/disposition/disposition.controller";
import { DispositionService } from "../src/disposition/disposition.service";

function responseMock() {
  return {
    type: jest.fn().mockReturnThis(),
    send: jest.fn().mockReturnThis(),
  } as unknown as Response & {
    type: jest.Mock;
    send: jest.Mock;
  };
}

describe("DispositionController", () => {
  it("serves the dispatcher portal html", () => {
    const controller = new DispositionController({} as DispositionService);
    const response = responseMock();

    controller.index(response);

    expect(response.type).toHaveBeenCalledWith("html");
    expect(response.send).toHaveBeenCalledWith(
      expect.stringContaining("<title>Kaminfeger Disposition</title>"),
    );
  });

  it("forwards snapshot requests with tenant and authenticated user", async () => {
    const service = {
      snapshot: jest.fn().mockResolvedValue({ metrics: { total: 0 } }),
    } as unknown as DispositionService;
    const controller = new DispositionController(service);
    const user = {
      id: "dispatcher-1",
      tenantId: "tenant-1",
      email: "dispatcher@example.invalid",
      role: "dispatcher",
    };

    await expect(controller.snapshot("tenant-1", user)).resolves.toEqual({
      metrics: { total: 0 },
    });
    expect(service.snapshot).toHaveBeenCalledWith("tenant-1", user);
  });
});
