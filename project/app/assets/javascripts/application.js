//= require jquery3
//= require jquery_ujs
//= require jquery-ui
//= require popper
//= require bootstrap-sprockets
//= require toastr
//= require turbolinks
//= require_tree .

// Should put js codes in app/javascripts/packs/application.js
//const toastr = require('toastr');
//window.toastr = toastr;
toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": true,
    "progressBar": false,
    "positionClass": "toast-top-center",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

document.addEventListener('turbolinks:load', function() {
    var fileInput = document.querySelector('.custom-file-input');
    var fileLabel = document.querySelector('.custom-file-label');
    fileInput.addEventListener("change", (e) => {fileLabel.textContent = e.target.value.replace(/^.*[\\\/]/, ''); });
}, false);
