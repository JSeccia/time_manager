
// import React from 'react'

// import { StatusBar } from 'expo-status-bar';
// import { StyleSheet, Text, View, Image, onChangeText, TextInput, Pressable } from 'react-native';
// import { NavigationContainer } from "@react-navigation/native";
// import { createStackNavigator } from "@react-navigation/stack";

// import { useState } from 'react';
// import Timemanager from '../../../assets/Timemanager.png';
// import CustomInput from '../../components/CustomInput';
// import CustomButton from '../../components/CustomButton';







// export const screens = ({navigation}) => {
//     return (
//         <ScreenContainer>
//             <View style={styles.container}>
//         <Image source={Timemanager} style={styles.logo} />
//         <Text style={styles.title}>Time Manager</Text>


//         <CustomInput   
//         placeholder="Email Address"   
//         value={email} 
//         setValue={setEmail}
//         />

//         <CustomInput 
//         placeholder="Password" 
//         secureTextEntry={true} 
//         value={password} 
//         setValue={setPassword} 
//         />

//         <CustomButton text='Connect' onPress={onLoginPressed} />

//         <Text>Forgot password ? <Text onPress={() => navigation.push("LoginScreen")} style={{ color: 'limegreen', fontSize: 13, fontWeight: 'bold', margin: 15, }}>Click here</Text></Text>
//     </View>

//         </ScreenContainer>
//     )
// }