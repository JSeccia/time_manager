<template>
  <q-layout>
    <q-header>
      <div class="bg-green text-white">
        <q-toolbar>
          <q-btn flat round dense icon="assignment_ind" />

          <q-space />
          <q-btn flat round dense icon="search" class="q-mr-xs" />
        </q-toolbar>

        <q-toolbar inset>
          <q-breadcrumbs active-color="white" style="font-size: 16px">
            <q-breadcrumbs-el label="Profile" icon="home" to="/profile" />
            <q-breadcrumbs-el label="Clocks" to="/clocks" />
            <q-breadcrumbs-el label="Charts" to="/charts" />
            <q-breadcrumbs-el label="Workings" to="/workings" />
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
import { defineComponent, ref } from 'vue'
//import LoginPageVue from 'src/pages/LoginPage.vue'
//import EssentialLink from 'components/EssentialLink.vue'
//import User from 'components/User.vue'
//import WorkingTimes from 'components/WorkingTimes.vue'

export default defineComponent({

  name: 'MainLayout',

})
</script>
