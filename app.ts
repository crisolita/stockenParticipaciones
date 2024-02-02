import express, { Express, NextFunction, Request, Response } from "express";
import dotenv from "dotenv";
import cors from "cors";
// import morgan from "morgan";
import { PrismaClient } from "@prisma/client";
import cuentasParticipes from "./routes/cuentasParticipes";
import notasConvertibles from "./routes/notasConvertibles";

import bodyParser from "body-parser";

const prisma = new PrismaClient();
const app: Express = express();
const port = process.env.PORT || 3001;

app.use(cors());
// app.use(morgan("tiny"));
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());

app.use((req: Request, res: Response, next: NextFunction) => {
  // @ts-ignore
  req.prisma = prisma;
  next();
});

app.use("/cuentas_participes", cuentasParticipes);
app.use("/notas_convertibles", notasConvertibles);

app.use((err: any, req: any, res: any, next: any) => {
  if (err && err.error && err.error.isJoi) {
    // we had a joi error, let's return a custom 400 json response
    res.status(400).json({
      error: err.error.details[0].message,
    });
  } else {
    // pass on to another error handler
    next(err);
  }
});

app.get("/", (req: Request, res: Response) => res.type("html").send(html));
app.get("/health", (req: Request, res: Response, NextFunction) => {
  const healthcheck = {
    uptime: process.uptime(),
    message: "OK",
    timestamp: Date.now(),
  };
  try {
    res.send(healthcheck);
  } catch (error) {
    //@ts-ignore
    healthcheck.message = error;
    res.status(503).send();
  }
});

// Start the server
const server = app.listen(port, () => {
  console.log(`Stocken accounts listening on port ${port}!`);
});

// Graceful shutdown
const handleExit = async (signal: string) => {
  console.log(`Received ${signal}. Closing server now.`);
  await prisma.$disconnect(); // Disconnect Prisma
  server.close(() => {
    console.log("HTTP server closed.");
    process.exit(0);
  });
};

process.on("SIGINT", handleExit);
process.on("SIGTERM", handleExit);

const html = `
<!DOCTYPE html>
<html>
  <head>
    <title>Hello from Render!</title>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js"></script>
    <script>
      setTimeout(() => {
        confetti({
          particleCount: 100,
          spread: 70,
          origin: { y: 0.6 },
          disableForReducedMotion: true
        });
      }, 500);
    </script>
    <style>
      @import url("https://p.typekit.net/p.css?s=1&k=vnd5zic&ht=tk&f=39475.39476.39477.39478.39479.39480.39481.39482&a=18673890&app=typekit&e=css");
      @font-face {
        font-family: "neo-sans";
        src: url("https://use.typekit.net/af/00ac0a/00000000000000003b9b2033/27/l?primer=7cdcb44be4a7db8877ffa5c0007b8dd865b3bbc383831fe2ea177f62257a9191&fvd=n7&v=3") format("woff2"), url("https://use.typekit.net/af/00ac0a/00000000000000003b9b2033/27/d?primer=7cdcb44be4a7db8877ffa5c0007b8dd865b3bbc383831fe2ea177f62257a9191&fvd=n7&v=3") format("woff"), url("https://use.typekit.net/af/00ac0a/00000000000000003b9b2033/27/a?primer=7cdcb44be4a7db8877ffa5c0007b8dd865b3bbc383831fe2ea177f62257a9191&fvd=n7&v=3") format("opentype");
        font-style: normal;
        font-weight: 700;
      }
      html {
        font-family: neo-sans;
        font-weight: 700;
        font-size: calc(62rem / 16);
      }
      body {
        background: white;
      }
      section {
        border-radius: 1em;
        padding: 1em;
        position: absolute;
        top: 50%;
        left: 50%;
        margin-right: -50%;
        transform: translate(-50%, -50%);
      }
    </style>
  </head>
  <body>
    <section>
      Hello from Render!
    </section>
  </body>
</html>
`;
