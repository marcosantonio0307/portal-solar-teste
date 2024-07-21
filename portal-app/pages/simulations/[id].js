import moment from 'moment';
import portalApiGateway from '../../lib/portal-api-gateway';
import cookies from 'next-cookies';
import { useRouter } from 'next/router'
import { useEffect, useState } from 'react';

const SimulationPage = ({token}) => {
  const router = useRouter();
  const { id } = router.query;
  const [simulation, setSimulation] = useState(null);

  const handlePdf = async (e) => {
    e.preventDefault();
    try {
      const response = await portalApiGateway.get(
        `/api/v1/simulations/${id}/download`,
        { responseType: 'blob'}
      );

      if (response.status === 200) {
        const blob = new Blob([response.data], { type: 'application/pdf' });
        const url = URL.createObjectURL(blob);
        window.open(url, '_blank');
        URL.revokeObjectURL(url);
      }
    } catch (error) {
      console.error('Failed to generate PDF', error);
    }
  };

  useEffect(() => {
    if (!token) {
      router.push('/sign_in');
    } else {
      portalApiGateway.get(`/api/v1/simulations/${id}`)
        .then(response => setSimulation(response.data.simulation))
        .catch(error => {
          if(error.response && error.response.status === 401) {
            router.push('/sign_in');
          } else {
            console.error('Failed to fetch simulation', error);
          }
        });
    }
  }, [token]);

  if (!simulation) return <p>Loading...</p>;

  return (
    <div>
      <div>
        <h1>Simulação Nº {simulation.id}</h1>

        <button className='btn btn-success' onClick={handlePdf}>Imprimir PDF</button>
      </div>

      <div className='mt-5'>
        <p>Data: {moment(simulation.created_at).format('DD/MM/YYYY')}</p>
        <p>Valor da conta de luz: R$ {simulation.electricity_bill}</p>
        <p>Potência necessária: {simulation.power}</p>
      </div>

      <div className='mt-5'>
        <h2>Geradores mais indicados</h2>
        
        <div className='mt-5'>
          {simulation.chosen_generators.map(generator => (
            <div className='mt-5 pb-3 border-bottom' key={generator.id}>
              <p><b>{ generator.name }</b></p>
              <p><b>Preço:</b> { generator.price }</p>
              <p><b>Qtde. de painéis:</b> { generator.panels }</p>
              <p><b>Potência do gerador:</b> { generator.power }</p>
              <img src={generator.image_url} width='100px'></img>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

SimulationPage.getInitialProps = async (ctx) => {
  const { token } = cookies(ctx);
  return { token };
};

export default SimulationPage;
