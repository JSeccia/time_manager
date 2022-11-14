import React from 'react'
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, Image, onChangeText, TextInput, Pressable } from 'react-native';
import { useState } from 'react';
import Timemanager from '../../../assets/Timemanager.png';
import CustomInput from '../../components/CustomInput';
import CustomButton from '../../components/CustomButton';

import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack"; 




const LoginScreen = (navigation) => {
    const [email, setEmail] = useState('');

    const [password, setPassword] = useState('');

    // const { onPress, title = 'Connect' } = props;

    const onLoginPressed = () => {
        console.warn("Connect pressed");
    };

    const onForgotPasswordPressed = () => {
        console.warn("Forgot password pressed");
    };

  return (
    <View style={styles.container}>
        <Image source={Timemanager} style={styles.logo} />
        <Text style={styles.title}>Time Manager</Text>


        <CustomInput   
        placeholder="Email Address"   
        value={email} 
        setValue={setEmail}
        />

        <CustomInput 
        placeholder="Password" 
        secureTextEntry={true} 
        value={password} 
        setValue={setPassword} 
        />

        <CustomButton text='Connect' onPress={onLoginPressed} />

        <Text>Forgot password ? <Text onPress={onForgotPasswordPressed} style={{ color: 'limegreen', fontSize: 13, fontWeight: 'bold', margin: 15, }}>Click here</Text></Text>
    </View>
  );
}


const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    padding: 10,
    marginTop: 100,

  },

    
  logo: {
    width: '80%',
    maxWidth: 300,
    maxHeight: 200,
    borderRadius: 50,

},

title: { 
    fontSize: 27,
    textAlign: 'center',
    fontWeight: 'bold',
    fontStyle: 'italic',
    textAlign: 'center',
    padding: 10,
   

}

  

  
});

export default LoginScreen