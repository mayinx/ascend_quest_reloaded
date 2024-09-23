import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inline-edit"
export default class extends Controller {
  static targets = ["form"]

  edit(event) {
    event.preventDefault()

    const row = event.currentTarget.closest('tr')
    const expenseId = row.dataset.expenseId 

    fetch(`/expenses/${expenseId}/edit_inline`, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    })
    .then(response => response.text())
    .then(html => {
      row.insertAdjacentHTML('afterend', html) // Insert the form after the row
      row.style.display = "none" // Hide the original row
    })
    .catch(error => console.error('Error:', error))
  }

  cancel(event) {
    event.preventDefault()
    
    const row = event.currentTarget.closest('tr')
    const originalRow = row.previousElementSibling
    
    originalRow.style.display = ""
    row.remove()
  }
}



// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = [ "display", "form" ]

//   connect() {
//     // Optionally, any initial setup can go here
//   }

//   // Hides the display view and shows the edit form.
//   edit(event) {
//     event.preventDefault();
//     this.displayTarget.classList.add("hidden")
//     this.formTarget.classList.remove("hidden")
//   }

//   // Hides the edit form and returns to the display view.
//   cancel(event) {
//     event.preventDefault();
//     this.formTarget.classList.add("hidden")
//     this.displayTarget.classList.remove("hidden")
//   }

//   // Triggered when the form is successfully submitted.
//   success() {
//     this.formTarget.classList.add("hidden")
//     this.displayTarget.classList.remove("hidden")
//   }

//   // Displays an alert if something goes wrong.
//   error() {
//     alert("Error updating the expense. Please try again.")
//   }
// }


