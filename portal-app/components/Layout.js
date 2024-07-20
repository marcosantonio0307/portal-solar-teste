import styles from './Layout.module.css';
import Head from 'next/head';
import Cookies from 'js-cookie';
import { useRouter } from 'next/router';

const Layout = ({ children }) => {
  const router = useRouter();

  const logout = () => {
    Cookies.remove('userName')
    Cookies.remove('token');
    router.push('/sign_in');
  };

  return (
    <>
    <Head>
      <link
        rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
        crossOrigin="anonymous"
      />
    </Head>
    <div>
      <header className={styles.navbar}>
      <nav className='navbar navbar-expand-lg'>
        <div className='collapse navbar-collapse'>
          <ul className='navbar-nav mr-auto'>
            <li className='nav-item'>
              <a className='nav-link' href='/'>Início</a>
            </li>
            <li className='nav-item'>
              <a className='nav-link' href='/user'>Minha conta</a>
            </li>
          </ul>
          <div>
            <button onClick={logout} className='btn btn-outline-danger my-2 my-sm-0'>Sair</button>
          </div>
        </div>
      </nav>
      </header>
      <main className='p-5'>{children}</main>
    </div>
    </>
  );
};

export default Layout;
