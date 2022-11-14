import React from "react";
import { View, Text, StyleSheet, Button } from 'react-native'



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


const ScreenContainer = ({ children }) => (
  <View style={styles.container}>{children}</View>
);


