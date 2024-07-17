import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "dateTime" ];

  connect() {
    flatpickr(this.dateTimeTarget, {
      enableTime: true,
      altInput: true,
      altFormat: "F j, Y h:i K",
      dateFormat: "Y-m-d H:i",
    });
  }
}
