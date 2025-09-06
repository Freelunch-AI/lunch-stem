///// tutorial Gesture Handler

// 1) Installation:
///////////////


// yarn add react-native-gesture-handler

// react-native link react-native-gesture-handler

// Update your MainActivity.java file (or wherever you create an instance of ReactActivityDelegate), 
//so that it overrides the method responsible for creating ReactRootView instance and then use the root 
//view wrapper provided by this library. Do not forget to import ReactActivityDelegate, ReactRootView, and 
//RNGestureHandlerEnabledRootView:


///Abaixo estao com + as linhas que tem que ser adicionadas:

// package com.swmansion.gesturehandler.react.example;

// import com.facebook.react.ReactActivity;
// + import com.facebook.react.ReactActivityDelegate;
// + import com.facebook.react.ReactRootView;
// + import com.swmansion.gesturehandler.react.RNGestureHandlerEnabledRootView;

// public class MainActivity extends ReactActivity {

//   @Override
//   protected String getMainComponentName() {
//     return "Example";
//   }

// +  @Override
// +  protected ReactActivityDelegate createReactActivityDelegate() {
// +    return new ReactActivityDelegate(this, getMainComponentName()) {
// +      @Override
// +      protected ReactRootView createRootView() {
// +       return new RNGestureHandlerEnabledRootView(MainActivity.this);
// +      }
// +    };
// +  }
// }


///Usage
////////////

////// We will have componenets for each handler(pan, pinch.. etc)
// that NEEDS to wrap around a View, that reccognizes a type of gesture 
// and gives information about that gesture via events (translation, scale etc)

// whenone gesture becomes active it cancels all the other gestures

//Available gesture handlers: 
// PanGestureHandler,
// TapGestureHandler,
// LongPressGestureHandler,
// RotationGestureHandler,
// FlingingGestureHandler,
// PinchGestureHandler,
//ForceGestureHandler,

///Two types;
// continuos and dicrete 

//continuos gh are active for a long period of time and generate a stream of
// gesture events until the gesture is over.Ex: PanGestureHandler

// discrete are boolean, like LongPress that deteccs only if it deteccted a long press or not

///exemplo: onGestureEvent pode chamar Animated.event([{nativeEvent:{x: this._touch}}], {useNativeDriver: true, listener: (e) => console.log(e)}) vc desestrutura as info que vc recebeu do evento jah atribuindo a uma variavel (this._touch nesse caso), ai como segundo argumento pode chamar uma funcao que recebe o evento tb.
Exemplo:


// um eventhandler em cima desse valores. Por exemplo pra mudar a posicao de uma View conforme o gesturehandler
// detecta que ela ta sendo arrastada. E ai o eventhandler faz o animatedValue.setValue(posicao x detectado por ex)
// e eisso vai ser repassado pro style da view!

// A diferenca ehq o que a gente tava acostumado era o Animated.timing modificar os valores pra mim conforme a o tempo e funcao de easing

/////////Nesting Handler:
//Ex: (without hooks)

class Multitap extends Component {
  render() {
    return (
      <LongPressGestureHandler
        onHandlerStateChange={this._onLongPress}
        minDurationMs={800}
      >
        <TapGestureHandler
          onHandlerStateChange={this._onSingleTap}
          waitFor={this.doubleTapRef} //ele vai esperar pra ver se o  TapEventHandler vai
          // ser ativado tb, pq ai o usuario apertou duas vezes e nao soh uma
        >
          <TapGestureHandler
            ref={this.doubleTapRef}
            onHandlerStateChange={this._onDoubleTap}
            numberOfTaps={2}
          >
            <View style={styles.box}>
            </View>
          </TapGestureHandler>
        </TapGestureHandler>
      </LongPressGestureHandler>
    )
  }
}

// ok so we used this prop onHandlerStateChange do a event handler kind of thing

// But what exactly is passed as argument for the event handler and what are these state changes?

//////Gesture handler can be treated as state machines that can have these states:

// UNDETERMINED
// FAILED 
// BEGAN
// CANCELLED
// ACTIVE
// END

/// ad we pass to the event handler function an object containing nativeEvent property 

//we can extract the state with nativeEvent.state 
//lets see an example:

import {State, LongPressGestureHandler} from 'react-native-gesture-handler';
import { Animated } from 'react-native';

class Demo extends Component {
  _handleStateChange = ({nativeEvent}) => {
    if (nativeEvent.state === State.ACTIVE) {
      Alert.alert('Longpress')
    }
  };
  render() {
    return (
      <LongPressGestureHandler onHandlerStateChange={this._handleStateChange}>
        <Text style={styles.buttonText}>LongPressMe</Text>
      </LongPressGestureHandler>
    )
  }
}


///////State Flows

// longer arrows represent that there are more touch event sreceived befoore state change

// usuallyis like this: (when thinngs go well)
// UNDETERMINED -> BEGAN --------> ACTIVE --------> END -> UNDETERMINED

// other possibility: 
// UNDETERMINED -> BEGAN -----> FAILED -> UNDETERMINED

// or can be:
// UNDETERMINED -> BEGAN -----> ACTIVE -> CANCELLED -> UNDETERMINED

//Basicante o gesture entra no began quando ele identifica um evento que pode ser o cmeco do gesto que
// ele quer indicar, mas se a acao nao seguir do jeito que ta definido o gesto ele nao ativa

// e o usuario ou o prorio sistema (interferencia de touches) pode causar o cancelamento da acao jah ativa 





////////// Cross handler iteractions

// Gesture handlers can communicate with each other in order to allow complexx gesture interactions and 
// to control how they activate i certain scenarios

// There are two ways of control: simultaneos and awaiting
// in BOTH CASES WE NEED TO provide a ref of one handler (with React.reateRef)


///1) Simultaneous

// por default quando um gesture handler ta ativo ele cancela todos os outros handlers no BEGAN,
// enquanto ele ta ativo, soh ele pode estar ativo
// PORÉM, podemos mudar esse comportamento usando a propriedade SimultaneousHandlers que recebe uma ref 
// ou array the ref the outrso handlers que vao poder estar ativos jutos com ela

// CASO DE USO: preview de foto que vc pode girar ela, fazer zoom(scaling e arrastar)

//Vamos ver um exemplo:

class Pinchable extends React.Component {
  render() {
    const imagePinch = React.createRef();
    const imageRotation = React.createRef();
    return (
      <RotationGestueHandler
        ref={imageRotation}
        simultaneousHandlers={imagePinch}
        onGestureEvent={this.onRotateGestureEvent}
        onHandlerStateChange={this.onRotateHandlerStateChange}
      >
        <Animated.View>
          <PinchGesturehandler
            ref={imagePinch}
            simultaneousHandlers={imageRotation}
            onGestureEvent={this._onPinchGestureEvent}
            onHandlerStateChange={this.onPinchHandlerStateChange}
          >
            <Animated.View style={styles.container} collapsable={false}>
              <Animated.Image 
                style={[styles.pinchable, {/* events-related trasformations*/}]}
              />
            </Animated.View>
          </PinchGesturehandler>
        </Animated.View>
      </RotationGestueHandler>
    )
  }
}



/////Awaiting other handlers

///CASO DE USO: quando quero diferenciar single tap, double tap, long press da mesma view poe exemplo

// ex que a gente jah tinha visto antes:

class Multitap extends Component {
  render() {
    return (
      <LongPressGestureHandler
        onHandlerStateChange={this._onLongPress}
        minDurationMs={800}
      >
        <TapGestureHandler
          onHandlerStateChange={this._onSingleTap}
          waitFor={this.doubleTapRef} //ele vai esperar pra ver se o  TapEventHandler vai
          // ser ativado tb, pq ai o usuario apertou duas vezes e nao soh uma
        >
          <TapGestureHandler
            ref={this.doubleTapRef}
            onHandlerStateChange={this._onDoubleTap}
            numberOfTaps={2}
          >
            <View style={styles.box}>
            </View>
          </TapGestureHandler>
        </TapGestureHandler>
      </LongPressGestureHandler>
    )
  }
}


///// Now  lets take a look into each gesturehandleer api in depth(which properties we can use and what it 
//passes to eventhandler  function etc)


//BUT FIRST: There are some basic properties that ALL gesturehandlers have, so we will talk about them first

///// 1) Units:

// All of the handler componetns properties and event atributtes that represents onscreen dimensions are expressed 

//// 2) properties:

## enabled
// Takes a boolean value. Indicates if the given handler should be analyzing stream of touch events or not. When set to false we can be sure that the handler will never activate. If the value gets updated while the handler already started recognizing gesture it will immediately fail or cancel recognizing depending on its current state. Default value is true.

## shouldCancelWhenOutside
// Takes a boolean value. When true the handler will cancel or fail recognition (depending on its current state) whenever the finger leaves the area of the connected view. Default value of this property is different depending on the handler type. Most of the handlers defaults to true but in case of the LongPressGestureHandler and TapGestureHandler

## simultaneousHandlers
// Accepts a react ref object or an array of refs to other handler components (refs should be created using React.createRef()). When set the handler will be allowed to activate even if one or more of the handlers provided by their refs are active. It will also prevent the provided handlers from cancelling current handler when they activate. Read more in the cross handler interaction section.

## waitFor
// Accepts a react ref object or an array of refs to other handler components (refs should be created using React.createRef()). When set the handler will not activate as long as the handlers provided by their refs are in began state. Read more in the cross handler interaction section.

## hitSlop
// This parameter enables control over what part of the connected view area can be used to begin recognizing the gesture. When a negative number is provided the bounds of the view will reduce the area by the given number of points in each of the sides evenly.

// Instead you can pass an object to specify how each boundary side should be reduced by providing different number of points for left, right, top or bottom sides. You can alternatively provide horizontal or vertical instead of specifying directly left, right or top and bottom. Finally, the object can also take width and height attributes. When width is set it is only allow to specify one of the sides right or left. Similarly when height is provided only top or bottom can be set. Specifying width or height is useful if we only want the gesture to activate on the edge of the view. In which case for example we can set left: 0 and width: 20 which would make it possible for the gesture to be recognize when started no more than 20 points from the left edge.

## IMPORTANT: Note that this parameter is primarily designed to reduce the area where gesture can activate. Hence it is only supported for all the values (except width and height) to be non positive (0 or lower). Although on Android it is supported for the values to also be positive and therefore allow to expand beyond view bounds but not further than the parent view bounds. To achieve this effect on both platforms you can use React Native's View hitSlop property.

## onGestureEvent
// Takes a callback that is going to be triggered for each subsequent touch event while the handler is in an ACTIVE state. Event payload depends on the particular handler type. Common set of event data attributes is documented below and handler specific attributes are documented on the corresponding handler pages. E.g. event payload for PinchGestureHandler contains scale attribute that represents how the distance between fingers changed since when the gesture started.

## Instead of a callback ////Animated.event object can be used////. Also Animated events with useNativeDriver flag enabled are fully supported.

## onHandlerStateChange
// Takes a callback that is going to be triggered when state of the given handler changes.

// The event payload contains the same payload as in case of onGestureEvent including handler specific event attributes some handlers may provide.

// In addition onHandlerStateChange event payload contains oldState attribute which represents the state of the handler right before the change.

## Instead of a callback Animated.event object can be used. Also Animated events with useNativeDriver flag enabled are fully supported.

// Event data
// This section describes the attributes of event object being provided to onGestureEvent and onHandlerStateChange callbacks:

## state
// Current state of the handler. Expressed as one of the constants exported under State object by the library. Refer to the section about handler state to learn more about how to use it.

## numberOfPointers
// Represents the number of pointers (fingers) currently placed on the screen.



///////
Observacao: todos os gestures devlvem event data que engloba sempre a posicao do(s) ponteiro(s)(dedo(s)) e ai
outros marcadores dependendo do gestureHandler, e isso tudo vem na propriedade ddo evento que chama //nativeEvent// 
por ex:
<FlingGestureHandler   
  onHandleStateChange={{nativeEvent} => {/* faz alguma coisa */}}
>
...
</FlingGestueHandler>


//////////// PanGestureHandler /////////////

Overview:

A continuous gesture handler that recognizes panning (dragging) gesture and allows for tracking their movement.

The handler activates when finger is placed on the screen and moved by some initial distance. The distance can be configured and allow for detecting only vertical or horizontal pan. Also the number of fingers required for the handler to activates can be configured, which allows for detecting multifinger swipes.

Gesture callback can be used for continuous tracking of the pan gesture. It provides information about the translation from the start of the gesture as well as tracks the velocity.

Component PanGestureHandler exposes a number of properties that allows for customizing the criteria under which the handler will activate or fail recognizing.

SEE DOCUMENTATION FOR PROPERTIES!!

Example:

const circleRadius = 30;
class Circle extends Component {
  _touchX = new Animated.Value(windowWidth / 2 - circleRadius);
  _onPanGestureEvent = Animated.event([{nativeEvent: {x: this._touchX}}], { useNativeDriver: true });
  render() {
    return (
      <PanGestureHandler
        onGestureEvent={this._onPanGestureEvent}>
        <Animated.View style={{
          height: 150,
          justifyContent: 'center',
        }}>
          <Animated.View
            style={[{
                backgroundColor: '#42a5f5', borderRadius: circleRadius, height: circleRadius * 2, width: circleRadius * 2,
              }, {
                <!-- nao entendi mt bem ppq ele fez esse add aqui mas suave -->
                transform: [{translateX: Animated.add(this._touchX, new Animated.Value(-circleRadius))}]
              }]}
          />
        </Animated.View>
      </PanGestureHandler>
    );
  }
}

////// TapGestureHandler ///////////

Overview:

A discrete gesture handler that recognizes tap (or many taps).

Tap gestures detect one or more fingers touching the screen briefly. The fingers involved in these gestures must not move significantly from the initial touch points, and you can configure the number of times the fingers must touch the screen and allowable distance. For example, you might configure tap gesture recognizers to detect single taps, double taps, or triple taps.

For the handler to be activated the specified number of fingers must tap the view a specified number of times in proper time and with short enough delay. When handler gets activated it will turn into END state immediately. The handler will fail to recognize if the finger is moved further than the allowable distance.


Example:

export class PressBox extends Component {
  doubleTapRef = React.createRef();
  render() {
    return (
      <TapGestureHandler
        onHandlerStateChange={this._onSingleTap}
        waitFor={this.doubleTapRef}>
        <TapGestureHandler
          ref={this.doubleTapRef}
          numberOfTaps={2}>
          <View style={styles.box} />
        </TapGestureHandler>
      </TapGestureHandler>
    );
  }
}


/////////LogPress GestureHandler /////////


Overview:

A discrete gesture handler that activates when the corresponding view is pressed sufficiently long. When handler gets activated it will turn into END state when finger is released. The handler will fail to recognize if the finger is lifted before the minimum required time or if the finger is moved further than the allowable distance.

Example:

const LongPressButton = () => (
  <LongPressGestureHandler
      onHandlerStateChange={({ nativeEvent }) => {
        if (nativeEvent.state === State.ACTIVE) {
          Alert.alert("I'm being pressed for so long");
        }
      }}
      minDurationMs={800}>
      <View style={styles.box} />
  </LongPressGestureHandler>
);

////////////////RotationGestureHandler ///////////

Overview:

A continuous gesture handler that recognizes rotation gesture and allows for tracking its movement.

The handler activates when fingers are placed on the screen and change their position in a proper way. Gesture callback can be used for continuous tracking of the rotation gesture. It provides information about the rotation, anchor (focal) point of gesture and progress of rotating.


Exemplo:

class RotableBox extends React.Component {
  _rotate = new Animated.Value(0);
  _rotateStr = this._rotate.interpolate({
    inputRange: [-100, 100],
    outputRange: ['-100rad', '100rad'],
  });
  _lastRotate = 0;
  _onRotateGestureEvent = Animated.event(
    [{ nativeEvent: { rotation: this._rotate } }],
    { useNativeDriver: USE_NATIVE_DRIVER }
  );


<!-- /////observacao: essa parte é muito importate para que se conserve sentido 
do mapeamento input output, pois pra esse mapaemento fazer sentido _rotate tem que ser um valor acumulado,
entao eu nao posso a cada passo fica sbreescrevedo o valr de _rotate com uma rotacoezinha, pq ai no output nao vais air do lugar,  NAO SER QUE EU DE UM OFFSET pq ai o valor acumulado conserva e eu ainda tenho a possibilidade de ficar
fazendo a minha atribuicao a variavel(na desestruturacao ) como a gente sempre faz -->

/// pq a rotacao eh que foi feita em uma passada de dedo eh em relacao

  _onRotateHandlerStateChange = event => {
    if (event.nativeEvent.oldState === State.ACTIVE) {
      this._lastRotate += event.nativeEvent.rotation;
      this._rotate.setOffset(this._lastRotate);
      this._rotate.setValue(0);
    }
  };


  render() {
    return (
      <RotationGestureHandler
        onGestureEvent={this._onRotateGestureEvent}
        onHandlerStateChange={this._onRotateHandlerStateChange}>
          <Animated.Image
            style={[
              styles.pinchableImage,
              {
                transform: [
                  { perspective: 200 },
                  { rotate: this._rotateStr },
                ],
              }]}
          />
        </RotationGestureHandler>
    );
  }
}



///////////////// Fling Gensture Handler //////

A discrete gesture handler that activates when the movement is sufficiently long and fast. Handler gets ACTIVE when movement is sufficiently long and it did not take too much time. When handler gets activated it will turn into END state when finger is released. The handler will fail to recognize if the finger is lifted before being activated. The handler is implemented using UISwipeGestureRecognizer on iOS and from scratch on Android.


exemplo:

const LongPressButton = () => (
  <FlingGestureHandler
      direction={Directions.RIGHT | Directions.LEFT}
      onHandlerStateChange={({ nativeEvent }) => {
        if (nativeEvent.state === State.ACTIVE) {
          Alert.alert("I'm flinged!");
        }
      }}>
      <View style={styles.box} />
  </FlingGestureHandler>
);


///////// Pinch Gestue Handler /////////

Overview:

A continuous gesture handler that recognizes pinch gesture. It allows for tracking the distance between two fingers and use that information to scale or zoom your content. The handler activates when fingers are placed on the screen and change their position. Gesture callback can be used for continuous tracking of the pinch gesture. It provides information about velocity, anchor (focal) point of gesture and scale.

The distance between the fingers is reported as a scale factor. At the beginning of the gesture, the scale factor is 1.0. As the distance between the two fingers increases, the scale factor increases proportionally. Similarly, the scale factor decreases as the distance between the fingers decreases. Pinch gestures are used most commonly to change the size of objects or content onscreen. For example, map views use pinch gestures to change the zoom level of the map.



Example:

export class PinchableBox extends React.Component {
  _baseScale = new Animated.Value(1);
  _pinchScale = new Animated.Value(1);
  _scale = Animated.multiply(this._baseScale, this._pinchScale);
  _lastScale = 1;
  _onPinchGestureEvent = Animated.event(
    [{ nativeEvent: { scale: this._pinchScale } }],
    { useNativeDriver: USE_NATIVE_DRIVER }
  );


  

<!-- /////observacao: essa parte é muito importate para que se conserve sentido 
do mapeamento input output, pois pra esse mapaemento fazer sentido _rotate tem que ser um valor acumulado,
entao eu nao posso a cada passo fica sbreescrevedo o valr de _rotate com uma rotacoezinha, pq ai no output nao vais air do lugar,  NAO SER QUE EU DE UM OFFSET pq ai o valor acumulado conserva e eu ainda tenho a possibilidade de ficar
fazendo a minha atribuicao a variavel(na desestruturacao ) como a gente sempre faz -->


  _onPinchHandlerStateChange = event => {
    if (event.nativeEvent.oldState === State.ACTIVE) {
      this._lastScale *= event.nativeEvent.scale;
      this._baseScale.setValue(this._lastScale);
      this._pinchScale.setValue(1);
    }
  };

  render() {
    return (
      <PinchGestureHandler
        onGestureEvent={this._onPinchGestureEvent}
        onHandlerStateChange={this._onPinchHandlerStateChange}>
        <View style={styles.container} collapsable={false}>
          <Animated.Image
            style={[
              styles.pinchableImage,
              {
                transform: [
                  { perspective: 200 },
                  { scale: this._scale },
                ],
              },
            ]}
          />
        </View>
      </PinchGestureHandler>
    );
  }
}







