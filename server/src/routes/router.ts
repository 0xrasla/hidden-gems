import Elysia from "elysia";
import { LocationRouter } from "./locations-router";

const baseRouter = new Elysia({
  prefix: "/api",
});

baseRouter.use(LocationRouter);

export default baseRouter;
