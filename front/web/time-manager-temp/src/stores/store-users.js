import { defineStore } from "pinia";
import { LocalStorage } from "quasar";

export const useUserStore = defineStore("user", {
  state: () => ({
    user: LocalStorage.getItem("currentUser")
      ? JSON.parse(LocalStorage.getItem("currentUser"))
      : {
          id: 0,
          username: "",
          email: "",
          team: null,
          role: "user",
        },
  }),
  actions: {
    setUser({ id, username, email, team, role }) {
      LocalStorage.set(
        "currentUser",
        JSON.stringify({ id, username, email, team, role })
      );
      this.user = { id, username, email, team, role };
    },
    // createUser({ username, email, team, role }) {
    //   this.user = { username, email, team, role };
    // },
  },
});
