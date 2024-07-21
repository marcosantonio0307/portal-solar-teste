import { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import cookies from 'next-cookies';
import portaApiGateway from '../../lib/portal-api-gateway';

const NewSimulationPage = ({ token }) => {
  const [electricity_bill, setElectricityBill] = useState('');
  const router = useRouter();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await portaApiGateway.post('/api/v1/simulations/', { electricity_bill });
      if (response.status === 200) {
        const simulationId = response.data.simulation['id'];
        router.push(`/simulations/${simulationId}`);
      }
    } catch (error) {
      console.error('Failed to create a simulation', error);
    }
  };

  useEffect(() => {
    if (!token) {
      router.push('/sign_in');
    }
  }, [token]);

  return (
    <div className='sm-container d-flex justify-content-center mt-5'>
      <form onSubmit={handleSubmit}>
        <h4 className='mb-5 text-center'>Nova simulação</h4>
        <div className='form-group'>
          <label>
            Valor da sua conta de luz:
            <input
              type='number'
              step='0.01'
              value={electricity_bill}
              onChange={(e) => setElectricityBill(e.target.value)}
              className='form-control'
              required
            />
          </label>
        </div>
        <div className='form-group text-center'>
          <button type='submit' className='btn btn-success'>Criar simulação</button>
        </div>
      </form>
    </div>
  );
};

NewSimulationPage.getInitialProps = async (ctx) => {
  const { token } = cookies(ctx);
  return { token };
};

export default NewSimulationPage;
