<template id="uservue">
  <H1 id="H1.connex">Page de connexion</H1>
  <!-- <button @click="changeUpdate">{{"create" }}</button> -->
  <form id="create" @submit="onSubmitCreate">
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

   <!-- <button @click="changeUpdate">{{"update" }}</button> -->
  <form id="update" @submit="onSubmitUpdate">
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

   <!-- <button @click="changeUpdate">{{"get user ID" }}</button> -->
  <form id="getuserid" @submit="getUserById">
    <input type="text" id="get_user" v-model="userId" />
    <label for="get_user" placeholder="enter user id"></label>
    <input type="submit" value="Get user by Id" />
  </form>

   <!-- <button @click="changeUpdate">{{"get user user name and email" }}</button> -->
  <form id="getuser" @submit="getUserByFields">
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
    
  </form>

  <form id="c.user">
    <h2>Current User</h2>
    <ul :key="currentUser.id">
      <li>{{ currentUser.id }}</li>
      <li>{{ currentUser.username }}</li>
      <li>{{ currentUser.email }}</li>
    </ul>
  </form>

  <!-- <button @click="changeUpdate">{{ update ? "update" : "create" }}</button> -->
</template>

<script>
import axios from "axios";
import { defineComponent } from "vue";

let update = false;

export default {
  name: "user-vue",
  data() {
    return {
      currentUser: localStorage.getItem("currentUser")
        ? JSON.parse(localStorage.getItem("currentUser"))
        : {
            email: "",
            username: "",
            id: 0,
          },
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


<style>

#uservue {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
  
}

#H1.connex {
  margin: 0 auto;
  min-height: 85vh; 
    display: flex;
    justify-content: center;
    align-items: center;
}

#update {
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid red;
  width: 30%;
  height: 50%;
}

#create {
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid red;
  width: 30%;
  height: 50%;
}
#getuser {
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid red;
  width: 30%;
  height: 50%;
}

#getuserid {
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid red;
  width: 30%;
  height: 50%;
}

#c.user {
  float: right;
  display: block;
}



</style>

