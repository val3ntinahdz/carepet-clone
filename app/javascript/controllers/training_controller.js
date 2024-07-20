import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="training"
export default class extends Controller {
  connect() {
    new Swiper( '.swiper-container.training', {
      effect: 'coverflow',
      grabCursor: true,
      loop: true,
      centeredSlides: true,
      coverflow: {
        rotate: 0,
        stretch: 100,
        depth: 150,
        modifier: 1.5,
        slideShadows : false,
      }
    } );
  }
}
