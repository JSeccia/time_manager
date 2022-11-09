<template>
  <q-layout>
    <q-header>
      <div class="bg-green text-white">
        <q-toolbar>
          <q-btn flat round dense icon="assignment_ind" to="/login" />

          <q-space />
          <q-btn flat round dense icon="search" class="q-mr-xs" />
        </q-toolbar>

        <q-toolbar inset>
          <q-breadcrumbs active-color="white" style="font-size: 16px">
            <q-breadcrumbs-el label="Profile" icon="home" to="/profile" />
            <q-breadcrumbs-el label="Clocks" to="/clocks" />
            <q-breadcrumbs-el label="Charts" to="/charts" />
            <q-breadcrumbs-el label="Working times" to="/workingtimes" />
            <q-breadcrumbs-el label="User" to="/users" />
            <!-- test graph -->
            <q-breadcrumbs-el label="GraphTest" to="/graphtest" />
            <!-- test graph -->
          <q-breadcrumbs-el v-if="currentUser.role === 'admin'" label="Admin" to="/admin" />
          
        </q-breadcrumbs>
        </q-toolbar>
      </div>
    </q-header>
    <q-page-container>
      <LoginComponent v-if="!currentUser"/>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent, ref } from "vue";
import { useUserStore } from "src/stores/store-users";
import LoginComponent from 'src/components/LoginComponent.vue';

export default defineComponent({
  name: "MainLayout",
  components: {
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
    };
  },

  
});
</script>
