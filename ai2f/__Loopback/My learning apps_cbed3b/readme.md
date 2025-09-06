comandos para iniciar :

1) npm install expo-cli --global
1.1) tomar cuidado quando fazer upgrade pq adb fica rodando e fode tudo
2) expo init [name pf the app]
3) npm start  


####React Native Apps are hard work:

"Write javascript code and run it everywhere" ? Np.

Its "Learn once, write everywhere"

a. No or very little cross-platform styling of components
    So, style components on your oown or use third party libraries
b. Only a basic set of pre-built components (everything you need though)
    So, build components on your oown or use third party libraries
c. Tools to create responsive designs but no responsiveness out of the box
    So, create responsive designs on your oown (check for device size and OS)

# new versions every month
# breaking changes do happen
# high dependency on third party packages also change (expo helps a bit)
# bugs/workarounds required


#Core Components:

Built into React Native:
    - "translation" to Native UI Widgets provided by ReactNative
    - examples: <View> 
                <Text> 
                <Button> / <Touchable...>
                <TextInput>
                <Image>
                and others


#There is no CSS!
But, then we have inline styles and StyleSheet Objects (is prefered) to do the job
These are written in javascript, but based on css syntax

para dar reload no emulador : r + r


How to debug using chrome debugger:

1) cntrl + m in emulator

2) make sure that in your expo dev tools you arent in tunnel connection

3) cntrl + shift + j 

4)


How to debug with React Native debugger (React Native dev tools + redux devtolls):

1) open the debugger

2) cntrl + t

3)  confirm right port (the same as in devtools)

4) in emulator:
    cntrl + m
    debug remote js

5) in React  Degguber:
    expand RNDebugerWorker.js
    os primeiros arquivos js sao os da nossa aplicacao (vai ter um monte)
    (ao sei pq ta zuado assim)


