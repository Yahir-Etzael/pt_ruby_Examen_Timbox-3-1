import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["required", "password", "passwordConfirmation"]

  validate(event) {
    let valid = true

    this.requiredTargets.forEach((field) => {
      field.classList.toggle("is-invalid", field.value.trim() === "")
      valid = valid && field.value.trim() !== ""
    })

    if (this.hasPasswordTarget && this.hasPasswordConfirmationTarget) {
      const password = this.passwordTarget.value
      const confirmation = this.passwordConfirmationTarget.value
      const mismatch = password !== confirmation
      this.passwordTarget.classList.toggle("is-invalid", mismatch)
      this.passwordConfirmationTarget.classList.toggle("is-invalid", mismatch)
      valid = valid && !mismatch
    }

    if (!valid) event.preventDefault()
  }
}
