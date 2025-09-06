########OBSERVAÇÃO IMPORTANTE #######

/// vamos sempre trabalahr recebendo json no backend por padrao  #####

/// se fosse na fetch api teriamos que dar json.stringify no nosso objeto javascript que mandarms pelo front end
/// porque json as keys sao todas string 
// e na hora de recber fazer res.json tambem pra converter dvolta 

//////////////
///!!PORÉM O axios jah faz essa parte pra gente, entao apenas trabalhamos com os objetos msm!!


#########EXEMPLO ROCKETSEAT - CONFIGURACAO AXIOS PRA CONSUMIR API ########

###Serviços###
// Nesse sistema existirá dois serviços importantes que serão requisitados em diversas situações, 
// por isso que foi criado o diretório services. Um serviço para a autenticação do usuários, o auth.js, 
// e o outro para consumir os dados da nossa API feita com o AdonisJS, o api.js.

// No arquivo services/auth.js, como dito, será tratado a autenticação dos usuários, e para isso há quatro 
// funções login, logout, getToken e isAuthenticated:


export const TOKEN_KEY = "@airbnb-Token";
export const isAuthenticated = () => localStorage.getItem(TOKEN_KEY) !== null;
export const getToken = () => localStorage.getItem(TOKEN_KEY);
export const login = token => {
  localStorage.setItem(TOKEN_KEY, token);
};
export const logout = () => {
  localStorage.removeItem(TOKEN_KEY);
};

// Já no services/api.js será definido qual é a API de consumo, para você não ficar passando 
// isso por extenso toda hora, e já pode definir o headerde Authorization passando o token jwt 
// caso o mesmo exista. (Famoso 2 coelhos, uma cajadada rsrs)

import axios from "axios";
import { getToken } from "./auth";

const api = axios.create({
  baseURL: "http://127.0.0.1:3333" 
 ///importante: esssa base_url no ios eh o padrao localhost mesmo  (https//locahost:3333/) acho que eh isso
});

api.interceptors.request.use(async config => {
  const token = getToken();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;


######AXIOS SENDING BEARER AUTHORIZATION (github)########

const config = {
    headers: { Authorization: `Bearer ${token}` }
};

const body = {
   key: "value"
};

Axios.post( 
  'http://localhost:8000/api/v1/get_token_payloads',
  body,
  config
).then(console.log).catch(console.log);

########CONFIGURING BEARER AUTHORIZATION TO BE DEFAULT (github)#####
import axios from 'axios';
axios.defaults.baseURL = 'http://localhost:1010/'
axios.defaults.headers.common = {'Authorization': `Bearer ${token}`}
export default axios;



#######BASIC ########
//obs: body vai ta em response.data


///get request

axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

///post request

axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

#######CONCURRENT REQUESTS #########


function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // Both requests are now complete
  }));

