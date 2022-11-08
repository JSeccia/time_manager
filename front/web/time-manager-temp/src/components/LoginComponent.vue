<template>
  <!-- {{ store }} -->
  <main class="main_login">
    <div class="login_section">
      <div class="login_title">
        <p color="green-10">Welcome on Time Manager</p>
      </div>

      <p v-if="mode === 'signin'">Sign in below</p>
      <p v-else>Create your account here</p>

      <!-- sign in (login) -->
      <q-form
        v-if="mode === 'signin'"
        class="signin_section__form"
        @submit.prevent="login"
      >
        <q-input
          rounded
          outlined
          v-model="email"
          class="input_login"
          label="Email"
          color="green-10"
        >
        </q-input>
        <q-input
          rounded
          outlined
          v-model="password"
          class="input_login"
          label="Password"
          color="green-10"
          type="password"
        >
        </q-input>
        <q-btn
          type="submit"
          class="input_btn"
          push
          color="green-10"
          label="Connect"
        />
        <div class="forgot_password">
          <p>Forgot your password?</p>
          <span @click="handleSignUp">Sign up</span>
        </div>
      </q-form>

      <!-- sign up -->
      <q-form
        @submit.prevent="CreateNewUser"
        class="signup_section__form"
        v-if="mode === 'signup'"
      >
        <q-input
          rounded
          outlined
          v-model="username"
          class="input_login"
          label="Username"
          color="green-10"
        >
        </q-input>
        <q-input
          rounded
          outlined
          v-model="email"
          class="input_login"
          label="Email"
          color="green-10"
        >
        </q-input>
        <q-input
          rounded
          outlined
          v-model="password"
          class="input_login"
          label="Password"
          color="green-10"
          type="password"
        >
        </q-input>
        <q-btn
          type="submit"
          class="input_btn"
          push
          color="green-10"
          label="Sign up"
        />

        <span @click="handleSignIn">Already have an account, Sign in </span>
      </q-form>
    </div>
  </main>
</template>

<script>
import axios from "axios";
import { LocalStorage } from "quasar";
// import { store } from "quasar/wrappers";
import { useUserStore } from "src/stores/store-users";

export default {
  name: "LoginComponent",
  setup() {
    const store = useUserStore();
    return {
      store

    }
  },
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
      password: "",
      username: "",
      mode: "signin",
      curentUser: {},
    };
  },

  methods: {
    login() {
      axios
        .post("/api/users/login", {
          email: this.email,
          password: this.password,
        })
        .then((res) => {
          // console.log(res.data);
          this.user = res.data;
          // console.log(this.user);
          if (res.data.token) {
            LocalStorage.set("token", res.data.token);
            localStorage.setItem(
              "currenUser",
              JSON.stringify(this.email, this.password, res.data.token)
            );
            // localStorage.setItem("currentUser", JSON.stringify(res.data.token));
          } else {
            console.log("error");
          }
        });
    },
    handleSignUp() {
      this.mode = "signup";
    },
    handleSignIn() {
      this.mode = "signin";
    },
    // create() {
    //   const body = {
    //     user: {
    //       username: this.username,
    //       email: this.email,
    //       password: this.password,
    //     },
    //   };
    //   axios
    //     .post("/api/users", body, {
    //       headers: {
    //         "Content-Type": "application/json",
    //       },
    //     })
    //     .then((res) => {
    //       localStorage.setItem("currentUser", JSON.stringify(res.data.data));
    //       this.user = res.data.data;
    //       alert("User created");
    //       this.$router.push("/profile");
    //     });
    // }
    CreateNewUser() {
      this.store.CreateNewUser( {
        username: this.username,
        email: this.email,
        password: this.password,
      });
    },
  },
};
</script>

<style>
.main_login {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 90vh;
}

.login_section {
  width: 50%;
  height: 70%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  background-color: #9ae691;
  box-shadow: 0 0 0 2px white;
  border-radius: 8px;
}

.login_title {
  font-size: 30px;
  font-weight: bold;
  border-bottom: 3px solid black;
  margin-top: 13%;
  display: flex;
  align-items: center;
  height: 5%;
}

.signin_section__form,
.signup_section__form {
  color: black;
  height: 55%;
  width: 80%;
  margin-bottom: 10%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
}

.input_login {
  justify-content: center;
  align-items: center;
  width: 80%;
  margin: 2%;
}

.input_btn {
  margin: 1%;
}

.forgot_password {
  font-size: 15px;
  font-weight: bold;
  color: black;
  height: 10%;
  margin: 2%;
}
</style>
