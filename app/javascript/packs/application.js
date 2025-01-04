// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Import jQuery and Popper.js before Bootstrap
require('jquery')
import 'popper.js';
import 'bootstrap';

// Import custom stylesheets
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Make jQuery and Popper.js available globally
window.$ = window.jQuery = require('jquery');

document.addEventListener("turbolinks:load", function() {
  const addFieldsButton = document.getElementById('add-incident-fields');
  const incidentFieldsContainer = document.getElementById('incident-fields-container');

  if (addFieldsButton && incidentFieldsContainer) {
    addFieldsButton.addEventListener('click', function() {
      const newFields = incidentFieldsContainer.firstElementChild.cloneNode(true);
      incidentFieldsContainer.appendChild(newFields);
    });
  }

  incidentFieldsContainer.addEventListener('click', function(event) {
    if (event.target.classList.contains('remove-incident-fields')) {
      const fields = incidentFieldsContainer.getElementsByClassName('incident-fields');
      if (fields.length > 1) {
        event.target.closest('.incident-fields').remove();
      } else {
        alert('最低一つの事故事例を残してください。'); 
      }
    }
  });
});
