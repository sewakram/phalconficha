{{ content() }}
<section class="application-wrapper">
    <div class="applicationheadtab">
        <div class="app-header row plain-color">
            <div class="col-xs-12 col-sm-8 col-md-8">
                <h1 class="app-title"><?=$t->_("team_members"); ?></h1>
                <h5 class="app-desc"><?=$t->_("team_member_sub_heading"); ?></h5>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 main-app-point">
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
    </div>
    <div class="clearfix"></div>
    <div class="row">
        <div class="col-sm-6 col-md-12 team-member-container-wrap">
            <div class="container team-container team-member-container">
                <div class="table-responsive">
                <table id="invite_apps" class="display" style="width:100%">
                <tbody>
                    <?php
                        foreach ($apps as $app) { ?>
                            <tr>
                                <th>
                                    <img src="<?php echo $this->url->get($app->thumbnail)?>" class="img_icon">
                                    <span class="live-search"><?php echo $app->app_title; ?></span>

                                    <?=modal_anchor('<span class="btn ficha-btn team-mob-btn"><span class="glyphicon glyphicon-plus"></span> Invite to this application</span>', ['url' => $this->url->get('team-members/share_app/'.$app->id), 'class'=> 'pull-right inviteapp', 'data-post-variable' =>'share_app_app', 'data-post-app_id' =>$app->id, 'data-post-app_title' =>$app->app_title, 'data-title'=>'Add a new Member']);?>
                                      <div class="col-md-12 team-separator-head"></div>
                                </th>
                            </tr>
                            <tr>
                                <td class="live-search">
                                    
                                    <?php 
                                        $email_invite->builder->select('email_invitation.id, email_invitation.name, email_invitation.email, email_invitation.permission_list, email_invitation.status');
                                        $email_invite->builder->from("email_invitation");
                                        $email_invite->builder->where('email_invitation.app_id',$app->id);  
                                        $email_invite->builder->order_by("email_invitation.id","DESC");
                                        // $email_invite->builder->limit(3);
                                        $data= $email_invite->get_result();
                                        
                                        for ($i=0; $i < sizeof($data); $i++) { ?>
                                            <form method="post" id="<?=$data[$i]->id;?>" action="">
                                            <div class="<?='member-wrapper member-wrapper-identifier'.$data[$i]->id;?>">
                                                <div class="col-md-3 user-name"><span><?=$data[$i]->name;?></span></div>
                                                <span class="close-wrapp-mob visible-xs"><i data-post-invitee-id="<?=$data[$i]->id;?>" class="material-icons remove-invitee pull-right">close</i></span>
                                              
                                                <div class="clearfix hidden-xs" ></div>                                        
                                                <?php
                                                    $per = json_decode($data[$i]->permission_list);
                                                    ?>
                                                    <div class=" team-label-wrap">
                                                        <label class="col-md-3 user-mail"><?=$data[$i]->email;?></label>
                                                         <div class="permissions-wrapper">
                                                            <span class="permission-title"><?=$t->_("permissions_for_user");?></span>
                                                            <div class="permission-checks">
                                                                <label class="checkbox-inline col-md-2 box-check container-check">
                                                                    <input type="checkbox" name="permission[]" value="application_settings" <?php if ( isset($per) && in_array("application_settings", $per)){ echo "checked";}?> >
                                                                    <span class="checkmark"></span>
                                                                    <label class="check-label"><?=$t->_("application_settings"); ?></label>
                                                                </label>
                                                                <label class="checkbox-inline col-md-2 box-check container-check">
                                                                    <input type="checkbox" name="permission[]" value="integration_key" <?php if ( isset($per) && in_array("integration_key", $per)){ echo "checked";}?> >
                                                                    <span class="checkmark"></span>
                                                                    <label class="check-label"><?=$t->_("integration_key"); ?></label>
                                                                    </label>
                                                                <label class="checkbox-inline col-md-3 box-check container-check">
                                                                    <input type="checkbox" name="permission[]" value="generate_and_export_reports" <?php if ( isset($per) && in_array("generate_and_export_reports", $per)){ echo "checked";}?> >
                                                                    <span class="checkmark"></span>
                                                                     <label class="check-label"><?=$t->_("generate_export_reports"); ?></label>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <span class="close-wrapp hidden-xs"><i data-post-invitee-id="<?=$data[$i]->id;?>" class="material-icons remove-invitee pull-right">close</i></span>
                                                <?php
                                                if (isset($data[$i]->status) && ($data[$i]->status == 1)) { ?>
                                                    <div class="col-md-3 active-btn-wrap">
                                                        <button class="btn btn-default btn-sm active-user-btn"><span><?=$t->_("active_user");?></span></button>
                                                    </div> <?php
                                                }
                                                elseif (isset($data[$i]->status) && ($data[$i]->status == 0)) { ?>
                                                    <div class="col-md-3 active-btn-wrap">
                                                        <button class="btn btn-default btn-sm active inactive-user-btn"><?=$t->_("waiting_to_accept_invitation");?></button>
                                                    </div> <?php
                                                }
                                                echo '<div class="clearfix"></div>';
                                                echo '<div class="col-md-12 team-separator"></div>';
                                            echo '</div>';
                                            echo'</form>';
                                        }
                                    ?>
                                
                                </td>
                            </tr>
                            <div class="clearfix"></div> <?php
                        }
                    ?>
                </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(document).ready(function(){
        $(".inviteapp").click(function(){ $("div#app-ajax-modal").addClass("connect-new-app-btn-for-model"); });
       
        $('#invite_apps_filter input[type="search"]').attr("class", "form-control");
               
        $(".connectapp").click(function(){ $("div#app-ajax-modal").addClass("connect-new-app-btn-for-model"); }); // Setting class to popup model

        $('.remove-invitee').click(function (e) {
            e.preventDefault();
            var divToBeRemoved = '.member-wrapper-identifier'+$(this).attr('data-post-invitee-id');
            $.ajax({
                type  :  'post',
                url   :  '<?php echo $this->url->get('team-members/deleteInvitee'); ?>',    
                data  :  { id : $(this).attr('data-post-invitee-id'), },
                dataType: 'json',
                success: function (response) {
                    $(divToBeRemoved).animate({height:0, opacity: 0}, 2000, function(){ $(divToBeRemoved).hide(); } );
                    $().toastmessage('showToast', {
                        text     : response.msg,
                        sticky   : false,
                        position : 'bottom-right',
                        type     : 'success',
                        closeText: ''
                    });
                }               
            });
        });

        ////////////////////
            $('.permission-checks input').change(function (e) {
                var x = $(this).parents('form').serialize();
                console.log("sewak",x);
            // e.preventDefault();
            // var divToBeRemoved = '.member-wrapper-identifier'+$(this).attr('data-post-invitee-id');
            $.ajax({
            type  :  'post',
            url   :  '<?php echo $this->url->get('team-members/editInvitee'); ?>',    
            data  :  { id : $(this).parents('form').attr('id'),formdata:x, },
            dataType: 'json',
            success: function (response) {
                console.log('hi sewak')
            // $(divToBeRemoved).animate({height:0, opacity: 0}, 2000, function(){ $(divToBeRemoved).hide(); } );
            // $().toastmessage('showToast', {
            // text     : response.msg,
            // sticky   : false,
            // position : 'bottom-right',
            // type     : 'success',
            // closeText: ''
            // });
            }               
            });
            });
        ////////////////////
    });
</script>