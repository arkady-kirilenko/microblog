# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

postFromForm = (form)->
  post =
    title: form[2]['value']
    body:  form[3]['value']

previewPost = (post)->
  post_html  = '<section class="post-container post-preview ">'
  post_html += '<h2>Post Preview: </h2><hr>'
  post_html += '<article class="post type-system-serif">'
  post_html += '<h1>' + post.title + '</h1>'
  post_html += post.body
  post_html += '</article></section>'

$(document).ready ->

  #Adds a semi-transparent mask over a project when hovered
  $("#post-preview").click ->
    $('.post-preview').remove()
    post = postFromForm $('form').serializeArray()
    $(previewPost(post)).insertAfter(".project-form-page")
