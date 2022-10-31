import ClockPage from "../pages/ClockPage.vue";
import ChartsPages from "../pages/ChartsPage.vue";
import WorkingPage from "../pages/WorkingsPage.vue";

const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      // {
      //   path: "workingtimes",
      //   component: WorkingTimesPages,
      // },
      { path: "clocks", component: ClockPage },
      { path: "charts", component: ChartsPages },
      { path: "workings", component: WorkingPage },
      {
        path: "workings/:userId/:id",
        component: () => import("pages/WTPage.vue"),
      },
    ],
  },
  // {
  //   path: '/workings',
  //   component: () => import('src/pages/WorkingsPage.vue'),
  //   children: [
  //     { path: '/:userId/:id', component: () => import('pages/WorkingTime.vue') },

  //   ]
  // },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue"),
  },
];

export default routes;
