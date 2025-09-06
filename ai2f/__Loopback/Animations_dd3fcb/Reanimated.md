Porque usar reanimated?

1- Pra poder tirar vantagem de fazer a animacao de forma totalmente nativa(usa a UI thread, nao tem que ficar fazendo a 
ponte toda hora ) 

2 - Da a oportunidade de implementar logica complexa dentro da animacao. Porque antes a gente nao tinha acesso  à
parte de dentroda animacao, vs soh fazia o .start()nela e nao tinha mais controle, que aquela porra ia ficar atualizando
o valor da variavel que vc escolheu (Animated.value(number)) ath atingir o toValue.  Mas agora a gente controla quando comeca esses updates(startClock), como sao osupdates(timing(clock, state, config) ou spring etc) de cada passo (que vao atulizar o state com novos valores) e quando termina a animacao com Stopcloack() por exemplo. Tem mt mais coisa


com Reanimated a gente pode simplismente usar Animated.Code e fazer qualquer logica com os operadores do Animated, por exemplo recebendo os valores de estado que o HandleGestureHandler setou, como tambem os valores de estado gerado nas animmacoes enfim 

Ex:

       <Animated.Code>
          {() =>
            cond(
              eq(this.gestureState, State.ACTIVE),
              call([this.absoluteY, this.circleY], this.moving)
            )
          }

onde cond eh um condicional, eq eh equal, e call chama a funcao this.moving com [this.absoluteY, this.circleY]
de paramtero



da pra fazer direto em um gesture tambem, tipo meio que a sintaxe do listener de antes, sohq agora eh uma arrow function. A vantagem acho desse em relacao ao Animated.code ehq ele jah faz a logica no mesmo ciclod e renderizacao enquanto o Animated.Code
espera a mudanca do estado. mas por exemplo se tiver variass coisas acontecendo ao mesmo tempo, e vc quer mexer com essas varaiveis(nodes), ai se vc implementar aqui dentro ce vai ter um valor atualizado desse GestureHandler mas nao dos outros lugares

Ex:

obs: block apenas define uma sequencia de operacoes e retorna o valor da ultima, e quando eh passado como argumento eh só
colocar [toda as operacoes que vc quer fazer aqui dentro]

ex:

## Importante : no reanimated nao eh setValue, mas sim, set 

<PanGestureHandler
  onGestureEvent={event([
    {
      nativeEvent: ({ translationX: x, translationY: y, state }) =>
        block([
          set(this._transX, add(x, offsetX)),
          set(this._transY, add(y, offsetY)),
          cond(eq(state, State.END), [
            set(this.offsetX, add(this.offsetX, x)),
            set(this.offsetY, add(this.offsetY, y)),
          ]),
        ]),
    },
  ])}>
  <Animated.View
    style={{
      transform: [{ translateX: this._transX, translateY: this._transY }],
    }}
  />
</PanGestureHandler>


Exemplo de Aplicacao de Animation pra transladar em x 

Declarative Animation API
Invoking animation differs from the way it is done when using the original Animated API. Here, instead of having animation objects we operate on nodes that can perform single animation steps. In order to map an animation into a value, we will make the value to be assigned to a node that among few other things will call into the animation step node. Check timing, decay and spring nodes documentation for some details about how animation step nodes can be configured.

The example below shows a component that renders:

-------------------------------------------------------------

import Animated, { Easing } from 'react-native-reanimated';

const {
  Clock,
  Value,
  set,
  cond,
  startClock,
  clockRunning,
  timing,
  debug,
  stopClock,
  block,
} = Animated;

function runTiming(clock, value, dest) {
  const state = {
    finished: new Value(0),
    position: new Value(0),
    time: new Value(0),
    frameTime: new Value(0),
  };

  const config = {
    duration: 5000,
    toValue: new Value(0),
    easing: Easing.inOut(Easing.ease),
  };

  return block([
    cond(
      clockRunning(clock),
      [
        // if the clock is already running we update the toValue, in case a new dest has been passed in
        set(config.toValue, dest),
      ],

      //// Importante: no reanimated nao eh setValue, mas sim, set 
      [
        // if the clock isn't running we reset all the animation params and start the clock
        set(state.finished, 0),
        set(state.time, 0),
        set(state.position, value),
        set(state.frameTime, 0),
        set(config.toValue, dest),
        startClock(clock),
      ]
    ),
    // we run the step here that is going to update position
    timing(clock, state, config),
    // if the animation is over we stop the clock
    cond(state.finished, debug('stop clock', stopClock(clock))),
    // we made the block return the updated position
    state.position,
  ]);
}

export class AnimatedBox extends Component {
  // we create a clock node
  clock = new Clock();
  // and use runTiming method defined above to create a node that is going to be mapped
  // to the translateX transform.
  transX = runTiming(this.clock, -120, 120);

  render() {
    return (
      <View style={styles.container}>
        <Animated.View
          style={[styles.box, { transform: [{ translateX: this.transX }] }]}
        />
      </View>
    );
  }
}


-------------------------------------------------------
(o jeito acima da mais opcoes, mas eh mt coisa, entao eles fieram um jeito simples
de usar, pra quando a gente nao precisa mudar tanta coisa, e só quer fazer o que a Animated API jah fazia)

Backward compatible API
As it might sometimes be impractical to use the API above, there's an alternative way of invoking animation, which is similar to the original Animated API.

class Example extends Component {
  constructor(props) {
    super(props);
    this._transX = new Value(0);
    this._config = {
      duration: 5000,
      toValue: 120,
      easing: Easing.inOut(Easing.ease),
    };
    this._anim = timing(this._transX, this._config);
  }

  render() {
    return (
      <View style={styles.container}>
        <Animated.View
          style={[styles.box, { transform: [{ translateX: this._transX }] }]}
        />
        <Button
          onPress={() => {
            this._anim.start();
          }}
          title="Start"
        />
      </View>
    );
  }
}

-----------------------------------------------------------------

## This API gives the possibility to use animation with original Animated API. It's also a way of running animation on some interaction without necessity or rerendering view.