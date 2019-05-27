{{ javascript_include('js/sweetalert-dev.js') }}
{{ stylesheet_link('css/sweetalert.css') }}
<style type="text/css">
    .validation {
        color: red;
        margin-bottom: 20px;
    }
</style>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://unpkg.com/sweetalert2"></script>
<script type="text/javascript" src="https://unpkg.com/promise-polyfill"></script>

<div class="col-sm-12 col-md-12 login-page register-page">
    <div class="row">
         <div class="col-xs-12 col-sm-4 col-md-4 get-strated-wrapper">
            <div class="login-get-started">
                <div class="col-md-6"><p><a class="label-create-acc"><?=$t->_('already_have_account');?></a></p></div>
                 <div class="col-md-4"><a href="{{url('session/index')}}"><button type="submit" class="btn ficha-btn"><?=$t->_('sign_in');?></button></a></div>
            </div>
        </div>

    	<div class="col-xs-12 col-sm-4 col-md-4 login-from-wrapper" id="login_form_anchor_target_mobile">
    		<div class="login-from-wrapper-in">
                 <div class="logo-wapper">
                    <div class="row">
                        <img src="{{url('images/ficha_new_logo.png')}}">
                    </div>
                </div> 
                <?php $this->view->partial("register/index", ['form'=> new RegisterForm]); ?>
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
         
             <div class="row social-footer col-md-12 visible-lg visible-md">
                    <ul>
                        <li><a target="_blank" href="#"><img src="/images/twitter-icon1.png"></a></li>
                        <li><a target="_blank" href="#"><img src="/images/in-icon2.png"></a></li>
                        <li><a target="_blank" href="#"><img src="/images/facebook-icon3.png"></a></li>
                    </ul>
                </div>
        </div>
    </div>
    <!-- FOOTER -->
<!--     <div class="col-xs-12 col-sm-12 col-md-12 ficha-login-footer ">
        <div class="row ficha-login-footer-wrapper">
            <div class="col-md-6">
         
            </div>
            <div class="col-md-6 social-footer">
                <ul>
                    <li><a href="#"><img src="/images/twitter-icon1.png"></a></li>
                    <li><a href="#"><img src="/images/in-icon2.png"></a></li>
                    <li><a href="#"><img src="/images/facebook-icon3.png"></a></li>
                </ul>
            </div>
        </div>
    </div> -->
    
</div>

<script type="text/javascript">
    $(document).ready(function() { 
        $("input[name='signupbutton']").on('click', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);

            if (!regex.test(key)) {
                // document.getElementById("fname_error").innerHTML = "Special Character are not allowed";
                $().toastmessage('showToast', {
                    text     : "Special Character are not allowed",
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
                $("input[name='name']").addClass('error-input');
                event.preventDefault();
                return false;
            }

            document.getElementById("fname_error").innerHTML = "";
            $("input[name='name']").removeClass('error-input');
            if (!regex.test(key)) {
                // document.getElementById("lname_error").innerHTML = "Special Character are not allowed";
                $().toastmessage('showToast', {
                    text     : "Special Character are not allowed",
                    sticky   : false,
                    position : 'bottom-right',
                    type     : 'success',
                    closeText: ''
                });
                $("input[name='lastname']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            
            document.getElementById("lname_error").innerHTML = "";
            $("input[name='lastname']").removeClass('error-input');
        });

        // $("input[name='lastname']").on('focusout', function (event) {
        //     var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
        //     var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            
        // });

        jQuery.extend(jQuery.validator.messages, {
            // required: "This field is required.",
            // remote: "Please fix this field.",
            // email: "Please enter a valid email address.",
            // url: "Please enter a valid URL.",
            // date: "Please enter a valid date.",
            // dateISO: "Please enter a valid date (ISO).",
            // number: "Please enter a valid number.",
            // digits: "Please enter only digits.",
            // creditcard: "Please enter a valid credit card number.",
            // equalTo: "Please enter the same value again.",
            // accept: "Please enter a value with a valid extension.",
            maxlength: jQuery.validator.format("Please enter only {0} characters."),
            minlength: jQuery.validator.format("Please enter minimum {0} characters."),
            // rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long."),
            // range: jQuery.validator.format("Please enter a value between {0} and {1}."),
            // max: jQuery.validator.format("Please enter a value less than or equal to {0}."),
            // min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
        });

        <?php
            if($this->dispatcher->getParam('activeid')){
                if(!empty($this->dispatcher->getParam('activeid')) && (strtotime($expiry_date) > strtotime(date('Y-m-d H:i:s')))){
                    ?>
                    swal("Awesome!", 'We are excited you joined us! Please login.', "success");
                    <?php 
                } else {
                    ?>
                    swal("Oops..!", 'The link expired! Please register again.', "error");
                    <?php
                }
            }
        ?>
        var _Loader={container: '#nav-tabContent'};

        $("#registerForm").fichaForm({
        showLoader:_Loader,
        validatorsmethod:{
          'validator1':$.validator.addMethod("fandlname", function(value, element) { return this.optional(element) || /^[ A-Za-z0-9./()!]+$/.test(value); }, "Special Character are not allowed"),
          'validator2':$.validator.addMethod("emailvali", function(value, element) { return this.optional(element) || /\b[a-zA-Z0-9\u00C0-\u017F._%+-]+@[a-zA-Z0-9\u00C0-\u017F.-]+\.[a-zA-Z]{2,}\b/.test(value); }, "Not a valid email"),
          'validator3':$.validator.addMethod("password1", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, " Password must contain at least one upper & lower case characters one digit & special character."),
          'validator4':$.validator.addMethod("repeatPassword", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, " Password must contain at least one upper & lower case characters one digit & special character.")
        },
        validaterules:{
            name: { fandlname: true , required: true,maxlength:50, minlength:3},
            lastname: { fandlname: true , required: true,maxlength:50, minlength:3},
            email: { emailvali: true , required: true,maxlength:50, minlength:3}, 
            password: { password1: true , required: true,maxlength:50, minlength:8},
            repeatPassword: { repeatPassword: true , required: true,maxlength:50, minlength:8}, 
            register_terms:{ required:true}
        },
        validatemessage:{
            name:               {required: "Please enter first name"},
            lastname:           {required: "Please enter last name"},
            email:              {required: "Please enter email address"},
            password:           {required: "Please enter password"},
            repeatPassword:     {required: "Please enter repeat password"},
            register_terms:     {required: "Please accept our terms & conditions"},
            //name:{maxlength: "Enter only {0} characters"}
        },
        onSuccess: function (result) {
            if(result.status==true){
                swal({
                    title: '<img class="sweet-logo-img" src="../images/logo_fa.png"><h3 class="sweet-head">Awesome! Welcome to FICHA<h3>',
                    // width: 900,
                    // // height: 900,
                    // padding: '10em',
                    background: '#7338bb',
                    html:
                      '<span class="sweet-sub-head">Please verify your account.</span>, ' +
                      '<p class="sweet-text">Hi '+result.name+', we are excited you joined us. for security purposes please continue by verifying your newly created FICHA account through clicking the link sent to your inbox. See you there!</p> ' +
                      '<ul class="sweet-social"><li><img src="/images/twitter-icon.png" alt=""></li><li><img src="/images/in-icon.png" alt=""></li><li><img src="/images/facebook-icon.png" alt=""></li></ul>',
                    showCloseButton: true,
                    showCancelButton: true,
                    focusConfirm: false,
                    showConfirmButton: false,
                    showCancelButton: false,
                });
            }
        },
        onError: function (result) {
            if(result.emailalert=='email'){
                if($('div.toast-container.toast-position-bottom-right div').length < 1){
                    $().toastmessage('showToast', {
                        text     : result.msg,
                        sticky   : false,
                        position : 'bottom-right',
                        type     : 'success',
                        closeText: ''
                    });
                }
            }
        }
     });

        $('a.scroll_to_form').click(function(){
            var $target = $('html,body'); $target.animate({scrollTop: $target.height()}, 500);
            return false;
        });
     });
</script>