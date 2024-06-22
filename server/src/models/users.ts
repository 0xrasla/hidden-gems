import { model, Schema } from "mongoose";

export interface User {
  _id: string;
  name: string;
  mobileNumber: string;
}

const userSchema = new Schema<User>({
  name: {
    type: String,
    default: "User",
    required: true,
  },
  mobileNumber: {
    type: String,
    required: true,
  },
});

export const UserModel = model<User>("User", userSchema);
