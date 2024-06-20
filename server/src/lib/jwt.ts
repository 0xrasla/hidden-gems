import { sign, verify } from "jsonwebtoken";

export const jwt = {
  sign: (payload: any) => {
    return sign(payload, process.env.JWT_SECRET || "secret", {
      expiresIn: "7d",
    });
  },
  verify: (token: string) => verify(token, process.env.JWT_SECRET || "secret"),
};
