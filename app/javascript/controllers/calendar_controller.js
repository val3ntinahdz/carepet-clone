import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static values = { dayNumber: String }
  static targets = ["form", "hour"]

  connect() {
    console.log("connected to calendar")
  }

  openModal() {
    console.log(this.dayNumberValue)
    this.formTarget.classList.remove("d-none")
    this.formTarget.classList.add("calendar-modal")
  }

  select(event) {
    event.preventDefault()
    this.hourTargets.forEach(hour => {
      hour.classList.remove("btn-primary")
    });
    
    event.currentTarget.classList.add("btn-primary")
  }
}
