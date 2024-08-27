import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reschedule-form"
export default class extends Controller {
  static targets = ['rescheduleForm']

  connect() {
    console.log("Connected")
  }

  closeForm() {
    this.rescheduleFormTarget.classList.add("d-none")
  }
}
