import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reschedule-form"
export default class extends Controller {
  static targets = ['rescheduleForm']

  connect() {
    console.log("Connected")
    this.hideForm();
    this.openForm();
  }

  openForm() {
    this.rescheduleFormTarget.classList.remove("d-none")
  }

  hideForm() {
    this.rescheduleFormTarget.classList.add("d-none")
  }
}
