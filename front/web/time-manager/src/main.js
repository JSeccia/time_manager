import { createApp } from "vue";
import { createPinia } from "pinia";
//import Vue from "vue";
//import VueFusionCharts from "vue-fusioncharts";
//import FusionCharts from "fusioncharts";


import App from "./App.vue";
import router from "./router";

import "./assets/main.css";
import { Quasar } from 'quasar'
import quasarUserOptions from './quasar-user-options'

//Vue.use(VueFusionCharts, FusionCharts);

const app = createApp(App).use(Quasar, quasarUserOptions);

app.use(createPinia());
app.use(router);

app.mount("#app");
