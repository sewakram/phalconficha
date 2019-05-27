
<div class="connect_new_app_modal_wrap">
	<div class="image_wrapp">
		<img src="<?=$this->url->get('images/connect_a_new_application_popup_img.png');?>">	
	</div>

	<div class="content-wrapp">
		<span class="title-text"><?= $t->_("connect_a_new_application");?></span>	
		<span class="normal-text"><?= $t->_("add_application_para");?></span>

		<form id="connectNewAppForm" class="form-horizontal connect_new_app_modal_form" action="/application/single_app_no_data" method="post">
			<div class="form-group">
			  <label for="applicationname"><?= $t->_("application_name");?>:</label>
			  <input type="text" class="form-control" data-rule-required="true" id="applicationname" placeholder="<?= $t->_("application_name_placeholder");?>" name="applicationname">
			</div>
			<div class="form-group">
			  <label for="binaryname"><?= $t->_("android_binary_name");?>:</label>
			  <input type="text" class="form-control" data-rule-required="true" id="binaryname" placeholder="<?= $t->_("android_binary_name_placeholder");?>" name="binaryname">
			</div>
			<div class="form-group">
			  <label for="apitype"><?= $t->_("api_type");?>:</label>
			  <!-- <input type="text" class="form-control" id="apitype" placeholder="Enter api type" name="apitype"> -->
			  <!-- <input class="select_input" list="apitype" name="apitype"> -->
				<select id="apitype" class="select_input" name="apitype">
				    <option value="Native Application"><?= $t->_("native_application");?></option>
				    <option value="Hybrid Application"><?= $t->_("hybrid_application");?></option>
				</select>
			</div>
			<div class="terms_and_submmit_wrapp">
				<div class="terms">
				  <label><?= $t->_("terms_first_half");?> <a href="#!" class="terms_text"><?= $t->_("terms_second_half");?></a></label>
				</div>
				<div class="submmit_btn_wrapp">
					<!-- <button type="submit" class="btn ficha-btn"><?= $t->_("create_application");?></button> -->
					<input type="submit" class="btn ficha-btn" name="connectAppSubmitButton" value="<?= $t->_("create_application");?>" />
				</div>
			</div>
		</form>
	</div>
</div>

<script type='text/javascript'>
	$(document).ready(function() { 
	  var _Loader={container: '.tab-content-settings',css:"background: rgba(0, 0, 0, 0.14);box-shadow: 0 0 120px rgba(39, 39, 39, 0.22);"};
	    $("#connectNewAppForm").fichaForm({
	        showLoader:_Loader,
	        onSuccess: function (result) {
				$().toastmessage('showToast', {
					text     : result.msg,
					sticky   : false,
					position : 'bottom-right',
					type     : 'success',
					closeText: ''
				});
	        }
	    });

	});
</script>