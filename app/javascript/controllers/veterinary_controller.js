import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="veterinary"
export default class extends Controller {
  connect() {
    new Swiper( '.swiper-container.veterinary', {
      effect: 'slide',
    } );
  }
}
