import { defineStore } from 'pinia';
import axios from 'axios';
import { api } from 'boot/axios';
import { LocalStorage } from 'quasar';

export const useUserStore = defineStore('user', {
  state: () => ({
    user: [],
  }),
  actions: {
    CreateNewUser: () => {
      axios
      .post('/api/users', users)
      .then((response) => {
        console.log(response);
        u
      })
      console.log(users);
    },
  }
});
