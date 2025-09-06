//Vamos fazer validacao dos dados no backend com a bibiliotec celebrate
//Essa biblioteca integra a biblioteca Joi de validacao com o express
// a validacao faz sentido em rotas de criacao ou alteracao de coisas
// ou seja, quando vem parametros do cliente

>> yarn add celebrate


//Vamo usar o Jest para fazer os testes na nossa aplicacao

// Lembrando que tem dois jeitos de fazer os testes:
1) antes de fazer o código (TDD)
2) Após fazer o código --> o jeito que a gente vai fazer aqui dessa vez

>> npm install jest -D

>> npx jest --init

√ Would you like to use Jest when running "test" script in "package.json"? ... yes
√ Choose the test environment that will be used for testing » node
√ Do you want Jest to add coverage reports? ... no
√ Automatically clear mock calls and instances between every test? ... yes

//dois dos mais importantes tipos de teste são

- unit (testa um pedaco da noossa aplicacao de forma muito isolada, uma coisa muito especifica
por exemplo na nossa aplicacao vamos testar o generateUniqueId.js que eh apenas uma funcao que gera id)
 --> nao vai ter side effects, nao encosta em nenhuma outra ferramenta ou conexao externa

- integration (testa por completo uma funcionalidade da nossa aplicacao, uma rota e por ai vai)

// apos criar os testes, como executar eles:

>> npm test 

// vamos criar um banco de dados especifico para os testes de integracao, 
// pra que  agente nao fique alternado o nosso db real com os testes

//adicionamos um novo ambiente de conexao(pra gerar uma db teste)

// adcionamos esse codigo no knexfile:

test: {
    client: 'sqlite3',
    connection: {
      filename: './src/database/test.sqlite'
    },
    migrations: {
      directory: './src/database/migrations'
    },
    useNullAsDefault: true,
  },

  // pra trabalhar com esses dois ambientes vamos instalar cross-env

  >> yarn add cross-env

  no package.json no script "test" deixamos assim:

  "test": "cross-env NODE_ENV=test jest"

  // o que esse código faz:
  quando a gente exeutar em script de teste , vamos ter disponivel uma variavel de ambiante chamada NODE_ENV

  //para ter acesso à essa variavel de ambiente no connection.js:

  const env = process.env.NODE_ENV  


  /////////pra fazer os testes de integracao ////////

  //precisamos fazer chamada a api e verificar oq devolve e tal
  //mas NÃO usaremos o axios pra fazer isso, ele nao eh recomenddo para testes
  // tipo, com o supertest a gente nao precisa fazer um request para um endereco url
  // da pra fazer "internamente", apenas assando como paramtro o app do express, onde a gente definiu tudo

  usaremos a biblioteca supertest (alem dela fazer as requisicoes vai deixar fazer umas validacoes no retorno na api)

  // como dependencia de desenvolvimento
  >> npm install supertest -D 

  // vamos subir o nosso server para fazer as chamadas teste, MAS USAREMOSOUTRA PORTA, pra nao interferir com o server real.
  --> criaremos server.js e o que era antes nosso index.js renomeamos para app.js
  --> ai no package.json no script "start" precisamos lembrar de chamar o server.js agora