tinymce_active = false

htmlEncode = (str) ->
  str.replace /[&<>"']/g, ($0) ->
    "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";"



$ ->

  insert_embed_from_response = (file, response) ->
    $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, '<p><a class="media_replace" href="' + response.id + '">' + file + '</a></p>')

  insert_embed_from_link = (url) ->
    (response) ->
      $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, '<p><a class="media_replace" href="' + response.id + '">' + url + '</a></p>')
      

  check_file = (file, extension) ->
    return true
  if $("#insert_file").length > 0
    upload_object = new AjaxUpload('insert_file', {
      action: $("#link_to_embed_in_document").attr("href"),
      name: "resource[file]",
      data: { "resource[file_type]": "upload", format:"json" },
      autoSubmit: true,
      responseType: "json",
      onSubmit: check_file,
      onComplete: insert_embed_from_response
    })

  $("#insert_code_form").dialog({
    autoOpen: false,
    width: 600,
    modal: true,
    resizable: false
  })
  
  $("#insert_link_form").dialog({
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
    if content
      $("#tinymce_area").tinymce().execCommand('mceInsertContent', false, "<pre>" + htmlEncode(content) + "</pre><p></p>")
      $("#insert_code_form").find("textarea").val("")

  $("#insert_link").click ->
    $("#insert_link_form").dialog("open")
    $("#insert_link_form").find("input").val("")

  $("#insert_link_form").find("button").click ->
    $("#insert_link_form").dialog("close")
    url = $("#insert_link_form").find("input").val()
    if url
      $.post( $("#link_to_embed_in_document").attr("href"),
        data = { 
          "resource[file_type]": "link",
          "resource[url]":url,
          "format":"json"
        },
        success = insert_embed_from_link(url)
      )

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
    plugins : "autolink,lists,layer,table,save,advlink,inlinepopups,preview,media,searchreplace,contextmenu,paste,noneditable,template",
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
