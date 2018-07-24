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
        <ScannerComponent style={styles.scanWindow}
         ref={(component) => this.scannerComponentInstance = component } />
        <View style={styles.container2}>
          <TextInput
          editable={false}
          defaultValue={"-----"}
          ref={component => this._textInput = component}>
          
          </TextInput>

          <TouchableOpacity onPress={this.onButtonClickLight.bind(this)}>
            <Text style={styles.button}>{'燈光'}</Text>
          </TouchableOpacity>

          <TouchableOpacity onPress={this.onButtonClickPromise.bind(this)}>
            <Text style={styles.button}>{'掃瞄'}</Text>
          </TouchableOpacity>
        </View>
       
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

    this._textInput.setNativeProps({text:"start scanning"});

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
    flexDirection: 'column',
    


  },

  mainWindow: {
    position: 'absolute',
    width: 300,
    height:300,
    left:20,
    top: 20,
  },
  
  scanWindow: {
    flex:3,


  },
  container2: {
      flex: 1,
      flexDirection: 'row',
      justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'white'
  },
  scanHeight: {
    flex: 0.8,
    backgroundColor: '#FF3366'
  },
  button: {
    width: 120,
    height: 60,
    padding: 5,
    borderRadius: 12,
    borderWidth: 1,
    textAlign: 'center',
    textAlignVertical : 'middle',
    borderColor: '#F0F',
    
  }
});
