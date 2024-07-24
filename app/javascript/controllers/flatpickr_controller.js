import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="flatpickr"
export default class extends Controller {
    static values = { bookedDates: Array }

    connect() {
      // console.log("connected to flatpickr", this.element)

      // // const bookedDates = JSON.parse(this.element.dataset.bookedDates);
      // // const disabledDates = bookedDates.map(date => new Date(date));
      // const disabledDates = this.bookedDatesValue.map(date => new Date(date));

      // flatpickr(this.element.querySelector(".datetime"), {
      //   enableTime: true,
      //   dateFormat: "Y-m-d H:i",
      //   minDate: "today",
      //   disableMobile: true,
      //   time_24hr: true,
      //   disable: [ function(date) { return disabledDates.some(bookedDate => { return ( date.getFullYear() === bookedDate.getFullYear() && date.getMonth() === bookedDate.getMonth() && date.getDate() === bookedDate.getDate() && date.getHours() === bookedDate.getHours() && date.getMinutes() === bookedDate.getMinutes() ); }); } ]
      // });
  }
}
