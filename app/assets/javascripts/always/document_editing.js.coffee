tinymce_active = false

htmlEncode = (str) ->
  str.replace /[&<>"']/g, ($0) ->
    "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";"



$ ->

  insert_embed_from_response = (file, response) ->
    alert(response)

  check_file = (file, extension) ->
    return true

  new AjaxUpload('insert_file', {
    action: $("#insert_file").attr("name"),
    name: "resource[file]",
    data: {
      "resource[file_type]": "upload"
    }
    autoSubmit: true,
    responseType: "json",
    onSubmit: check_file,
    onComplete: insert_embed_from_response
  }

  $("#insert_file").click ->
    $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, '<p><a class="media_replace" href="#">Link</a></p>')

  $("#insert_code_form").dialog({
    autoOpen: false,
    width: 600,
    modal: true,
    resizable: false
  })

  $("#insert_code").click ->
    $("#insert_code_form").dialog("open")
    $("#insert_code_form").find("textarea").val("")

  $("#insert_code_form").find("button").click ->
    $("#insert_code_form").dialog("close")
    content = $("#insert_code_form").find("textarea").val()
    alert(content)
    if content
      $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, "<pre>" + htmlEncode(content) + "</pre><p></p>")
      $("#insert_code_form").find("textarea").val("")


  $("#toggle_editor").toggle(
    -> $("#tinymce_area").tinymce().hide(),
    ->
      $("#tinymce_area").tinymce().show()
      $.SyntaxHighlighter.init()
  )

activate_tinymce = ->
  $('#tinymce_area').tinymce({
    script_url : '/assets/tinymce/tiny_mce.js',
    theme : "advanced",
    plugins : "autolink,lists,layer,table,save,advimage,advlink,inlinepopups,preview,media,searchreplace,contextmenu,paste,noneditable,template",
    theme_advanced_buttons1 : ",bold,italic,underline,strikethrough,sub,sup,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,outdent,indent,blockquote,|,formatselect,|,forecolor,pastetext,pasteword,|,undo,redo,|,link,unlink,|,hr,charmap",
    theme_advanced_buttons2 : "",
    theme_advanced_buttons3 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    content_css : "/assets/document_content.css",
    extended_valid_elements: "pre[class=highlight]"
  })
  tinymce_active = true

$ ->
  activate_tinymce()
