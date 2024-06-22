import Elysia, { t } from "elysia";
import { saveFile } from "../lib/file";
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

        let _imgList: any = [];

        for (const image of images) {
          const { filename, ok } = saveFile(image, "location");

          if (ok) {
            _imgList.push(filename);
          }
        }

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
          images: _imgList,
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
        locationName: t.Any({ minLength: 1 }),
        category: t.Any({ minLength: 1 }),
        description: t.Any({ minLength: 1 }),
        lat: t.Any(),
        lon: t.Any(),
        address: t.Any({ minLength: 1 }),
        able_to_bath: t.Any(),
        food_available: t.Any(),
        child_safe: t.Any(),
        danger: t.Any(),
        bikes_only: t.Any(),
        cars_accessible: t.Any(),
        wheelchair_accessible: t.Any(),
        restrooms_available: t.Any(),
        popularity: t.Any({ min: 0, max: 5 }),
        opening_hours: t.Any(),
        entry_fee: t.Any({ min: 0 }),
        reviews: t.Any(t.Any()),
        images: t.Any(t.Any()),
        public_transport: t.Any(),
        parking_available: t.Any(),
        parking_fee: t.Any({ min: 0 }),
        nearest_landmark: t.Any(),
        best_season_to_visit: t.Any(),
        historical_significance: t.Any(),
        guided_tours: t.Any(),
        user_ratings: t.Any({ min: 0, max: 5 }),
        number_of_reviews: t.Any({ min: 0 }),
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
        page: t.Optional(t.Any({ min: 1, max: 100 })),
        limit: t.Optional(t.Any({ min: 1, max: 100 })),
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
        id: t.Any({ minLength: 1 }),
      }),
      tags: ["location"],
      detail: {
        summary: "Delete a location",
        description: "Delete a location",
      },
    }
  );
