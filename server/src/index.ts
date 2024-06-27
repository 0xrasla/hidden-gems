// @ts-ignore
import cors from "@elysiajs/cors";
import { swagger } from "@elysiajs/swagger";
import { Elysia } from "elysia";
import { Logestic } from "logestic";
import mongoose from "mongoose";
import baseRouter from "./routes/router";

const app = new Elysia();

// @ts-ignore
app.use(cors());

try {
  await mongoose.connect(process.env.MONGO_URI as string, {
    dbName: "hiddenspots",
  });

  console.log("Connected to MongoDB");
} catch (e) {
  console.log(e);
}

app.use(Logestic.preset("fancy"));
app.use(baseRouter);

// swagger
app.use(
  swagger({
    autoDarkMode: false,
    path: "/docs",

    exclude: ["/docs", "/docs/json"],
    documentation: {
      security: [
        {
          securitySchemes: [],
        },
      ],
      servers: [
        {
          url: "http://localhost:4000",
          description: "Localhost",
        },
        {
          url: "https://hiddenspots.com",
          description: "Production",
        },
      ],
      info: {
        title: "Hidden Spots",
        version: "1.0.0",
      },
    },
  })
);

app.onError(({ code, error }) => {
  if (code === "VALIDATION") {
    return {
      status: 400,
      body: error.all,
    };
  }
});

const port = 4000;

app.listen(port, () => {
  console.log("Server is running on port " + port);
});
