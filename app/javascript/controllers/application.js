import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true // default: false
window.Stimulus   = application

export { application }
