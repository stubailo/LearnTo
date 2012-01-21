$ ->
  $("#insert_code").click ->
    $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, '<pre class="highlight">Insert Code Here</pre>')
