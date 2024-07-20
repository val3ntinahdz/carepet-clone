import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="redirect-refresh"
export default class extends Controller {
  connect() {
    this.handleRefresh = this.refresh.bind(this)
    window.addEventListener("turbo:load", this.handleRefresh)
  }
  disconnect() {
    window.removeEventListener("turbo:load", this.handleRefresh)
  }
  refresh() {
    if (!localStorage.getItem('refreshed')) {
      localStorage.setItem('refreshed', 'true')
      window.location.reload()
    } else {
      localStorage.removeItem('refreshed')
    }
  }
}
