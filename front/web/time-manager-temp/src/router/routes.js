import ClockPage from "../pages/ClockPage.vue";
import ChartsPages from "../pages/ChartsPage.vue";
import WorkingPage from "../pages/WorkingsPage.vue";
import WTPage from "../pages/WTPage.vue";
import ProfilePage from "../pages/ProfilePage.vue";
import User from "../pages/User.vue";
import LoginPage from "../pages/LoginPage.vue";
import SignInPage from "../pages/SignInPage.vue";
import GraphTestPage from "../pages/GraphTestPage.vue";
import AdminPage from "../pages/AdminPage.vue";





const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      // {
      //   path: "workingtimes",
      //   component: WorkingTimesPages,
      // },
      { path: "profile", component: ProfilePage },
      { path: "clocks", component: ClockPage },
      { path: "charts", component: ChartsPages },
      { path: "workingtimes", component: WorkingPage },
      {
        path: "workings/:userId/:id",
        component: WTPage,
      },
      { path: "users", component: User },
      { path: "login", component: LoginPage},
      { path: "signin", component: SignInPage},
      { path: "graphtest", component: GraphTestPage},

      { path: "admin", component: AdminPage, meta: {requiresAuth: true},
        beforEnter: (to, from, next) => {
          let currentUser = JSON.parse(window.localStorage.currentUser);
          if (currentUser && currentUser.role === 'admin') {
            console.log(currentUser.role);
            next();
          } else {
            next('/profile');
          }

        }
      },
      

    ],
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue"),
  },
];





export default routes;
