<div class="applicationheadtab" style="background: #fff;">
  <div class="app-header row plain-color">
      <div class="col-xs-12 col-sm-6 col-md-6">
      	<div class="display-flex-wrapp">
	      	<div class="app-logo-wrapp">
	      	<?php 
	      	$inviteid = $this->dispatcher->getParam('inviteid');
	      	$iconurl=!empty($inviteid)? '/'.$app_res->thumbnail : '../'.$app_res->thumbnail;
	      	
	      	?>
	      		<img class="app-logo" src="<?php echo $iconurl; ?>">
	      	</div>
	      	<div class="app-title-wrapp">
	      		<h4 class="app-title"><?=ucfirst($app_res->app_title);?></h4>
	        	<h5 class="app-desc"><?=$t->_("app_subtitle"); ?></h5>
	      	</div>
      	</div>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-6 main-app-point">
        	<!-- <div class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">  -->
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="down-arrow-img"></span>
                            <span class="user-name"><span class="user-name"><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname[0]).".";?></span></span>
                            <span class="user-img-wrapp"><img class="profile-icon" src="<?=$this->url->get('images/82092abcffa42dae1d948bb7bed4bb01139322c4.png');?>" /></span>
                            <!-- <span class="glyphicon glyphicon-user"></span>  -->
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <div class="navbar-login">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <p class="text-center">
                                                <img class="profilepi" src="<?=$this->url->get('images/82092abcffa42dae1d948bb7bed4bb01139322c4.png');?>" />
                                                <!-- <span class="glyphicon glyphicon-user icon-size"></span> -->
                                            </p>
                                        </div>
                                        <div class="col-lg-8">
                                            <p class="text-left"><strong><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname);?></strong></p>
                                            <p class="text-left small"><?=$loggedInUser->email;?></p>
                                            <p class="text-left">
                                                <a href="<?=$this->url->get('account/index');?>" class="btn btn-primary btn-block btn-sm"><?=$t->_("update_profile"); ?></a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="navbar-login navbar-login-session">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p>
                                                <a href="<?=$this->url->get('session/end');?>" class="btn btn-danger btn-block"><?=$t->_("log_out"); ?></a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
  	  </div>
  </div>
</div>

<div class="content-wrapp" style="padding: 30px;">
	<form id="connectNewAppForm" class="form-horizontal connect_new_app_modal_form" action="#" method="post">
		<div class="form-group">
		  <label for="applicationname"><?= $t->_("API Key");?>:</label>
		  <input type="text" required class="form-control" data-rule-required="true" id="apikey" placeholder="" name="apikey" value="<?php echo $apiKey; ?>" readonly>
		</div>
		<div class="terms_and_submmit_wrapp">
			<div class="submmit_btn_wrapp">		
				<span style="display: block; margin-bottom: 10px;">Warning: Mobile Apps using old api key will stop reporting data immediately after changing to New API key</span>
				<button type="submit" class="btn ficha-btn" name="changeApiKeyButton"><?= $t->_("Change API Key");?></button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function(){
	
		$("form").submit(function(e){
			e.preventDefault();
			if (confirm("Warning: Mobile Apps using old api key will stop reporting data immediately after changing to New API key") ) {
				var key = '<?php echo md5(uniqid(rand(), true)); ?>';
				console.log(key);

				$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/update_api_keys'); ?>',	
					data: {
						api_key: key,
						app_id: '<?php echo $app_id; ?>'
					},
					dataType: 'json',
					success: function (response) {
						console.log(response);
					}				
				});
			}
			else {
				console.log('cancel');
			}
			console.log('form submit');
		});
	});
	

</script>