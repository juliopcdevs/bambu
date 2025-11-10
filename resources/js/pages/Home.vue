<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- Hero Section -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
      <div class="text-center mb-16">
        <div class="flex justify-center mb-6">
          <img src="/panda.png" alt="Bambu Logo" class="w-24 h-24">
        </div>
        <h1 class="text-5xl font-bold text-gray-900 mb-4">
          Bambu Boilerplate
        </h1>
        <p class="text-xl text-gray-600 mb-8">
          Modern full-stack template for building web applications
        </p>
      </div>

      <!-- Features Grid -->
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🎯</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Laravel 12</h3>
          <p class="text-gray-600 text-sm">
            Powerful PHP framework with modern features and elegant syntax
          </p>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">⚡</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Vue 3 + TypeScript</h3>
          <p class="text-gray-600 text-sm">
            Reactive frontend with type safety and modern development tools
          </p>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🗄️</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">MongoDB</h3>
          <p class="text-gray-600 text-sm">
            Flexible NoSQL database for modern data structures
          </p>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🔒</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">JWT Authentication</h3>
          <p class="text-gray-600 text-sm">
            Secure token-based authentication with Vue Router guards
          </p>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🎨</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Tailwind CSS 4</h3>
          <p class="text-gray-600 text-sm">
            Utility-first CSS framework for rapid UI development
          </p>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
          <div class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🐳</span>
          </div>
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Docker Ready</h3>
          <p class="text-gray-600 text-sm">
            Complete Docker setup for development and production environments
          </p>
        </div>
      </div>

      <!-- Quick Start Section -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-4">Quick Start</h2>
        <div class="space-y-3 text-gray-700">
          <div class="flex items-start">
            <span class="font-mono text-sm bg-gray-100 px-3 py-1 rounded mr-4 flex-shrink-0">1</span>
            <div>
              <code class="text-sm bg-gray-900 text-gray-100 px-3 py-1 rounded">make init</code>
              <span class="text-sm text-gray-600 ml-2">- Initialize project configuration</span>
            </div>
          </div>
          <div class="flex items-start">
            <span class="font-mono text-sm bg-gray-100 px-3 py-1 rounded mr-4 flex-shrink-0">2</span>
            <div>
              <code class="text-sm bg-gray-900 text-gray-100 px-3 py-1 rounded">make build && make up</code>
              <span class="text-sm text-gray-600 ml-2">- Build and start Docker containers</span>
            </div>
          </div>
          <div class="flex items-start">
            <span class="font-mono text-sm bg-gray-100 px-3 py-1 rounded mr-4 flex-shrink-0">3</span>
            <div>
              <code class="text-sm bg-gray-900 text-gray-100 px-3 py-1 rounded">make install</code>
              <span class="text-sm text-gray-600 ml-2">- Install dependencies</span>
            </div>
          </div>
          <div class="flex items-start">
            <span class="font-mono text-sm bg-gray-100 px-3 py-1 rounded mr-4 flex-shrink-0">4</span>
            <div>
              <code class="text-sm bg-gray-900 text-gray-100 px-3 py-1 rounded">make migrate</code>
              <span class="text-sm text-gray-600 ml-2">- Run database migrations</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <footer class="bg-white border-t mt-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <p class="text-center text-gray-600 text-sm">
          Built with Laravel, Vue, TypeScript & MongoDB • MIT License
        </p>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
// Home page - Bambu Boilerplate showcase
</script>
