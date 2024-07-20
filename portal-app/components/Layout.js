import styles from './Layout.module.css';
import Head from 'next/head';

const Layout = ({ children }) => {
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
        <nav>
          <ul>
            <li><a href="/">Página Inicial</a></li>
          </ul>
        </nav>
      </header>
      <main className='p-5'>{children}</main>
    </div>
    </>
  );
};

export default Layout;
