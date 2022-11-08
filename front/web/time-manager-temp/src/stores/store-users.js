import { defineStore } from 'pinia';
import axios from 'axios';
import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';

export const useUserStore = defineStore('user', {
  state: () => ({
   
  }),
 
  actions: {
    CreateNewUser (userDetails) {
      console.log(userDetails);
    },
  }
});
