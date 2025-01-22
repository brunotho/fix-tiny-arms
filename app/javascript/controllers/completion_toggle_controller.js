import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("CompletionToggle controller connected")

    this.element.addEventListener("change", () => {
      console.log("Checkbox 😎!")

      this.element.form.requestSubmit()
    })
  }
}
