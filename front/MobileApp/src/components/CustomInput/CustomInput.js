import { View, Text, TextInput, StyleSheet } from 'react-native'
import React from 'react'

const CustomInput = ({value, setValue, placeholder, secureTextEntry }) => {
  return (
    <View style={styles.container}>

      <TextInput
        style={styles.input}
        value={value}
        placeholder={placeholder}
        onChangeText={setValue}
        secureTextEntry={secureTextEntry}
    />   
    </View>
  );
};

const styles = StyleSheet.create({


container: {
    padding: 10,
    borderWidth: 1,
    margin: 7,
    width: 200,
    borderRadius: 7

},

input: {

},

});

export default CustomInput