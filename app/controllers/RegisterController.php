<?php
    use Phalcon\Http\Response;
    use Phalcon\Http\Request;
    use Phalcon\Config\Adapter\Ini as ConfigIni;

    class RegisterController extends ControllerBase {
        public function initialize() {
            $this->tag->setTitle('Sign Up/Sign In');
            $this->view->body_class='body-login';
            parent::initialize();
        }

        public function indexAction(){
            $form = new RegisterForm;
            if ($this->request->isPost()) {
                if ($this->request->isAjax()){
                    try {
                        $response = new Response();
                        $response->setHeader("Content-Type", "application/json");
                        $name = $this->request->getPost('name');
                        // $lname = $this->request->getPost('lastname');
                        $email = $this->request->getPost('email', 'email');
                        $password = $this->request->getPost('password');
                        $repeatPassword = $this->request->getPost('repeatPassword');

                        $_post_data = $this->request->getPost();
                        if (!$form->isValid($_post_data)) { return $response->setJsonContent(['status'=>false,'form_error' => get_form_error($form)]); }
            
                        if ($password != $repeatPassword) { return $response->setJsonContent(['status'=>false,'form_error' => ['repeatPassword' => 'Password not match!']]); }
                  
                        $activeuserexist = Users::findFirst(array(
                            "email = :email: AND active = '1'",
                            'bind' => array('email' => $email)
                        ));

                        if($activeuserexist == true) { return $response->setJsonContent(['msg'=>'Email address already exist!','emailalert'=>'email']); }

                        $userexist = Users::findFirst(array(
                            "email = :email: AND active = '0'",
                            'bind' => array('email' => $email)
                        ));

                        $user_id = $userexist->id;
                        $clientexist = Client::findFirst("user_id='".$userexist->id."'");
                        
                        if (($userexist == true) && ($clientexist == true)){
                            $expiry_date=date('Y-m-d H:i:s', strtotime($userexist->created_at. ' + 2 days'));
                            
                            if(strtotime($expiry_date) < strtotime(date('Y-m-d H:i:s'))){
                            
                                if (!$userexist->delete()) { 
                                    foreach ($productss->getMessages() as $message) {
                                        $this->flash->error($message);
                                    }
                                    return $this->dispatcher->forward([ "controller" => "session", "action" => "index", ]);
                                }

                                if (!$clientexist->delete()) { 
                                    foreach ($productss->getMessages() as $message) {
                                        $this->flash->error($message);
                                    }
                                    return $this->dispatcher->forward([ "controller" => "session", "action" => "index", ]);
                                }
                            }
                        }
                        
                        $user = new Users();
                        $client = new Client();
                        $subscriptions = new Subscriptions();
                        
                        $user->password = sha1($password);
                        $user->fname = $name;
                        // $user->lname = $lname;
                        $user->email = $email;
                        
                        $user->created_at = new Phalcon\Db\RawValue('now()');
                        
                        $user->active = '0';
                        $user->user_type = 'client';
                        
                        if ($user->save() == false) {
                            return $response->setJsonContent(['status'=>false,'form_error'=>get_model_error($user),'msg'=>"Data not Saved."]);
                        }
                        else {
                            $client->user_id = $user->id;
                            if ($client->save() == true){
                                
                                $subscriptions->client_id = $client->id;
                                if ($subscriptions->save() == false) {
                                    return $response->setJsonContent(['status'=>false,'form_error'=>get_model_error($user),'msg'=>"Failed to add subscription plan"]);
                                }

                                $config = new ConfigIni("../app/config/config.ini");
                                $mail= $this->mailer;
                                $variables = array();
                                $variables['user_name'] = ucfirst($name);
                                $variables['url_conform'] = $this->url->get('session').'/'.$user->id;
                                $variables['email_from'] = $config->mail->from_name;

                                $template = file_get_contents("../app/views/register/register.html");

                                foreach($variables as $key => $value) {
                                    $template = str_replace($key, $value, $template);
                                }

                                $mail->isSMTP();
                                $mail->setFrom($config->mail->from_email, $config->mail->from_name); 
                                $mail->addAddress($email,$name);
                                $mail->Subject = 'Email verification for Ficha app';
                                $mail->msgHTML($template);
                            
                                if (!$mail->send()) {
                                    echo "Mailer Error: " . $mail->ErrorInfo; 
                                }
                                else {
                                    return $response->setJsonContent(['status'=>true, 'name'=>ucfirst($name.' '.$lname), 'msg'=>"Activation Details Sent to your registered email address"]);
                                }
                            }
                        }
                    } 
                    catch (Exception $e) {
                        echo 'Caught exception: ',  $e->getMessage(), "\n";
                        die();
                    }
                }
            }
            $this->view->form = $form;
        }

        public function reset_PasswordAction($data = false){
            $request = new Request();
            if ($this->request->isPost()) {
                if ($this->request->isAjax()){

                    
                    $response = new Response();
                    $response->setHeader("Content-Type", "application/json");
                    $response->header = new stdClass();
                    $Users = Users::findFirst(array(
                        "id = :id: AND token=:token: AND active=1",
                        'bind' => ['id'=> ($this->request->getPost('id')), 'token'=> ($this->request->getPost('token'))]
                    ));
                    $Users->password = sha1($this->request->getPost('reset_password'));
                    // try{
                    //     if ($Users->update()==true){
                    //         echo "true";
                    //     }else{
                    //         echo "false";
                    //     }

                    // }

                    // catch (Exception $e) {
                    //     echo 'Caught exception: ',  $e->getMessage(), "\n";
                    //     die();
                    // }
                    // exit;
                    if ($Users->update()==true) {
                        $res['status'] = true;
                        $res['msg']    = "Password Updated..!";
                        $res['redirect']    = $this->url->get('session/index');
                        $mail = $this->mailer;
                        $_template_val = [
                            'login_url'  => $this->url->get('session/index'),
                            'action_url' => $this->url->get('session/index'),
                            'name'       => ucfirst($Users->fname).' '.ucfirst($Users->lname),
                            'username'   => $Users->email,
                        ];
                        $template = file_get_contents("../app/views/register/reset.html");

                        foreach($_template_val as $key => $value) {
                        $template = str_replace($key, $value, $template);
                        }
                        $mail->isSMTP();
                        $mail->setFrom($Users->email, $Users->email);
                        $mail->render_template('password_update', $_template_val);
                        $mail->Subject = 'Password updated for Ficha app';
                        $mail->AddAddress($Users->email);
                        $mail->msgHTML($template);
                        if ($mail->Send()) {
                            $res['mail_msg'] = "mail Send";
                        } else {
                            $res['mail_msg']   = "mail Not Send";
                            $res['mail_error'] = $mail->ErrorInfo;
                        }
                    }
                    else { $res['error'] = get_model_error($Users); }
                    return $response->setJsonContent($res);
                }
            }

            $_token = (explode('/', $_SERVER['QUERY_STRING']));
            $decrypt=base64_decode($_token[3]);
            parse_str($decrypt, $output);
            
            if(!is_array($output)){ return $response->setJsonContent(['status'=>false,'msg'=>"Something Went Wrong!"]); }
            
            $Users = Users::findFirst(array(
                "id = :id: AND token=:token: AND active=1",
                'bind' => ['id'=>$output['id'], 'token'=>$output['token']]
            ));
            $this->view->tokens_arr = $output;
            // $this->view->token=true;
            $this->view->msg=false;            
            // if($data){
                // $decrypt=base64_decode($data);
                // parse_str($decrypt, $output);
                // $Users = Users::findFirstById($output['id']);
                // if($Users){
                    // if($Users->token==$output['token']){
                        // token match
                        // $this->view->token=true;
                        // $this->view->tokens_arr=['token'=>$data];
                    // }
                    // else{
                        // token missmatch
                        // $this->view->msg="Token Missmatch!";
                        // $this->view->token=false;
                    // }
                // }
                // else {
                    //invalid_user
                    // $this->view->msg='Invalid User';
                // }
            // }
            $this->view->reset_password=true;
            $this->view->pick("session/index");
        }

        public function forgot_PasswordAction(){
            $response = new Response();
            $response->setHeader("Content-Type", "application/json");
            // $Users = Users::findFirstByEmail(['email' => $this->request->getPost('email')]);
            $Users = Users::findFirst( [
                'email = :email: AND active = 1',
                'bind' => ['email' => $this->request->getPost('email')],
            ]);
            $str='1234567890abcdefghijklmnopqrstwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
            if($Users){
                $Users->token=md5(str_shuffle($str));
                if($Users->update()){
                    $_params=http_build_query(['email'=>$Users->email,'id'=>$Users->id,'token'=>$Users->token]);
                    $_params=base64_encode($_params);
                    $_template_val = [
                        'login_url'  => $this->url->get('register/reset_password/'.$_params),
                        'action_url' => $this->url->get('register/reset_password/'.$_params),
                        'name'       => ucfirst($Users->fname).' '.ucfirst($Users->lname),
                        'username'   => $Users->email,
                    ];
                    $mail = $this->mailer;
                    // ///////////////
                    //     $variables = array();

                    //     $variables['user_name'] = $request->getPost('sharename');
                    //     $variables['url_conform'] = $this->url->get('application/').$request->getPost('app_id').'/'.$inviteid;
                    //     $variables['email_from'] = $config->mail->from_name;

                    //     $template = file_get_contents("../app/views/team-members/invitation.html");

                    //     foreach($variables as $key => $value) {
                    //     $template = str_replace($key, $value, $template);
                    //     }
                    // ///////////////
                    $template = file_get_contents("../app/views/register/forget.html");

                        foreach($_template_val as $key => $value) {
                        $template = str_replace($key, $value, $template);
                        }
                    $mail->isSMTP();
                    $mail->setFrom($Users->email, $Users->email);    
                    // $mail->render_template('password_reset', $_template_val);
                    $mail->AddAddress($this->request->getPost('email'));
                    $mail->Subject = 'Reset password for Ficha app';
                    $mail->msgHTML($template);
                    if($mail->Send()) {
                        $res['mail_msg'] = "mail Send";
                    } else {
                        $res['mail_msg']   = "mail Not Send";
                        $res['mail_error'] = $mail->ErrorInfo;
                    }
                    $res['status']  = true;
                    $res['msg']     = 'Please check your Inbox for reset your password.';
                    return $response->setJsonContent($res);  
                }
                else{ return $response->setJsonContent(['status'=>false,'msg'=>'Something Went Wrong!','error'=>get_model_error($Users)]); }
            }
            else { return $response->setJsonContent(['status'=>true,'msg'=>'Email address not exists']); }
            return $response->setJsonContent(['status'=>true,'msg'=>'Something Went Wrong!']);
        }
    }