>> expo init pwaexpo

pra rodar:
>> yarn web

vai ficar igualzinho desenvolvimento mobile
maioria (uns 70%) dos modulos da pra usar na web 


>> yarn add @react-navigation/native
>> expo install react-native-gesture-handler react-native-reanimated react-native-screens react-native-safe-area-context @react-native-community/masked-view
>> yarn add @react-navigation/bottom-tabs

>> expo install expo-camera


ai da pra rodar nos emuladores andorid e ios e veriicar como fica !

## Importante: pra usar a camera no celular precisa colocar os codigos de permissoes,ta tudo na docuentacao do expo


gerando o build:

>> expo build:web

>>yarn global add netlify-cli

>> netflify login

>> netflify deploy --dir web-build

ele vai dar um link da nossa plicacao rodando, porem nai eh a de producao ainda
eh de "staging" pra gentever se ta tudo certo mesmo pra depois colocar em producao


pra colcoar em producção:
>> netlify deploy --prod


o daora eh que o wervice worker, que eh um thread que vai rodar javascript no navegador(sem er a que manipula a dom) fazendo nossa codigo funcionar lah, vai gerar cash das coisas sempre parecidas da nossa aplicacao => ai vc entra offile ele vai lembrar e mostrar uma tela !!

ele carrega tudo, menos o que eh importante estar atualizado na aplicacao(os dados em si que vemd e api principalemnte) (no ios n funciona direito isso)

## importante: configuar adaptive icon: pra ele se adaptar (quadrado, redondo ...)

