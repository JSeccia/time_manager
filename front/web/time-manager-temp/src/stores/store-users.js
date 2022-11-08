import { defineStore } from 'pinia';
import axios from 'axios';
import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';

export const useUserStore = defineStore('user', {
  state: () => ({
    userDetails: {},
    truc: 'machin',
  }),
  actions: {
    CreateNewUser: (userDetails, truc) => {
      console.log(userDetails);
      console.log(truc)
    },
  }
});
