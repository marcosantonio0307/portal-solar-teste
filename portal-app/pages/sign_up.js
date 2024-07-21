import { useState } from 'react';
import portaApiGateway from '../lib/portal-api-gateway';
import { useRouter } from 'next/router';
import Cookies from 'js-cookie';
import Link from 'next/link';

const SignUp = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const router = useRouter();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await portaApiGateway.post('/api/v1/customer/', { email, password, name });
      if (response.status === 200) {
        const name = response.data.data['name'];
        const id = response.data.data['id'];
        Cookies.set('userName', name);
        Cookies.set('userId', id);
        router.push('/');
      }
    } catch (error) {
      console.error('Failed to sign up', error);
    }
  };

  return (
    <div className='sm-container d-flex justify-content-center mt-5'>
      <form onSubmit={handleSubmit}>
        <h4 className='mb-5 text-center'>Crie sua conta</h4>
        <div className='form-group'>
          <label>
            Nome:
            <input
              type='text'
              value={name}
              onChange={(e) => setName(e.target.value)}
              className='form-control'
              required
            />
          </label>
        </div>
        <div className='form-group'>
          <label>
            Email:
            <input
              type='email'
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className='form-control'
              required
            />
          </label>
        </div>
        <div className='form-group'>
          <label>
            Senha:
            <input
              type='password'
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className='form-control'
              required
            />
          </label>
        </div>
        <div className='form-group text-center'>
          <button type='submit' className='btn btn-success'>Criar conta</button>
        </div>
        <div className='text-center'>
          <Link href='/sign_in'>Voltar a tela de login</Link>
        </div>
      </form>
    </div>
  );
};

export default SignUp;
