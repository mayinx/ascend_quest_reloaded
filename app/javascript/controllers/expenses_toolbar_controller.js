// app/javascript/controllers/expenses_toolbar_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["searchInput", "sortSelect", "columnSelect", "table", "cards", "tableBody"];

  connect() {
    console.log("Toolbar connected");
    console.log("TableBody Target:", this.tableBodyTarget);

    // Get columns-meta-data (incl. defautl visible columns setup) from data attribute that's filled by the expenses decorator 
    // this.columns = JSON.parse(this.element.dataset.expensesColumns); 
    // console.log("columns from dataset: ", this.columns)
    // this.initializeColumnCheckboxes();
    // this.restoreColumnPreferences();    

    this.searchInputTarget.addEventListener("input", this.search.bind(this));
    this.sortSelectTarget.addEventListener("change", this.sort.bind(this));
    this.columnSelectTarget.addEventListener("change", this.updateColumns.bind(this));
  }

  // // Initialize the column checkboxes based on the available columns
  // initializeColumnCheckboxes() {
  //   const selectElement = this.columnSelectTarget; // This will be the container for checkboxes
  //   selectElement.innerHTML = ''; // Clear any previous content

  //   this.columns.forEach((column) => {
  //     // Create checkbox input
  //     const checkbox = document.createElement("input");
  //     checkbox.type = "checkbox";
  //     checkbox.value = column.key;
  //     checkbox.checked = column.visible;
  //     checkbox.disabled = !column.hideable; // Disable checkbox if column is non-hideable
  //     checkbox.dataset.columnKey = column.key; // Store column key in dataset for easy access

  //     // Create label for the checkbox
  //     const label = document.createElement("label");
  //     label.textContent = column.label;
  //     label.prepend(checkbox); // Insert checkbox before label text

  //     // Append checkbox and label to the select container
  //     selectElement.appendChild(label);

  //     // Add change listener for each checkbox
  //     checkbox.addEventListener("change", this.updateColumns.bind(this));
  //   });
  // }

  // // Update column visibility when user changes the checkbox selection
  // updateColumns(event) {
  //   const checkbox = event.target;
  //   const columnKey = checkbox.dataset.columnKey;
  //   const isVisible = checkbox.checked;

  //   // Find the column index by its key
  //   const columnIndex = this.columns.findIndex((col) => col.key === columnKey);
  //   if (columnIndex === -1) return;

  //   const header = this.tableTarget.querySelectorAll("th")[columnIndex];
  //   const rows = this.tableBodyTarget.querySelectorAll("tr");

  //   // Toggle visibility for headers and table rows based on checkbox state
  //   header.style.display = isVisible ? "" : "none";
  //   rows.forEach(row => {
  //     const cell = row.cells[columnIndex];
  //     if (cell) {
  //       cell.style.display = isVisible ? "" : "none";
  //     }
  //   });

  //   // Update column visibility state
  //   this.columns[columnIndex].visible = isVisible;

  //   // Store updated visibility preferences
  //   this.storeColumnPreferences();
  // }

    // // Update column visibility when user changes the checkbox selection
  updateColumns(event) {

    console.log("updaateColumn fired!");


    const checkbox = event.target;
    const columnKey = checkbox.dataset.columnKey;
    const isVisible = checkbox.checked;

    console.log("columnKey: ", columnKey);
    console.log("isVisible: ", isVisible);
  
    // // Find the column index by its key
    // const columnIndex = this.columns.findIndex((col) => col.key === columnKey);
    // if (columnIndex === -1) return;
  
    const header = this.tableTarget.querySelector(`th[data-key='${columnKey}']`);
    const column_cells = this.tableBodyTarget.querySelectorAll(`td[data-key='${columnKey}']`);

    console.log("header: ", header);
    console.log("column_cells.length: ", column_cells.length);
 
    // Toggle column header cell & corresponding column cells visibility based on checkbox state
    header.toggleAttribute('data-hidden', !isVisible);
    column_cells.forEach(cell => {
        // cell.style.display = isVisible ? "" : "none"; // Toggle cell visibility
        // cell.classList.toggle('expenses__table-cell--hidden', !isVisible)
        cell.toggleAttribute('data-hidden', !isVisible);
    });
  
  
    // Store updated visibility preferences
    this.storeColumnPreferences();
  }





  
 // Store user’s column preferences in localStorage
 storeColumnPreferences() {
  localStorage.setItem("expensesColumnPreferences", JSON.stringify(this.visibleColumnsKeys()));
}

visibleColumns(){
  return this.tableTarget.querySelectorAll('th:not([data-hidden])');
}

visibleColumnsKeys(){
  return Array.from(this.visibleColumns()).map((visibleCol) => visibleCol.dataset?.key );
}


// restoreColumnPreferences() {
//   const storedPreferences = JSON.parse(localStorage.getItem("expensesColumnPreferences"));

//   if (storedPreferences) {
//     // Apply stored visibility preferences
//     this.columns.forEach((column) => {
//       column.visible = storedPreferences.includes(column.key);
//     });
//     this.updateTableVisibility(); // Ensure table reflects new visibility
//     // this.initializeColumnCheckboxes(); // Ensure checkboxes reflect new state
//   }
// }



// // Apply visibility to the entire table based on current column states
// updateTableVisibility() {
//   const headers = this.tableTarget.querySelectorAll("th");
//   const rows = this.tableBodyTarget.querySelectorAll("tr");

//   this.columns.forEach((column, index) => {
//     const isVisible = column.visible;
//     const header = headers[index];
//     const cells = Array.from(rows).map(row => row.cells[index]);

//     // Toggle visibility of headers and table cells
//     header.style.display = isVisible ? "" : "none";
//     cells.forEach(cell => {
//       cell.style.display = isVisible ? "" : "none";
//     });

//     // Update checkboxes to reflect current visibility
//     const checkbox = this.columnSelectTarget.querySelector(`input[data-column-key="${column.key}"]`);
//     if (checkbox) {
//       checkbox.checked = isVisible;
//     }
//   });
// }



  // ----------------------------

  // Live search filter
  search(event) {
    const query = event.target.value.toLowerCase();
    this.tableBodyTarget.querySelectorAll("tr").forEach(row => {
      const matches = [...row.querySelectorAll("td")].some(cell =>
        cell.innerText.toLowerCase().includes(query)
      );
      row.style.display = matches ? "" : "none";
    });
  }

  // Sort the table rows based on selected column
  sort(event) {
    const sortKey = event.target.value;
    const rows = [...this.tableBodyTarget.querySelectorAll("tr")];
  
    rows.sort((a, b) => {
      const aText = a.querySelector(`td[data-key="${sortKey}"]`).innerText; // Corrected query
      const bText = b.querySelector(`td[data-key="${sortKey}"]`).innerText; // Corrected query
  
      return aText.localeCompare(bText, undefined, { numeric: true });
    });
  
    rows.forEach(row => this.tableBodyTarget.appendChild(row)); // Re-append sorted rows
  }



  // // Toggle visible columns
  // updateColumns() {
  //   const selectedColumns = Array.from(this.columnSelectTarget.selectedOptions).map(option => option.value);
    
  //   this.tableTarget.querySelectorAll("th, td").forEach(cell => {
  //     const key = cell.dataset.key;
  //     if (key && selectedColumns.includes(key)) {
  //       cell.style.display = "";
  //     } else if (key) {
  //       cell.style.display = "none";
  //     }
  //   });
  // }

  // Toggle between table and cards view
  showTableView() {
    this.tableTarget.style.display = "";
    this.cardsTarget.style.display = "none";
  }

  showCardsView() {
    this.cardsTarget.style.display = "none";
    this.cardsTarget.style.display = "flex"; // Use flex for card layout
  }
}
