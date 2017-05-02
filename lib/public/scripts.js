/* global $, Ladda, swal */

var $imageInput = $('#image_input');
var $emailInput = $('#email_input');
var $submitInput = $('button[type="submit"]');
var $laddaSubmit = Ladda.create(document.querySelector('button[type="submit"]'));
var $imageDisplay = $('#image_display');

var base64 = '';

function displayAndConvert(input) {
  if (!filePresent()) {
    return;
  }

  var reader = new FileReader();
  reader.onload = function(e) {
    $imageDisplay.attr('src', e.target.result);
  };
  reader.onloadend = function() {
    base64 = reader.result;
  };

  reader.readAsDataURL(input.files[0]);
}

function filePresent() {
  return $imageInput[0].files && $imageInput[0].files[0];
}

function emailPresent() {
  return $emailInput.val() != null && $emailInput.val() != '';
}

function enableSubmit() {
  $submitInput.prop('disabled', !(filePresent() && emailPresent()));
}

$imageInput.change(function() {
  displayAndConvert(this);
  enableSubmit();
});

$emailInput.keyup(function() {
  enableSubmit();
});

$('form').submit(function(e) {
  e.preventDefault();
  $laddaSubmit.start();

  $.post({ url: '/login', data: { email: $emailInput.val(), image: base64 }})
    .done(function() {
      swal('Bienvenido', 'Sesión iniciada con éxito', 'success');
    })
    .fail(function() {
      swal('Error', 'Credenciales incorrectas', 'error');
    })
    .always(function() {
      $laddaSubmit.stop();
    });
});
