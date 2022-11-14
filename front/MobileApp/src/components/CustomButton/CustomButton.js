import { View, Text, StyleSheet, Pressable } from 'react-native'
import React from 'react'

const CustomButton = ({ onPress, text }) => {
  return (
    <Pressable onPress={onPress} style={styles.container}>
      <Text style={styles.text}>{text}</Text>
    </Pressable>

  );
};

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'limegreen',
        width: '35%',

        padding: 15,
        marginVertical: 8,

        alignItems: 'center',
        borderRadius: 10,
    },
    text: {
        fontWeight: 'bold',
        fontSize: 15,
    },
});

export default CustomButton;