<template>
  <p>Page de connexion</p>
  <form @submit="onSubmitCreate">
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
    <ul :key="user.id">
      <li>{{ user.id }}</li>
      <li>{{ user.username }}</li>
      <li>{{ user.email }}</li>
    </ul>
  </form>
  <!-- <button @click="changeUpdate">{{ update ? "update" : "create" }}</button> -->
</template>

<script>
import axios from "axios";

let update = false;

export default {
  name: "Create",
  data() {
    return {
      user: {
        email: "",
        username: "",
        id: 0,
      },
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
          `http://localhost:4000/api/users/?${
            this.email ? `email=${this.email}` : ""
          }${this.email && this.username ? "&" : ""}${
            this.username ? `username=${this.username}` : ""
          }
        `
        )
        .then((res) => {
          localStorage.setItem("currentUser", JSON.stringify(res.data.data));
          this.user = res.data.data;
        });
    },
    getUserById(e) {
      e.preventDefault();
      axios
        .get(`http://localhost:4000/api/users/${this.userId}`)
        .then((res) => {
          localStorage.setItem("currentUser", JSON.stringify(res.data.data));
          this.user = res.data.data;
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
          `http://localhost:4000/api/users/${
            JSON.parse(localStorage.getItem("currentUser")).id
          }`,
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
        user: { username: this.username, email: this.email },
      };
      axios
        .post("http://localhost:4000/api/users", body, {
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
