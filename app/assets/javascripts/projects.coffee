# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $(".project-thumb").hover ->
    # $(this).children().eq(1).before("<div class='hover'></div>")
    $(this).children(".hover").fadeIn "slow"
    $(this).children("a").fadeIn "slow"
  , ->
    $(this).children(".hover").fadeOut "slow"
    $(this).children("a").fadeOut "slow"
