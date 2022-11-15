<template>
  <main class="main-index">
    <div class="logo" v-if="!this.currentUser.id">
      <img id="logo_web" src="../assets/logo_web.png" alt="logo Time Manager">
    </div>
    <LoginComponent v-if="!this.currentUser.id"/>
  

    <div class="main_layout" v-if="this.currentUser.id">
      <MainLayout />
    </div>
  </main>
</template>

<script>
import { defineComponent } from 'vue'
import MainLayout from 'src/layouts/MainLayout.vue';
import LoginComponent from 'src/components/LoginComponent.vue';
import { useUserStore } from 'src/stores/store-users';

export default defineComponent({
  name: 'IndexPage',
  components: {
    MainLayout,
    LoginComponent,
  },
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      currentUser: this.store.user,
    }
  },
  methods: {
    handleSigninButton() {
      this.$router.push({ path: '/login' });
    },
  },
})
</script>
<style>

.main-index {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  height: 100%;
  width: 100%;
}

.main-index .main_login {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  width: 95%;
  height: 40%;

}

.main-index .login_section {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 50%;
  height: 100%;
}

.main-index .login_title {
  margin-top: 3%;
  margin-bottom: 3%;
}

.main-index .login_title .signin_section__form {
  margin-bottom: 2%;
}

.logo {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 200px;
  height: 10%;
}

#logo_web {
  width: 100%;
}

.main-index .main_layout {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  width: 100%;
  height: 100%;
}


  


@media screen and (min-width: 769px) and (max-width: 1024px) {
  .main-index .main_login {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 70%;
    height: 40%;
  }

  .main-index .login_section {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }

  .main-index .login_title {
    margin-top: 3%;
    margin-bottom: 3%;
  }

  .main-index .login_title .signin_section__form {
    margin-bottom: 2%;
  }

  .logo {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 200px;
    height: 10%;
  }

  #logo_web {
    width: 100%;
  }

  .main-index .main_layout {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    height: 100%;
  }
}

@media screen and (min-width: 600px) and (max-width: 768px) {
  .main-index .main_login {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 70%;
    height: 40%;
  }

  .main-index .login_section {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }

  .main-index .login_title {
    margin-top: 3%;
    margin-bottom: 3%;
  }

  .main-index .login_title .signin_section__form {
    margin-bottom: 2%;
  }

  .logo {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 200px;
    height: 10%;
  }

  #logo_web {
    width: 100%;
  }

  .main-index .main_layout {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    height: 100%;
  }
}

@media screen and (min-width: 320px) and (max-width: 599px) {
  .main-index .main_login {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 70%;
    height: 40%;
  }

  .main-index .login_section {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }

  .main-index .login_title {
    margin-top: 3%;
    margin-bottom: 3%;
  }

  .main-index .login_title .signin_section__form {
    margin-bottom: 2%;
  }

  .logo {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 200px;
    height: 10%;
  }

  #logo_web {
    width: 100%;
  }

  .main-index .main_layout {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    height: 100%;
  }
}

</style>
