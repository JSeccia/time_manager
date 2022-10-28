import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
//import Vue from "vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/chart",
      name: "chart",
      component: () => import("../views/ChartView.vue"),
    },
    {
      path: "/clock",
      name: "clock",
      component: () => import("../views/ClockView.vue"),
    },
    {
      path: "/about",
      name: "about",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/AboutView.vue"),
    },
    // WorkingTimes route
    {
      path: "/workingtimes",
      name: "WorkingTimes",
      component: () => import("../views/WorkingTimesView.vue"),
    },
    {
      path: "/workingtimes/:user_id/:id",
      name: "WorkingTime",
      component: () => import("../views/WorkingTimeShowView.vue"),
    },
  ],
});

export default router;
