# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  #Adds a semi-transparent mask over a project when hovered
  $(".project-thumb").hover ->
    # Hover In
    $(this).children(".hover").fadeIn "fast"
    $(this).children("a").fadeIn "fast"
  , ->
    # Hover Out
    $(this).children(".hover").fadeOut "fast"
    $(this).children("a").fadeOut "fast"
