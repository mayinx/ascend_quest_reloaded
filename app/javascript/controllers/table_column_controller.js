import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table-column"
export default class extends Controller {
  static targets = ["table", "dropdown", "headerCell", "bodyCell"]

  // Default column settings
  defaultColumns = [
    { id: 'title', name: 'Title', visible: true },
    { id: 'amount', name: 'Amount', visible: true },
    { id: 'date', name: 'Date', visible: true },
    { id: 'actions', name: 'Actions', visible: true }
  ];

  connect() {
    // Load column settings from localStorage or fall back to defaults
    this.columns = JSON.parse(localStorage.getItem('tableColumns')) || this.defaultColumns;
    this.renderDropdown();
    this.applyColumnVisibility();
  }

  renderDropdown() {
    // Clear existing dropdown content
    this.dropdownTarget.innerHTML = '';

    // Create checkboxes for each column
    this.columns.forEach((column, index) => {
      const checkbox = document.createElement('input');
      checkbox.type = 'checkbox';
      checkbox.checked = column.visible;
      checkbox.dataset.index = index;
      checkbox.addEventListener('change', (event) => this.toggleColumnVisibility(event));

      const label = document.createElement('label');
      label.textContent = column.name;
      label.appendChild(checkbox);

      const li = document.createElement('li');
      li.appendChild(label);
      this.dropdownTarget.appendChild(li);
    });
  }

  applyColumnVisibility() {
    this.columns.forEach((column) => {
      const isVisible = column.visible;

      // Toggle header visibility
      this.headerCellTargets.forEach((cell) => {
        if (cell.dataset.columnId === column.id) {
          cell.classList.toggle('hidden', !isVisible);
        }
      });

      // Toggle body cell visibility for each row
      this.bodyCellTargets.forEach((cell) => {
        if (cell.dataset.columnId === column.id) {
          cell.classList.toggle('hidden', !isVisible);
        }
      });
    });
  }

  toggleColumnVisibility(event) {
    const index = event.target.dataset.index;
    this.columns[index].visible = event.target.checked;

    // Save updated column settings in localStorage
    localStorage.setItem('tableColumns', JSON.stringify(this.columns));

    // Reapply visibility
    this.applyColumnVisibility();
  }
}
