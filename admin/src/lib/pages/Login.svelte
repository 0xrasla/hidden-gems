<script lang="ts">
	import { Button } from '$lib/components/ui/button/index.js';
	import * as Card from '$lib/components/ui/card/index.js';
	import { Input } from '$lib/components/ui/input/index.js';
	import { Label } from '$lib/components/ui/label/index.js';
	import { toast } from 'svelte-sonner';

	let email = '';
	let password = '';

	function handleLogin() {
		if (!email || !password) {
			return;
		}
		if (email === 'admin@gmail.com' && password === 'admin') {
			toast.success('Login successful!');
			window.location.href = '/admin/dashboard';
		}

		toast.error('Invalid email or password');
	}
</script>

<form action="" on:submit|preventDefault={handleLogin}>
	<Card.Root class="w-full max-w-sm">
		<Card.Header>
			<Card.Title class="text-2xl">Login</Card.Title>
			<Card.Description>Enter your email below to login to your account.</Card.Description>
		</Card.Header>
		<Card.Content class="grid gap-4">
			<div class="grid gap-2">
				<Label for="email">Email</Label>
				<Input
					id="email"
					bind:value={email}
					type="email"
					placeholder="admin@example.com"
					required
				/>
			</div>
			<div class="grid gap-2">
				<Label for="password">Password</Label>
				<Input id="password" type="password" required bind:value={password} />
			</div>
		</Card.Content>
		<Card.Footer>
			<Button type="submit">Login</Button>
		</Card.Footer>
	</Card.Root>
</form>
