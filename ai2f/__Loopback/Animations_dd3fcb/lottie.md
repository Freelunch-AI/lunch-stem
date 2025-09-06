Pra pegar animacoes prontas do lottie eh soh ir no lottie library 
e baixar o json da animacao que vc quiser

<!-- Instalacao: -->

Installing (React Native >= 0.60.0)
Install lottie-react-native (latest) and lottie-ios (3.1.3):

yarn add lottie-react-native
yarn add lottie-ios@3.1.3
or

npm i --save lottie-react-native
npm i --save lottie-ios@3.1.3
Go to your ios folder and run:

pod install
_ IMPORTANT _

If you have issues linking your iOS project check out this StackOverflow thread on how to fix it.

If your app crashes on Android, means auto linking didn't work. You will need to make the following changes:

android/app/src/main/java/<AppName>/MainApplication.java

add import com.airbnb.android.react.lottie.LottiePackage; on the imports section
add packages.add(new LottiePackage()); in List<ReactPackage> getPackages();


in android/app/build.gradl
add: implementation project(':lottie-react-native') in the dependencies block

android/settings.gradle
add:
include ':lottie-react-native'
project(':lottie-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/lottie-react-native/src/android')

