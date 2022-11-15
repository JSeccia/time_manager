<template>
  <q-layout>
    <q-header>
      <div class="bg-green text-white">
        <q-toolbar>


          <q-space />
          <q-btn v-if="currentUser.role === 'admin'" flat round dense icon="lock" to="/admin" label="admin"
            @click="handleAdminButton" class="q-mr-xs" />
        </q-toolbar>

        <q-toolbar inset v-if="currentUser.id">
          <q-breadcrumbs active-color="white" style="font-size: 16px">
            <q-breadcrumbs-el v-if="currentUser.role != 'admin'" label="Profile" icon="home" to="/profile" />
            <q-breadcrumbs-el v-if="currentUser.role === 'manager' || currentUser.role === 'user'" label="Clocks"
              to="/clocks" />
            <q-breadcrumbs-el v-if="currentUser.role === 'manager'" label="Charts" to="/charts" />
            <q-breadcrumbs-el v-if="currentUser.role != 'admin'" label="Working times" to="/workingtimes" />
            <q-breadcrumbs-el v-if="currentUser.role === 'admin'" label="Teams" to="/teams" />
            <q-breadcrumbs-el v-if="currentUser.role === 'manager'" label="Team" to=teams />

            <q-breadcrumbs-el v-if="currentUser.role === 'admin'" label="Users" to="/users" />


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
      if (this.currentUser.role === 'admin') {
        this.$router.push({ path: '/admin' });
      }
    },

  },
});
</script>
