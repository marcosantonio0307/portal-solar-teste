# PORTAL SOLAR TESTE

Essa é uma aplicação de um painel onde os clientes Portal Solar podem
se cadastrar e fazer simulações para encontrar o melhor gerador de
energia solar para sua usina de microgeração.

Nesse repositorio está a API e o Painel do usuário. Sendo a API desenvolvidade
em Ruby on Rails (v6.1) e o painel em NextJS (v13.4).

## Instalação e execução

Este projeto utiliza Docker e Docker Compose, então
executa-lo é simples e prático :)

Você vai precisar ter instalado na sua máquina o Docker e o Docker Compose.
Caso não tenha, você pode baixar e instalar através do site oficial do Docker:
- Docker: https://docs.docker.com/engine/install/
- Docker Compose: https://docs.docker.com/compose/install/

Com o Docker e Docker Compose instalados, você está pronto para rodar a aplicação.

### Rodando a aplicação

1. Clone o repositório:
```bash
git clone git@github.com:marcosantonio0307/portal-solar-teste.git
```

2. Entre na pasta do projeto:
```bash
cd portal-solar-teste
```

3. Faça o build dos containers:
```bash
docker-compose build
```

4. Crie o banco de dados da API e rode as migrações:
```bash
docker-compose run app rails db:create db:migrate
```
5. IMPORTANTE! edite a ENV 'PORTAL_SOLAR_KEY' no `.env.development` para o valor real da key
da API mokaroo para rodar o seed corretamente.

6. Com a ENV configurada rode o seed para popular a tabela de geradores disponíveis. Esse passo demora um poquinho.
```bash
docker-compose run app rails db:seed
```

7. Inicie a aplicação:
```bash
docker-compose up
```
8. Acesse a aplicação no seu navegador:
- API: http://localhost:3001 (para testar requisições)
- Painel: http://localhost:3000 (para acessar o painel do usuário)

## Testes

A aplicação tem uma suite de testes automatizados usando Rspec e Rswag para
garantir seu funcionamento.

- Para rodar os testes da API, execute:
```bash
docker-compose run app rspec
```
### Teste os endpoints da API

Como estamos usando o Rswag, você pode acessar a url
http://localhost:3001/api-docs e encontrar toda a documentação sobre os
endpoints e ainda testa-los por lá mesmo se preferir :)

## Informações adicionais

### Rubocop
Temos o Rubocop adicionado ao projeto da API para garantir que o código está dentro
dos padrões de estilo do Ruby.

Execute o Rubocop:
```bash
docker-compose run app rubocop
```
