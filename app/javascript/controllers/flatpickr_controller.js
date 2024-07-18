import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="flatpickr"
export default class extends Controller {

  connect() {
    console.log("connected to flatpickr", this.element)

    flatpickr((".datetime"), {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      minDate: "today",
      disableMobile: true
    });
  }
}
