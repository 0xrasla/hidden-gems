<script>
	import { page } from '$app/stores';
	import Bell from 'lucide-svelte/icons/bell';
	import Home from 'lucide-svelte/icons/home';
	import Package2 from 'lucide-svelte/icons/package-2';
	import TreePalm from 'lucide-svelte/icons/tree-palm';
	import Button from '../ui/button/button.svelte';

	let pathName = '';

	page.subscribe(($page) => {
		pathName = $page.url.pathname;
	});

	const navItems = [
		{ label: 'Dashboard', href: '/admin/dashboard', icon: Home },
		{ label: 'Locations', href: '/admin/dashboard/locations', icon: Package2 },
		{ label: 'Users', href: '/admin/dashboard/users', icon: Package2 }
	];
</script>

<div class="bg-muted/40 sticky top-0 z-10 h-screen w-[300px] border-r md:block">
	<div class="flex h-full max-h-screen flex-col gap-2">
		<div class="flex h-14 items-center border-b px-4 lg:h-[60px] lg:px-6">
			<a href="/" class="flex items-center gap-2 font-semibold">
				<TreePalm class="h-6 w-6" />
				<span class="">Hidden Spots</span>
			</a>
			<Button variant="outline" size="icon" class="ml-auto h-8 w-8">
				<Bell class="h-4 w-4" />
				<span class="sr-only">Toggle notifications</span>
			</Button>
		</div>
		<div class="flex-1">
			<nav class="grid items-start px-2 text-sm font-medium lg:px-4">
				{#each navItems as item}
					<a
						href={item.href}
						class={`${
							pathName === item.href
								? 'bg-muted text-primary'
								: 'text-muted-foreground hover:text-primary'
						} flex items-center gap-3 rounded-lg px-3 py-2 transition-all`}
					>
						<svelte:component this={item.icon} class="h-4 w-4" />
						{item.label}
						<!-- {#if item.badge}
							<Badge class="ml-auto flex h-6 w-6 shrink-0 items-center justify-center rounded-full">
								{item.badge}
							</Badge>
						{/if} -->
					</a>
				{/each}
			</nav>
		</div>
	</div>
</div>
