import { route } from 'quasar/wrappers'
import { createRouter, createMemoryHistory, createWebHistory, createWebHashHistory } from 'vue-router'
import routes from './routes'
import {useUserStore} from '../stores/store-users'
/*
 * If not building with SSR mode, you can
 * directly export the Router instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Router instance.
 */
export default (function ({ store, /* ssrContext */ }) {
  const createHistory = process.env.SERVER
    ? createMemoryHistory
    : (process.env.VUE_ROUTER_MODE === 'history' ? createWebHistory : createWebHashHistory)

  const Router = createRouter({
    scrollBehavior: () => ({ left: 0, top: 0 }),
    routes,

    // Leave this as is and make changes in quasar.conf.js instead!
    // quasar.conf.js -> build -> vueRouterMode
    // quasar.conf.js -> build -> publicPath
    history: createHistory(process.env.VUE_ROUTER_BASE),


    })
    // Router.beforeEach((to, from, next) => {
    //   let routerAuthCheck = false;
      
    //   if (to.matched.some(record => record.meta.requiresAuth)) {
    //     // check user is authenticated
    //     if (routerAuthCheck) {
    //       store.isUserAuthorized = true;
    //     }
    //     if (routerAuthCheck) {
    //       // user is authenticated
    //       // commit to store that the user is authenticated
    //       next();
    //     } else {
    //       // user is not authenticated
    //       Router.push('/login')
    //     }
    //   } 
    //   // Allow access
    //   else {
    //     next();
    //   }
    // })

  return Router
})

