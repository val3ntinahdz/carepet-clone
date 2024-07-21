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
    const tiempo = event.currentTarget.dataset.tiempo
    const fecha = event.currentTarget.dataset.fecha
    const selectedTimeElement = document.getElementById("selected_time")
    const month = parseInt(event.currentTarget.dataset.month) - 1
    const selectedDate = new Date (2024, month, fecha, tiempo, 0, 0)
    const selectedDateString = selectedDate.toLocaleString()
    console.log(selectedDate)

    this.savedDateTarget.innerText = selectedDateString
    this.inputTarget.value = selectedDate
    console.log(this.inputTarget.value)
  }

  startCloseModalTimer() {
    this.closeTimeout = setTimeout(() => {
      this.closeModal()
    }, 7000)
  }

  cancelCloseModalTimer() {
    clearTimeout(this.closeTimeout)
  }

  closeModal() {
    this.formTarget.classList.add("d-none")
    this.formTarget.classList.remove("calendar-modal")
  }
}
