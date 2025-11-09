<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center">
    <div class="max-w-md w-full text-center">
      <h1 class="text-4xl font-bold text-primary-600 mb-4">
        Welcome to Your Project
      </h1>
      <p class="text-gray-600 mb-8">
        Laravel 12 + Vue 3 + TypeScript + MongoDB Boilerplate
      </p>
      <div class="space-x-4">
        <router-link
          to="/login"
          class="inline-block px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition"
        >
          Login
        </router-link>
        <router-link
          v-if="isAuthenticated"
          to="/dashboard"
          class="inline-block px-6 py-3 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition"
        >
          Dashboard
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useAuthStore } from '@stores/authStore';

const authStore = useAuthStore();
const isAuthenticated = computed(() => authStore.isAuthenticated);
</script>
