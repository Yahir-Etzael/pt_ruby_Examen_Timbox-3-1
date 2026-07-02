import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "result"]

  evaluate() {
    const words = this.inputTarget.value
      .split(/[\n,]+/)
      .map((word) => word.trim())
      .filter(Boolean)

    const rows = words.map((word) => {
      const normalized = word.toLowerCase().replace(/\s/g, "")
      const reversed = normalized.split("").reverse().join("")
      const isPalindrome = normalized === reversed
      const badge = isPalindrome ? "text-bg-success" : "text-bg-secondary"
      const label = isPalindrome ? "Palindroma" : "No palindroma"

      return `<tr><td>${this.escape(word)}</td><td><span class="badge ${badge}">${label}</span></td></tr>`
    })

    this.resultTarget.innerHTML = `
      <table class="table table-sm table-bordered">
        <thead><tr><th>Palabra</th><th>Resultado</th></tr></thead>
        <tbody>${rows.join("")}</tbody>
      </table>
    `
  }

  escape(value) {
    return value.replace(/[&<>"']/g, (char) => ({
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#039;"
    }[char]))
  }
}
