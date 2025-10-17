import { Controller } from "@hotwired/stimulus"

// Conecta com data-controller="item"
export default class extends Controller {
  toggle(event) {
    const checkbox = event.target
    const form = checkbox.closest("form")

    // Envia o form automaticamente com o novo status
    form.requestSubmit()
  }
}