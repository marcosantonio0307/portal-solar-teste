import { useEffect, useState } from 'react';
import portaApiGateway from '../lib/portal-api-gateway';
import { useRouter } from 'next/router';
import cookies from 'next-cookies';
import moment from 'moment';

const Home = ({ token, userName }) => {
  const [data, setData] = useState(null);
  const router = useRouter();

  useEffect(() => {
    if (!token) {
      router.push('/sign_in');
    } else {
      portaApiGateway.get('/api/v1/simulations/')
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

  const navigateToSimulationPage = (id) => {
    router.push(`/simulations/${encodeURIComponent(id)}`);
  };

  if (!data) return <p>Loading...</p>;

  return (
    <div>
      <div>Bem-vindo, {userName}!</div>

      <div className='mt-3'>
        <h2>Minhas simulações</h2>

        <table className='table mt-5'>
          <thead>
            <tr>
              <th>Id</th>
              <th>Data</th>
              <th>Valor da Conta de Luz</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {data.simulations.map(simulation => (
              <tr key={simulation.id}>
                <td>{simulation.id}</td>
                <td>{moment(simulation.created_at).format('DD/MM/YYYY')}</td>
                <td>R$ {simulation.electricity_bill}</td>
                <td>
                  <button onClick={() => navigateToSimulationPage(simulation.id)} className='btn btn-primary'>
                    Visualizar
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

Home.getInitialProps = async (ctx) => {
  const { token, userName } = cookies(ctx);
  return { token, userName };
};

export default Home;
