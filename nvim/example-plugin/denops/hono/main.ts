import { Denops } from "https://deno.land/x/denops_std@v5.2.0/mod.ts";

import { Hono } from "https://deno.land/x/hono@v3.11.12/mod.ts";
import { getContent } from "./pages.tsx";

// import { open } from "https://deno.land/x/open@v0.0.6/index.ts";

export async function main(denops: Denops): Promise<void> {
  let server: Deno.HttpServer | null;

  denops.dispatcher = {
    async test() {
      const line = await denops.call("getbufline", 1, 1, "$") as string[];
      console.log(line);
    },

    async hono() {
      const app = new Hono();
      app.get("/", async (c) => {
        // const { response, socket } = Deno.upgradeWebSocket(
        //   c.req as unknown as Request,
        // );
        // socket.addEventListener("message", (e) => console.log(e));

        const line = await denops.call("getbufline", 1, 1, "$") as string[];

        // const content = "<h1>Hello Deno!</h1>" +
        //   line.map((element) => `<p>${element}</p>`).join("");

        return c.html(
          // content,
          getContent(line),
        );
      });
      app.get("*", (c) => c.redirect("/"));

      const port = 8000;
      const hostname = "127.0.0.1";
      if (server) {
        await server.shutdown();
        server = null;
      }
      server = Deno.serve({
        port: port,
        hostname: hostname,
      }, app.fetch);
      // open(`http://${hostname}:${port}`);
    },
  };

  const n = denops.name;
  await denops.cmd(
    `command! DenopsHono call denops#notify("${n}", "hono", [])`,
  );
  await denops.cmd(
    `command! DenopsTest call denops#notify("${n}", "test", [])`,
  );
}
