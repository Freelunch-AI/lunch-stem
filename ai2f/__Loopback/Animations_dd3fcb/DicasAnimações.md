/// se for usar a Animated API, sempre usar com a propriedade useNativeDriver: true
//  pra ele rodar nativamente e nao ter que fazer a ponte do javascript pro nativo toda hora q causa lag


///o problema ehq useNativeDriver: true só funciona com non-layout properties que são:
// backgrgoundColor, opacidade e transformations 


//// cso de uso: se eu tenho um botao submit que dependendo do estado mostra coias diferentes dentro dele
/// tipo: se ta crregando ele soh mostro o icone de certo dentro =, mas se jah carregou tb mostra 
// um escrito de submit
/// como da pra perceber o tamnho do botao vai ser diferente 
// mas tipo pra fazer com p Animated, eu teria que saber os tamanhos de antes e depois, nao eh tao simples assim

// e jah vimos que nao vamos connsguir mudar o width usando nativeDriver neh

//SOLUCAO:  se a gent equer fazer a transicao entre dois layout da pra usar LayoutAnimation 
//ex:  LayoutAnimation.configurenext(LayoutAnimation.Presets.easeInEaseOut);

In short, this method will trigger the layout animation fro the next render cycle (ideal colocar no useEffect)
, it will add a nice transition to the layout change depending on the config you give


/// caso de uso de performance/lag: vamos supor que eu quero fazer logo na entrada do meu app 4 animacoes,
// oproblema ehq na entrada do app geralmente tem que fazer umas chamadas a api e tal quando o omponente 
// é montado meter lag na nossa animacao:

//SOLUCAO: da pra tratar as 4 animacoes como uma animacao só, em que cada uma inicia em um ponto diferente do input 
// range !


