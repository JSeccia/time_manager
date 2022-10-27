<template>
  <p>Page de connexion</p>
  <form @submit="onSubmitCreate">
    <input type="text" v-model="username" id="username_input" placeholder="Your username" />
    <label for="username_input">Username</label>
    <input type="text" id="email_input" placeholder="Your email" v-model="email" />
    <label for="email_input">Email</label>
    <input type="submit" id="user_submit" value="Submit" />
  </form>
  <form @submit="onSubmitUpdate">
    <input type="text" v-model="userId" placeholder="User id" id="user_id" />
    <label for="user_id">User id</label>
    <input type="text" v-model="username" id="username_input" placeholder="Your username" />
    <label for="username_input">Username</label>
    <input type="text" id="email_input" placeholder="Your email" v-model="email" />
    <label for="email_input">Email</label>
    <input type="submit" id="user_submit" value="Submit" />
  </form>
  <form @submit="getUser">
    <input type="text" id="get_user" v-model="userId" />
    <label for="get_user" placeholder="enter user id"></label>
    <input type="submit" value="Get user" />
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
      form: {
        email: "",
        username: "",
      },
    };
  },
  methods: {
    getUser(e) {
      e.preventDefault();
      if (this.userId === null) {
        window.alert("no id");
        return;
      }

      axios
        .get(`http://localhost:4000/api/users/${this.userId}`)
        .then((res) =>
          localStorage.setItem("currentUser", JSON.stringify(res.data.data))
        );
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
      if (this.userId === null) {
        window.alert("no id");
        return;
      }
      const body = {
        user: { username: this.username ?? null, email: this.email ?? null },
      };
      axios.put(`http://localhost:4000/api/users/${this.userId}`, body, {
        headers: {
          "Content-Type": "application/json",
        },
      });
    },
    onSubmitCreate(e) {
      e.preventDefault();
      const body = {
        user: { username: this.username, email: this.email },
      };
      axios.post("http://localhost:4000/api/users", body, {
        headers: {
          "Content-Type": "application/json",
        },
      });
      // window.alert(this.username, this.email);
    },
  },
};
</script>
