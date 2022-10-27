import { createApp } from "vue";
import { createPinia } from "pinia";
//import Vue from "vue";
//import VueFusionCharts from "vue-fusioncharts";
//import FusionCharts from "fusioncharts";


import App from "./App.vue";
import router from "./router";

import "./assets/main.css";

//Vue.use(VueFusionCharts, FusionCharts);

const app = createApp(App);

app.use(createPinia());
app.use(router);

app.mount("#app");
