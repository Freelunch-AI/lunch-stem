/////para encriptar a password vamos usar uma biblioteca de hash

>> yarn add bcryptjs

###IMPORTANTE PORQUE NAO USAR MONGO#####

// a gente vai ver aqui que quando vs comeca a precisar de muitos relacionamentos 
// a sintaxe vai ficar muito verbosa e complicada por isso nesses casos vale mais a pena bancos
// sql

// um project vai pertencer a um user, cada project pode ter varias tarefas(ou nenhuma), e 
// essas tarefas podem ser designadas a outros users 


###instalacoes

///////////// para usar token
>> yarn add jsonwebtoken

//// pra gente trabalahar com os modulos de file system e path
// e poder importar todos os arquivos de um diretorio
>> yarn add fs path 

OU MELHOR, COMO O  DIEGO ENSINOU ATUALMENTE:

>> yarn add require-dir

requireDir("[diretorio]"); que ele jah faz o require do diretorio inteiro

// pra mandar os emails 
>> yarn add nodemailer

// trabalhar com templates de email
>> yarn add nodemailer-express-handlebars

