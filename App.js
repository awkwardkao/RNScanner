/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import ReactNative,{
  Platform,
  StyleSheet,
  Text,
  TextInput,
  View,
  requireNativeComponent,
  NativeModules,
  TouchableOpacity,
  UIManager
} from 'react-native';
import VersionNumber from 'react-native-version-number';

const ScannerComponent = requireNativeComponent('ScannerView');
const {ResultManager} = NativeModules;



const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu\n' + VersionNumber.appVersion,
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu\n'+
    VersionNumber.appVersion,
});

console.log(VersionNumber.appVersion);

type Props = {};
export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <ScannerComponent  style={styles.container} 
         ref={(component) => this.scannerComponentInstance = component } />
        <TextInput
         editable={false}
         defaultValue={"-----"}
         ref={component => this._textInput = component}>
         
        </TextInput>

        <TouchableOpacity onPress={this.onButtonClickLight.bind(this)}>
          <Text style={styles.button}>{'TouchLight'}</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={this.onButtonClickPromise.bind(this)}>
          <Text style={styles.button}>{'Promise'}</Text>
        </TouchableOpacity>
       
      </View>
      
    );
  }

  onButtonClick(e) { 
    //console.log(UIManager);
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.scannerComponentInstance),
      UIManager.ScannerView.Commands.doScanViaManager,
      []
    );
  }

  onButtonClickLight(e) { 
    //console.log(UIManager);
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.scannerComponentInstance),
      UIManager.ScannerView.Commands.doTouchLightViaManager,
      []
    );
  }

  onButtonClickPromise(e) { 
    //console.log(UIManager);
    /*UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.scannerComponentInstance),
      UIManager.ScannerView.Commands.fetchScanCode,
      []
    ).then( (response) => {
      console.log(reponse);
    }).catch((error) => {
      console.log(error);
    });*/
    //SC.fetchScanCode(ReactNative.findNodeHandle(this.scannerComponentInstance),
    //                               (response)=> console.log(response),(response,err) => console.log(err));
  
    //this._textInput.setNativeProps({text:"start scanning"})
    
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.scannerComponentInstance),
      UIManager.ScannerView.Commands.fetchScanCode,
      [
        
        function(response) {
          console.log(response); 
          this._textInput.setNativeProps({text:"Get Value"});
        },
        function(response,err) {console.log(err);}
      ]);

      

      this._textInput.setNativeProps({text:"start scanning"});

      ResultManager.checkValue(200000)
      .then(
        (response) => this._textInput.setNativeProps({text:response}) 
      )
      .catch(
        (response,err) => console.log(err)
      ); 
      
  }

  success(msg) {
    console.log(msg);
  }

  fail(msg) {
    console.log(msg);
  }
}



const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',

    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  container1: {
    position: 'relatvie',
    bottom: 200,
    left: 10,
    right: 10,
    top: 10
  },
  container2: {
      flex: 1,
      flexDirection: 'row',
      backgroundColor: 'green',
  },
  scanHeight: {
    flex: 0.8,
    backgroundColor: '#FF3366'
  },
  button: {
    marginTop: 50,
    width: 120,
    height: 60,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#F0F',
    backgroundColor: "#FFF"
  }
});
