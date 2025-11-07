// app/javascript/controllers/theme_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  toggle() {
    // O .toggle() do classList é perfeito:
    // 1. Adiciona 'dark' se não existir, e retorna 'true'
    // 2. Remove 'dark' se existir, e retorna 'false'
    const isDark = document.documentElement.classList.toggle('dark')

    // Salva a escolha no localStorage
    localStorage.theme = isDark ? 'dark' : 'light'
  }
}