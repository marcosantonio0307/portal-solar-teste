# PORTAL SOLAR TESTE

Essa é uma aplicação de um painel onde os clientes Portal Solar podem
se cadastrar e fazer simulações para encontrar o melhor gerador de
energia solar para sua usina de microgeração.

Nesse repositorio está a API e o Painel do usuário. Sendo a API desenvolvidade
em Ruby on Rails (v6.1) e o painel em NextJS (v13.4).

## Instalação e execução

Este projeto foi desenvolvido utilizando Docker e Docker Compose, então
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
docker-compose run app bundle exec rails db:create db:migrate
```
5. Inicie a aplicação:
```bash
docker-compose up
```
6. Acesse a aplicação no seu navegador:
- API: http://localhost:3000 (para testar requisições)
- Painel: http://localhost:3001 (para acessar o painel do usuário)

## Testes

A aplicação tem uma suite de testes automatizados usando Rspec e Rswag para
garantir seu funcionamento.

- Para rodar os testes da API, execute:
```bash
docker-compose run app bundle exec rspec
```
### Teste os endpoints da API

Como estamos usando o Rswag, você pode acessar a url
http://localhost:3000/api-docs e encontrar toda a documentação sobre os
endpoints e ainda testa-los por lá mesmo se preferir :)

## Informações adicionais

Temos duas ferramentas bem legais para manter a qualidade da aplicação.
São elas:
- Rubocop: para manter o código limpo e organizado
- SimpleCov: para garantir que estamos testando tudo que precisamos

### Rubocop
Execute o Rubocop para verificar se o código está dentro dos padrões:
```bash
docker-compose run app bundle exec rubocop
```

### Coverage
Para verificar a cobertura dos testes, execute:
```bash
docker-compose run app bundle exec rspec
```
Após a execução dos testes, você pode verificar a cobertura acessando o arquivo
`coverage/index.html` no seu navegador.


