<style type="text/css">
  


</style>
<script type="text/javascript"> var uploadurl='<?php echo $this->url->get("application/upload");?>';</script>
{{ content() }}

<section class="dashboard-wrapper conatct-help">
    <div class="dashboard">
        <div class="app-header row plain-color">
            <div class="col-sm-8">
                <h1 class="app-title"><?=$t->_("contact_and_support"); ?></h1>
                <h5 class="app-desc"><?=$t->_("contact_and_support_para"); ?></h5>
            </div>
            <div class="col-sm-4 main-app-point">
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
        		                                <p><a href="/session/end" class="btn btn-danger btn-block log-btn"><?=$t->_("log_out"); ?></a></p>
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
        <div class="clearfix"></div>
    </div>
    <div class="col-sm-12 heading-wrap">
        <h4><?=$t->_("happy_to_assist"); ?></h4>
        <h5><?=$t->_("discover_faq"); ?></h5>
    </div>
    <div class="col-sm-12 contact-support-wrap">
        <div class="col-sm-4 support-wrap">
            <div class="image_wrapp">
                <img src="<?=$this->url->get('images/ficha/contact-support.png');?>"> 
            </div>
        </div>
        <div class="col-sm-8 support-wrap">
            <div class="inner contact">
              <!-- Form Area -->
                <div class="contact-form">
                    <!-- Form -->
                    <form id="contact-us" method="post" action="#">
                        <div class="col-md-4 col-xs-12  wow animated slideInLeft" data-wow-delay=".5s">
                            <input type="text" name="subject" id="subject" required="required" class="form" placeholder='<?=$t->_("Subject"); ?>' /><!-- Subject -->
                        </div>
                        <div class="col-md-8 col-xs-12 wow animated slideInLeft" data-wow-delay=".5s">
                          <div class="contact-select-wrap">
                            <select class="form" id="enquirytype">
                                <option value="" disabled selected><?=$t->_("select_enquiry_type"); ?></option>
                                <option>Enquiry Type #1</option>
                                <option>Enquiry Type #2</option>
                                <option>Enquiry Type #3</option>
                                <option>Enquiry Type #4</option>
                            </select>
                            <span class="down-arrow-img"></span>
                          </div>
                        </div>
                        <!-- Right Inputs -->
                        <div class="col-xs-12 wow animated slideInRight" data-wow-delay=".5s">
                            <textarea name="message" id="message" class="form textarea"  placeholder='<?=$t->_("your_message"); ?>'></textarea><!-- Message -->
                        </div><!-- End Right Inputs -->
                        <!-- Bottom Submit -->
                        <div class="relative fullwidth col-xs-12">
                            <button id="contactUsSubmitButton" type="submit" class="btn ficha-btn pull-right"><?=$t->_("send_message"); ?><i class="material-icons">arrow_forward</i></button><!-- Send Button -->
                        </div><!-- End Bottom Submit -->
                        <div class="clear"></div> <!-- Clear -->
                    </form>
                </div><!-- End Contact Form Area -->
            </div><!-- End Inner --> 
        </div>
    </div>
    <div class="clearfix"></div>
    <div  class="col-sm-12 tab-wrap">
        <div class="col-sm-3 contact-tab"> <!-- required for floating -->
            <!-- Nav tabs -->
            <ul class="nav nav-pills nav-stacked">
                <li ><a href="#dashboard-v" data-toggle="tab"><?=$t->_("dashboard"); ?></a></li>
                <li><a href="#application-v" data-toggle="tab"><?=$t->_("application"); ?></a></li>
                <li><a href="#teammembers-v" data-toggle="tab"><?=$t->_("team_members"); ?></a></li>
                <li class="active"><a href="#invoices-payment-v" data-toggle="tab"><?=$t->_("invoice_and_payment"); ?></a></li>
                <li><a href="#settings-v" data-toggle="tab"><?=$t->_("Settings"); ?></a></li>
            </ul>
        </div>
        <div class="col-sm-9 contact-tab-content">
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane " id="dashboard-v">
                    <h3><?=$t->_("dashboard"); ?></h3>
                    <p>Invoices are generated automatically after a successful payment for services. Find all details related to this section below.</p>
                    <div class="wrapper center-block">
                        <div class="panel-group" id="accordion-dashboard" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading active" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion-dashboard" href="#dashboardQueOne" aria-expanded="true" aria-controls="dashboardQueOne"> How many days does the Free Trial supports exporting data? </a>
                                    </h4>
                                </div>
                                <div id="dashboardQueOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        Invoices are generated automatically after a successful payment for services. Find all details related to this section below. Invoices are generated
                                        automatically after a successful payment for services. Find all details related to this section below.Invoices are generated automatically after a
                                        successful payment for services. Find all details related to this section below.
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-dashboard" href="#dashboardQueTwo" aria-expanded="false" aria-controls="dashboardQueTwo">Can I upgrade my account to “Pro Membership” at any moment?</a>
                                    </h4>
                                </div>
                                <div id="dashboardQueTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-dashboard" href="#dashboardQueThree" aria-expanded="false" aria-controls="dashboardQueThree">How do you manage the monthly billing process?</a>
                                    </h4>
                                </div>
                                <div id="dashboardQueThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="application-v">
                    <h3><?=$t->_("application"); ?></h3>
                    <p>Invoices are generated automatically after a successful payment for services. Find all details related to this section below.</p>
                    <div class="wrapper center-block">
                        <div class="panel-group" id="accordion-application" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading active" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion-application" href="#applicationQueOne" aria-expanded="true" aria-controls="applicationQueOne">How many days does the Free Trial supports exporting data?</a>
                                    </h4>
                                </div>
                                <div id="applicationQueOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        Invoices are generated automatically after a successful payment for services. Find all details related to this section below. Invoices are generated
                                        automatically after a successful payment for services. Find all details related to this section below.Invoices are generated automatically after a
                                        successful payment for services. Find all details related to this section below.
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-application" href="#applicationQueTwo" aria-expanded="false" aria-controls="applicationQueTwo"> Can I upgrade my account to “Pro Membership” at any moment?</a>
                                    </h4>
                                </div>
                                <div id="applicationQueTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-application" href="#applicationQueThree" aria-expanded="false" aria-controls="applicationQueThree">How do you manage the monthly billing process?</a>
                                    </h4>
                                </div>
                                <div id="applicationQueThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="teammembers-v">
                    <h3><?=$t->_("team_members"); ?></h3>
                    <p>Invoices are generated automatically after a successful payment for services. Find all details related to this section below.</p>
                    <div class="wrapper center-block">
                        <div class="panel-group" id="accordion-team-members" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading active" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion-team-members" href="#teamMembersQueOne" aria-expanded="true" aria-controls="teamMembersQueOne">How many days does the Free Trial supports exporting data?</a>
                                    </h4>
                                </div>
                                <div id="teamMembersQueOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        Invoices are generated automatically after a successful payment for services. Find all details related to this section below. Invoices are generated
                                        automatically after a successful payment for services. Find all details related to this section below.Invoices are generated automatically after a
                                        successful payment for services. Find all details related to this section below.
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-team-members" href="#teamMembersQueTwo" aria-expanded="false" aria-controls="teamMembersQueTwo">Can I upgrade my account to “Pro Membership” at any moment?</a>
                                    </h4>
                                </div>
                                <div id="teamMembersQueTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-team-members" href="#teamMembersQueThree" aria-expanded="false" aria-controls="teamMembersQueThree">How do you manage the monthly billing process?</a>
                                    </h4>
                                </div>
                                <div id="teamMembersQueThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane active" id="invoices-payment-v">
                    <h3><?=$t->_("invoice_and_payment"); ?></h3>
                    <p>Invoices are generated automatically after a successful payment for services. Find all details related to this section below.</p>
                    <div class="wrapper center-block">
                        <div class="panel-group" id="accordion-invoices" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading active" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion-invoices" href="#invoicesQueOne" aria-expanded="true" aria-controls="invoicesQueOne">
                                    How many days does the Free Trial supports exporting data?</a>
                                    </h4>
                                </div>
                                <div id="invoicesQueOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        Invoices are generated automatically after a successful payment for services. Find all details related to this section below. Invoices are generated
                                        automatically after a successful payment for services. Find all details related to this section below.Invoices are generated automatically after a
                                        successful payment for services. Find all details related to this section below.
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-invoices" href="#invoicesQueTwo" aria-expanded="false" aria-controls="invoicesQueTwo">Can I upgrade my account to “Pro Membership” at any moment?</a>
                                    </h4>
                                </div>
                                <div id="invoicesQueTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-invoices" href="#invoicesQueThree" aria-expanded="false" aria-controls="invoicesQueThree">How do you manage the monthly billing process?</a>
                                    </h4>
                                </div>
                                <div id="invoicesQueThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="settings-v">
                    <h3><?=$t->_("Settings"); ?></h3>
                    <p>Invoices are generated automatically after a successful payment for services. Find all details related to this section below.</p>
                    <div class="wrapper center-block">
                        <div class="panel-group" id="accordion-settings" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading active" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion-settings" href="#settingsQueOne" aria-expanded="true" aria-controls="settingsQueOne">How many days does the Free Trial supports exporting data?</a>
                                    </h4>
                                </div>
                                <div id="settingsQueOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        Invoices are generated automatically after a successful payment for services. Find all details related to this section below. Invoices are generated
                                        automatically after a successful payment for services. Find all details related to this section below.Invoices are generated automatically after a
                                        successful payment for services. Find all details related to this section below.
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-settings" href="#settingsQueTwo" aria-expanded="false" aria-controls="settingsQueTwo">Can I upgrade my account to “Pro Membership” at any moment?</a>
                                    </h4>
                                </div>
                                <div id="settingsQueTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-settings" href="#settingsQueThree" aria-expanded="false" aria-controls="settingsQueThree">How do you manage the monthly billing process?</a>
                                    </h4>
                                </div>
                                <div id="settingsQueThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        This is dummy text. This is dummy text. This is dummy text. This is dummy text. This is dummy text. 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</section>

<script type='text/javascript'>
    $(document).ready(function() { 
        /* accordion toggle starts */
            $('.panel-collapse').on('show.bs.collapse', function () {
                $(this).siblings('.panel-heading').addClass('active');
            });

            $('.panel-collapse').on('hide.bs.collapse', function () {
                $(this).siblings('.panel-heading').removeClass('active');
            });
        /* accordion toggle ends */

        $("#contactUsSubmitButton").click(function(e){
            console.log('inside ajax call');
            e.preventDefault();

            // var email = $("#mail").val();
            var subject = $("#subject").val();
            var enqtype = $("#enquirytype option:selected").text();
            var message = $("#message").val();
            // if ( email == "")  {
            //     $().toastmessage('showToast', {
            //         text     : 'Email Address must be filled out',
            //         sticky   : false,
            //         position : 'bottom-right',
            //         type     : 'success',
            //         closeText: ''
            //     });
            //     $("#mail").focus();
            //     return false;
            // }
            
            if ( subject == "")  {
                var ck=$( ".toast-container" ).hasClass("toast-position-bottom-right" );
                 if(ck==true){
                    $(".toast-container").removeClass("toast-position-bottom-right").addClass("toast-position-top-right");
                }
                if($('div.toast-container.toast-position-top-right div').length < 1){
                $().toastmessage('showToast', {
                    text     : 'Subject must be filled out',
                    sticky   : false,
                    position : 'top-right',
                    type     : 'error',
                    closeText: ''
                });
            }
                $("#subject").focus();
                return false;
            }

            if ( enqtype == "Select an enquiry type")  {
                var ck=$( ".toast-container" ).hasClass("toast-position-bottom-right" );
                 if(ck==true){
                    $(".toast-container").removeClass("toast-position-bottom-right").addClass("toast-position-top-right");
                }
                if($('div.toast-container.toast-position-top-right div').length < 1){

                $().toastmessage('showToast', {
                    text     : 'Enquiry type must be filled out',
                    sticky   : false,
                    position : 'top-right',
                    type     : 'error',
                    closeText: ''
                });
            }
                $("#enquirytype").focus();
                return false;
            }

            if ( message == "") {
                var ck=$( ".toast-container" ).hasClass("toast-position-bottom-right" );
                if(ck==true){
                    $(".toast-container").removeClass("toast-position-bottom-right").addClass("toast-position-top-right");
                }
                if($('div.toast-container.toast-position-top-right div').length < 1){

                $().toastmessage('showToast', {
                    text     : 'Message must be filled out',
                    sticky   : false,
                    position : 'top-right',
                    type     : 'error',
                    closeText: ''
                });
            }
                $("#message").focus();
                return false;
            }
            // var str = $( "form" ).serialize();
            $.ajax({
                type : "POST",
                crossDomain: false,
                url : "<?php echo $this->url->get('contact-and-support/contactData');?>",
                data: {
                    // email : email,
                    enqtype : enqtype,
                    subject : subject,
                    message : message
                },
                dataType : "json",
                success: function(result){
                    document.getElementById('contact-us').reset();
                    var ck=$(".toast-container").hasClass("toast-position-top-right" );
                     if(ck==true){
                    $(".toast-container").removeClass("toast-position-top-right").addClass("toast-position-bottom-right");
                    }
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
            });
        });
    });
</script>