/** @type {import('tailwindcss').Config} */
module.exports = {
  // ⚡️ A CHAVE QUE FALTAVA
  darkMode: "class",

  // ⚡️ A CHAVE ESSENCIAL PARA A GEMA 'tailwindcss-rails'
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './app/components/**/*'
  ],

  theme: {
    extend: {},
  },
  plugins: [],
}