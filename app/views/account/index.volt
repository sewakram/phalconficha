<script type="text/javascript"> var uploadurl='<?php echo $this->url->get("application/upload");?>';</script>
<div class="dashboard setting-bottom">
  <div class="app-header row plain-color ">
      <div class="col-sm-8">
        <h3 class="app-title"><?=$t->_("your_settings"); ?></h1>
        <h6 class="app-desc"><?=$t->_("settings_sub_heading"); ?></h5>
      </div>
      <div class="col-sm-4 main-app-point">
            <!-- <div class="navbar navbar-default navbar-fixed-top" role="navigation">
                <div class="container">  -->
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="down-arrow-img"></span>
                                <span class="user-name"><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname[0]).".";?></span>
                                    <span class="user-img-wrapp"><img class="profile-icon profile-pic" src="<?php echo ($loggedInUser->pic)? $this->url->get($loggedInUser->pic):'/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png'?>" /></span>
                                <!-- <span class="glyphicon glyphicon-user"></span>  -->
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <div class="navbar-login">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <p class="text-center upload_profile-wrap">

                                                    <img class="profilepi profile-pic" src="<?php echo ($loggedInUser->pic)? $this->url->get($loggedInUser->pic):'/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png'?>" />
                                                    <!-- <span class="glyphicon glyphicon-user icon-size"></span> -->
                                                    <i class="fa fa-camera upload-button"></i>
                                                    <div class="p-image">
                                                
                                                    <input class="file-upload" type="file" id="file" accept="image/*"/>
                                                    </div>
                                                </p>
                                            </div>
                                            <div class="col-lg-8">
                                                <p class="text-left"><strong><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname);?></strong></p>
                                                <p class="text-left small"><?=$loggedInUser->email;?></p>
                                                <p class="text-left">
                                                    <a href="/account/index" class="btn btn-primary btn-block btn-sm update-btn"><?=$t->_("update_profile"); ?></a>
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
                                                    <a href="/session/end" class="btn btn-danger btn-block log-btn"><?=$t->_("log_out"); ?></a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- </div>
        </div> -->
      </div>
  </div>
</div>
<div class="container setting-mob-wrap">
    <div class="col-lg-12 well ">
        <div class="row">
            <form id="profiletab" action="<?php echo $this->url->get('account/accountdata'); ?>" method="post">
                <div class="col-sm-12 border_wrap">
                    <div class="row">
                        <div class="col-sm-12 form-group">
                            <h4><?=$t->_("general_information"); ?></h4>
                        </div>
                    </div>  
                    <div class="row"> <!-- Firstnmae Block, Lastname block, Company block -->
                        <div class="col-sm-3 form-group setting-wrap">
                            <input type="text" placeholder='<?=$t->_("first_name"); ?>' name="txtFirstName" class="form-control" value="<?=$client_details->fname;?>" maxlength="50">
                        </div>  
                        <div class="col-sm-3 form-group setting-wrap">
                            <input type="text" placeholder='<?=$t->_("last_name"); ?>' name="txtLastName" class="form-control" value="<?=$client_details->lname;?>"  maxlength="50">
                        </div>  
                        <div class="col-sm-6 form-group setting-wrap">
                            <input type="text" placeholder='<?=$t->_("Company"); ?>' name="txtCompanyName" class="form-control" value="<?=$client_details->company_name;?>"  maxlength="50">
                        </div>
                    </div>
                    <div class="row"> <!-- Gender Block, Birthday block, Country block -->
                        <div class="col-md-3 form-group setting-wrap ">
                            <div class="switch-field ">
                                <input type="radio" id="gender_male" name="gender" value="Male" data-msg-required="This field is required." <?php if ($client_details->gender=='male') { echo "checked"; } ?>/>
                                <label for="gender_male"><?=$t->_("male"); ?></label>
                                <input type="radio" id="gender_female" name="gender" value="Female" data-msg-required="This field is required." <?php if ($client_details->gender=='female') { echo "checked"; } ?>/>
                                <label for="gender_female"><?=$t->_("female"); ?></label>
                            </div>
                        </div> <!-- Gender Block -->
                        <div class="col-sm-3 form-group Material-pick setting-wrap">
                            <div class="Material-pick-wrap">
                            <input type="text" placeholder='<?=$t->_("Birthday"); ?>' id="txtBirthday" name="txtBirthday" class="form-control" value="<?=$client_details->dob;?>">
                            <label class="" for="txtBirthday">
                                <img src="<?=$this->url->get('images/setting-calender-icon.png')?>" class="Material-pick-img" height="25" width="25">
                            </label>
                            </div>
                        </div> <!-- Birthday block -->
                        <div class="col-sm-6 form-group setting-wrap">
                            <div class=" common-wrapper">
                                <div class="input-wrapper">
                                    <select class="form-control select2" name="country" title="Select country" id="user-country" data-rule-required="true">
                                        <option value=""><?=$t->_("select_country"); ?></option>
                                        <?php
                                            foreach ($countries as $country) {
                                              $_chk=($client_details->country==$country->id) ? 'selected' : ''; 
                                              printf('<option value="%d" %s>%s</option>',$country->id,$_chk,$country->name);
                                            }
                                        ?>
                                    </select>
                                </div>
                            </div>
                        </div> <!-- Country block -->
                    </div>
                    <div class="row"> <!-- Phone Block, Email block, Newsletter block -->
                        <div class="col-sm-3 form-group phone-block-wrap setting-wrap">
                            <!-- <div class="col-md-12 common-wrapper"> -->
                            <!-- <div class="row-no-padding input-wrapper"> -->
                            <div class="col-sm-4 padding-right select-code">
                                <?php
                                    $_code= ($client_details->phone) ? explode("-", $client_details->phone) : array();
                                    $_contry_code=isset($_code[0]) ?  $_code[0] : false;
                                    $_phone=isset($_code[1]) ?  $_code[1] : '';
                                ?>
                                <select class="form-control select2" name="countrycode" id="countrycode" title="Select country code" data-rule-required="true">
                                    <option value="">Select</option>
                                    <?php
                                        foreach ($country_code as $code) {
                                            $_chk=($_contry_code==$code) ? 'selected' : ''; 
                                            printf('<option value="%d" %s>+%d</option>',$code,$_chk,$code);
                                        }
                                    ?>
                                </select>
                            </div>
                            <div class="col-sm-8 setting-phone-block ">
                                <input class="form-control" type="text" name="phone" placeholder='<?=$t->_("Phone"); ?>' value="<?=$_phone;?>" minlength="10" maxlength="11">
                                <div id="phone_error" class="error-block-msg"></div>
                            </div>
                            <!-- </div> -->
                            <!-- </div> -->
                        </div>  
                        <div class="col-sm-3 form-group setting-wrap">
                            <input type="email" readonly name="email" placeholder='<?=$t->_("account_email"); ?>' class="form-control" value="<?=$client_details->email; ?>">
                        </div>
                        <div class="col-sm-6 form-group subscribe-group-wrap setting-wrap  security-wrap">
                            <div class="col-sm-7 form-group subscribe-group">
                                <label class="subscribe-label"><?=$t->_("subscribe_newsletter"); ?></label>
                            </div>
                            <div class="col-sm-5 form-group subscribe-switch-field setting-wrap">
                                <div class="switch-field">
                                    <input type="radio" id="subscribe_yes" name="subscribe" value="Yes" data-msg-required="This field is required." <?php if ($client_details->newsletter=='Yes') { echo "checked"; } ?>/>
                                    <label for="subscribe_yes"><?=$t->_("Yes"); ?></label>
                                    <input type="radio" id="subscribe_no" name="subscribe" value="No" data-msg-required="This field is required." <?php if ($client_details->newsletter=='No') { echo "checked"; } ?>/>
                                    <label for="subscribe_no"><?=$t->_("No"); ?></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 setting-well setting-border-wrap border_wrap"> 
                    <div class="row">
                        <div class="col-sm-12 form-group setting-wrap">
                            <h4>Security settings</h4>
                        </div>
                    </div>
                    <div class="row setting-wrap">  <!-- Update Password block -->
                        <div class="col-sm-3 form-group update-group setting-wrap">
                            <label class="subscribe-label"><?=$t->_("update_password"); ?></label>
                        </div>
                        <div class="col-sm-4 form-group setting-wrap">
                            <div class="switch-field ">
                                <input type="radio" id="security_yes" name="security" value="yes"/>
                                <label for="security_yes"><?=$t->_("Yes"); ?></label>
                                <input type="radio" id="security_no" name="security" value="no" checked/>
                                <label for="security_no"><?=$t->_("No"); ?></label>
                            </div>
                        </div>
                    </div>
                    <div class="row disable-group">  <!-- Current Password Block, New Password block, Confirm Password block -->
                        <div class="col-sm-4 form-group setting-wrap">
                            <input name="currentpwd" type="password" placeholder='<?=$t->_("current_password"); ?>' class="form-control" maxlength="15" minlength="8">
                        </div>  
                        <div class="col-sm-4 form-group setting-wrap">
                            <input name="newpwd" id="newpwd" type="password" placeholder='<?=$t->_("new_password"); ?>' class="form-control" maxlength="15" minlength="8" >
                        </div>  
                        <div class="col-sm-4 form-group setting-wrap">
                            <input name="confirmpwd" type="password" placeholder='<?=$t->_("confirm_new_password"); ?>' class="form-control" maxlength="15" minlength="8" >
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 setting-well border_wrap">
                    <div class="row">
                        <div class="col-lg-12 form-group">
                            <button type="submit" class="btn ficha-btn pull-right"><?=$t->_("update_your_settings"); ?><i class="material-icons">arrow_forward</i> </button>         
                        </div>
                    </div>
                </div>
            </form> 
        </div>
    </div>
</div>
<link rel="stylesheet" href="<?=$this->url->get("css/bootstrap-material-datetimepicker.css");?>" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script type="text/javascript" src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>
<script type="text/javascript" src="<?=$this->url->get("js/bootstrap-material-datetimepicker.js");?>"></script>
<script type='text/javascript'>
    $(document).ready(function() { 
        jQuery.extend(jQuery.validator.messages, {
            maxlength: jQuery.validator.format("Please enter only {0} characters."),
            minlength: jQuery.validator.format("Please enter minimum {0} characters."),
        });
        
        $("input[name='phone']").on('keypress', function (event) {
            var regex = new RegExp("^[0-9]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            console.log(event.which);
            // if(event.which!=13){
            if (event.keyCode == 13) {
                // document.getElementById("phone_error").innerHTML = "Invalid input";
                // $("input[name='phone']").addClass('error-input');
                if($('div.toast-container.toast-position-top-right div').length < 1){
                    $().toastmessage('showToast', {
                        text     : "Invalid input",
                        sticky   : false,
                        position : 'top-right',
                        type     : 'error',
                        closeText: ''
                    });
                }
            event.preventDefault();
            }
            if (!regex.test(key)) {
                if(event.keyCode != 13)
                // document.getElementById("phone_error").innerHTML = "Special character & Alphabets are not allowed";
                // $("input[name='phone']").addClass('error-input');

                if($('div.toast-container.toast-position-top-right div').length < 1){
                    $().toastmessage('showToast', {
                        text     : "Special character & Alphabets are not allowed",
                        sticky   : false,
                        position : 'top-right',
                        type     : 'error',
                        closeText: ''
                    });
                }
                event.preventDefault();
                return false;
            }
            // document.getElementById("phone_error").innerHTML = "";

            // $("input[name='phone']").removeClass('error-input');
            // }
        });

        $("input[name='txtCompanyName']").on('keypress', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./,()@]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                document.getElementById("companyname_error").innerHTML = "Special Character are not allowed";
                $("input[name='txtCompanyName']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            // document.getElementById("companyname_error").innerHTML = "";
            $("input[name='txtCompanyName']").removeClass('error-input');
        });

        $("input[name='txtFirstName']").on('keypress', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                document.getElementById("fname_error").innerHTML = "Special Character are not allowed";
                $("input[name='txtFirstName']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            // document.getElementById("fname_error").innerHTML = "";
            $("input[name='txtFirstName']").removeClass('error-input');
        });

        $("input[name='txtLastName']").on('keypress', function (event) {
            var regex = new RegExp("^[ A-Za-z0-9./()!]+$");
            var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                document.getElementById("lname_error").innerHTML = "Special Character are not allowed";
                $("input[name='txtLastName']").addClass('error-input');
                event.preventDefault();
                return false;
            }
            // document.getElementById("lname_error").innerHTML = "";
            $("input[name='txtLastName']").removeClass('error-input');
        });

        $("input[name='confirmpwd']").on('focusout', function (event) {
            var newpass = $("input[name='newpwd']").val();
            var confirmpass = $(this).val();
            console.log(newpass+confirmpass);

            if( newpass != confirmpass ){
                if($('div.toast-container.toast-position-top-right div').length < 1){
                    $().toastmessage('showToast', {
                        text     : "New password & confirm password must be same",
                        sticky   : false,
                        position : 'top-right',
                        type     : 'error',
                        closeText: ''
                    });
                }
                $("input[name='confirmpwd']").addClass('error-input');
                event.preventDefault();
                return false;
            }

         });

        if( $('input[name=security]:checked', '#profiletab').val() == 'no' ){
            $("input[name='currentpwd']").attr('disabled','disabled');
            $("input[name='newpwd']").attr('disabled','disabled');
            $("input[name='confirmpwd']").attr('disabled','disabled');
        }

        $('#txtBirthday').bootstrapMaterialDatePicker({ weekStart : 0, time: false, maxDate : new Date() });

        /* Toggle buttons functionality starts */
            $('.gender').click(function() {
                $(this).find('.btn').toggleClass('active');  
                if ($(this).find('.btn-primary').length>0) {
                    $(this).find('.btn').toggleClass('btn-primary');
                }
                $(this).find('.btn').toggleClass('btn-default');
            });

            $('.subscribe').click(function() {
                $(this).find('.btn').toggleClass('active');  
                if ($(this).find('.btn-primary').length>0) {
                    $(this).find('.btn').toggleClass('btn-primary');
                }
                $(this).find('.btn').toggleClass('btn-default');
            });

            $('#profiletab input[name=security]').on('change', function() {
                if( $('input[name=security]:checked', '#profiletab').val() == 'no' ){
                    $("input[name='currentpwd']").attr('disabled','disabled');
                    $("input[name='newpwd']").attr('disabled','disabled');
                    $("input[name='confirmpwd']").attr('disabled','disabled');
                }
                else if( $('input[name=security]:checked', '#profiletab').val() == 'yes' ){
                    $("input[name='currentpwd']").removeAttr('disabled');
                    $("input[name='newpwd']").removeAttr('disabled');
                    $("input[name='confirmpwd']").removeAttr('disabled');
                }
            });
        /* Toggle buttons functionality ends */
    
        $('select.select2').select2();
        $('select.select2').on('change', function () {
            $(this).valid();
        });
        //////////////
        // $('.ficha-btn ').submit(function(e){
        // var ckagain=$( ".toast-container" ).hasClass("toast-position-top-right" );
        // console.log(ckagain); 
        // if(ckagain==true)
        // $(".toast-container").removeClass("toast-position-top-right").addClass('toast-position-bottom-right');

        // });
        $('input:radio[name="security"]').change(
        function(e){
            // $(".toast-container").toggleClass("toast-position-top-right");
            if($(this).val() == 'yes'){
                console.log($(this).val());
                var ck=$( ".toast-container" ).hasClass("toast-position-top-right" );
                console.log('inside');
                var currentpwd=$("input[name='currentpwd']").val();
                var newpwd=$("input[name='newpwd']").val();
                var confirmpwd=$("input[name='confirmpwd']").val();
                console.log(currentpwd);
                if(currentpwd!=''){
                    console.log('blank');
                $(".toast-container").removeClass("toast-position-top-right").addClass("toast-position-bottom-right");
                }
                if(ck==false){
                    console.log('tester');
                $(".toast-container").removeClass("toast-position-top-right").addClass("toast-position-bottom-right");
                }
                if(ck==true){
                    $(".toast-container").removeClass("toast-position-top-right");
                    console.log("test");

                }
                $(".toast-container").removeClass("toast-position-bottom-right").addClass("toast-position-top-right");
            }else{
                $(".toast-container").removeClass("toast-position-top-right").addClass("toast-position-bottom-right");
            }
        
        });
        /////////////
        var _Loader={container:'.tab-content-settings',css:"background: rgba(0, 0, 0, 0.14);box-shadow: 0 0 120px rgba(39, 39, 39, 0.22);"};

        $("#profiletab").fichaForm({
            validatorsmethod:{
                'validator1': $.validator.addMethod("fandlname", function(value, element) { return this.optional(element) || /^[A-Za-z./()!]+$/.test(value); }, "Special characters and numbers are not allowed."), 

                'validator2': $.validator.addMethod("emailvali", function(value, element) { return this.optional(element) || /\b[a-zA-Z0-9\u00C0-\u017F._%+-]+@[a-zA-Z0-9\u00C0-\u017F.-]+\.[a-zA-Z]{2,}\b/.test(value); }, "Not a valid email"),

                'validator3': $.validator.addMethod("password", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, "Password must contain at least one upper and lower case characters, a special symbol,one digit."),

                'validator4': $.validator.addMethod("repeatPassword", function(value, element) { return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$&+,:;=?@#|'<>.^*()%!-])/.test(value); }, "Password must contain at least one upper and lower case characters, a special symbol,one digit."),

                'validator5':$.validator.addMethod("number", function(value, element) { return this.optional(element) || /^[ 0-9]+$/.test(value); }, "Numbers only please"),
            },
            validaterules:{
                txtFirstName:   { fandlname: true, required: true, maxlength:20, minlength:3},
                txtLastName:    { fandlname: true, required: true, maxlength:20, minlength:3},
                txtCompanyName: { fandlname: true, required: true, maxlength:20, minlength:3},
                phone:          { number: true, required: true, maxlength:15, minlength:7}, 
                email:          { emailvali: true, required: true, maxlength:50, minlength:3}, 
                currentpwd:     { required: true, maxlength:15, minlength:8},
                newpwd:         { password: true, required: true, maxlength:15, minlength:8},
                confirmpwd:     { repeatPassword: true, equalTo: "#newpwd", required: true, maxlength:15, minlength:8}, 
            },
            validatemessage: {
                txtFirstName:   { required: "Please enter first name" },
                txtLastName:    { required: "Please enter last name" },
                txtCompanyName: { required: "Please enter company name" },
                phone:          { required: "Please enter phone number" },
                email:          { required: "Please enter email address" },
                currentpwd:     { required: "Please enter current password" },
                newpwd:         { required: "Please enter new password" },
                confirmpwd:     { required: "Please enter confirm password" },
            },
            showLoader:_Loader,
            onSuccess: function (result) {
                console.log(result);
                

                if(result.msg){
                    console.log("msg bottom");
                       if($('div.toast-container.toast-position-bottom-right div').length < 1){
                        $().toastmessage('showToast', {
                            text     : result.msg,
                            sticky   : false,
                            position : 'bottom-right',
                            type     : 'success',
                            closeText: ''
                        });
                        } 
                }else {
                    //console.log("msg top"); return false;
                        if($('div.toast-container.toast-position-top-right div').length < 1){
                        $().toastmessage('showToast', {
                            text     : result.msg,
                            sticky   : false,
                            position : 'top-right',
                            type     : 'error',
                            closeText: ''
                        });
                        }
                }
                
            },
            onError: function (result) {
                if($('div.toast-container.toast-position-top-right div').length < 1){
                    $().toastmessage('showToast', {
                        text     : result.msg,
                        sticky   : false,
                        position : 'top-right',
                        type     : 'error',
                        closeText: ''
                    });
                }
            }
        });
    });
</script>