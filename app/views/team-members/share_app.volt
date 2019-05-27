<div class="connect_new_app_modal_wrap">
	<div class="image_wrapp">
		<img src="<?=$this->url->get('images/ficha/team-member-popup.png');?>">	
	</div>
	<div class="content-wrapp">
		<span class="title-text"><?= $t->_("share_application");?></span>	
		<span class="normal-text"><?= $t->_("share_application_para");?><?php echo ": ".$app_title;?></span>
		<form id="sendemail" class="form-horizontal connect_new_app_modal_form" method="post" action="/team-members/sendemail">
			<div class="form-group hide">
				<input type="text" class="form-control" data-rule-required="true" value="<?php echo $app_id; ?>" id="app_id" name="app_id" required maxlenght="50">
			</div>
			<div class="form-group">
				<label for="sharename"><?= $t->_("Full name");?>:</label>
				<input type="text" class="form-control" data-rule-required="true" id="sharename" placeholder="<?= $t->_("share_name");?>" name="sharename" required maxlenght="50">
			</div>
			<div class="form-group">
				<label for="shareemail"><?= $t->_("Email address");?>:</label>
				<input type="text" class="form-control" data-rule-required="true" id="shareemail" placeholder="<?= $t->_("share_user_email");?>" name="shareemail" required maxlenght="50">
			</div>
			<div class="form-group">
				<label for="permissions"><?= $t->_("Permissions");?>:</label>
				<label class="checkbox-inline permission-box-check box-check container-check"><?= $t->_("application_settings");?>
					<input type="checkbox" value="application_settings" name="permissionsChecked[]">
					<span class="checkmark"></span>
				</label>
				<label class="checkbox-inline permission-box-check box-check container-check" ><?= $t->_("integration_key");?>
					<input type="checkbox" value="integration_key" name="permissionsChecked[]">
					<span class="checkmark"></span>
				</label>
				<label class="checkbox-inline permission-box-check box-check container-check" ><?= $t->_("generate_export_reports");?>
					<input type="checkbox" value="generate_and_export_reports" name="permissionsChecked[]">
					<span class="checkmark"></span>
				</label>
			</div>
			<div class="terms_and_submmit_wrapp">
				<div class="submmit_btn_wrapp">
					<input type="submit" class="btn ficha-btn" name="shareAppSubmitButton" value="<?= $t->_("send_invitation");?>" id="shareAppSubmitButton"/>
				</div>
			</div>
		</form>
	</div>
</div>

<script type='text/javascript'>
	$(document).ready(function() { 
		var _Loader={container: '.tab-content-settings',css:"background:rgba(0, 0, 0, 0.14);box-shadow: 0 0 120px rgba(39, 39, 39, 0.22);"};
		
		$("#sendemail").fichaForm({
            validatorsmethod:{
                'validator1': $.validator.addMethod("fandlname", function(value, element) { return this.optional(element) || /^[ A-Za-z./()!]+$/.test(value); }, "Letters only please"), 
                'validator2': $.validator.addMethod("emailvali", function(value, element) { return this.optional(element) || /\b[a-zA-Z0-9\u00C0-\u017F._%+-]+@[a-zA-Z0-9\u00C0-\u017F.-]+\.[a-zA-Z]{2,}\b/.test(value); }, "Not a valid email"),
            },
            validaterules:{
                sharename:  { fandlname: true,      required: true,    maxlength:20,    minlength:3},
                shareemail: { emailvali: true,      required: true,    maxlength:50,    minlength:3}, 
            },
            validatemessage: {
                sharename:  { required: "Please enter first name" },
                shareemail: { required: "Please enter email address" },
            },
            showLoader:_Loader,
            onSuccess: function (result) {
            	closeAjaxDialog('Modal closure');
                $().toastmessage('showToast', {
                    text     : result,
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
                window.location=result.redirect;
            },
            onError: function (result) {
				closeAjaxDialog('Modal closure');
                $().toastmessage('showToast', {
                    text     : result,
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
                setTimeout(function(){ window.location="<?php echo $this->url->get('team-members/index');?>"; }, 3000);
            }
        });
		
		// $("#shareAppSubmitButton").click(function(e){
		// 	var str = $( "form" ).serialize();
		// 	e.preventDefault();
		// 	var permissionsChecked = [];
  //           $.each($("input[name='permission_list']:checked"), function(){            
  //               permissionsChecked.push($(this).val());
  //           });
  //           var app_id = $("#app_id").val();
  //           var sharename = $("#sharename").val();
  //           var shareemail = $("#shareemail").val();
		// 	$.ajax({
		// 		type : "POST",
		// 		crossDomain: false,
		// 		url : "<?php //echo $this->url->get('team-members/sendemail');?>",
		// 		data: {
		// 			// formdata:str // as you are getting in php $_POST['action1'] 
		// 			shareemail:shareemail,
		// 			sharename: sharename,
		// 			app_id: app_id,
		// 			permissionsChecked: permissionsChecked
		// 		},
		// 		dataType : "json",
		// 		showLoader:_Loader,
		// 		success: function(result){
		// 			closeAjaxDialog('Please choose custom option');
		// 			$().toastmessage('showToast', {
		// 			text     : result,
		// 			sticky   : false,
		// 			position : 'bottom-right',
		// 			type     : 'success',
		// 			closeText: ''
		// 			});
		// 			// window.location=result.redirect;
		// 		}
  //       	});
  //       	return false;
		// });
	});
</script>