
#Transforms a serialized form in a js object
postFromForm = (form)->
  post =
    title: form[2]['value']
    body:  form[3]['value']

#Creates the correspondent html of the post object
previewPost = (post)->
  post_html  = '<section class="post-container post-preview ">'
  post_html += '<h2>Post Preview: </h2><hr>'
  post_html += '<article class="post type-system-serif">'
  post_html += '<h1>' + post.title + '</h1>'
  post_html += post.body
  post_html += '</article></section>'

$(document).ready ->

  #Adds the post preview to the end of the page
  $("#post-preview").click ->
    $('.post-preview').remove()
    post = postFromForm $('form').serializeArray()
    $(previewPost(post)).insertAfter(".project-form-page")
