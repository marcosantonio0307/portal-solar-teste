const Layout = ({ children }) => {
  return (
    <div>
      <header>
        <nav>
          <ul>
            <li><a href="/">Página Inicial</a></li>
            {!authToken && <li><a href="/sign-in">Login</a></li>}
          </ul>
        </nav>
      </header>
      <main>{children}</main>
      <footer>
        {/* Rodapé */}
      </footer>
    </div>
  );
};

export default Layout;
