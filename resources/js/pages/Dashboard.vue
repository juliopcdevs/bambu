<template>
  <div class="min-h-screen bg-gray-100">
    <nav class="bg-white shadow">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex items-center">
            <h1 class="text-xl font-bold text-gray-900">Dashboard</h1>
          </div>
          <div class="flex items-center">
            <span class="text-gray-700 mr-4">{{ user?.name }}</span>
            <button
              @click="handleLogout"
              class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 transition"
            >
              Logout
            </button>
          </div>
        </div>
      </div>
    </nav>

    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <div class="px-4 py-6 sm:px-0">
        <div class="border-4 border-dashed border-gray-200 rounded-lg p-8">
          <h2 class="text-2xl font-semibold text-gray-900 mb-4">
            Welcome, {{ user?.name }}!
          </h2>
          <p class="text-gray-600">
            This is your dashboard. Start building your application from here.
          </p>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@stores/authStore';

const router = useRouter();
const authStore = useAuthStore();

const user = computed(() => authStore.user);

async function handleLogout() {
  await authStore.logout();
  router.push({ name: 'login' });
}
</script>
