$ ->
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
    custom_elements: "resource_embed"
    extended_valid_elements: "resource_embed"
  })

