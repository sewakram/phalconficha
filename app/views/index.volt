<!DOCTYPE html>
<?php
if(isset($body_class)){
    echo '<html class="html-login">';  
}else{
    echo '<html>';  
}
?>

    <head>
        <meta charset="utf-8">
        {{ get_title() }}
        {{ stylesheet_link('css/bootstrap.min.css') }}
        {{ stylesheet_link('css/sb-admin.css') }}
        <!-- {{ stylesheet_link('css/plugins/morris.css') }} -->
        {{ stylesheet_link('font-awesome/css/font-awesome.min.css') }}
        {{ stylesheet_link('css/animatecss/animate.css') }}
        {{ stylesheet_link('css/custom-style.css') }}
        {{ stylesheet_link('css/dialogfx/dialog.css') }}
        {{ stylesheet_link('js/select2/css/select2.min.css') }}

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animsition/4.0.2/css/animsition.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        {{ javascript_include('js/jquery.min.js') }}
        <?php
         $this->view->partial('layouts/languageJS', array('t'=>$t));
        ?>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animsition/4.0.2/js/animsition.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.js"></script>
        <script src="http://malsup.github.com/jquery.form.js"></script> 

        {{ javascript_include('js/dialogfx/modernizr.custom.js') }}
        {{ javascript_include('js/dialogfx/classie.js') }}
        {{ javascript_include('js/dialogfx/dialogFx.js') }}
        {{ javascript_include('js/common.js') }}
        {{ javascript_include('js/select2/js/select2.min.js') }}
        <!-- {{ javascript_include('js/select2/js/select2.min.js') }} -->
        {{ javascript_include('js/amcharts/amcharts/amcharts.js') }}
        {{ javascript_include('js/amcharts/amcharts/xy.js') }}
        {{ javascript_include('js/amcharts/amcharts/serial.js') }}
        {{ javascript_include('js/amcharts/amcharts/themes/light.js') }}
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta name="description" content="Ficha - Realtime App Analytics - © <?=date("Y"); ?>">
        <meta name="author" content="Ficha Team">
          
       </head>
    <?php
    if(isset($body_class)){
        echo '<body class="'.$body_class.'">';  
    }else{
        echo '<body>';  
    }
    ?>
        {{ content() }}
        {{ javascript_include('js/bootstrap.min.js') }}
        {{ javascript_include('js/utils.js') }}
        <?php
        /*
        <!--    
            {{ javascript_include('js/plugins/morris/raphael.min.js') }}
            {{ javascript_include('js/plugins/morris/morris.min.js') }}
            {{ javascript_include('js/plugins/morris/morris-data.js') }} 
        -->
        */
        ?>

    </body>
</html>
