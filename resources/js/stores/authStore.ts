import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import axios from '@/bootstrap';
import type { User, LoginCredentials, AuthResponse } from '@types/auth';

export const useAuthStore = defineStore('auth', () => {
  const user = ref<User | null>(null);
  const token = ref<string | null>(localStorage.getItem('token'));
  const isLoading = ref(false);

  const isAuthenticated = computed(() => !!token.value && !!user.value);

  async function login(credentials: LoginCredentials) {
    isLoading.value = true;
    try {
      const response = await axios.post<AuthResponse>('/login', credentials);
      token.value = response.data.access_token;
      user.value = response.data.user;
      localStorage.setItem('token', response.data.access_token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${response.data.access_token}`;
      return true;
    } catch (error) {
      console.error('Login error:', error);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  async function logout() {
    isLoading.value = true;
    try {
      await axios.post('/logout');
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      clearAuth();
      isLoading.value = false;
    }
  }

  async function init() {
    if (!token.value) return;

    isLoading.value = true;
    try {
      const response = await axios.get<User>('/me');
      user.value = response.data;
    } catch (error) {
      console.error('Init auth error:', error);
      clearAuth();
    } finally {
      isLoading.value = false;
    }
  }

  function clearAuth() {
    user.value = null;
    token.value = null;
    localStorage.removeItem('token');
    delete axios.defaults.headers.common['Authorization'];
  }

  return {
    user,
    token,
    isLoading,
    isAuthenticated,
    login,
    logout,
    init,
    clearAuth,
  };
});
