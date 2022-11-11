<template>
  <q-layout>
    <q-header>
      <div class="bg-green text-white">
        <q-toolbar>
          <div v-if="!currentUser.id">
            <q-btn flat round dense icon="assignment_ind" to="/login" label="Sign in" @click="handleSigninButton"/>
          </div>
          

          <q-space />
          <q-btn v-if="currentUser.role === 'admin'" flat round dense icon="lock" to="/admin" label="admin" @click="handleAdminButton" class="q-mr-xs" />
        </q-toolbar>

        <q-toolbar inset v-if="currentUser.id" >
          <q-breadcrumbs active-color="white" style="font-size: 16px">
            <q-breadcrumbs-el label="Profile" icon="home" to="/profile" />
            <q-breadcrumbs-el label="Clocks" to="/clocks" />
            <q-breadcrumbs-el label="Charts" to="/charts" />
            <q-breadcrumbs-el label="Working times" to="/workingtimes" />
            <q-breadcrumbs-el v-if="currentUser.role === 'admin'" label="User" to="/users" />
            <!-- test graph -->
            <q-breadcrumbs-el label="GraphTest" to="/graphtest" />
            <!-- test graph -->
          
        </q-breadcrumbs>
        </q-toolbar>
      </div>
    </q-header>
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useUserStore } from "src/stores/store-users";

export default defineComponent({
  name: "MainLayout",
  
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      currentUser: this.store.user,
    };
  },
  methods: {
    handleAdminButton() {
      if(this.currentUser.role === 'admin') {
        this.$router.push({ path: '/admin' });
      }
    },
    handleSigninButton () {
      if(!this.currentUser) {
        this.$router.push({ path: '/login' });
      }
    },
  },
    

  
});
</script>
