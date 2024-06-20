<script lang="ts">
	import { _axios } from '$lib/axios';
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as Pagination from '$lib/components/ui/pagination';
	import { Skeleton } from '$lib/components/ui/skeleton';
	import * as Table from '$lib/components/ui/table';
	import { useMutation, useQuery } from '@sveltestack/svelte-query';
	import Eye from 'lucide-svelte/icons/eye';
	import Pen from 'lucide-svelte/icons/pen';
	import Delete from 'lucide-svelte/icons/trash-2';

	let page = 1;
	let limit = 10;
	let deleteDialogOpen = false;
	let currentLocationData: any = {};

	export let toggleForm = () => {};

	const queryResult = useQuery(
		['todos', page, limit],
		async () => {
			return _axios.get(`/locations/all?page=${page}&limit=${limit}`);
		},
		{
			refetchOnWindowFocus: false
		}
	);

	const deleteMutation = useMutation(async (id: any) => {
		return _axios.delete(`/locations/${id}`);
	});

	function refetch() {
		$queryResult.refetch();
	}

	function handlePageChange(newPage: any) {
		if (page !== newPage) {
			page = newPage;
			refetch();
		}
	}
</script>

<Table.Root>
	<Table.Caption
		>All Places added so far (Total: {$queryResult?.data?.data?.totalCount})</Table.Caption
	>
	<Table.Header>
		<Table.Row>
			<Table.Head class="w-[100px]">SL No</Table.Head>
			<Table.Head>Location Name</Table.Head>
			<Table.Head>Category</Table.Head>
			<Table.Head class="text-right">Opening Hours</Table.Head>
			<Table.Head class="text-right">Entry Fee</Table.Head>
			<Table.Head class="text-right">Action</Table.Head>
		</Table.Row>
	</Table.Header>
	<Table.Body>
		{#if $queryResult.isLoading || $queryResult.isRefetching}
			{#each Array(10) as _, i}
				<Table.Row>
					<Table.Cell class="font-medium" colspan={2}>
						<Skeleton class="h-4 w-[100px]" />
					</Table.Cell>
					<Table.Cell class="font-medium" colspan={1}>
						<Skeleton class="h-4 w-[100px]" />
					</Table.Cell>
					<Table.Cell class="font-medium" colspan={3}>
						<Skeleton class="h-4 w-[100px]" />
					</Table.Cell>
					<Table.Cell class="font-medium" colspan={3}>
						<Skeleton class="h-4 w-[100px]" />
					</Table.Cell>
					<Table.Cell class="font-medium" colspan={3}>
						<Skeleton class="h-4 w-[100px]" />
					</Table.Cell>
				</Table.Row>
			{/each}
		{:else if $queryResult.status === 'error'}
			<Table.Row>
				<Table.Cell colspan={5}>Error</Table.Cell>
			</Table.Row>
		{:else if $queryResult.data && $queryResult.data.data}
			{#each $queryResult?.data.data?.locations as location, i}
				<Table.Row>
					<Table.Cell class="font-medium">{limit * (page - 1) + i + 1}</Table.Cell>
					<Table.Cell>{location.locationName}</Table.Cell>
					<Table.Cell>{location.category}</Table.Cell>
					<Table.Cell class="text-right">{location.opening_hours}</Table.Cell>
					<Table.Cell class="text-right">₹ {location.entry_fee}</Table.Cell>
					<Table.Cell class="flex justify-end gap-6">
						<div class="cursor-pointer hover:text-blue-300">
							<Eye class="h-4 w-4" />
						</div>
						<div class="cursor-pointer hover:text-blue-300">
							<Pen class="h-4 w-4" />
						</div>
						<button
							on:click={() => {
								deleteDialogOpen = true;
								currentLocationData = location;
							}}
						>
							<div class="cursor-pointer hover:text-red-300">
								<Delete class="h-4 w-4" />
							</div>
						</button>
					</Table.Cell>
				</Table.Row>
			{/each}
		{/if}
	</Table.Body>
</Table.Root>

<Dialog.Root bind:open={deleteDialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Are you sure to delete this location ?</Dialog.Title>
			<Dialog.Description class="text-sm text-red-500">
				This action cannot be undone. This will permanently delete your account and remove the
				location.
			</Dialog.Description>
		</Dialog.Header>
		<p>{currentLocationData.locationName}</p>
		<p>{currentLocationData.category}</p>
		<p>{currentLocationData.opening_hours}</p>

		<Dialog.Footer class="flex justify-end gap-3">
			<Button
				on:click={() => {
					deleteDialogOpen = false;
				}}
			>
				Cancel
			</Button>
			<Button
				variant="destructive"
				on:click={() => {
					deleteDialogOpen = false;
					$deleteMutation.mutate(currentLocationData._id);
				}}
			>
				Delete
			</Button>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>

<Pagination.Root
	count={$queryResult?.data?.data?.totalCount}
	perPage={limit}
	let:pages
	let:currentPage
>
	<Pagination.Content>
		<Pagination.Item>
			<Pagination.PrevButton
				on:click={() => handlePageChange(currentPage - 1)}
				disabled={currentPage === 1}
			/>
		</Pagination.Item>
		{#each pages as page (page.key)}
			{#if page.type === 'ellipsis'}
				<Pagination.Item>
					<Pagination.Ellipsis />
				</Pagination.Item>
			{:else}
				<Pagination.Item>
					<Pagination.Link
						{page}
						isActive={currentPage == page.value}
						on:click={() => handlePageChange(page.value)}
					>
						{page.value}
					</Pagination.Link>
				</Pagination.Item>
			{/if}
		{/each}
		<Pagination.Item>
			<Pagination.NextButton
				on:click={() => handlePageChange(currentPage + 1)}
				disabled={currentPage === pages.length}
			/>
		</Pagination.Item>
	</Pagination.Content>
</Pagination.Root>
