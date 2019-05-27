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
                <li><a href="#" class="label-create-acc">Dont have an account?</a></li>
                <li><a href="{{url('session/register')}}"><button type="submit" class="btn ficha-btn">GET STARTED</button></a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="col-sm-12 col-md-12 login-page">
    <div class="row">
        <div class="col-xs-12 col-sm-4 col-md-4 login-from-wrapper" id="login_form_anchor_target_mobile">
            <div class="login-from-wrapper-in">
                <div class="page-header">
                    <h2>Reset your account password for FICHA.</h2>
                    <span>Enter your password below</span>
                </div>
                {{ form('session/start', 'role': 'form','id':"log-in-form") }}
                    <fieldset>
                        <?php
                        if($redirect){
                            ?>
                            <input type="hidden" name="redirect" value="<?=$redirect;?>">
                            <?php
                        }
                        ?>
                        <div class="form-group">
                          <input type="text" maxlength="51" id="email" name="email" class="form-control" placeholder="Email" data-rule-required="true" data-rule-email="true">
                          <i class="material-icons">mail_outline</i>
                        </div>
                        <div class="form-group">
                          <input type="password" maxlength="51" id="login-password" name="password" class="form-control" placeholder="Password" data-rule-required="true">
                          <i class="material-icons">lock</i>
                        </div>
                        <div class="form-group form-action-wrapper">
                          <div class="row">
                            <div class="col-sm-6 col-md-6">
                              <!-- <a id="nav-forgot-password-tab" data-toggle="tab" href="#nav-forgot-password" role="tab" aria-controls="nav-forgot-password" aria-selected="false" class="login-forgot-password"><?//=$t->_('forgot_password');?></a> -->
                              <a href="{{url('session/forgot')}}" class="login-forgot-password"><?=$t->_('forgot_password');?></a>
                            </div>
                            <div class="col-sm-6 col-md-6 text-right">
                              <button type="submit" class="btn ficha-btn"><?=$t->_('SIGN IN');?><i class="material-icons">arrow_forward</i></button>
                            </div>
                          </div>
                        </div>
                    </fieldset>
                </form>

                <form action="{{url('register/reset_password')}}" id="reset-password-form" method="POST">
                    <?php
                    if($token){
                      foreach ($tokens_arr as $key => $value) {
                        printf('<input type="hidden" name="%s" value="%s">',$key,$value);
                      }
                    }
                    ?>
                    <div class="form-group">
                      <input type="password" id="reset-password" name="reset_password" class="form-control" placeholder="New Password" data-rule-required="true">
                    </div>

                    <div class="form-group">
                      <input type="password" name="confirm_reset_password" class="form-control" placeholder="Confirm new Password" data-rule-required="true" data-rule-equalTo="#reset-password">
                    </div>

                    <div class="form-group form-reset-password-action text-right">
                       <button type="submit" class="btn ficha-btn"><?=$t->_('create_new_password');?></button>
                    </div>
                </form>
            </div>
          <div class="col-xs-12 col-sm-12 col-md-12 ficha-login-footer">
          <div class="row">
            <span class="text-login-footer"><?=$t->_('ficha_footer_subtitle');?></span>
          </div>
        </div>
      </div>
        <div class="col-xs-12 col-sm-8 col-md-8 background-image-wrapper">
            <div class="row">
                <!-- <img src="{{url('images/login_page_images/login-banner.jpg')}}"> -->
            </div>
            <div class="scroll-to-form-mobile">
                <a href="#login_form_anchor_target_mobile" class="scroll_to_form bounce animated infinite">Click Here</a>
            </div>
        </div>
    </div>
</div>

