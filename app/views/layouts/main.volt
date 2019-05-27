<div class="animsition">
	<!-- <button class="btn ficha-btn trigger" data-dialog="somedialog" style="position: fixed; z-index: 9999;" >test modal</button> -->

<?php   
$auth = $this->session->get('auth');
if (!$auth) { 
?>
<!--  <nav class="navbar navbar-default navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Ficha</a>
        </div>
        {{ elements.getMenus() }}
    </div>
</nav> 
 -->
 {{ content() }}
<?php  
}else {
?>
    <!-- Navigation -->
    <nav class="navbar" role="navigation">
    	<div class="ficha_mobile_nav_header">
	    	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-ex1-collapse" aria-expanded"false"><i class="glyphicon glyphicon-align-center"></i>
	        </button>
	        <div class="ficha_nav_header_title">
	        	<a href="<?=$this->url->get('dashboard/index');?>">
	        		<img src="<?=$this->url->get('images/logo_fa.png');?>">
	        	</a>
	        </div>
    	</div>

         {{ elements.getMenu(t) }}
    
        <!-- /.navbar-collapse -->
    </nav>

	<div class="main-right-wrapper">
	    <div id="wrapper">
	        {{ flash.output() }}
	        {{ content() }}
	    </div> 
	</div>

<?php 
} 
?>


</div>

	<!-- App Ajax modal -->
	<?php
	/*
	<div class="modal fade" id="app-ajax-modal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog mini-modal" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h3 class="app-ajax-modal-title text-center">Modal title</h3>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-dynamic-content">
	        <!-- Loader Here -->
	        
	      </div>
	    </div>
	    <div class="clearfix"></div>
	  </div>
	</div>
	
	<!-- 
	<div id="somedialog" class="dialog">
		<div class="dialog__overlay"></div>
		<div class="dialog__content">
			<h2><strong>Howdy2</strong>, I'm a dialog box</h2><div><button class="action" data-dialog-close>Close</button></div>
		</div>
	</div> 
	-->
	<script type="text/javascript">
		// var dlgtrigger = document.querySelector( '[data-dialog]' ),
		// somedialog = document.getElementById(app-ajax-modal),
		// dlg = new DialogFx( somedialog );
	</script>
	*/
	?>

	<div id="app-ajax-modal" class="dialog">
		<div class="dialog__overlay"></div>
		<div class="dialog__content">
			<button type="button" class="close" aria-label="Close" data-dialog-close>
			  <span aria-hidden="true">&times;</span>
			</button>
			 <h3 class="app-ajax-modal-title text-center text-capitalize">Modal Title</h3>
			<div class="modal-dynamic-content">
				<!-- Loader Here -->
			</div>
		</div>
	</div>