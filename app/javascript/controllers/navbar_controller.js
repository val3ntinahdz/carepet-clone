import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["item"]

  connect() {
  }

  activeLink(event) {
    // event.preventDefault()
    this.itemTargets.forEach(item => {
      item.classList.remove("active")
    });
    event.currentTarget.parentElement.classList.add("active")
  }
}

/* <script>
    const listItem = document.querySelectorAll(".list");
      function activeLink(){
        listItem.forEach((item) =>
        item.classList.remove("active"));
        this.classList.add("active");
      }
    listItem.forEach((item) =>
    item.addEventListener("click",activeLink));
  </script> */
