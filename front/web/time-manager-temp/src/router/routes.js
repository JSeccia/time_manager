
const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: 'workingtimes', component: () => import('pages/WorkingTimes.vue') },
      { path: 'clocks', component: () => import('pages/ClockPage.vue') },
      { path: 'charts', component: () => import('pages/ChartsPage.vue') },
      { path: 'workings', component: () => import('pages/WorkingsPage.vue') }
    ]
  },
  

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes
