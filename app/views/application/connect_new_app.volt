
<div class="connect_new_app_modal_wrap">
	<div class="image_wrapp">
		<img src="<?=$this->url->get('images/ficha/application-popup.png');?>">	
	</div>

	<div class="content-wrapp">
		<span class="title-text"><?= $t->_("connect_application");?></span>	
		<span class="normal-text"><?= $t->_("add_application_para");?></span>

		<form id="connectNewAppForm" class="form-horizontal connect_new_app_modal_form" action="/application/single_app_no_data" method="post">
			<div class="form-group">
			  <label for="applicationname"><?= $t->_("application_name");?>:</label>
			  <input type="text" tab-index="1" required class="form-control" data-rule-required="true" id="applicationname" placeholder="<?= $t->_("application_name_placeholder");?>" name="applicationname" maxlength="51">
			  <div id="applicationname_error" class="error-block-msg"></div>
			</div>
			<div class="form-group">
			  <label for="binaryname"><?= $t->_("android_binary_name");?>:</label>
			  <input type="text" tab-index="2" required class="form-control" data-rule-required="true" id="binaryname" placeholder="<?= $t->_("android_binary_name_placeholder");?>" name="binaryname" maxlength="51">
			</div>
			<div class="form-group">
			  <label for="apitype"><?= $t->_("api_type");?>:</label>
			  <!-- <input type="text" class="form-control" id="apitype" placeholder="Enter api type" name="apitype"> -->
			  <!-- <input class="select_input" list="apitype" name="apitype"> -->
				<select id="apitype" class="select_input" name="apitype" tab-index="3">
					<option value="Native Application"><?= $t->_("native_application");?></option>
					<option value="Hybrid Application"><?= $t->_("hybrid_application");?></option>
				</select>
			</div>
			<div class="terms_and_submmit_wrapp">
				<div class="terms">
				  <label><?= $t->_("terms_first_half");?> <a href="#!" class="terms_text"><?= $t->_("terms_second_half");?></a></label>
				</div>
				<div class="submmit_btn_wrapp">
					
					<input type="submit" class="btn ficha-btn" name="connectAppSubmitButton" value="<?= $t->_("create_application");?>" />
				</div>
			</div>
		</form>
	</div>
</div>

<script type='text/javascript'>
	$(document).ready(function() { 	  
		$("input[name='applicationname']").on('keypress', function (event) {
			var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
			var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
			if (!regex.test(key)) {
				document.getElementById("applicationname_error").innerHTML = "Special Character are not allowed";
				$("input[name='applicationname']").addClass('error-input');
				event.preventDefault();
				return false;
			}
			document.getElementById("applicationname_error").innerHTML = "";
			$("input[name='applicationname']").removeClass('error-input');
		});

		var _Loader={container: '.tab-content-settings',css:"background: rgba(0, 0, 0, 0.14);box-shadow: 0 0 120px rgba(39, 39, 39, 0.22);"};
		
		jQuery.extend(jQuery.validator.messages, {
			maxlength: jQuery.validator.format("Please enter only {0} characters."),
		});

		// $("#connectNewAppForm").click(function (e) {
		$("input[name='connectAppSubmitButton']").click(function (e) {
            e.preventDefault();

            var applicationname = $("#applicationname").val();
            var apitype = $("#apitype option:selected").text();
            var binaryname = $("#binaryname").val();

            if ( applicationname == "")  {
            	if($('div.toast-container.toast-position-bottom-right div').length < 1){
                $().toastmessage('showToast', {
                    text     : 'Application name must be filled out',
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
            }
                $("#applicationname").focus();
                return false;
            }

            if ( apitype == "")  {
                $().toastmessage('showToast', {
                    text     : 'API type type must be filled out',
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
                $("#apitype").focus();
                return false;
            }

            if ( binaryname == "") {
            	if($('div.toast-container.toast-position-bottom-right div').length < 1){
                $().toastmessage('showToast', {
                    text     : 'Binary name must be filled out',
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
            }
                $("#binaryname").focus();
                return false;
            }

            $.ajax({
                type : "POST",
                crossDomain: false,
                url : "<?php echo $this->url->get('application/single_app_no_data');?>",
                data: {
                    applicationname : applicationname,
                    apitype 		: apitype,
                    binaryname 		: binaryname
                },
                dataType : "json",
                success: function(result){
                	closeAjaxDialog(true);
                	$().toastmessage('showToast', {
                        text     : result,
                        sticky   : false,
                        position : 'bottom-right',
                        type     : 'success',
                        closeText: ''
                    });
                    setTimeout(function(){ window.location="<?php echo $this->url->get('application/index');?>"; }, 3000);
                }
            });
		});

		// $("#connectNewAppForm").fichaForm({
		// 	showLoader:_Loader,
		// 	validatorsmethod:{
		// 		'validator1':$.validator.addMethod("appname", function(value, element) { return this.optional(element) || /^[ A-Za-z0-9./()!]+$/.test(value); }, "Special Character are not allowed")
		// 	},
		// 	validaterules:{
		// 		applicationname: { appname: true , required: true, maxlength:50},
		// 		binaryname: { appname: true , required: true, maxlength:50},
		// 	},
		// 	onSuccess: function (result) {
		// 		$().toastmessage('showToast', {
		// 			text     : result.msg,
		// 			sticky   : false,
		// 			position : 'bottom-right',
		// 			type     : 'success',
		// 			closeText: ''
		// 		});
		// 	}
		// });




       
        $('#app-ajax-modal').attr('tab-index','-1');




	});
</script>