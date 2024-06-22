import Elysia, { t } from "elysia";
import { UserModel } from "../models/users";

export const UserAuthRouter = new Elysia({
  prefix: "/auth",
}).post(
  "/login",
  async ({ body, set }) => {
    try {
      const { mobileNumber } = body;

      const user = await UserModel.findOne({ mobileNumber });

      if (!user) {
        const newUser = new UserModel({
          mobileNumber,
          name: "User",
        });

        await newUser.save();

        set.status = 200;
        return {
          message: "User created successfully",
          user: newUser,
        };
      }

      return {
        message: "Login Successful",
        phoneNumber: user?.mobileNumber,
        status: true,
      };
    } catch (e) {
      console.error(e);
      return {
        status: 400,
        body: {
          error: e,
        },
      };
    }
  },
  {
    body: t.Object({
      mobileNumber: t.String({
        maxLength: 10,
        minLength: 10,
        default: "6384796245",
      }),
    }),
    detail: {
      tags: ["User"],
      description: "Login to the user account",
      summary: "Login to the user account",
    },
  }
);
