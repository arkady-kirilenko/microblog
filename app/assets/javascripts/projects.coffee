
projectFromForm = (form)->
  project =
    title:        form[2]['value']
    description:  form[5]['value']

previewProject = (project)->
  project_html  = '<section class="project-page project-preview ">'
  project_html += '<div class="project-container">'
  project_html += '<h2>Project Preview: </h2><hr>'
  project_html += '<h1 class="project-title">' + project.title + '</h1>'
  project_html += '<div class="project-text">' + project.description + '</div>'
  project_html += '</div></section>'

$(document).ready ->

  #Adds the project preview to the end of the page
  $("#project-preview").click ->
    $('.project-preview').remove()
    console.log $('form').serializeArray()
    project = projectFromForm $('form').serializeArray()
    $(previewProject(project)).insertAfter(".project-form-page")

  #Adds a semi-transparent mask over a project when hovered
  $(".project-thumb").hover ->
    # Hover In
    $(this).children(".hover").fadeIn "fast"
    $(this).children("a").fadeIn "fast"
  , ->
    # Hover Out
    $(this).children(".hover").fadeOut "fast"
    $(this).children("a").fadeOut "fast"
