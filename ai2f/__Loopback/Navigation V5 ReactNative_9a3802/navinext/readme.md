## FUNDAMENTALS

////bibliotecas e dependencias

>> yarn add @react-navigation/native

>> yarn add react-native-reanimated react-native-gesture-handler react-native-screens react-native-safe-area-context @react-native-community/masked-view

To finalize installation of react-native-gesture-handler, add the following at the top (make sure it's at the top and there's nothing else before it) of your entry file, such as index.js or App.js:

>> yarn add @react-navigation/stack

import 'react-native-gesture-handler';

///////// Passing parameters to routes:

There are two pieces to this:
Pass params to a route by putting them in an object as a second parameter
to the navigation.navigate function: 
navigation.navigate('RouteName', { /* params go here */ })
Read the params in your screen component: route.params.


////////passingparams to nested navigators:

Passing params to nested navigators
If you have nested navigators, you need to pass params a bit differently. 
For example, say you have a navigator inside the Account screen, and want 
to pass params to the Settings screen inside that navigator. Then you can 
pass params as following:

navigation.navigate('Account', {
  screen: 'Settings',
  params: { user: 'jane' },
});

//////// Configuring the header bar

function StackScreen() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerTitleAlign: 'center'
      }}
    >
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{ title: 'My home' }}
      />
      <Stack.Screen
        name="Profile"
        component={ProfileScreen}
        options={({ route }) => ({ title: route.params.name })}
      />
    </Stack.Navigator>
  );
}


//////// Updating options with setOptions
It's often necessary to update the options configuration for the active screen from the mounted screen component itself. We can do this using navigation.setOptions

Copy
/* Inside of render() of React class */
<Button
  title="Update the title"
  onPress={() => navigation.setOptions({ title: 'Updated!' })}
/>



 ////////// Adjusting header styles

 function StackScreen() {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{
          title: 'My home',
          headerStyle: {
            backgroundColor: '#f4511e',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
      />
    </Stack.Navigator>
  );
}



///////// Sharing common options across screens

function StackScreen() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: '#f4511e',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{ title: 'My home' }}
      />
    </Stack.Navigator>
  );
}


///////// Adding a button to the header

function StackScreen() {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{
          headerTitle: props => <LogoTitle {...props} />,
          headerRight: () => (
            <Button
              onPress={() => alert('This is a button!')}
              title="Info"
              color="#fff"
            />
          ),
        }}
      />
    </Stack.Navigator>
  );
}




//////////// Navigation Lifecycle (siando de uma tela ou chegando e uma  tela)

import { useFocusEffect } from '@react-navigation/native';

function Profile() {
  useFocusEffect(
    React.useCallback(() => {
      // Do something when the screen is focused

      return () => {
        // Do something when the screen is unfocused
        // Useful for cleanup functions
      };
    }, [])
  );

  return <ProfileContent />;
}


/////////Nesting navigators 

#Each navigator keeps its own navigation history
For example, when you press the back button inside a nested stack navigator, it'll go back to the previous screen inside the nested stack even if there's another navigator as the parent.

#Navigation actions are handled by current navigator and bubble up if couldn't be handled
For example, if you're calling navigation.goBack() in a nested screen, it'll only go back in the parent navigator if you're already on the first screen of the navigator. Other actions such as navigate work similarly, i.e. navigation will happen in the nested navigator and if the nested navigator couldn't handle it, then the parent navigator will try to handle it. In the above example, when calling navigate('Settings'), inside Profile screen, the nested stack navigator will handle it, but if you call navigate('Home'), the parent tab navigator will handle it.

#Navigator specific methods are available in the navigators nested inside
For example, if you have a stack inside a drawer navigator, the drawer's openDrawer, closeDrawer methods etc. will also be available on the navigation prop in the screen's inside the stack navigator. But say you have a stack navigator as the parent of the drawer, then the screens inside the stack navigator won't have access to these methods, because they aren't nested inside the drawer.

Similarly, if you have a tab navigator inside stack navigator, the screens in the tab navigator will get the push and replace methods for stack in their navigation prop.

#Nested navigators don't receive parent's events
For example, if you have a stack navigator nested inside a tab navigator, the screens in the stack navigator won't receive the events emitted by the parent tab navigator such as (tabPress) when using navigation.addListener. To receive events from parent navigator, you can explicitly listen to parent's events with navigation.dangerouslyGetParent().addListener.

#Parent navigator's UI is rendered on top of child navigator
For example, when you nest a stack navigator inside a drawer navigator, you'll see that the drawer appears above the stack navigator's header. However, if you nest the drawer navigator inside a stack, the drawer will appear below the header. This is an important point to consider when deciding how to nest your navigators.

In your app, you will probably use these patterns depending on the behavior you want:

Stack navigators nested inside each screen of drawer navigator - The drawer appears over the header from the stack.
Tab navigator nested inside the initial screen of stack navigator - New screens cover the tab bar when you push them.
Stack navigators nested inside each screen of tab navigator - The tab bar is always visible. Usually pressing the tab again also pops the stack to top.



////////Example withModal (like a pop up)


function HomeScreen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text style={{ fontSize: 30 }}>This is the home screen!</Text>
      <Button
        onPress={() => navigation.navigate('MyModal')}
        title="Open Modal"
      />
    </View>
  );
}

function DetailsScreen() {
  return (
    <View>
      <Text>Details</Text>
    </View>
  );
}

function ModalScreen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text style={{ fontSize: 30 }}>This is a modal!</Text>
      <Button onPress={() => navigation.goBack()} title="Dismiss" />
    </View>
  );
}

const MainStack = createStackNavigator();
const RootStack = createStackNavigator();

function MainStackScreen() {
  return (
    <MainStack.Navigator>
      <MainStack.Screen name="Home" component={HomeScreen} />
      <MainStack.Screen name="Details" component={DetailsScreen} />
    </MainStack.Navigator>
  );
}

function RootStackScreen() {
  return (
    <RootStack.Navigator mode="modal">
      <RootStack.Screen
        name="Main"
        component={MainStackScreen}
        options={{ headerShown: false }}
      />
      <RootStack.Screen name="MyModal" component={ModalScreen} />
    </RootStack.Navigator>
  );
}



////////////////////////API REFERENCE //////////////////

////Route prop:

Each screen component in your app is provided with the route prop automatically. The prop contains various information regarding current route (place in navigation hierarchy component lives).

route
key - key of the screen. Created automatically or added while navigating to this screen.
name - name of the screen. Defined in navigator component hierarchy.
params - set of params which is defined while navigating e.g. navigate('Twitter', { user: 'Dan Abramov' }).
Copy
function ProfileScreen({ route }) {
  return (
    <View>
      <Text>This is the profile screen of the app</Text>
      <Text>{route.name}</Text>
    </View>
  );
}


///////////navavigation prop


Navigation prop reference
Each screen component in your app is provided with the navigation prop automatically. The prop contains various convenience functions that dispatch navigation actions on the route's router. It looks like this:

navigation:
navigate - go to another screen, figures out the action it needs to take to do it
reset - wipe the navigator state and replace it with a new routes
goBack - close active screen and move back in the stack
setParams - make changes to route's params
dispatch - send an action to router
setOptions - update the screen's options
isFocused - check whether the screen is focused
addListener - subscribe to updates to events from the navigators

It's important to highlight the navigation prop is not passed in to all components; only screen components receive this prop automatically! React Navigation doesn't do any magic here. For example, if you were to define a MyBackButton component and render it as a child of a screen component, you would not be able to access the navigation prop on it. If, however, you wish to access the navigation prop in any of your components, you may use the useNavigation hook.



///////set params

The setParams method lets us update the params (route.params) of the current screen. setParams works like React's setState - it merges the provided params object with the current params.

function ProfileScreen({ navigation: { setParams } }) {
  render() {
    return (
      <Button
        onPress={() =>
          navigation.setParams({
            friends:
              route.params.friends[0] === 'Brent'
                ? ['Wojciech', 'Szymon', 'Jakub']
                : ['Brent', 'Satya', 'Michaś'],
            title:
              route.params.title === "Brent's Profile"
                ? "Lucy's Profile"
                : "Brent's Profile",
          })
        }
        title="Swap title and friends"
      />
    );
  }
}


////////////////// useNavigation (bem útil!!)

useNavigation is a hook which gives access to navigation object. It's useful when you cannot pass the navigation prop into the component directly, or don't want to pass it in case of a deeply nested child.

#####useNavigation() returns the navigation prop of the screen it's inside.#####

#Example
Copy
import * as React from 'react';
import { Button } from 'react-native';
import { useNavigation } from '@react-navigation/native';

function MyBackButton() {
  const navigation = useNavigation();

  return (
    <Button
      title="Back"
      onPress={() => {
        navigation.goBack();
      }}
    />
  );
}





