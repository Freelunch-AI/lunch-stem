# API REST 

GET /users
POST /users
PUT /users/:id
DELETE /users/:id

--------------------

# GRAPHQL

1) A gente passa de uma estrutura ode a gente tem varias rotas no backend , pra uma
uma unica rota, onde a gente determina o recurso que a gente quer acessar pelo corpo da
requisição

2) O graphql tem como se fosse um insomnia integrado à ele, entao quando a gente instancia 
nosso backendconfigurado com graphql, a gente ganha uma interface vizual pra queries dentro da nossa
aplicacao.

3) Tudo vai ser POST para /graphql, mas existem 3 métodos: query/mutation/subscription. 
Query eh quand a gente quer pegar informacao do backend mas não vi mudar nada nele; 
mutation eh quando a gente muda alguma coisa no backend;
subscription eh quando eu quiser ouvir uma informacao em tempo real; --> frameworks de graphql jah tem a parte ed real-time integrada, entao nao precisamos usar  uma bibilioteca tipo socket.io

4) Podemos fazer multiplos queries e mutations em uma mesma requisicao

5) A gente passa mais responsabilidade pro forntend. Isso eh bom porque muitas vezes temos um backend que vai distribuir infromacao para variso clientes diferentes: web, mobile, externo.E esses clientes vao ter necessidades diferentes. Ex: na web eh muito interessante ter paginacao e filtro, enquanto em mobile nao, pois perde usabilidade. Entao pra configurar isso tinhamos que modificar nosso backend pra atender todas essas possibilidades. Com o graphql
a gente passa a deixar essa responsabilidade ao cliente que pode pedir coisas diferentes, com ou se paginacao, com ou se filtro. Exemplo de request:
{
  query users {
    users({per_page: 20, page: 2, filter: { nome: {"starts_with": "Diego"}}}) {
      id
      name             // !! nao precisa de virgula entre os paramtros !!
      groups //relacionamento de grupos {
        id
        title
      }
    }
  }
}

// mas porque a gente simplismente nao traz todas informacoes do backend, e soh utiliza as que a gente uer depois?
Porque isso da overfetching, que eh pegar muita coisa dessnecessaria do backend, saturando a conexao do cliente, gastando internet dele, ou seja, temos que pegar apenas o que precisamos

POST /graphql

exemplo de requisicao: 2 queries dentro da mesma requisicao

obs: nao se usa o axios e tal, tem bibiliotecas de graphql pra ajudar

# obs2: vamos usar como framework para o backend o graphql-yoga , que eh basicamente um wrapper em cima do express,
utiliza ele por debaixo dos panos

# obs3: // !! nao precisa de virgula entre os parametros da req !!


## Modo de Enchergar a requisicao: veja que a gente estrutura a nossa reuqisição eatamente do jeito que 
## a gente quer receber a resposta, a resposta vai ser um objeto que praticamente espelha a estrutura da nossa
## requicisao. Observacao: na resposta todos nossos dados vao ser englobados pela propriedade data: como de custume,
# jah que podemos passar outra configuracoes que nao tem a ver com os dados diretamente 

Exemplos:

## Exemlplo  1. (Uma query)

# request:

query HeroNameAndFriends {
  hero {
    name
    friends {
      name
    }
  }
}

# response:

{
  "data": {
    "hero": {
      "name": "R2-D2",
      "friends": [
        {
          "name": "Luke Skywalker"
        },
        {
          "name": "Han Solo"
        },
        {
          "name": "Leia Organa"
        }
      ]
    }
  }
}


## Exemplo 2. (multiplas queries)

#  request:

# obs:  nesse caos estamos fazendo duas queries iguais, entao temos que colocar aliases(nomes) às 
# duas queries, pra que a resposta seja um objeto dentro da prppriedade com o nome que a gente deu

{
  empireHero: hero(episode: EMPIRE) {
    name
  }
  jediHero: hero(episode: JEDI) {
    name
  }
}

# response

{
  "data": {
    "empireHero": {
      "name": "Luke Skywalker"
    },
    "jediHero": {
      "name": "R2-D2"
    }
  }
}

## Exemplo 3. (usando fragments pra reutilizar codido da query, tipo pra gente nao ter q reescrever os parametros)

#  request:

{
  leftComparison: hero(episode: EMPIRE) {
    ...comparisonFields
  }
  rightComparison: hero(episode: JEDI) {
    ...comparisonFields
  }
}

fragment comparisonFields on Character {
  name
  appearsIn
  friends {
    name
  }
}

# response

{
  "data": {
    "leftComparison": {
      "name": "Luke Skywalker",
      "appearsIn": [
        "NEWHOPE",
        "EMPIRE",
        "JEDI"
      ],
      "friends": [
        {
          "name": "Han Solo"
        },
        {
          "name": "Leia Organa"
        },
        {
          "name": "C-3PO"
        },
        {
          "name": "R2-D2"
        }
      ]
    },
    "rightComparison": {
      "name": "R2-D2",
      "appearsIn": [
        "NEWHOPE",
        "EMPIRE",
        "JEDI"
      ],
      "friends": [
        {
          "name": "Luke Skywalker"
        },
        {
          "name": "Han Solo"
        },
        {
          "name": "Leia Organa"
        }
      ]
    }
  }
}

# pra rodar o servidor: node src/server.js como de custume, vai levantar servidor no localhost:4000
