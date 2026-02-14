// Gateway diagnostics — systemd journal is the primary log source on Linux.
// The launchd-based log path resolver has been removed (macOS not supported).

export async function readLastGatewayErrorLine(_env: NodeJS.ProcessEnv): Promise<string | null> {
  // On Linux, gateway logs go to systemd journal; reading them requires journalctl.
  // Return null — callers already handle this gracefully.
  return null;
}
