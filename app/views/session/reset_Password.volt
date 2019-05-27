{{ javascript_include('js/sweetalert-dev.js') }}
{{ stylesheet_link('css/sweetalert.css') }}
<style type="text/css">
    .validation {
        color: red;
        margin-bottom: 20px;
    }
</style>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            <a class="navbar-brand" href="#"><img src="http://dev.fichapp.co/images/logo1.png"></a>
        </div>
        <div class="collapse navbar-collapse navbar-collapse-home" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a class="label-create-acc"><?=$t->_('dont_have_account');?></a></li>
                <li><a href="{{url('session/register')}}"><button type="submit" class="btn ficha-btn"><?=$t->_('get_started');?></button></a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="col-sm-12 col-md-12 login-page">
    <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-4 login-from-wrapper" id="login_form_anchor_target_mobile">
            <div class="login-from-wrapper-in">
                <div class="page-header">
                    <h2><?=$t->_('reset_acc_pwd_ficha');?></h2>
                    <span><?=$t->_('pwd_below');?></span>
                </div>
                {{ form('session/start', 'role': 'form','id':"log-in-form") }}
                    <fieldset>
                        <?php if($redirect){ ?>
                            <input type="hidden" name="redirect" value="<?=$redirect;?>">
                        <?php } ?>
                        <div class="form-group">
                            <input type="text" maxlength="51" id="email" name="email" class="form-control" placeholder="<?=$t->_('email');?>" data-rule-required="true" data-rule-email="true"> <i class="material-icons">mail_outline</i>
                        </div>
                        <div class="form-group">
                            <input type="password" maxlength="51" id="login-password" name="password" class="form-control" placeholder="<?=$t->_('password');?>" data-rule-required="true"> <i class="material-icons">lock</i>
                        </div>
                        <div class="form-group form-action-wrapper">
                            <div class="row">
                                <div class="col-sm-6 col-md-6">
                                    <a href="{{url('session/forgot')}}" class="login-forgot-password"><?=$t->_('forgot_password');?></a>
                                </div>
                                <div class="col-sm-6 col-md-6 text-right">
                                    <button type="submit" class="btn ficha-btn"><?=$t->_('sign_in');?><i class="material-icons">arrow_forward</i></button>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
                <form action="{{url('register/reset_password')}}" id="reset-password-form" method="POST">
                    <?php if($token){
                        foreach ($tokens_arr as $key => $value) { printf('<input type="hidden" name="%s" value="%s">', $key, $value); }
                    } ?>
                    <div class="form-group">
                        <input type="password" id="reset-password" name="reset_password" class="form-control" placeholder="<?=$t->_('new_pwd');?>" data-rule-required="true">
                    </div>
                    <div class="form-group">
                        <input type="password" name="confirm_reset_password" class="form-control" placeholder="<?=$t->_('confirm_new_pwd');?>" data-rule-required="true" data-rule-equalTo="#reset-password">
                    </div>
                    <div class="form-group form-reset-password-action text-right">
                        <button type="submit" class="btn ficha-btn"><?=$t->_('create_new_password');?></button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-xs-12 col-sm-8 col-md-8 background-image-wrapper">
            <div class="row">
                <!-- <img src="{{url('images/login_page_images/login-banner.jpg')}}"> -->
            </div>
            <div class="scroll-to-form-mobile">
                <a href="#login_form_anchor_target_mobile" class="scroll_to_form bounce animated infinite"><?=$t->_('click_here');?></a>
            </div>
        </div>
    </div>
    <!-- FOOTER -->
    <div class="col-xs-12 col-sm-12 col-md-12 ficha-login-footer ">
        <div class="row ficha-login-footer-wrapper">
            <div class="col-md-6"> <span class="text-login-footer"><?=$t->_('ficha_footer_subtitle');?></span> </div>
            <div class="col-md-6 social-footer">
                <ul>
                    <li> <img src="/images/twitter-icon1.png"></li>
                    <li> <img src="/images/in-icon2.png"></li>
                    <li> <img src="/images/facebook-icon3.png"></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){ 
        
        $("#reset-password-form").fichaForm({
                alert('hola');
                    // validatorsmethod:{
                    //     'validator1':$.validator.addMethod("emailvali", function(value, element) { return this.optional(element) || /\b[a-zA-Z0-9\u00C0-\u017F._%+-]+@[a-zA-Z0-9\u00C0-\u017F.-]+\.[a-zA-Z]{2,}\b/.test(value); }, "Not a valid email"),
                    //     'validator2':$.validator.addMethod("password1", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, " Password must contain at least one upper & lower case characters one digit & special character."),
                    // },
                    // validaterules:{
                    //     email: { emailvali: true , required: true,maxlength:50, minlength:3},
                    //     password: { password1: true , required: true,maxlength:50, minlength: 8},
                    // },
                    // validatemessage:{
                    //     email: {required: "Please enter email address"},
                    //     password: {required: "Please enter password"},
                    // },
                    // onSuccess: function (result) {

                    //     $('#login-password').css('border','solid 1px #dfe7e9');
                    
                    //     if(result.status){
                    //         window.location=result.redirect;
                    //     }
                    // }
                });
    });
</script>