
{{ stylesheet_link('css/sweetalert.css') }}
{{ javascript_include('js/sweetalert-dev.js') }}
<script type="text/javascript" src="https://unpkg.com/sweetalert2"></script>
<script type="text/javascript" src="https://unpkg.com/promise-polyfill"></script>
<style type="text/css">
    .validation {
        color: red;
        margin-bottom: 20px;
    }
</style>



<div class="col-sm-12 col-md-12 login-page">
    <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-4 get-strated-wrapper">
            <div class="login-get-started">
                <div class="col-md-6"><p><a class="label-create-acc"><?=$t->_('dont_have_account');?></a></p></div>
                 <div class="col-md-4"><a href="{{url('session/register')}}"><button type="submit" class="btn ficha-btn"><?=$t->_('get_started');?></button></a></div>
            </div>
        
        </div>

    	<div class="col-xs-12 col-sm-4 col-md-4 login-from-wrapper" id="login_form_anchor_target_mobile">
    		<div class="login-from-wrapper-in">
    			<div class="logo-wapper">
                    <div class="row">
                        <img src="{{url('images/ficha_new_logo.png')}}">
                    </div>
    			</div>
                <div class="forms-area">
                    <?php if($reset_password) { 
                        if($msg){
                            echo '<p class="error-msg text-center">'.$msg.'</p>';
                        } else {
                            ?>
                            <div class="page-header">
                                <h2><?=$t->_('reset_pwd_ficha');?></h2>
                                <span><?=$t->_('new_pwd_details_below');?></span>
                            </div>
                            <form action="{{url('register/reset_password')}}" id="reset-password-form" method="POST">
                                <?php if($tokens_arr) {
                                        foreach ($tokens_arr as $key => $value) {
                                            printf('<input type="hidden" name="%s" value="%s">', $key, $value);
                                        }
                                } ?>
                                <div class="col-md-12">
                                <div class="form-group forgot-icon-wrapper">
                                    <input type="password" maxlength="51" id="reset-password" name="reset_password" class="form-control" placeholder="<?=$t->_('new_pwd');?>" data-rule-required="true">
                                    <i class="material-icons">lock</i>
                                </div>
                                <div class="form-group forgot-icon-wrapper">
                                    <input type="password" maxlength="51" id="confirm-reset-password" name="confirm_reset_password" class="form-control" placeholder="<?=$t->_('confirm_new_pwd');?>" data-rule-required="true" data-rule-equalTo="#reset-password">
                                    <i class="material-icons">lock</i>
                                </div>
                                <div class="form-group form-reset-password-action text-right">
                                    <button type="submit" class="btn ficha-btn"><?=$t->_('create_new_password');?></button>
                                </div>
                                </div>
                            </form> <?php
                        }
                    } else { ?>
                        <div class="page-header">
                            <h2><?=$t->_('sign_into_ficha');?></h2>
                            <span><?=$t->_('access_details_below');?></span>
                        </div>
                        {{ form('session/start', 'role': 'form','id':"log-in-form") }}
                            <fieldset>
                                <?php if($redirect){  ?>
                                    <input type="hidden" name="redirect" value="<?=$redirect;?>">
                                <?php } ?>
                                <div class="form-group icon-wrapper">
                                    <input type="text" maxlength="51" id="email" name="email" class="form-control" placeholder="<?=$t->_('email');?>" data-rule-required="true" data-rule-email="true">
                                    <i class="material-icons">mail_outline</i>
                                </div>
                                <div class="form-group icon-wrapper">
                                    <input type="password" maxlength="51" id="login-password" name="password" class="form-control" placeholder="<?=$t->_('password');?>" data-rule-required="true">
                                    <i class="material-icons">lock</i>
                                </div>
                                <div class="form-group form-action-wrapper">
                                    <div class="row ">
                                        <div class="col-md-7 forgot-text">
                                            <a href="{{url('session/forgot')}}" class="login-forgot-password"><?=$t->_('forgot_password');?></a>
                                        </div>
                                        <div class="col-md-5 text-right">
                                            <button type="submit" class="btn ficha-btn"><?=$t->_('sign_in');?><i class="material-icons">arrow_forward</i></button>
                                        </div>
                                    </div>
                                </div>
                                  
                            </fieldset>
                        </form> <?php
                    }  ?>
                </div>

                <!-- DUMMY -->
                <div id="errormsg" class="hide">
                    
                </div>
            </div>
            <div class="row web-name visible-lg visible-md ">
              <span class="text-login-footer"><?=$t->_('ficha_footer_subtitle');?></span>
             </div>
             <div class="col-xs-12 col-sm-12 col-md-12 ficha-login-footer visible-sm visible-xs">
        <div class="row ficha-login-footer-wrapper">
            <div class="col-md-6">
                <span class="text-login-footer"><?=$t->_('ficha_footer_subtitle');?></span>
            </div>
            <div class="col-md-6 social-footer">
                <ul>
                    <li><a href="#"><img src="/images/twitter-icon1.png"></a></li>
                    <li><a href="#"><img src="/images/in-icon2.png"></a></li>
                    <li><a href="#"><img src="/images/facebook-icon3.png"></a></li>
                </ul>
            </div>
        </div>
    </div>
    	</div>

         <div class="col-xs-12 col-sm-8 col-md-8 background-image-wrapper">
            <div class="row">
            </div>
                  <div class="row social-footer col-md-12 visible-lg visible-md ">
                    <ul>
                        <li><a target="_blank" href="#"><img src="/images/twitter-icon1.png"></a></li>
                        <li><a target="_blank" href="#"><img src="/images/in-icon2.png"></a></li>
                        <li><a target="_blank" href="#"><img src="/images/facebook-icon3.png"></a></li>
                    </ul>
                </div>
         
        </div>

    
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() { 
        $("input[name='name']").on('focusout', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                document.getElementById("fname_error").innerHTML = "Special Character are not allowed";
                $("input[name='name']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            document.getElementById("fname_error").innerHTML = "";
            $("input[name='name']").removeClass('error-input');
        });

        $("input[name='lastname']").on('focusout', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                document.getElementById("lname_error").innerHTML = "Special Character are not allowed";
                $("input[name='lastname']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            document.getElementById("lname_error").innerHTML = "";
            $("input[name='lastname']").removeClass('error-input');
        });

        jQuery.extend(jQuery.validator.messages, {
            maxlength: jQuery.validator.format("Please enter only {0} characters."),
            minlength: jQuery.validator.format("Please enter minimum {0} characters."),
        });

        <?php
            if($this->dispatcher->getParam('activeid')) {
                if(!empty($this->dispatcher->getParam('activeid')) && (strtotime($expiry_date) > strtotime(date('Y-m-d H:i:s')))) { ?>
                    swal("Activated successfully!", 'Welcome! please login', "success"); <?php 
                } else { ?>
                    swal("Link expired!", 'Sorry! please register again', "error"); <?php
                }
            }
        ?>
        var _Loader={container: '#nav-tabContent'};
        <?php
            if($reset_password) {
                ?>
                $("#reset-password-form").fichaForm({
                    showLoader:_Loader,
                    onSuccess: function (result) {
                        if(result.status){
                            var logo="<?php echo $this->url->get('../images/logo_fa.png');?>";
                            console.log(logo);
                            swal({
                                title: '<img class="sweet-logo-img" src="'+logo+'"><h3 class="sweet-head">Awesome! Thank you for using Ficha.<h3>',
                                // width: 900,
                                // // height: 900,
                                // padding: '10em',
                                background: '#7338bb',
                                html:
                                  '<span>Thank you for reset password link.</span>, ' +
                                  '<p>Hi, we are excited you joined us. Please try to login to your account with your new credentials. See you there!</p> ' +
                                  '<ul class="sweet-social"><li><img src="/images/twitter-icon.png" alt=""></li><li><img src="/images/in-icon.png" alt=""></li><li><img src="/images/facebook-icon.png" alt=""></li></ul>',
                                showCloseButton: true,
                                showCancelButton: true,
                                focusConfirm: false,
                                showConfirmButton: false,
                                showCancelButton: false,
                            });
                        }
                    }
                });
                <?php
            }
            else {
                ?>
                $("#log-in-form").fichaForm({
                    validatorsmethod:{
                        'validator1':$.validator.addMethod("emailvali", function(value, element) { return this.optional(element) || /\b[a-zA-Z0-9\u00C0-\u017F._%+-]+@[a-zA-Z0-9\u00C0-\u017F.-]+\.[a-zA-Z]{2,}\b/.test(value); }, "Not a valid email"),
                        // 'validator2':$.validator.addMethod("password1", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, " Password must contain at least one upper & lower case characters one digit & special character."),
                    },
                    validaterules:{
                        email: { emailvali: true , required: true,maxlength:50, minlength:3},
                        //password: { password1: true , required: true,maxlength:50, minlength: 8},
                        password: {required: true,maxlength:50, minlength: 8},
                    },
                    validatemessage:{
                        email: {required: "Please enter email address"},
                        password: {required: "Please enter password"},
                    },
                    onSuccess: function (result) {

                        //to remove custom color of password inbox
                        $('#login-password').css('border','solid 1px #dfe7e9');
                    
                        if(result.status){
                            window.location=result.redirect;
                        }
                    }
                });
                <?php
            }
        ?>

        $('a.scroll_to_form').click(function(){
            var $target = $('html,body'); $target.animate({scrollTop: $target.height()}, 500);
            return false;
        });
    });
  
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var _area_controll=$(this).attr("aria-controls");
		var _href=$(this).attr("href");
		var _default=$("#preset-log-in-nav");
		var reset_pw=$("#reset-pw-log-in-nav");
		console.log(_area_controll);
		if(_area_controll=="nav-forgot-password"){
			_default.hide();
			reset_pw.show();
		}else{
			_default.show();
			reset_pw.hide();
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
            $(_href).fichaAnimate('fadeIn');
		}
	});
</script>
