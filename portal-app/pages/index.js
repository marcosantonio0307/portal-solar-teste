import { useEffect, useState } from 'react';
import axios from '../lib/axios';
import { useRouter } from 'next/router';
import cookies from 'next-cookies';
import Cookies from 'js-cookie';

const Home = ({ token, userName }) => {
  const [data, setData] = useState(null);
  const router = useRouter();
  console.log(userName)

  useEffect(() => {
    if (!token) {
      router.push('/sign_in');
    } else {
      axios.get('/api/v1/customers/1')
        .then(response => setData(response.data))
        .catch(error => {
          if (error.response && error.response.status === 401) {
            router.push('/sign_in');
          } else {
            console.error('Failed to fetch data', error);
          }
        });
    }
  }, [token]);

  const handleLogout = () => {
    Cookies.remove('userName')
    Cookies.remove('token');
    router.push('/sign_in');
  };

  if (!data) return <p>Loading...</p>;

  return (
    <div>
      <div>Bem-vindo, {userName} usuário autenticado!</div>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
};

Home.getInitialProps = async (ctx) => {
  const { token, userName } = cookies(ctx);
  return { token, userName };
};

export default Home;
