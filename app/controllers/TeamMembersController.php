<?php
// use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Mvc\View,
        Phalcon\Http\Response,
        Phalcon\Http\Request;
use Phalcon\Loader;
use Phalcon\Config\Adapter\Ini as ConfigIni;
use Phalcon\Mvc\Model\Query;

    class TeamMembersController extends ControllerBase
    {

        public function initialize(){
            $this->tag->setTitle('Team Members');
            parent::initialize();
        }

        public function indexAction(){
            $auth = $this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;
                // print_r( $this->login_user->id);exit;

            $app = new App();

            if ($this->login_user->user_type == 'client') {
                $client_id = $app->get_client_id($this->login_user->id);
                $this->view->apps = $app->get_active_apps($client_id->client_id);
                // print_r($this->view->apps="test");exit;
                // $invitesQuery = "SELECT COUNT(*) as invites FROM `email_invitation` WHERE `app_id` IN (SELECT id FROM `app` WHERE `app`.`client_id`=".$client_id->client_id.")";

                // $inviteResult = $this->db->query($invitesQuery);
                // $inviteResult->setFetchMode(Phalcon\Db::FETCH_ASSOC);
                // $inviteResult = $inviteResult->fetchAll($inviteResult);

                $cookieCreatedDate = strtotime($this->login_user->created_at);
                $cookieExpiryDate = strtotime("+7 day", $cookieCreatedDate);
                $currentDate = strtotime(date("Y-m-d"));

                $dateDifference = $cookieExpiryDate - $currentDate;

                // if ($dateDifference > 0) {
                if (!$app->get_active_apps($client_id->client_id)) {
                    return $this->forward('team-members/home');
                }

                // if ((int)$inviteResult[0]['invites'] == 0) {
                // }
            }
            else {
                $this->view->apps = $app->get_active_apps();
            }

            $email_invite = new Emailinvitation();
            $this->view->email_invite =$email_invite;
        }

        public function share_appAction(){
            $request = new Request();
            $this->view->app_id =$request->getPost('app_id');
            $this->view->app_title =$request->getPost('app_title');
            $this->view->setRenderLevel(
                View::LEVEL_ACTION_VIEW
            );
        }

        public function sendemailAction(){
            $auth = $this->session->get('auth');
            $response = new Response();
            $response->setHeader("Content-Type", "application/json");
            $request = new Request();
            // print_r($request->getPost());exit;
            $email_invite = new Emailinvitation();
            $chk_invite = new EmailTemplate();
            $app = new App();
            $client_id = $app->get_client_id($auth['id']);
            $appresult = $app->get_apps($client_id->client_id,$request->getPost('app_id'));
            
            // $app->builder->from('app');
            // $app->builder->where('app.id', $request->getPost('app_id'));
            // $app->builder->where('app.client_id', $client_id->client_id);
            // $appresult= $app->get_result();
            // echo $appresult[0]->client_id;exit;
            
            $appwoner=$chk_invite->chkwoner($appresult[0]->client_id,$request->getPost('shareemail'));
            // echo "<pre>";print_r($appwoner);echo "</pre>";exit;
            if(!empty($appwoner)){
                return $response->setJsonContent('Can not invite to app woner..!!');
                // echo "if";exit;
            }else{
                // echo "else";exit;
            $email_invite->builder->select('email_invitation.email');
            $email_invite->builder->from("email_invitation");
            $email_invite->builder->where('email_invitation.email', $request->getPost('shareemail'));
            $email_invite->builder->where('email_invitation.app_id', $request->getPost('app_id'));

            $emailInviteDetails = $email_invite->get_result();
            if ($emailInviteDetails) {
                return $response->setJsonContent('Invitation for this email exists..!!');
            }
            // print_r($auth['id']);exit;
            $email_invite->name = $request->getPost('sharename');
            $email_invite->email = $request->getPost('shareemail');
            $email_invite->app_id = $request->getPost('app_id');
            $email_invite->superuid = $auth['id'];
            $email_invite->permission_list = json_encode($request->getPost('permissionsChecked'));

            if($email_invite->save() == false) {
                foreach ($email_invite->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
            else {
                $inviteid=$email_invite->id;          
            }          
           
            $config = new ConfigIni("../app/config/config.ini");
            $mail= $this->mailer;

            $variables = array();

            $variables['user_name'] = $request->getPost('sharename');
            $variables['url_conform'] = $this->url->get('application/').$request->getPost('app_id').'/'.$inviteid;
            $variables['email_from'] = $config->mail->from_name;

            $template = file_get_contents("../app/views/team-members/invitation.html");

            foreach($variables as $key => $value) {
                $template = str_replace($key, $value, $template);
            }

            $mail->isSMTP();
            $mail->setFrom($config->mail->from_email, $config->mail->from_name); 
            $mail->addAddress($request->getPost('shareemail'), $request->getPost('sharename'));
            $mail->Subject = 'Invitation from ficha app';
            $mail->msgHTML($template);

            if (!$mail->send()) {
                echo "Mailer Error: " . $mail->ErrorInfo;
            }
            else{
                return $response->setJsonContent('Invitation sent successfully..!!');
            }
          }
        }

        public function homeAction(){
            $auth = $this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;
            
        }

        public function deleteInviteeAction(){
            $request = new Request();
            $response = new Response();
            
            $response->setHeader("Content-Type", "application/json");
            
            $invitee_id = $request->getPost('id');
            
            $emailInviteeData = Emailinvitation::findFirst($invitee_id);

            if ($emailInviteeData !== false) {
                if ($emailInviteeData->delete() === false) {
                    echo "Sorry, we can't delete the emailInviteeData right now: \n";

                    $messages = $emailInviteeData->getMessages();

                    foreach ($messages as $message) {
                        echo $message, "\n";
                    }

                    $res['status'] = true;
                    $res['msg'] = 'Error occurred while removing invitee.';
                    return $response->setJsonContent($res);
                }
                else {
                    $res['status'] = true;
                    $res['msg'] = 'Invitee removed successfully from this application.';
                    return $response->setJsonContent($res);
                }
            }
        }


        public function editInviteeAction(){
            $request = new Request();
            $response = new Response();
            
            $response->setHeader("Content-Type", "application/json");
            
            $invitee_id = $request->getPost('id');
            $formdata = $request->getPost('formdata');
            parse_str($formdata, $searcharray);
            $permission=json_encode($searcharray['permission']);
            // print_r(implode(',',$formdata));exit;
            $emailInviteeData = Emailinvitation::findFirst($invitee_id);
            $emailInviteeData->permission_list=$permission;

            if ($emailInviteeData !== false) {
                if ($emailInviteeData->save() === false) {
                    echo "Sorry, we can't update the emailInviteeData right now: \n";

                    $messages = $emailInviteeData->getMessages();

                    foreach ($messages as $message) {
                        echo $message, "\n";
                    }

                    $res['status'] = true;
                    $res['msg'] = 'Error occurred while updating invitee.';
                    return $response->setJsonContent($res);
                }
                else {
                    $res['status'] = true;
                    $res['msg'] = 'Invitee update successfully from this application.';
                    return $response->setJsonContent($res);
                }
            }
        }


    }