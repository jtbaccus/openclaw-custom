import type { OpenClawConfig } from "../../config/config.js";
import type { GroupToolPolicySender } from "../../config/group-policy.js";
import {
  resolveChannelGroupRequireMention,
  resolveChannelGroupToolsPolicy,
} from "../../config/group-policy.js";

type MentionParams = {
  cfg: OpenClawConfig;
  groupId?: string | null;
  accountId?: string | null;
  requireMentionOverride?: boolean;
  overrideOrder?: "before-config" | "after-config";
};

type ToolPolicyParams = {
  cfg: OpenClawConfig;
  groupId?: string | null;
  accountId?: string | null;
} & GroupToolPolicySender;

export function resolveDiscordGroupRequireMention(params: MentionParams): boolean {
  return resolveChannelGroupRequireMention({ ...params, channel: "discord" });
}

export function resolveDiscordGroupToolPolicy(params: ToolPolicyParams) {
  return resolveChannelGroupToolsPolicy({ ...params, channel: "discord" });
}

export function resolveTelegramGroupRequireMention(params: MentionParams): boolean {
  return resolveChannelGroupRequireMention({ ...params, channel: "telegram" });
}

export function resolveTelegramGroupToolPolicy(params: ToolPolicyParams) {
  return resolveChannelGroupToolsPolicy({ ...params, channel: "telegram" });
}
