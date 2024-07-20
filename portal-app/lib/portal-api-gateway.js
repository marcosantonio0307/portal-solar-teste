import axios from 'axios';
import Cookies from 'js-cookie';

const instance = axios.create({
  baseURL: 'http://127.0.0.1:3001',
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  }
});

instance.interceptors.request.use(config => {
  const token = Cookies.get('token');
  if (token) {
    config.headers.Authorization = token;
  }
  return config;
});

instance.interceptors.response.use(response => {
  const token = response.headers.authorization;
  if (token) {
    Cookies.set('token', token);
  }
  return response;
});

export default instance;
