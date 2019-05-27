{{ content() }}

<?php 
    $queryString = explode('/', $_SERVER['QUERY_STRING']);
    $app_id = isset($queryString[3]) ? $queryString[3] : $insertedEntities['id'];
 ?>
<section class="singleapp-wrapper">
    <div class="singleapp-header">
        <div class="app-header row plain-color">
            <div class="col-xs-12 col-sm-6 col-md-6">
                <div class="display-flex-wrapp">
                    <div class="app-logo-wrapp">
                        <img class="app-logo thumb" >
                    </div>
                    <div class="app-title-wrapp">
                        <h3 class="app-title"></h3>
                        <h6 class="app-desc"><?= $t->_("app_subtitle");?></h6>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 main-app-point">
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="down-arrow-img"></span>
                                <span class="user-name"><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname[0]).".";?></span>
                                <span class="user-img-wrapp">
                                <img class="profile-icon" src="/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png" />
                                </span>
                                <!-- <span class="glyphicon glyphicon-user"></span>  -->
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <div class="navbar-login">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <p class="text-center">
                                                    <img class="profilepi" src="/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png" />
                                                    <!-- <span class="glyphicon glyphicon-user icon-size"></span> -->
                                                </p>
                                            </div>
                                            <div class="col-lg-8">
                                                <p class="text-left"><strong><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname);?></strong></p>
                                                <p class="text-left small"><?=$loggedInUser->email;?></p>
                                                <p class="text-left">
                                                    <a href="/account/index" class="btn btn-primary btn-block btn-sm"><?=$t->_("update_profile"); ?></a>
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
                                                    <a href="/session/end" class="btn btn-danger btn-block"><?=$t->_("log_out"); ?></a>
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
    <div class="singleapp-general">
        <div class="row">
            <div class="singleapp-general-inner">
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 border-single-left">
    	            <form class="form-horizontal col-xs-12 col-sm-12 col-md-12" action="/application/index" method="post">
                        <div class="form-group">
                          <h4 class="app-title-inner"><?= $t->_("application_settings");?></h4>
                          <div class="border-small-wrapp"><span class="border-small"></span></div>
                        </div>
                        <div class="form-group">
                            <label for="binaryname"><img class="thumb" width="50" height="50"><?= $t->_("Select a square image for your application’s icon");?></label>
                        </div>
                        <div class="form-group single-icon">
    					  <label for="applicationname"><?= $t->_("application_name");?></label>
    					  <input type="hidden" name="applicationid">
                          <input type="text" class="form-control" readonly id="applicationname" name="applicationname">
                          <i class="material-icons wrap-single-icon">clear_all</i>
    					</div>
    					<div class="form-group single-icon">
    					  <label for="binaryname"><?= $t->_("android_binary_name");?></label>
    					  <input type="text" class="form-control" readonly id="binaryname" name="binaryname">
                          <i class="material-icons wrap-single-icon">android</i>
    					</div>
    					<div class="form-group single-icon">
    					  <label for="apitype"><?= $t->_("api_type");?></label>
    					  <input type="text" class="form-control" readonly id="apitype" name="apitype" >
                          <i class="material-icons wrap-single-icon">phone_iphone</i>
    					</div>
                        <div class="form-group">
                            <label class="checkbox-inline  permission-box-check container-check" ><?= $t->_("privacy_policy");?>
                                <input type="checkbox" >
                                <span class="left-checkmark checkmark "></span>
                            </label>
                        </div>
                        <div class="form-group">
                            <div class="delete-application-btn-wrapp">
                               <div class="delete-application-btn-wrapp-inn">
                                    <input type="submit" class="btn btn-info" name="save_details" value="Save Details">
                               </div> 
                            </div>  
                        </div>
    				</form>
                </div>
                <div class="border-left-section-in-form col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="border-left-section-form-innn">
                    	<h4 class="app-title-inner"><?= $t->_("Application status / Integration key");?></h4>
                        <div class="border-small-wrapp">
                            <span class="border-small"></span>
                        </div>
                        <div class="app-connect-subheading-wrapp">
                    	   <h4 class="app-connect-subheading"><?= $t->_("app_connect_subheading");?></h4>
                        </div>
                        <div class="after-successfully-text-wrapp">
                        	<span class="after-successfully-text"><?= $t->_("app_connect_after_successfully_1");?><span class="strong">"<?= $t->_("test_connection");?>"</span>. <?= $t->_("app_connect_after_successfully_2");?>.</span>
                            <div class="documentation-btn-wrapp">
                        	   <button class="btn btn-info"><?= $t->_("read_documentation");?></button>
                            </div>
                    	</div>
                        <div class="form-grou-wrapp-border">  
                          <div class="row form-group api-border key-border">
                            <label for="api_key"><?= $t->_("API Key");?>:</label>
                            <input type="text" class="url-box col-md-12" id="api_key" name="api_key" placeholder="" readonly="true">
                          </div>

                          <div class="form-group">
                            <label for="sandbox"><?= $t->_("sandbox_url");?>:</label>
                            <input type="text" class="url-box url-border" id="sandbox" placeholder="https://dev.website.com/url/script.py">
                            <!-- <a href="/application/index"><button type="submit" class="btn btn-primary">Test Connection</button></a> -->
                            <a href="/application/index"><?= $t->_("test_connection");?></a>
                          </div>
        						
            			  <div class="form-group">
            			    <label for="production"><?= $t->_("production_url");?>:</label>
            			    <input type="text" class="url-box url-border" id="production" placeholder="https://dev.website.com/url/script.py">
                            <!-- <a href="/application/single_app"><button type="submit" class="btn btn-primary">Test Connection</button></a> -->
            			  	<a href="/application/single_app"><?= $t->_("test_connection");?></a>
            			  </div>
                        </div>
        			</div>
                </div>
                <!-- <div class="delete-application-btn-wrapp">
                   <div class="delete-application-btn-wrapp-inn">
                        <input type="submit" class="btn btn-info" name="delete_app" value="Delete Application">
                   </div> 
                </div> -->   
            </div>
        </div>
    <div class="row delete-application-btn-wrapp">
       <div class="delete-application-btn-wrapp-inn">
            <input type="submit" class="btn btn-info pull-right" name="delete_app" value="Delete Application">
       </div> 
    </div>  
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        var base = '<?=$this->url->get();?>';
        
        $.ajax({
            type: 'post',
            url: '<?php echo $this->url->get('application/getNonActiveApps'); ?>',    
            data: {
                app_id : <?=$app_id?>
            },
            dataType: 'json',
            success: function (response) {
                $(".app-title").text(response.app_title).css('textTransform', 'capitalize');
                $("input[name=delete_app]").attr('data-post-app-id', response.id);
                $("input[name=applicationid]").attr('value', response.id);
                $("input[name=applicationname]").attr('value', response.app_title);
                $("input[name=binaryname]").attr('value', response.android_binary_name);
                $("input[name=apitype]").attr('value', response.api_type);
                $("input[name=api_key]").attr('value', response.api_key);
                $(".thumb").attr('src', base+response.thumbnail);
            }
        });

        $('input[type="submit"][name="delete_app"]').click(function(){
            $.ajax({
                type: 'post',
                url: '<?php echo $this->url->get('application/index'); ?>',    
                data: {
                    delete_app : 1,
                    applicationid : $(this).attr('data-post-app-id'),
                },
                dataType: 'json',
                success: function (response) {
                    // console.log('Application deleted suucessfully..!');
                    if (response.status == true) {
                        window.location = response.redirect;
                    }
                }
            });
        });
    });
</script>