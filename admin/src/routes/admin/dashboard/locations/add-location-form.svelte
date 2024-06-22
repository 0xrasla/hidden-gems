<script lang="ts">
	import Button from '$lib/components/ui/button/button.svelte';
	import Input from '$lib/components/ui/input/input.svelte';
	import { field, form } from 'svelte-forms';
	import { max, min, required } from 'svelte-forms/validators';
	import { toast } from 'svelte-sonner';

	import { _axios } from '$lib/axios';
	import { Checkbox } from '$lib/components/ui/checkbox';
	import Label from '$lib/components/ui/label/label.svelte';
	import * as Select from '$lib/components/ui/select';
	import { Textarea } from '$lib/components/ui/textarea';
	import { useMutation } from '@sveltestack/svelte-query';

	const locationName = field('locationName', 'Default Location', [required(), min(3)]);
	const category = field('category', 'Nature Spot', [required()]);
	const description = field('description', 'This is a default description for testing purposes.', [
		required()
	]);
	const lat = field('lat', '12.9716', [required()]);
	const lon = field('lon', '77.5946', [required()]);
	const address = field('address', '123 Main Street, City, Country', [required()]);

	const able_to_bath = field('able_to_bath', true);
	const food_available = field('food_available', false);
	const child_safe = field('child_safe', true);
	const danger = field('danger', false);
	const bikes_only = field('bikes_only', false);
	const cars_accessible = field('cars_accessible', true);
	const wheelchair_accessible = field('wheelchair_accessible', true);
	const restrooms_available = field('restrooms_available', true);
	const popularity = field('popularity', 3, [min(0), max(5)]);
	const opening_hours = field('opening_hours', '9 AM - 6 PM');
	const entry_fee = field('entry_fee', 10, [min(0)]);
	const reviews = field('reviews', ['Great place!', 'Enjoyed my visit.']);
	const public_transport = field('public_transport', 'Buses and trains available nearby.');
	const parking_available = field('parking_available', true);
	const parking_fee = field('parking_fee', 5, [min(0)]);
	const nearest_landmark = field('nearest_landmark', 'Famous Monument');
	const best_season_to_visit = field('best_season_to_visit', 'Spring');
	const historical_significance = field(
		'historical_significance',
		'This place has a rich historical background.'
	);
	const guided_tours = field('guided_tours', true);
	const user_ratings = field('user_ratings', 4, [min(0), max(5)]);
	const number_of_reviews = field('number_of_reviews', 10, [min(0)]);
	const last_updated = field('last_updated', new Date());

	let images: any = [];

	const addLocationForm = form(
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
		public_transport,
		parking_available,
		parking_fee,
		nearest_landmark,
		best_season_to_visit,
		historical_significance,
		guided_tours,
		user_ratings,
		number_of_reviews,
		last_updated
	);

	const addLocationMutation = useMutation(async (data: any) => {
		const res = await _axios.post('/locations', data);

		return res;
	});

	export let toggleForm = () => {};

	async function addLocation() {
		if (images.length === 0) {
			toast.error('Please select at least one image');
			return;
		}

		await addLocationForm.validate();
		if ($addLocationForm.valid) {
			try {
				const formData = new FormData();
				formData.append('locationName', $locationName.value);
				formData.append('category', $category.value);
				formData.append('description', $description.value);
				formData.append('lat', $lat.value);
				formData.append('lon', $lon.value);
				formData.append('address', $address.value);
				formData.append('able_to_bath', $able_to_bath.value.toString());
				formData.append('food_available', $food_available.value.toString());
				formData.append('child_safe', $child_safe.value.toString());
				formData.append('danger', $danger.value.toString());
				formData.append('bikes_only', $bikes_only.value.toString());
				formData.append('cars_accessible', $cars_accessible.value.toString());
				formData.append('wheelchair_accessible', $wheelchair_accessible.value.toString());
				formData.append('restrooms_available', $restrooms_available.value.toString());
				formData.append('popularity', $popularity.value.toString());
				formData.append('opening_hours', $opening_hours.value);
				formData.append('entry_fee', $entry_fee.value.toString());
				formData.append('reviews', $reviews.value.toString());

				for (const image of images) {
					formData.append('images', image);
				}

				formData.append('public_transport', $public_transport.value.toString());
				formData.append('parking_available', $parking_available.value.toString());
				formData.append('parking_fee', $parking_fee.value.toString());
				formData.append('nearest_landmark', $nearest_landmark.value.toString());
				formData.append('best_season_to_visit', $best_season_to_visit.value.toString());
				formData.append('historical_significance', $historical_significance.value.toString());
				formData.append('guided_tours', $guided_tours.value.toString());
				formData.append('user_ratings', $user_ratings.value.toString());
				formData.append('number_of_reviews', $number_of_reviews.value.toString());
				formData.append('last_updated', $last_updated.value.toString());

				let res = $addLocationMutation.mutate(formData);
				addLocationMutation.subscribe((res) => {
					if (res.isSuccess) {
						toast.success('Location added successfully');
						toggleForm();
						addLocationForm.reset();
						images = [];
					}

					if (res.isError) {
						toast.error('Something went wrong');
					}
				});
			} catch (error) {}
		} else {
			toast.error('Please fill in all required fields');
		}
	}
</script>

<title>Hidden Spots | Locations</title>

<section class="min-h-screen overflow-y-auto p-4">
	<h1 class="mb-3 text-2xl font-bold">Add Location</h1>
	<form on:submit|preventDefault={addLocation}>
		<div class="grid grid-cols-2 gap-4">
			<div class="flex flex-col gap-2">
				<Label for="locationName">Location Name</Label>
				<Input
					type="text"
					placeholder="Enter a name for the location"
					name="locationName"
					bind:value={$locationName.value}
				/>

				{#if $addLocationForm.hasError('locationName.required')}
					<p class="text-sm text-red-500">Location Name is required</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="category">Category</Label>
				<Select.Root
					selected={{
						value: $category.value,
						label: $category.value
					}}
					onSelectedChange={(e) => {
						category.set(e?.value ?? '');
					}}
				>
					<Select.Trigger class="">
						<Select.Value placeholder="Select a category" />
					</Select.Trigger>
					<Select.Content>
						<Select.Item value="Bathing Place">Bathing Place</Select.Item>
						<Select.Item value="Nature Spot">Nature Spot</Select.Item>
						<Select.Item value="Restaurant">Restaurant</Select.Item>
						<Select.Item value="Mountain">Mountain</Select.Item>
						<Select.Item value="Beach">Beach</Select.Item>
						<Select.Item value="Shop">Shop</Select.Item>
						<Select.Item value="Other">Other</Select.Item>
					</Select.Content>
				</Select.Root>

				{#if $addLocationForm.hasError('category.required')}
					<p class="text-sm text-red-500">Category is required</p>
				{/if}
			</div>

			<div class="col-span-2 flex flex-col gap-2">
				<Label for="description">Description</Label>
				<Textarea
					placeholder="Enter a description"
					name="description"
					bind:value={$description.value}
				/>

				{#if $addLocationForm.hasError('description.required')}
					<p class="text-sm text-red-500">Description is required</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="lat">Latitude</Label>
				<Input type="text" placeholder="Enter a latitude" name="lat" bind:value={$lat.value} />

				{#if $addLocationForm.hasError('lat.required')}
					<p class="text-sm text-red-500">Latitude is required</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="lon">Longitude</Label>
				<Input type="text" placeholder="Enter a longitude" name="lon" bind:value={$lon.value} />

				{#if $addLocationForm.hasError('lon.required')}
					<p class="text-sm text-red-500">Longitude is required</p>
				{/if}
			</div>

			<div class="col-span-2 flex flex-col gap-2">
				<Label for="address">Address</Label>
				<Textarea name="address" placeholder="Enter an address" bind:value={$address.value} />

				{#if $addLocationForm.hasError('address.required')}
					<p class="text-sm text-red-500">Address is required</p>
				{/if}
			</div>

			<div class="col-span-2 grid grid-cols-3 gap-4">
				<div class="flex items-center gap-2">
					<Checkbox name="able_to_bath" bind:checked={$able_to_bath.value} />
					<Label for="able_to_bath">Able to bath</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="food_available" bind:checked={$food_available.value} />
					<Label for="food_available">Food available</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="child_safe" bind:checked={$child_safe.value} />
					<Label for="child_safe">Child safe</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="danger" bind:checked={$danger.value} />
					<Label for="danger">Danger</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="bikes_only" bind:checked={$bikes_only.value} />
					<Label for="bikes_only">Bikes only</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="cars_accessible" bind:checked={$cars_accessible.value} />
					<Label for="cars_accessible">Cars accessible</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="wheelchair_accessible" bind:checked={$wheelchair_accessible.value} />
					<Label for="wheelchair_accessible">Wheelchair accessible</Label>
				</div>

				<div class="flex items-center gap-2">
					<Checkbox name="restrooms_available" bind:checked={$restrooms_available.value} />
					<Label for="restrooms_available">Restrooms available</Label>
				</div>
				<div class="flex items-center gap-2">
					<Checkbox name="guided_tours" bind:checked={$guided_tours.value} />
					<Label for="guided_tours">Guided Tours</Label>
				</div>
			</div>

			<div class="flex flex-col gap-2">
				<Label for="popularity">Popularity</Label>
				<Input
					type="number"
					placeholder="Enter popularity (0-5)"
					name="popularity"
					bind:value={$popularity.value}
					min="0"
					max="5"
				/>

				{#if $addLocationForm.hasError('popularity.min') || $addLocationForm.hasError('popularity.max')}
					<p class="text-sm text-red-500">Popularity should be between 0 and 5</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="opening_hours">Opening Hours</Label>
				<Input
					type="text"
					placeholder="Enter opening hours"
					name="opening_hours"
					bind:value={$opening_hours.value}
				/>
			</div>

			<div class="flex flex-col gap-2">
				<Label for="entry_fee">Entry Fee</Label>
				<Input
					type="number"
					placeholder="Enter entry fee"
					name="entry_fee"
					bind:value={$entry_fee.value}
					min="0"
				/>

				{#if $addLocationForm.hasError('entry_fee.min')}
					<p class="text-sm text-red-500">Entry fee should be greater than or equal to 0</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="parking_fee">Parking Fee</Label>
				<Input
					type="number"
					placeholder="Enter parking fee"
					name="parking_fee"
					bind:value={$parking_fee.value}
					min="0"
				/>

				{#if $addLocationForm.hasError('parking_fee.min')}
					<p class="text-sm text-red-500">Parking fee should be greater than or equal to 0</p>
				{/if}
			</div>
			<div class="col-span-2 flex flex-col gap-2">
				<Label for="public_transport">Public Transport</Label>
				<Textarea
					placeholder="Enter public transport details"
					name="public_transport"
					bind:value={$public_transport.value}
				/>
			</div>

			<div class="flex flex-col gap-2">
				<Label for="nearest_landmark">Nearest Landmark</Label>
				<Input
					type="text"
					placeholder="Enter nearest landmark"
					name="nearest_landmark"
					bind:value={$nearest_landmark.value}
				/>
			</div>

			<div class="flex flex-col gap-2">
				<Label for="best_season_to_visit">Best Season to Visit</Label>
				<Input
					type="text"
					placeholder="Enter best season to visit"
					name="best_season_to_visit"
					bind:value={$best_season_to_visit.value}
				/>
			</div>

			<div class="col-span-2 flex flex-col gap-2">
				<Label for="historical_significance">Historical Significance</Label>
				<Textarea
					placeholder="Enter historical significance"
					name="historical_significance"
					bind:value={$historical_significance.value}
				/>
			</div>

			<div class="flex flex-col gap-2">
				<Label for="user_ratings">User Ratings</Label>
				<Input
					type="number"
					placeholder="Enter user ratings (0-5)"
					name="user_ratings"
					bind:value={$user_ratings.value}
					min="0"
					max="5"
				/>

				{#if $addLocationForm.hasError('user_ratings.min') || $addLocationForm.hasError('user_ratings.max')}
					<p class="text-sm text-red-500">User ratings should be between 0 and 5</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="number_of_reviews">Number of Reviews</Label>
				<Input
					type="number"
					placeholder="Enter number of reviews"
					name="number_of_reviews"
					bind:value={$number_of_reviews.value}
					min="0"
				/>

				{#if $addLocationForm.hasError('number_of_reviews.min')}
					<p class="text-sm text-red-500">Number of reviews should be greater than or equal to 0</p>
				{/if}
			</div>

			<div class="flex flex-col gap-2">
				<Label for="images">Images</Label>
				<input
					type="file"
					accept="image/*"
					multiple
					placeholder="Select images"
					name="images"
					bind:files={images}
				/>
			</div>
		</div>

		<div class="flex justify-end">
			<Button disabled={$addLocationMutation.isLoading} type="submit" class="mt-4 bg-green-400"
				>Add Location</Button
			>
		</div>
	</form>
</section>
