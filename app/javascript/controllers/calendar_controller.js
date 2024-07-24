import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static values = { dayNumber: String }
  static targets = ["form", "hour", "input", "savedDate"]

  connect() {
    this.closeTimeout = null
  }

  openModal() {
    this.formTarget.classList.remove("d-none")
    this.formTarget.classList.add("calendar-modal")
  }

  select(event) {
    event.preventDefault()
    this.hourTargets.forEach(hour => {
      hour.classList.remove("btn-primary")
    });

    event.currentTarget.classList.add("btn-primary")
    const hour = parseInt(event.currentTarget.dataset.tiempo) - 6
    const day = parseInt(event.currentTarget.dataset.fecha)
    const month = parseInt(event.currentTarget.dataset.month) - 1
    const year = new Date().getFullYear()
    const selectedDate = new Date(year, month, day, hour, 0, 0)

    const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' }
    const formattedDate = selectedDate.toLocaleDateString('en-US', options)
    console.log(formattedDate)

    // this.savedDateTarget.innerText = formattedDate;
    this.inputTarget.value = selectedDate.toISOString();
    console.log(this.inputTarget.value)
  }

  closeModal(event) {
    event.currentTarget.parentElement.remove()
  }
}
