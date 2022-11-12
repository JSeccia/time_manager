import ClockPage from "../pages/ClockPage.vue";
import ChartsPages from "../pages/ChartsPage.vue";
import WorkingPage from "../pages/WorkingsPage.vue";
import WTPage from "../pages/WTPage.vue";
import ProfilePage from "../pages/ProfilePage.vue";
import LoginPage from "../pages/LoginPage.vue";
import AdminPage from "../pages/AdminPage.vue";
import AdminUserPage from "../pages/UsersPage.vue";
import UserPage from "../pages/UserPage.vue";
import TeamsPage from "../pages/TeamsPage.vue";
import TeamPage from "../pages/TeamPage.vue";

const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "profile", component: ProfilePage },
      { path: "clocks", component: ClockPage },
      { path: "charts", component: ChartsPages },
      { path: "workingtimes", component: WorkingPage },
      {
        path: "workings/:userId/:id", 
        component: WTPage,
      },
      { path: "users", component: AdminUserPage },
      { path: "users/:userId", component: UserPage },
      { path: "login", component: LoginPage},
      { path: "teams", component: TeamsPage},
      { path: "teams/:teamId", component: TeamPage},

      { path: "admin", component: AdminPage, meta: {requiresAuth: true},
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
