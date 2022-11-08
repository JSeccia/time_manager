import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    user: { id: 0, username: "", email: "", team: null },
  }),
  actions: {
    setUser({ id, username, email, team }) {
      this.user = { id, username, email, team };
    },
    createUser({ username, email, team }) {
      this.user = {username, email, team};
    },
  },
});
