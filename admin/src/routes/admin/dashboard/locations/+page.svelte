<script>
	import Button from '$lib/components/ui/button/button.svelte';
	import { PlusIcon, X } from 'lucide-svelte';
	import { blur } from 'svelte/transition';
	import AddLocationForm from './add-location-form.svelte';
	import LocationList from './location-list.svelte';

	let showForm = false;

	function toggleForm() {
		showForm = !showForm;
	}
</script>

<title>Hidden Spots | Locations</title>

<div class="flex items-center justify-between">
	<h1 class="p-2 text-2xl font-bold">Manage Locations</h1>

	<button
		on:click={() => {
			showForm = !showForm;
		}}
	>
		{#if showForm}
			<Button class="" on:click={() => {}}>
				<X class="h-5 w-5" />
				Cancel
			</Button>
		{:else}
			<Button class="" on:click={() => {}}>
				<PlusIcon class="h-5 w-5" />
				Add Location
			</Button>
		{/if}
	</button>
</div>

{#if showForm}
	<div
		transition:blur={{
			opacity: 0.5,
			duration: 200
		}}
		class=""
	>
		<AddLocationForm {toggleForm} />
	</div>
{:else}
	<LocationList {toggleForm} />
{/if}
