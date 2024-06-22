import Elysia from "elysia";
import { UserAuthRouter } from "./auth-router";
import { LocationRouter } from "./locations-router";

const baseRouter = new Elysia({
  prefix: "/api",
});

baseRouter.use(LocationRouter).use(UserAuthRouter);

export default baseRouter;
