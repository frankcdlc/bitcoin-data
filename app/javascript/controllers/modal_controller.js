import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {

  }
  delete(event) {
    let confirmed = confirm("Are you sure you want delete this block?")

    if(!confirmed) {
      event.preventDefault()
    }
  }
}
