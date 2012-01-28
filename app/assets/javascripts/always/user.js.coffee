# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> $("#new_user").validate(
  rules: {
    "user[password]": { minlength: 6 },
    "user[password_confirmation]": { equalTo: "#user_password" },
    "recaptcha_response_field": "required" 
  },

  messages: {
    "user[password]": { minlength: "Password must be at least 8 characters long." },
    "user[password_confirmation]": { equalTo: "Please enter the same password again." },
    "recaptcha_response_field": { required: "Please type the text in the image." }
  }
)
