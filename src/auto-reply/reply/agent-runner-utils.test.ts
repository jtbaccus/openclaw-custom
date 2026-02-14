import { describe, expect, it } from "vitest";
import type { OpenClawConfig } from "../../config/config.js";
import type { TemplateContext } from "../templating.js";
import { buildThreadingToolContext } from "./agent-runner-utils.js";

describe("buildThreadingToolContext", () => {
  const cfg = {} as OpenClawConfig;

  it("uses the recipient id for Telegram", () => {
    const sessionCtx = {
      Provider: "telegram",
      From: "user:42",
      To: "chat:99",
    } as TemplateContext;

    const result = buildThreadingToolContext({
      sessionCtx,
      config: cfg,
      hasRepliedRef: undefined,
    });

    expect(result.currentChannelId).toBe("chat:99");
  });

  it("uses the recipient id for Discord", () => {
    const sessionCtx = {
      Provider: "discord",
      From: "user:123",
      To: "channel:456",
    } as TemplateContext;

    const result = buildThreadingToolContext({
      sessionCtx,
      config: cfg,
      hasRepliedRef: undefined,
    });

    expect(result.currentChannelId).toBe("channel:456");
  });
});
