import axios from 'axios';
import { baseUrl } from './config';

export const _axios = axios.create({
	baseURL: baseUrl,
	headers: {
		'Content-Type': 'application/json'
	}
});
