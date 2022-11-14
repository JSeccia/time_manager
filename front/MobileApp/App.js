import React from "react";
import { SafeAreaView, StyleSheet, Text } from "react-native";
import LoginScreen from "./src/screens/LoginScreen";

import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack"; 

import Screens from "./src/screens/Screens";


const AuthStack = createStackNavigator();


const App = () => {
  return (
    <NavigationContainer>
      <AuthStack.Navigator>
        <AuthStack.Screen name="Login" component={LoginScreen} />
        {/* <AuthStack.Screen name="Screens" component={Screens} /> */}
    </AuthStack.Navigator>
    </NavigationContainer>
  );
};

const styles = StyleSheet.create({
  root: {
    flex: 1,
    backgroundColor: "gainsboro",
    justifyContent: "center",
  },
});

export default App;