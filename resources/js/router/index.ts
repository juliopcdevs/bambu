import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'home',
    component: () => import('@pages/Home.vue'),
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
