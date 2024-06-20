import { model, Schema } from "mongoose";

export interface Location {
  locationName: string;
  category: string;
  description: string;
  lat: string;
  lon: string;
  address: string;
  able_to_bath: boolean;
  food_available: boolean;
  child_safe: boolean;
  danger: boolean;
  bikes_only: boolean;
  cars_accessible: boolean;
  wheelchair_accessible: boolean;
  restrooms_available: boolean;
  popularity: number;
  opening_hours: string;
  entry_fee: number;
  reviews: string[];
  images: string[];
  public_transport: string;
  parking_available: boolean;
  parking_fee: number;
  nearest_landmark: string;
  best_season_to_visit: string;
  historical_significance: string;
  guided_tours: boolean;
  user_ratings: number;
  number_of_reviews: number;
  last_updated: Date;
  active: boolean;
}

const locationSchema = new Schema<Location>(
  {
    locationName: {
      type: String,
      required: true,
    },
    category: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    lat: {
      type: String,
      required: true,
    },
    lon: {
      type: String,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    able_to_bath: {
      type: Boolean,
      default: false,
    },
    food_available: {
      type: Boolean,
      default: false,
    },
    child_safe: {
      type: Boolean,
      default: false,
    },
    danger: {
      type: Boolean,
      default: false,
    },
    bikes_only: {
      type: Boolean,
      default: false,
    },
    cars_accessible: {
      type: Boolean,
      default: false,
    },
    wheelchair_accessible: {
      type: Boolean,
      default: false,
    },
    restrooms_available: {
      type: Boolean,
      default: false,
    },
    popularity: {
      type: Number,
      min: 0,
      max: 5,
      default: 0,
    },
    opening_hours: {
      type: String,
      default: "",
    },
    entry_fee: {
      type: Number,
      min: 0,
      default: 0,
    },
    reviews: {
      type: [String],
      default: [],
    },
    images: {
      type: [String],
      default: [],
    },
    public_transport: {
      type: String,
      default: "",
    },
    parking_available: {
      type: Boolean,
      default: false,
    },
    parking_fee: {
      type: Number,
      min: 0,
      default: 0,
    },
    nearest_landmark: {
      type: String,
      default: "",
    },
    best_season_to_visit: {
      type: String,
      default: "",
    },
    historical_significance: {
      type: String,
      default: "",
    },
    guided_tours: {
      type: Boolean,
      default: false,
    },
    user_ratings: {
      type: Number,
      min: 0,
      max: 5,
      default: 0,
    },
    number_of_reviews: {
      type: Number,
      min: 0,
      default: 0,
    },
    last_updated: {
      type: Date,
      default: Date.now,
    },
    active: {
      type: Boolean,
      default: true,
    },
  },
  {
    timestamps: true,
  }
);

export const LocationModel = model<Location>("Location", locationSchema);
