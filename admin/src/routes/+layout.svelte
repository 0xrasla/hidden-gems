<script>
	import { Toaster } from '$lib/components/ui/sonner';
	import { QueryClient, QueryClientProvider } from '@sveltestack/svelte-query';
	import { ModeWatcher } from 'mode-watcher';
	import '../app.css';

	const queryClient = new QueryClient();
</script>

<ModeWatcher />
<Toaster position="top-right" />

<QueryClientProvider
	client={queryClient}
	defaultOptions={{
		queries: {
			refetchOnWindowFocus: false
		}
	}}
>
	<slot />
</QueryClientProvider>
