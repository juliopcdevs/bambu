import './bootstrap';
import { createApp } from 'vue';
import { createPinia } from 'pinia';
import router from './router';
import App from './App.vue';

// Import main CSS
import '../css/app.css';

// Create Vue app
const app = createApp(App);

// Use Pinia for state management
const pinia = createPinia();
app.use(pinia);

// Use Vue Router
app.use(router);

// Mount the app
app.mount('#app');
