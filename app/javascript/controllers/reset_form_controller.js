import { Controller } from "@hotwired/stimulus"

// Conecta automaticamente quando o Turbo envia o form
export default class extends Controller {
  reset() {
    this.element.reset()
  }
}
