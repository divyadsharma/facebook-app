# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require jquery_ujs
#= require jquery.validate.min

$(document).ready ->
  init: ->
    @doValidate()
  doValidate: ->
      $('#new_user').validate
        errorElement: 'span'
        errorClass:'help-block errorSpan'
        rules:
          'user[username]':
            required: true
            maxlength: 8
          'user[email]':
            required: true
          'user[password]':
            required: true
          'user[password_confirmation]':
            required: true
        messages:
          'user[username]':
            required: "Ad Name can't be blank"
            maxlength: 'Length should not be greater than 40 characters'
          'user[email]':
            required: 'Select Ad type'
          'user[password]':
            required: 'Select Ad type'
          'user[password_confirmation]':
            required: 'Select Ad type'


