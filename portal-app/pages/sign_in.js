import { useState } from 'react';
import portalApiGateway from '../lib/portal-api-gateway';
import { useRouter } from 'next/router';
import Cookies from 'js-cookie';
import Link from 'next/link';

const SignIn = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [apiError, setApiError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await portalApiGateway.post('/api/v1/customer/sign_in', { email, password });
      if (response.status === 200) {
        const name = response.data.data['name'];
        const id = response.data.data['id']
        Cookies.set('userName', name);
        Cookies.set('userId', id);
        router.push('/');
      }
    } catch (error) {
      if (error.response && error.response.status === 401) {
        setApiError('Usuário ou senha inválido. Tente novamente.');
      }
      console.error('Failed to sign in', error);
    }
  };

  return (
    <div className='sm-container d-flex justify-content-center mt-5'>
      <form onSubmit={handleSubmit}>
        {
          apiError &&
          <div className='alert alert-danger alert-dismissible position-absolute'>
            {apiError}
          </div>
        }
        <div>
          <h4 className='mb-5 text-center'>Acesse sua conta</h4>
        </div>
        <div className='form-group'>
          <label>
            Email:
            <input type='email' value={email} onChange={(e) => setEmail(e.target.value)} className='form-control' />
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
            />
          </label>
        </div>
        <div className='form-group text-center'>
          <button type='submit' className='btn btn-success'>Entrar</button>
        </div>
        <div className='text-center'>
          <Link href='/sign_up'>Novo por aqui? Crie sua conta</Link>
        </div>
      </form>
    </div>
  );
};

export default SignIn;
