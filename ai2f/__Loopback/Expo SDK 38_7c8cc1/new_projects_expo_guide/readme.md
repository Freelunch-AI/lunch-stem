1. Projeto jah rodando em react antive cli:

-> segue tutorial unimodules

2. Projeto expo e quer ir para bare workflow + unimodules:

-> yarn eject (fazer backup)

3. Novos projetos:
(bare workflow + unimodules)
importante: nao escolher templates, senao nao vai fica rno bareworkflow
>> yarn create react-native-app 

Pra usar com typescript:

mudar para App.tsx

adicionar tsconfig.json com:

{
  "compilerOptions": {
    "allowSyntheticDefaultImports": true,
    "jsx": "react-native",
    "lib": ["dom", "esnext"],
    "moduleResolution": "node",
    "noEmit": true,
    "skipLibCheck": true
  }
}

instalar as dependenccias do typescript: tipagem do react-native e react-native dom

>> yarn add --dev typescript @types/react @types/react-native @types/react-dom



// pro update over the air 
expo login 

yarn expo publish

## importante: tem que rodar o yarn expo publish antes de lancar o app, 
## pra ele saber onde tao sendo os updates