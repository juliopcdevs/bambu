import { defineConfig } from 'vitest/config';
import vue from '@vitejs/plugin-vue';
import { fileURLToPath } from 'node:url';

export default defineConfig({
  plugins: [vue()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./resources/js/__tests__/setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'resources/js/__tests__/',
        '**/*.spec.ts',
        '**/*.test.ts',
        '**/types/',
      ],
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./resources/js', import.meta.url)),
      '@components': fileURLToPath(new URL('./resources/js/components', import.meta.url)),
      '@layouts': fileURLToPath(new URL('./resources/js/layouts', import.meta.url)),
      '@pages': fileURLToPath(new URL('./resources/js/pages', import.meta.url)),
      '@stores': fileURLToPath(new URL('./resources/js/stores', import.meta.url)),
      '@types': fileURLToPath(new URL('./resources/js/types', import.meta.url)),
      '@utils': fileURLToPath(new URL('./resources/js/utils', import.meta.url)),
      '@composables': fileURLToPath(new URL('./resources/js/composables', import.meta.url)),
    },
  },
});
