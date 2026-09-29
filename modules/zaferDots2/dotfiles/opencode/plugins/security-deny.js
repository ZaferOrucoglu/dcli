// security-deny — global deterministic deny hook (tum projelerde gecerli)
// V1 + V2 cifte seklin export: calisan surum V2 oldugu icin `setup`,
// eski V1 calistiricilar icin `server` ayni kurallari uygular.
// Throw = deny. Asla auto-allow yok. Degisiklikten sonra opencode'u restart et.

const EXFIL_HOSTS = [
  "pastebin.com",
  "transfer.sh",
  "ngrok.io",
  "ngrok-free.app",
  "ngrok.com",
  "webhook.site",
  "pipedream.net",
  "requestbin.com",
  "request catcher",
  "oastify.com",
  "burpcollaborator.net",
  "interact.sh",
  "canarytokens.com",
];

const SECRET_PATHS = ["/.ssh/", "/.gnupg/", "api.txt", ".claude.json", "opencode/auth.json"];

function containsSecretPath(s) {
  if (!s) return false;
  const low = String(s).toLowerCase();
  return SECRET_PATHS.some((p) => low.includes(p.toLowerCase()));
}

function containsExfilHost(s) {
  if (!s) return false;
  const low = String(s).toLowerCase();
  return EXFIL_HOSTS.some((h) => low.includes(h.toLowerCase()));
}

function checkBash(cmd) {
  if (!cmd || typeof cmd !== "string") return;
  const c = cmd;
  const low = c.toLowerCase();

  // 1. Downloader -> veri yolu: shell'den curl/wget yasak, webfetch kullan.
  if (/(^|[\s;&|(`$])curl[\s-]/.test(low) || low.includes("curl ") || low === "curl")
    throw new Error(
      "DENY: bash curl blocked. Use webfetch tool so URL permission applies. Raw curl in shell is forbidden.",
    );
  if (/(^|[\s;&|(`$])wget[\s-]/.test(low) || low.includes("wget ") || low === "wget")
    throw new Error("DENY: bash wget blocked. Use webfetch tool.");
  if (/(^|[\s;&|(`$])(aria2c|axel)[\s ]/.test(low)) throw new Error("DENY: downloader binary blocked.");

  // 2. Pipe to shell: | sh, | bash, curl ... | ...
  if (/\|\s*(sh|bash|dash|zsh|fish)(\s|$|;|&|\|)/.test(low))
    throw new Error("DENY: pipe-to-shell blocked (curl | sh pattern).");
  if ((low.includes("curl") || low.includes("wget")) && low.includes("|"))
    throw new Error("DENY: downloader piped to another command blocked.");

  // 3. python -c (tek satirlik decoder bypass'i)
  if (/python3?\s+.*-c(\s|$|=)/.test(low) || /python3?\s*-c(\s|$)/.test(low))
    throw new Error(
      "DENY: python -c blocked. Write a script file to /tmp/opencode-scratch and run it with a clean interpreter instead.",
    );

  // 4. chmod +x (indirilen payload'i calistirilabilir yapma)
  if (/chmod[^&|;]*\+x/.test(low)) throw new Error("DENY: chmod +x blocked.");

  // 5. Arsiv acma (zip slip / struct.py golgeleme yolu)
  if (/(^|[\s;&|])(unzip|unrar|7z)(\s|$)/.test(low))
    throw new Error(
      "DENY: archive extraction in main workspace blocked. Send archives to isolated container/VM for review.",
    );
  if (/tar\s+[^&|;]*[xX]/.test(low)) throw new Error("DENY: tar extraction blocked in main workspace.");
  if (/bsdtar\s+[^&|;]*[xX]/.test(low)) throw new Error("DENY: bsdtar extraction blocked.");

  // 6. Shell uzerinden bypass + config kacis kapaklari
  if (/opencode\s+.*--auto/.test(low)) throw new Error("DENY: nested opencode --auto blocked in shell.");
  if (
    low.includes("opencode_config_content") ||
    low.includes("opencode_config=") ||
    low.includes("opencode_disable_project_config") ||
    low.includes("opencode_pure")
  )
    throw new Error("DENY: OPENCODE_* config escape via shell blocked.");

  // 7. Shell uzerinden sizdirma host'u (downloader adi gizlenmis olsa bile)
  if (containsExfilHost(c)) throw new Error("DENY: exfil host blocked in shell.");

  // 8. Shell'den cat/head ile secret okuma
  if (
    containsSecretPath(c) &&
    /(^|[\s;&|])(cat|head|tail|less|more|strings|xxd|base64|head)(\s|$)/.test(low)
  )
    throw new Error("DENY: reading secrets via shell blocked.");
}

function checkWebfetch(args) {
  const s = JSON.stringify(args ?? {});
  if (containsExfilHost(s)) throw new Error("DENY: exfil host blocked in webfetch.");
  // Bilinmeyen host'a sessiz allow yok: permission.webfetch=ask prompt'a duser.
}

function checkFileTool(tool, args) {
  const p = args.filePath ?? args.path ?? args.file ?? JSON.stringify(args);
  if (containsSecretPath(String(p))) throw new Error(`DENY: secret path blocked for ${tool}: ${p}`);
}

function guardToolCall(toolName, args) {
  const tool = String(toolName ?? "").toLowerCase();
  const a = args ?? {};
  if (tool === "bash") {
    checkBash(String(a.command ?? a.cmd ?? JSON.stringify(a)));
    return;
  }
  if (tool === "webfetch" || tool === "websearch") {
    checkWebfetch(a);
    return;
  }
  if (tool === "read" || tool === "edit" || tool === "write" || tool === "patch") {
    checkFileTool(tool, a);
  }
  // task: subagent_depth=1 + agent.permission.task kurallari gecerli, burada ek kisit yok.
}

// V1 entrypoint (1.18.29+ obje seklini destekler)
async function server() {
  return {
    "tool.execute.before": async (input, output) => {
      guardToolCall(input.tool, output.args);
    },
  };
}

// V2 entrypoint (aktif calistirici bu)
async function setup(ctx) {
  await ctx.tool.hook("execute.before", (event) => {
    guardToolCall(event.tool, event.input);
  });
}

export default {
  id: "security-deny",
  setup,
  server,
};
