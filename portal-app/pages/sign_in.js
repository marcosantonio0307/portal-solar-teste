import { useState } from 'react';
import axios from '../lib/axios';
import { useRouter } from 'next/router';
import Cookies from 'js-cookie';

const SignIn = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const router = useRouter();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('/api/v1/customer/sign_in', { email, password });
      if (response.status === 200) {
        const name = response.data.data['name'];
        console.log(name)
        Cookies.set('userName', name);
        router.push('/');
      }
    } catch (error) {
      console.error('Failed to sign in', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Email:
        <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      </label>
      <label>
        Password:
        <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
      </label>
      <button type="submit">Sign In</button>
    </form>
  );
};

export default SignIn;
