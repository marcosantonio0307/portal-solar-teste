import portaApiGateway from '../lib/portal-api-gateway';
import cookies from 'next-cookies';
import Cookies from 'js-cookie';
import { useRouter } from 'next/router'
import { useEffect, useState } from 'react';

const UserPage = ({token, userId}) => {
  const router = useRouter();
  const [user, setUser] = useState(null);
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleUpdateUser = async (e) => {
    e.preventDefault();
    let dataParams;

    if (password !== '') {
      dataParams = { name, email, password }
    } else {
      dataParams = { name, email }
    }

    try {
      const response = await portaApiGateway.put(`/api/v1/customers/${userId}`, dataParams);
      if (response.status === 200) {
        const userName = response.data.customer['name'];
        Cookies.set('userName', userName);
        router.push('/');
      }
    } catch (error) {
      console.error('Failed to update customer', error);
    }
  };

  const handleDeleteUser = async (e) => {
    const confirmDelete = window.confirm('Deseja deletar sua conta?');

    if (confirmDelete) {
      e.preventDefault();

      try {
        const response = await portaApiGateway.delete('/api/v1/customer');
        if (response.status === 200) {
          Cookies.remove('userName');
          Cookies.remove('userId');
          Cookies.remove('token');
          router.push('/sign_in');
        }
      } catch (error) {
        console.error('Failed to delete customer', error);
      }
    }
  };

  useEffect(() => {
    if (!token) {
      router.push('/sign_in');
    } else {
      portaApiGateway.get(`/api/v1/customers/${userId}`)
        .then(response => {
          setUser(response.data.customer);
          setName(response.data.customer.name);
          setEmail(response.data.customer.email);
        })
        .catch(error => {
          if(error.response && error.response.status === 401) {
            router.push('/sign_in');
          } else {
            console.error('Failed to fetch user', error);
          }
        });
    }
  }, [token]);

  if (!user) return <p>Loading...</p>;

  return (
    <div>
      <div>
        <h1>Sua conta</h1>
      </div>

      <div className='mt-5'>
        <form onSubmit={handleUpdateUser}>
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
              />
            </label>
          </div>
          <div className='form-group'>
            <button type='submit' className='btn btn-success'>Atualizar conta</button>
          </div>
        </form>
        <div className='form-group'>
          <button type='submit' className='btn btn-danger' onClick={handleDeleteUser}>
            Deletar conta
          </button>
        </div>
      </div>
    </div>
  )
}

UserPage.getInitialProps = async (ctx) => {
  const { token, userId } = cookies(ctx);
  return { token, userId };
};

export default UserPage;
