import { Controller } from "@hotwired/stimulus"

// lida com o "abrir/fechar" do menu mobile
export default class extends Controller {
  // 1. Define qual "target" queremos controlar
  //    Neste caso, o próprio menu que será escondido/mostrado.
  static targets = [ "menu" ]

  // 2. Ação que será chamada pelo clique
  toggle() {
    // 3. Simplesmente alterna a classe "hidden" no "menuTarget"
    this.menuTarget.classList.toggle("hidden")
  }
}