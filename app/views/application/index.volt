{{ content() }}

<style type="text/css">
    .fa-caret-right{
      transition: all .4s ease;
    }
    .active .fa-caret-right{
      transform: rotate(90deg);
    }
    .panel-title a{
      text-decoration: none;
    }
    .panel-heading{
        border: 2px solid #000;
    }
    
</style>
 <script type="text/javascript"> var uploadurl='<?php echo $this->url->get("application/upload");?>';</script><section class="application-wrapper">
	<div class="applicationheadtab">
        <div class="app-header row plain-color">
            <div class="col-xs-12 col-sm-4 col-md-4">
                <h1 class="app-title"><?=$t->_("application"); ?></h1>
                <h5 class="app-desc"><?=$t->_("application_info"); ?></h5>
            </div>
            <div class="col-xs-12 col-sm-8 col-md-8 main-app-point">
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
                    <div class="button_and_input_wrapp">
                        <input class="searchapp col-sm-4" tabindex="-1" type="text" name="searchapp" placeholder="<?=$t->_("search_app_placeholder"); ?>">
                        <?=modal_anchor($t->_('connect_application').'', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'connect-app-btn btn ficha-btn connectapp col-sm-4', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                    </div>                    
                </div>
            </div>
        </div>
	</div>
	<div class="application-list-wrapper application-tab">
        <div class="wrapper">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav nav-tabs nav-tabs-responsive" role="tablist">
                    <li role="presentation" class="active">
                      <a href="#all" role="tab" id="all-tab" data-toggle="tab" aria-controls="all" aria-expanded="true">
                        <span class="text">All</span>
                      </a>
                    </li>
                    <li role="presentation" class="next">
                      <a href="#active" role="tab" id="active-tab" data-toggle="tab" aria-controls="active">
                        <span class="text">Active</span>
                      </a>
                    </li>
                    <li role="presentation" class="next">
                      <a href="#inactive" role="tab" id="inactive-tab" data-toggle="tab" aria-controls="inactive">
                        <span class="text">Inactive</span>
                      </a>
                    </li>
                    <li role="presentation">
                      <a href="#invited" role="tab" id="invited-tab" data-toggle="tab" aria-controls="invited">
                        <span class="text">Invited</span>
                      </a>
                    </li>
                </ul>
                <div class="clearfix"></div>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active" id="all" aria-labelledby="active-tab">
                        <ul class="application-list">
                            <?php
                            if (isset($allApps)) {
                                foreach ($allApps as $app) {
                                    $app=(object)$app;
                            
                            // echo "<pre>";print_r($app);exit;

                                    $keySearched = array_search($app->id, $dataPointsCountProcessed);
                                    if ($keySearched !== false) { $app->dp = $dataPointsCountProcessed[$keySearched+1]; }
                                    else { $app->dp = 0; }
                                    if($app->dp==0){
                                       printf('
                                        <li class="app-list">
                                            <a href="%s"><img src="%s"></a>
                                            <h5>%s</h5>
                                            <span>%s</span>
                                        </li>
                                        ',
                                        $this->url->get('application/single_app_no_data/'.$app->id),
                                        $this->url->get($app->thumbnail),
                                        $app->app_title,
                                        sprintf("%s ".$t->_("data_points"), $app->dp)
                                    ); 
                                   }else{
                                    printf('
                                        <li class="app-list">
                                            <a href="%s"><img src="%s"></a>
                                            <h5>%s</h5>
                                            <span>%s</span>
                                        </li>
                                        ',
                                        $this->url->get('application/'.$app->id),
                                        $this->url->get($app->thumbnail),
                                        $app->app_title,
                                        sprintf("%s ".$t->_("data_points"), $app->dp)
                                    );
                                   }
                                    
                                }
                            }
                            // if (isset($pendingApps)) {
                            //     foreach ($pendingApps as $app) {
                            //         $keySearched = array_search($app->id, $dataPointsCountProcessed);
                            //         if ($keySearched !== false) { $app->dp = $dataPointsCountProcessed[$keySearched+1]; }
                            //         else{ $app->dp = 0; }
                            //         printf('
                            //             <li class="app-list">
                            //                 <a href="%s"><img src="%s"></a>
                            //                 <h5>%s</h5>
                            //                 <span>%s</span>
                            //             </li>
                            //             ',
                            //             $this->url->get('application/single_app_no_data/'.$app->id),
                            //             $this->url->get($app->thumbnail),
                            //             ucfirst($app->app_title),
                            //             sprintf("%s ".$t->_("data_points"), $app->dp)
                            //         );
                            //     }
                            // }
                            // if (isset($invitedApps)) {
                            //     foreach ($invitedApps as $app) {
                            //         $keySearched = array_search($app['id'], $dataPointsCountProcessed);
                            //         if ($keySearched !== false) { $app['dp'] = $dataPointsCountProcessed[$keySearched+1]; }
                            //         else { $app['dp'] = 0; }
                            //         printf('
                            //             <li class="app-list">
                            //                 <a href="%s"><img src="%s"></a>
                            //                 <h5>%s</h5>
                            //                 <span>%s</span>
                            //             </li>
                            //             ',
                            //             $this->url->get('application/'.$app['id']),
                            //             $this->url->get($app['thumbnail']),
                            //             ucfirst($app['app_title']),
                            //             sprintf("%s ".$t->_("data_points"), $app['dp'])
                            //         );
                            //     }
                            // }
                            ?>
                            <li class="connect_a_new_app_li">
                                <?=modal_anchor('<div class="img-icon-and-text-wrapp"><img src="'.$this->url->get('images/connect_a_new_app_hd_icon.png').'"><span class="normal-text">Connect a new app</span></div>', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'btn  connectapp', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                            </li>
                        </ul>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="active" aria-labelledby="active-tab">
                        <ul class="application-list">
                            <?php foreach ($apps as $app) {
                                $keySearched = array_search($app->id, $dataPointsCountProcessed);
                                if ($keySearched !== false) { $app->dp = $dataPointsCountProcessed[$keySearched+1]; }
                                else { $app->dp = 0; }
                                printf('
                                    <li class="app-list">
                                        <a href="%s"><img src="%s"></a>
                                        <h5>%s</h5>
                                        <span>%s</span>
                                    </li>
                                    ',
                                    $this->url->get('application/'.$app->id),
                                    $this->url->get($app->thumbnail),
                                    $app->app_title,
                                    sprintf("%s ".$t->_("data_points"), $app->dp)
                                );
                            } ?>
                            <li class="connect_a_new_app_li">
                                <?=modal_anchor('<div class="img-icon-and-text-wrapp"><img src="'.$this->url->get('images/connect_a_new_app_hd_icon.png').'"><span class="normal-text">Connect a new app</span></div>', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'btn connectapp', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                            </li>
                        </ul>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="inactive" aria-labelledby="inactive-tab">
                        <ul class="application-list">
                            <?php  foreach ($pendingApps as $app) {
                                $keySearched = array_search($app->id, $dataPointsCountProcessed);
                                if ($keySearched !== false) { $app->dp = $dataPointsCountProcessed[$keySearched+1]; }
                                else{ $app->dp = 0; }
                                printf('
                                    <li class="app-list">
                                        <a href="%s"><img src="%s"></a>
                                        <h5>%s</h5>
                                        <span>%s</span>
                                    </li>
                                    ',
                                    $this->url->get('application/single_app_no_data/'.$app->id),
                                    $this->url->get($app->thumbnail),
                                    ucfirst($app->app_title),
                                    sprintf("%s ".$t->_("data_points"), $app->dp)
                                );
                            } ?>
                            <li class="connect_a_new_app_li">
                                <?=modal_anchor('<div class="img-icon-and-text-wrapp"><img src="'.$this->url->get('images/connect_a_new_app_hd_icon.png').'"><span class="normal-text">Connect a new app</span></div>', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'btn connectapp', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                            </li>
                        </ul>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="invited" aria-labelledby="invited-tab">
                        <ul class="application-list">
                            <?php foreach ($invitedApps as $app) {
                                $keySearched = array_search($app['id'], $dataPointsCountProcessed);
                                if ($keySearched !== false) { $app['dp'] = $dataPointsCountProcessed[$keySearched+1]; }
                                else { $app['dp'] = 0; }
                                printf('
                                    <li class="app-list">
                                        <a href="%s"><img src="%s"></a>
                                        <h5>%s</h5>
                                        <span>%s</span>
                                    </li>
                                    ',
                                    $this->url->get('application/'.$app['id']),
                                    $this->url->get($app['thumbnail']),
                                    ucfirst($app['app_title']),
                                    sprintf("%s ".$t->_("data_points"), $app['dp'])
                                );
                            } ?>
                            <li class="connect_a_new_app_li">
                                <?=modal_anchor('<div class="img-icon-and-text-wrapp"><img src="'.$this->url->get('images/connect_a_new_app_hd_icon.png').'"><span class="normal-text">Connect a new app</span></div>', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'btn connectapp', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
	</div>
</section>
<?php if ($expiryDocumentation) { ?>
    <div class="documentation-tab-wrapp">
        <div class="documentation-tab-wrapp-in">
            <div class="text-wrapp">
                <h3><?=$t->_("do_you_need_help"); ?></h3>
                <h5><?=$t->_("do_you_need_help_para"); ?></h5>
            </div>
            <div class="btn-wrapp">
                <button class="btn ficha-btn text-right"><?=$t->_("documentation"); ?></button>
            </div>
            <div class="close-btn-wrapp">
                <span class="close-btn">X</span>   
            </div>
        </div>   
    </div>
<?php } ?>

<script>
    /**
     * Bootstrap Accordion header active v1.0
     * Manu Morante @unavezfui
     * Last update: 20/10/2014
     * https://codepen.io/unavezfui/pen/HibzA
     */
    (function() {
        $(".panel").on("show.bs.collapse hide.bs.collapse", function(e) {
            if (e.type=='show') { $(this).addClass('active'); }
            else { $(this).removeClass('active'); }
        });
    }).call(this);

    $(document).ready(function(){
        $(".close-btn").click(function(){
            $(".documentation-tab-wrapp").hide('1200');
        });

        $(".connectapp").click(function(){
            $("div#app-ajax-modal").addClass("connect-new-app-btn-for-model");
        });  // Setting class to popup model

        // Live search for apps
        var i = 0;
        $('.app-list').each(function(){
            $(this).attr('data-search-term', $('.app-list h5').eq(i).text().toLowerCase());
            i = i+1;
        });

        $('.searchapp').on('keyup', function(){
            var searchTerm = $(this).val().toLowerCase();
            $('.app-list').each(function(){
                if ($(this).filter('[data-search-term *= ' + searchTerm + ']').length>0 || searchTerm.length<1) { $(this).show(); }
                else { $(this).hide(); }
            });
        });
        
    });
</script>