import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';
import path from 'path';

export default defineConfig({
  plugins: [
    tailwindcss(),
    laravel({
      input: ['resources/css/app.css', 'resources/js/app.ts'],
      refresh: true,
    }),
    vue({
      template: {
        transformAssetUrls: {
          base: null,
          includeAbsolute: false,
        },
      },
    }),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './resources/js'),
      '@components': path.resolve(__dirname, './resources/js/components'),
      '@layouts': path.resolve(__dirname, './resources/js/layouts'),
      '@pages': path.resolve(__dirname, './resources/js/pages'),
      '@stores': path.resolve(__dirname, './resources/js/stores'),
      '@types': path.resolve(__dirname, './resources/js/types'),
      '@utils': path.resolve(__dirname, './resources/js/utils'),
      '@composables': path.resolve(__dirname, './resources/js/composables'),
    },
  },
  server: {
    host: '0.0.0.0',
    port: parseInt(process.env.VITE_PORT || '5173'),
    hmr: {
      host: 'localhost',
      port: parseInt(process.env.VITE_PORT || '5173'),
    },
    watch: {
      usePolling: true,
    },
  },
});
