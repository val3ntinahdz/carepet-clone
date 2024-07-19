import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
    new Swiper( '.swiper-container.dashboard', {
      pagination: '.swiper-pagination',
      initialSlide: 0,
      paginationClickable: true,
      effect: 'coverflow',
      loop: false,
      centeredSlides: true,
      slidesPerView: 'auto',
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
