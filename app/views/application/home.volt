{{ content() }}

<section class="application-wrapper">
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
                                <span class="user-img-wrapp"><img class="profile-icon" src="/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png" /></span>
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
                    <div class="button_and_input_wrapp">
                        <input class="searchapp col-sm-4" type="text" name="searchapp" placeholder="<?=$t->_("search_app_placeholder"); ?>">
                        <?=modal_anchor($t->_('connect_application').'', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'connect-app-btn btn ficha-btn connectapp col-sm-4', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                    </div>                    
                </div>
            </div>
        </div>
	</div>
    <div>
        <section class="application-wrapper">
            <div  class="blank">
                <p><?= $t->_("no_applications_yet");?></p>
                <span><?= $t->_("no_applications_yet_para");?></span>
                <!-- <button type="submit" class="btn ficha-btn center-block"> -->
                    <?=modal_anchor($t->_('connect_application').'<i class="material-icons arrow-right">arrow_forward</i>', ['url' => $this->url->get('application/connect_new_app'), 'class'=> 'connect-app-btn btn ficha-btn connectapp ', 'data-post-variable' =>'connect_new_app', 'data-post-app_id' =>'id', 'data-title'=>'Connect a new application']);?>
                <!-- </button> -->
            </div>
        </section>
    </div>
    <section class="application-wrapper image-bg">
        <img class="center-block" src="/images/ficha/application-empty.png">
    </section>
</section>