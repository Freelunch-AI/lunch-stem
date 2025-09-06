///passo a passo

1) Cofigurar Ícone do Aplicativo
  A gente pega uma imagem que vamos usar de ícone e usamos a ferramente Apetools que jah vai
  converter pra todas as resolucoes que o andorid precisa

  1.1 Desmarcamos as opções IOS e Windows
  1.2 Clicar em Kapow
  1.3 Baixamos e descompactamos o zip
  1.4 Em bundle/andorid vai estar todas asresolucoes do meu ícone
  1.5 copiamos todas as pastas
  1.6 navegamos para o diretorio andorid/app/src/main/res
  1.7 Deletamos as pastas mipmap (que sao as pastas do icone padrap)
  1.8 Colamos as nossas pastas

  Agora precisamos configurar para que ele procure o ícone nessas pastas drawable

  1.9 Navegamos para android/app/src/main/AndoridManisfest.xml
  1.10 procuramos a linha de código -- android:icon='@mipmap/ic_launcher' e mudamos para 
  android:icon='@drawable/icon' (tem que bater com o nome das pastas e arquivos(dentro das pastas) que a gente colocou)
  
2) Configurar o Display Name (Nome da aplicação)
  2.1 navegando para res/values/strings.xml
  2.2 mudamos a linha de código -- <string name="app_name">IconAndSplah</string> para 
  <string name="app_name">[nome do aplicativo aqui]</string>
  2.3 

3) Configurar Splash Screen
  Primeiro vamos configurar as cores que a gente via poder utilizar 

  3.1 no diretório res/values/ criamos um arquivo colors.xml com o seguinte código:
    <?xml version="1.0" encoding="utf-8" ?>
    <resources>
      <color name="primary">[insira código hexa da cor do fundo aqui]</color>
    <resources>
  
  Agora vamos criar de fato o arquivo de configuracao da splah screen

  3.2 em res/drawable criamos o arquivo background_splash.xml com o seguinte código:
    <?xml version="1.0" encoding="utf-8" ?>
    <layer-list
      xmls:android="http://schemas.android.com/apk/res/android ">
      //colocando a nossa cor no fundo
      <item android:drawable="@color/primary" />
      // colocando o logo(icon) centralizado na tela
      <item 
        /* 200dp foi só um exemplo de tamanho */
        android:width="200dp"
        android:height="200dp"
        android:drawable="@drawable/icon" 
        android:gravity="center"
      />
    <layer-list>

  Criamos nossa splash scrren, mas o andorid ainda nao reconhece ela como um recurso,
  afinal a gente acabou de criar esse arquivo enao falou nada pra ele. Vamos indicar isso 
  para ele em res/values/styles.xml

  3.3 Navegar para res/values/styles.xml e inserir dentro da tag <style> o código:
    <item name="android:windowBackground">
      @drawable/background_splash
    </item>
    // agora vamos mudar a cor da status bar pra que fique igual a que a gente colocou a da 
    nossa aplicacao (assumindo que a gente mudou ela)
    <item name>
      @color/primary
    </item>



4) Problemas e bugs

  4.1 [BUG] Talvez tenha  que adicionar esse código em app/src/main/res/values/colors.xml:

    <?xml version="1.0" encoding="utf-8" ?>
    <resources>
      <color name="primary_dark">[insira código hexa da cor do fundo aqui]</color>
    <resources>

  4.2 Se for usar ficar distorcido, ou vc nao quiser que a sua imagem/icone aumente de tamanho pro default pra caber na view:

  na configuracao da splah screen (passo 3.2) coloca dentro de uma tag <bitmap> o código:
  

        //////// configuracao pra se quisermos colocar no centro:

        <item>
        <bitmap
        // 200dp foi só um exemplo de tamanho 
        android:width="200dp"
        android:height="200dp"
        android:drawable="@drawable/icon" 
        android:gravity="center"

        android:drawable="@drawable/icon" 
        android:gravity="fillcenter"
        >
        <item />
    <layer-list>

      /////// configuracao se quisermos colocar na tela inteira

        <item>
        <bitmap
          android:drawable="@drawable/icon" 
          android:gravity="fillcenter"
        >
        <item />
    <layer-list>



5) Usando react-native-splash-screen

Funcionalidades: mostrar splash screen por mais tempo | esconder splah screen 

 /////////Instalação: 

 5.1 Run npm i react-native-splash-screen --save

 5.2 Second step(Plugin Installation):

//Automatic installation

  5.3 react-native link react-native-splash-screen or rnpm link react-native-splash-screen

//Manual installation
Android:

  5.3 In your android/settings.gradle file, make the following additions:
include ':react-native-splash-screen'   
project(':react-native-splash-screen').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-splash-screen/android')
In your android/app/build.gradle file, add the :react-native-splash-screen project as a compile-time dependency:
...
dependencies {
    ...
    implementation project(':react-native-splash-screen')
}
Update the MainApplication.java file to use react-native-splash-screen via the following changes:
// react-native-splash-screen >= 0.3.1
import org.devio.rn.splashscreen.SplashScreenReactPackage;
// react-native-splash-screen < 0.3.1
import com.cboy.rn.splashscreen.SplashScreenReactPackage;

public class MainApplication extends Application implements ReactApplication {

    private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
        @Override
        public boolean getUseDeveloperSupport() {
            return BuildConfig.DEBUG;
        }

        @Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                    new MainReactPackage(),
            new SplashScreenReactPackage()  //here
            );
        }
    };

    @Override
    public ReactNativeHost getReactNativeHost() {
        return mReactNativeHost;
    }
}


/////Usage:

Use like so:

import SplashScreen from 'react-native-splash-screen'

export default class WelcomePage extends Component {

    componentDidMount() {
    	// do stuff while splash screen is shown
        // After having done stuff (such as async tasks) hide the splash screen
        SplashScreen.hide();
    }
}

//API
Method	  Type	   Optional	          Description
show()	function	  false	      Open splash screen (Native Method )
hide()	function	  false	         Close splash screen





