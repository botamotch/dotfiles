/** @jsx jsx */
import { jsx } from "https://deno.land/x/hono@v3.11.12/middleware.ts";
import { Hono } from "https://deno.land/x/hono@v3.11.12/mod.ts";

const app = new Hono();

// app.get("/", (c) => {
//   const content = <h1>Hello Deno!</h1>;
//   return c.html(
//     content,
//   );
// });
// app.get("*", (c) => c.redirect("/"));

// app.get("/hono", (c) => c.text("Hono!"));
// app.get(
//   "/",
//   // serveStatic({ path: join(basePath, "static/demo/index.html") }),
//   serveStatic({ path: basePath + "static/demo/index.html" }),
// );
// // app.get("/path", (c) => c.text(import.meta.url));

// app.get("*", serveStatic({ path: "./static/fallback.html" }));

function getContent(lines: string[]) {
  return (
    <html>
      <head>
        <title>Hello Hono!</title>
        <script src="https://cdn.tailwindcss.com"></script>
      </head>
      <body>
        <div class="h-full w-full bg-slate-100">
          <div class="max-w-screen-md mx-auto">
            <h1 class="text-3xl font-bold underline">Hello Hono!</h1>
            <div>
              {lines.map((element) => <p>{element}</p>)}
            </div>
          </div>
        </div>
      </body>
    </html>
  );
  // return <h1>Hello Deno!</h1>;
}

export { app, getContent };
