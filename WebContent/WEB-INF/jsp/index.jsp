<html>
<head>
    <title>CKEditor Classic Editing Sample</title> 

    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js" type="text/javascript"></script> 

    <script src="https://cdn.ckeditor.com/4.6.0-441b33b/full-all/ckeditor/ckeditor.js"></script>     

    <style type="text/css">
    /* Minimal styling to center the editor in this sample */
    body {
        padding: 30px;
        display: flex;
        align-items: center;
        text-align: center;
    }
    p{
    text-align:right; 
    }

    .container {
        margin: 0 auto;
    }
    </style>
</head>
<body>

    <div class="container">   
          <form method="post">
            <h2><label for="editor1">WeekReport</label></h2>  
            <p><a href="javascript:void(0);" onclick="ManualSave();" >Save</a></p>             
<!--         <a href="javascript:void(0);" onclick="Export();" >Export</a></p> -->
            <textarea name="editor1" id="editor1"> </textarea>      
          </form> 
    </div>
</body>

<script>    


$(document).ready(function () {  
    var editor=initeditor();
    var  initcontent= window.sessionStorage.getItem("comment_top");     
    initdata(editor,initcontent);
    // save on editing
    editor.on('change', function(evt) {  
        window.sessionStorage.setItem("comment_top", evt.editor.getData()); 
    });
});

function initeditor(){
      var editor=  CKEDITOR.replace( 'editor1' , {
          toolbar: [
                    { name: 'clipboard', items: [ 'Undo', 'Redo' ] },
                    { name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
                    { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
                    { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
                    { name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
                    { name: 'links', items: [ 'Link', 'Unlink' ] },
                    { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
                    { name: 'insert', items: [ 'Image', 'Table' ] },
                    { name: 'tools', items: [ 'Maximize' ] },
                    { name: 'editing', items: [ 'Scayt' ] }
                ],

        height: 800 ,  
        contentsCss: [ 'https://cdn.ckeditor.com/4.6.0-441b33b/full-all/ckeditor/contents.css', 'mystyles.css' ] ,  
        allowedContent : true ,
        disallowedContent: 'img{width,height,float}'   ,                  
        extraAllowedContent: 'img[width,height,align]' ,                  
        extraPlugins: 'tableresize,uploadimage,uploadfile' , 
          bodyClass: 'document-editor' ,               
        format_tags: 'p;h1;h2;h3;pre' ,               
        removeDialogTabs: 'image:advanced;link:advanced'  
      });
      return editor;
};

function initdata(editor,initcontent){  
    
    var aj =$.ajax({
            type : "POST",
            url : "initdata",
            async: false,
            dataType : "json",         
            success : function(data) {
                if (data == null) {
                    alert("No Init Text Found");
                } else if (!initcontent && typeof initcontent != "undefined" && initcontent != 0) {
                    editor.setData(data.scontent); 
                }else{
                    editor.setData(initcontent); 
                }
            }
    });
};

 function ManualSave(){    
            var aj = $.ajax( {    
                url:'save',                  
                type:'POST',       
                dataType:'json',    
                contentType: 'application/json;chartset=UTF-8',             
                data:JSON.stringify(window.sessionStorage.getItem("comment_top")),         
                success:function(data) {    
                    if(data.state){       
                        alert("Save Successfully");    
                        window.sessionStorage.removeItem("comment_top");
                        window.location.reload();   
                    }else{    
                        alert("Save failour！");    
                    }    
                 },    
                 error : function() {      
                      alert("Network Error！");    
                 }    
    });  
};   
</script>

</html>
