import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownContent", "openButton", "closeButton"]
  connect() {
    this.dropdownContentTarget.hidden = true
    this.closeButtonTarget.hidden = true
  }

  openDropdown() {
    this.dropdownContentTarget.hidden = false
    this.openButtonTarget.hidden = true
    this.closeButtonTarget.hidden = false
  }

  closeDropdown() {
    this.dropdownContentTarget.hidden = true
    this.openButtonTarget.hidden = false
    this.closeButtonTarget.hidden = true
  }
}
