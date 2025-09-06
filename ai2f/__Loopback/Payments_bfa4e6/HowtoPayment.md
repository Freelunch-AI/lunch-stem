///////////////// How to do Payment  /////////////

///Overview:

## a) Melhores plataformas: Stripe e Pagar.me

## b)  Quer usar em ReactJS(web) ou React Native(mobile) ?

  ## b1) Se for ReactJS(web) tanto Stripe como Pagar.me tem uma integracao muito boa já com o lado do cliente.
  Além de ser super simples de usar, nao tem o bo de ir pro nosso server os dados do cartao do cliente!

  No docs do stripe o primeiro exemplo jah mostra isso, no docs do pagar.me tem que ir na parte de checkout

  ## b2) Se for ReactNative, ai nao da pra fazer a integracao, e vamos ter que mandar manualmente os dados atraves do cliente(do cartao) pra pegar um token(nos tripe eles chamam assim)/hash(nos pagar.me eles chama assim) pra depois fazer a transacao por outro POST que vai ter esse token/hash junto com outras info que vao depender da plataforma



//////////////////////


##// Passo a Passo React Native

## 0) Criamos uma conta e recebemos a SECRET KEY/API KEY

## 1) O cliente vai preencher um forms com os dados do cartao

OBS: Em vez de criar um forms pra isso, tem uma bibilioteca que ah faz isso pra nois!
https://github.com/sbycrosz/react-native-credit-card-input

## 2 - Stripe) A gente vai pegar as info resutante do submit desse forms(objeto), mandar um POST pro nosso server e no  nosso server mandar na requisicao POST para o Stripe para obter o card token

https://stripe.com/docs/api/tokens/create_card

Ex: NO SERVER

var stripe = require('stripe')('sk_test_hCznjbAZyxHa9xHsXlm1cP3w00yW2faYq3');

stripe.tokens.create(
  {
    card: {
      number: '4242424242424242',
      exp_month: 4,
      exp_year: 2021,
      cvc: '314',
    },
  },
  function(err, token) {
    // asynchronously called
  }
);

## 2 -Pagar.me) A gente vai pegar as info resutante do submit desse forms(objeto), fazer um POST pro nosso server  e dentro do nosso server usar a biblioteca pagarme para fazer um metodo(que eh um post) que vai devolver uma hash do card pra gente 

https://docs.pagar.me/reference#gerando-card_hash-manualmente

Ex: NO SERVER

const pagarme = require('pagarme')

pagarme.client.connect({ encryption_key: 'SUA_ENCRYPTION_KEY' })
  .then(client => {
    return client.security.encrypt({
      card_number: '4111111111111111',
      card_holder_name: 'abc',
      card_expiration_date: '1225',
      card_cvv: '123',
    })
  })
  .then(card_hash => console.log(card_hash))

## 3 - Stripe ) request.body.payment_method_id é o nosso token que conseguimos anteriormente, e ai a gente cloca mais 
essa propridades na requisicao e pronto

https://stripe.com/docs/api/payment_intents/create

intent = await stripe.paymentIntents.create({
        payment_method: request.body.payment_method_id,
        amount: 1099,
        currency: 'usd',
        confirmation_method: 'manual',
        confirm: true
      });

## 3 - Pagar.me ) Todas as prorpiedades com card_algumacoisa podem e devem ser substituidas pelo card_hash

Percebe-se que tem que passar muiito mais coisa no pagarme, porque ele faz uma verificacoes dele, pra entnder
asnossa transacaoes, e nao soh simplismente aceitar a quantia de grana, por isso parece mais seguro e tal

https://docs.pagar.me/reference#criar-transacao

const pagarme = require('pagarme')

pagarme.client.connect({ api_key: 'SUA_API_KEY' })
  .then(client => client.transactions.create({
    "amount": 21000,
    "card_number": "4111111111111111",
    "card_cvv": "123",
    "card_expiration_date": "0922",
    "card_holder_name": "Morpheus Fishburne",
    "customer": {
      "external_id": "#3311",
      "name": "Morpheus Fishburne",
      "type": "individual",
      "country": "br",
      "email": "mopheus@nabucodonozor.com",
      "documents": [
        {
          "type": "cpf",
          "number": "30621143049"
        }
      ],
      "phone_numbers": ["+5511999998888", "+5511888889999"],
      "birthday": "1965-01-01"
    },
    "billing": {
      "name": "Trinity Moss",
      "address": {
        "country": "br",
        "state": "sp",
        "city": "Cotia",
        "neighborhood": "Rio Cotia",
        "street": "Rua Matrix",
        "street_number": "9999",
        "zipcode": "06714360"
      }
    },
    "shipping": {
      "name": "Neo Reeves",
      "fee": 1000,
      "delivery_date": "2000-12-21",
      "expedited": true,
      "address": {
        "country": "br",
        "state": "sp",
        "city": "Cotia",
        "neighborhood": "Rio Cotia",
        "street": "Rua Matrix",
        "street_number": "9999",
        "zipcode": "06714360"
      }
    },
    "items": [
      {
        "id": "r123",
        "title": "Red pill",
        "unit_price": 10000,
        "quantity": 1,
        "tangible": true
      },
      {
        "id": "b123",
        "title": "Blue pill",
        "unit_price": 10000,
        "quantity": 1,
        "tangible": true
      }
    ]
  }))
  .then(transaction => console.log(transaction))


## Exemplos de Aplicacoes

  Stripe no react-native medium

  https://medium.com/@lyzhovnik/using-stripe-payment-service-with-react-native-and-fetch-4177c8d992cb

  MercadoPago(outra alternativa) no react-native medium

  https://medium.com/@lyzhovnik/using-stripe-payment-service-with-react-native-and-fetch-4177c8d992cb
