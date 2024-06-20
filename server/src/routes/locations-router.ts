import Elysia, { t } from "elysia";
import { LocationModel } from "../models/location";

export const LocationRouter = new Elysia({
  prefix: "/locations",
})
  .post(
    "/",
    async ({ set, body }) => {
      try {
        const {
          locationName,
          category,
          description,
          lat,
          lon,
          address,
          able_to_bath,
          food_available,
          child_safe,
          danger,
          bikes_only,
          cars_accessible,
          wheelchair_accessible,
          restrooms_available,
          popularity,
          opening_hours,
          entry_fee,
          reviews,
          images,
          public_transport,
          parking_available,
          parking_fee,
          nearest_landmark,
          best_season_to_visit,
          historical_significance,
          guided_tours,
          user_ratings,
          number_of_reviews,
          last_updated,
        } = body;

        const newLocation = new LocationModel({
          locationName,
          category,
          description,
          lat,
          lon,
          address,
          able_to_bath,
          food_available,
          child_safe,
          danger,
          bikes_only,
          cars_accessible,
          wheelchair_accessible,
          restrooms_available,
          popularity,
          opening_hours,
          entry_fee,
          reviews,
          images,
          public_transport,
          parking_available,
          parking_fee,
          nearest_landmark,
          best_season_to_visit,
          historical_significance,
          guided_tours,
          user_ratings,
          number_of_reviews,
          last_updated,
        });

        await newLocation.save();

        set.status = 200;
        return {
          message: "Location created successfully",
          location: newLocation,
        };
      } catch (error) {
        console.error(error);
        set.status = 500;
        return {
          error: error,
          message: "Something went wrong",
        };
      }
    },
    {
      body: t.Object({
        locationName: t.String({ minLength: 1 }),
        category: t.String({ minLength: 1 }),
        description: t.String({ minLength: 1 }),
        lat: t.String(),
        lon: t.String(),
        address: t.String({ minLength: 1 }),
        able_to_bath: t.Boolean(),
        food_available: t.Boolean(),
        child_safe: t.Boolean(),
        danger: t.Boolean(),
        bikes_only: t.Boolean(),
        cars_accessible: t.Boolean(),
        wheelchair_accessible: t.Boolean(),
        restrooms_available: t.Boolean(),
        popularity: t.Number({ min: 0, max: 5 }),
        opening_hours: t.String(),
        entry_fee: t.Number({ min: 0 }),
        reviews: t.Array(t.String()),
        images: t.Array(t.String()),
        public_transport: t.String(),
        parking_available: t.Boolean(),
        parking_fee: t.Number({ min: 0 }),
        nearest_landmark: t.String(),
        best_season_to_visit: t.String(),
        historical_significance: t.String(),
        guided_tours: t.Boolean(),
        user_ratings: t.Number({ min: 0, max: 5 }),
        number_of_reviews: t.Number({ min: 0 }),
        last_updated: t.Date(),
      }),
      tags: ["location"],
      detail: {
        summary: "Create a new location",
        description: "Create a new location",
      },
    }
  )
  .get(
    "/all",
    async ({ set, query }) => {
      try {
        const { page, limit } = query;

        const fetchQuery: any = {
          active: true,
        };

        let _page = page ? +page : 1;
        let _limit = limit ? +limit : 10;

        const locations = await LocationModel.find(fetchQuery)
          .sort({ createdAt: -1 })
          .skip((_page - 1) * _limit)
          .limit(_limit)
          .lean()
          .exec();

        const totalCount = await LocationModel.countDocuments(fetchQuery);

        set.status = 200;
        return {
          message: "Locations fetched successfully",
          locations,
          totalCount,
        };
      } catch (error) {
        console.error(error);
        set.status = 500;
        return {
          error: error,
          message: "Something went wrong",
        };
      }
    },
    {
      query: t.Object({
        page: t.Optional(t.String({ min: 1, max: 100 })),
        limit: t.Optional(t.String({ min: 1, max: 100 })),
      }),
      tags: ["location"],
      detail: {
        summary: "Fetch all locations",
        description: "Fetch all locations",
      },
    }
  )
  .delete(
    "/:id",
    async ({ set, params }) => {
      try {
        const location = await LocationModel.findByIdAndUpdate(
          params.id,
          { active: false },
          { new: true }
        );

        set.status = 200;
        return {
          message: "Location deleted successfully",
          location,
        };
      } catch (error) {
        console.error(error);
        set.status = 500;
        return {
          error: error,
          message: "Something went wrong",
        };
      }
    },
    {
      params: t.Object({
        id: t.String({ minLength: 1 }),
      }),
      tags: ["location"],
      detail: {
        summary: "Delete a location",
        description: "Delete a location",
      },
    }
  );
