>> yarn add typescript -D

>> yarn tsc --init

>> yarn add express

>> yarn add @types/express

para converter nosso server.ts em server.js
>> yarn tsc 
mas nao vamos fazer assim
vamos automatizar isso com algumas ferramentas

basicamente uma soma do tsc + node + nodemon
>> yarn add ts-node-dev -D

ai eh soh rodar yarn ts-node-dev src/server.js

mas vamo criar um "script" : { "dev": "ts-node-dev src/server.js"}
com as flags --respawn --transpile-only

# configuracoes no tsconfig.json

pra ele mandar o build pra outra pasta na hora do deploy
pra nao mandar arquivos typescriot desnecessarios junto

"outDir": "./dist",                        
"rootDir": "./src",                 

pra conversao do codigo no build de producao
mudar o es5 pra es2017

"allowJs": true,

"lib": ["es6"],  

"removeComments": true,

comentar:
// "strict": true,

para Type ORM eh mt bom pois ele usa a sintaxe de decorators "@"
"emitDecoratorMetadata": true,

pra ele procuara as tipagens no node_modules e tb
poder substituir a tipgame quando necessario
"typeRoots": [
      "./node_modules/@types",
      "./src/@types"
    ], 

adicionar:
permite que possa fazer importacoes json dentro do codigo
"resolveJsonModule": true,

encurtar os paths assim:
"baseUrl": ".",
"paths": {
      "@controllers/*": ["./src/controllers/*"],
      "@models/*": ["./src/models/*"],
      "@views/*": ["./src/views/*"],
      "@config/*": ["./src/config/*"]
    }


masprecisamos instalar essa dependencia pra usar:

>> yarn add tsconfig-paths -D

alteramos o script dev para:
"dev": "ts-node-dev -r tsconfig-paths/register --respawn --transpile-only --ignore-watch node_modules src/server.js"

# eslint

>> yarn add eslint -D

>> yarn eslint --init

perguntas: 

how would you like to use? enforce code

whats type..? commonjs
which framework? none (pq tamo no backend)
typesript? yes
...
style do airbnb, mas como tava dando ruim pq da versao usamos standard

config file in json

ai qundo ele fala pra instalar com npm, fala nao e instala as dependencias com yarn

colocar isso no setting.json pra ele corrigir automatico
"editor.codeActionsOnSave": {
      "source.fixAll.eslint": true
    }
}


# jest 

>> yarn add jest

>> yarn jest --init

perguntas:
vamos adicioan rum scipt de teste
sem coverage reports, vamos configurar dps na mao
limpar os mocks em cada teste

por padrao nao funciona com typescript

>> yarn add ts-jest -D

em jest.config colocar :

"preset": "ts-jest",

no eslint dentro do "env" colocar:

>> yarn add @types/jest

>> yarn test pra ver se ta certo

pra ele entender as importacoe com @
no jest.config.js:

const { compilerOptions } = require('./tsconfig.json');
const { pathsToModuleNameMapper } = require('ts-jest/utils')

moduleNameMapper: pathsToModuleNameMapper(compilerOptions.paths, { prefix: '<rootDir>' }),


em tsconfig.json:

"include": [
    "src/**/*"
  ]

# build com babel 

>> yarn add -D @babel/cli @babel/core @babel/node @babel/preset-env @babel/preset-typescript babel-plugin-module-resolver



criar babel.config.js e colocar dentro:

module.exports = {
  presets = [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current'
        }
      }
    ],
    '@babel/preset-typescript'
  ],
  plugins: [
    ['module-resolver', {
      alias: {
        '@config': './src/config',
        '@models': './src/models',
        '@views': './src/views',
        '@controllers': './src/controllers'
      }
    }]
  ],
  ignore: [
    '**/*.spec.ts'
  ]
}



criando script de build:

"build": "babel src --extesions \".js,.ts\" --outdir dist --copy-files --no-copy-ignored",



# importante: pasta dist eh a que vai ser criada e usada em producao

criar .eslintignore
 e colocar:

 dist
/*.js



por ultimo, script para executar aplicacao em producao:

"start": "node dist/server.js",
//////////////////////////////////////

>> yarn add @types/babel-core 
>> yarn add @types/babel-generator

  