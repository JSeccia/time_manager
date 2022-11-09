<template>
  <!-- <p>Page de connexion</p>
  <form @submit="onSubmitCreate">
    <label for="username_input">Username</label>
    <input
      type="text"
      v-model="username"
      id="username_input"
      placeholder="Your username"
    />
    <label for="email_input">Email</label>
    <input
      type="text"
      id="email_input"
      placeholder="Your email"
      v-model="email"
    />
    <label for="password_input">Password</label>
    <input
      type="password"
      id="password_input"
      placeholder="Type a password"
      v-model="password"
    />
    <input type="submit" id="user_submit" value="Create" />
  </form>
  <form @submit="onSubmitUpdate">
    <input
      type="text"
      v-model="username"
      id="username_input"
      placeholder="Your username"
    />
    <label for="username_input">Username</label>
    <input
      type="text"
      id="email_input"
      placeholder="Your email"
      v-model="email"
    />
    <label for="email_input">Email</label>
    <input type="submit" id="user_submit" value="Update" />
  </form>
  <form @submit="getUserById">
    <input type="text" id="get_user" v-model="userId" />
    <label for="get_user" placeholder="enter user id"></label>
    <input type="submit" value="Get user by Id" />
  </form>
  <form @submit="getUserByFields">
    <input
      type="text"
      v-model="username"
      id="username_input"
      placeholder="Your username"
    />
    <label for="username_input">Username</label>
    <input
      type="text"
      id="email_input"
      placeholder="Your email"
      v-model="email"
    />
    <label for="email_input">Email</label>
    <input type="submit" id="user_submit" value="Get user by field" />
    <h2>Current User</h2>
  </form>

  <ul :key="currentUser.id">
    <li>{{ currentUser.id }}</li>
    <li>{{ currentUser.username }}</li>
    <li>{{ currentUser.email }}</li>
  </ul>
  <button @click="changeUpdate">{{ update ? "update" : "create" }}</button> -->
-->
</template>

<script>
import axios from "axios";
import { defineComponent } from "vue";

let update = false;

export default {
  name: "user-vue",
  data() {
    return {
      // currentUser: localStorage.getItem("currentUser")
      //   ? JSON.parse(localStorage.getItem("currentUser"))
      //   : {
      //       email: "",
      //       username: "",
      //       id: 0,
      //     },
      email: "",
      username: "",
      password: "",
    };
  },
  methods: {
    getUserByFields(e) {
      e.preventDefault();
      if (!this.username && !this.email) {
        window.alert("no params");
        return;
      }
      axios
        .get(
          `/api/users/?${this.email ? `email=${this.email}` : ""}${
            this.email && this.username ? "&" : ""
          }${this.username ? `username=${this.username}` : ""}
        `
        )
        .then((res) => {
          localStorage.setItem("currentUser", JSON.stringify(res.data.data));
          this.currentUser = res.data.data;
        });
    },
    getUserById(e) {
      e.preventDefault();
      axios.get(`/api/users/${this.userId}`).then((res) => {
        localStorage.setItem("currentUser", JSON.stringify(res.data.data));
        this.currentUser = res.data.data;
      });
    },
    changeUpdate() {
      if (update) {
        update = false;
      } else {
        update = true;
      }
      console.log(update);
    },

    onSubmitUpdate(e) {
      e.preventDefault();
      if (this.username === null || this.email === null) {
        window.alert("Missing field");
        return;
      }
      const body = {
        user: { username: this.username, email: this.email },
      };
      axios
        .put(
          `/api/users/${JSON.parse(localStorage.getItem("currentUser")).id}`,
          body,
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        )
        .then((res) => {
          localStorage.setItem("currentUser", JSON.stringify(res.data.data));
          this.user = res.data.data;
        });
    },
    onSubmitCreate(e) {
      e.preventDefault();
      const body = {
        user: {
          username: this.username,
          email: this.email,
          password: this.password,
        },
      };
      axios
        .post("/api/users", body, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((res) => {
          localStorage.setItem("currentUser", JSON.stringify(res.data.data));
          this.user = res.data.data;
        });
      // window.alert(this.username, this.email);
    },
  },
};
</script>
