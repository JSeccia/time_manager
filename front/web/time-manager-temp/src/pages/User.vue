<template>
  <main class="main_admin">
    <H1>Page de connexion</H1>
    <section class="manage_user">
      <!-- <button @click="changeUpdate">{{"create" }}</button> -->
    <div class="admin_create">
      <form id="create" @submit="onSubmitCreate">
        <label for="username_input">Username</label>
        <input type="text" v-model="username" id="username_input" placeholder="Your username" />
        <label for="email_input">Email</label>
        <input type="text" id="email_input" placeholder="Your email" v-model="email" />
        <label for="password_input">Password</label>
        <input type="password" id="password_input" placeholder="Type a password" v-model="password" />
        <input type="submit" id="user_submit" value="Create" />
      </form>
    </div>

      <!-- <button @click="changeUpdate">{{"update" }}</button> -->
      <div class="admin_update">
      <form id="update" @submit="onSubmitUpdate">
        <input type="text" v-model="username" id="username_input" placeholder="Your username" />
        <label for="username_input">Username</label>
        <input type="text" id="email_input" placeholder="Your email" v-model="email" />
        <label for="email_input">Email</label>
        <input type="submit" id="user_submit" value="Update" />
      </form>
    </div>

    <div class="admin_get">
      <!-- <button @click="changeUpdate">{{"get user ID" }}</button> -->
      <form id="getuserid" @submit="getUserById">
        <input type="text" id="get_user" v-model="userId" />
        <label for="get_user" placeholder="enter user id"></label>
        <input type="submit" value="Get user by Id" />
      </form>

      <!-- <button @click="changeUpdate">{{"get user user name and email" }}</button> -->
      <form id="getuser" @submit="getUserByFields">
        <input type="text" v-model="username" id="username_input" placeholder="Your username" />
        <label for="username_input">Username</label>
        <input type="text" id="email_input" placeholder="Your email" v-model="email" />
        <label for="email_input">Email</label>
        <input type="submit" id="user_submit" value="Get user by field" />

      </form>
    </div>

      <form id="c.user">
        <h2>Current User</h2>
        <ul :key="currentUser.id">
          <li>{{ currentUser.id }}</li>
          <li>{{ currentUser.username }}</li>
          <li>{{ currentUser.email }}</li>
        </ul>
      </form>


      <!-- <button @click="changeUpdate">{{ update ? "update" : "create" }}</button> -->
    </section>
  </main>
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
          `/api/users/?${this.email ? `email=${this.email}` : ""}${this.email && this.username ? "&" : ""
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
.manage_user{
    border: 2px solid yellow;
    height: 100%;
    width: 80%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

#uservue {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;

}


.admin_update {
  border: 1px solid red;
  padding-bottom: 10px;
  padding-top: 10px;
  height: 20%;
  width: 100%;
  display: flex;
  justify-content: center;
}


.admin_create {
 
  border: 1px solid red;
  padding-bottom: 10px;
  padding-top: 10px;
  height: 20%;
  width: 100%;
  display: flex;
  /* align-items: center; */
  justify-content: center;
}

.admin_get {
  border: 1px solid red;
  padding-bottom: 10px;
  padding-top: 10px;
  height: 40%;
  width: 100%;
  display: flex;
  justify-content: center;
  
}

#getuserid {
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid red;
  height: 20%;
  width: 100%;
  display: flex;
  /* align-items: center; */
  justify-content: center;
}

#getuser {
  display: flex;
  align-items: center;
  border: 1px solid red;
  
}

#c.user {
  float: right;
  display: block;
}
</style>

