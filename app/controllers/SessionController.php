<?php
use Phalcon\Http\Response,
    Phalcon\Http\Request;
class SessionController extends ControllerBase{
    public function initialize(){
        $this->tag->setTitle('Sign Up/Sign In');
        $this->view->body_class='body-login';
        parent::initialize();
    }

    public function indexAction() {
        $request = new Request();
        $activeid=$this->dispatcher->getParam('activeid');
        $userdata = Users::findFirst($activeid);
        $expiry_date=date('Y-m-d H:i:s', strtotime($userdata->created_at. ' + 2 days'));
        $this->view->expiry_date=$expiry_date;
        if($activeid) {
            if(!empty($activeid) && (strtotime($expiry_date) > strtotime(date('Y-m-d H:i:s')))) {
                $active=$this->activate($activeid); 
                //$this->flash->success('Welcome');
            }
            // if(strtotime($expiry_date) < strtotime(date('Y-m-d H:i:s'))){
                //return $response->setJsonContent(['status'=>true,'msg'=>"Your activation link is expired!"]);
                // $this->flash->error('Your activation link is expired');
            // }
        }
        $auth=$this->session->get('auth');
        if($auth) {
            $response = new Response();
            return $this->response->redirect($this->url->get('dashboard/index'), true);
        }
        $this->view->reset_password=false;
        $this->view->redirect= $this->request->get('redirect');
        if (!$this->request->isPost()) {
            // $this->tag->setDefault('email', 'demo@phalconphp.com');
            //$this->tag->setDefault('password', 'phalcon');
        }
    }

    private function _registerSession(Users $user){
        $this->session->set('auth', array( 'id' => $user->id, 'name' => $user->fname ));
    }

    public function startAction(){
        if ($this->request->isPost()) {
            if ($this->request->isAjax()) {
                $response = new Response();
                $response->setHeader("Content-Type", "application/json");
                $email = $this->request->getPost('email');
                $password = $this->request->getPost('password');
                $user = Users::findFirst(array(
                    // "(email = :email: OR username = :email:) AND password = :password: AND active = '1'",
                    "email = :email: AND password = :password: AND active = '1'",
                    'bind' => array('email' => $email, 'password' => sha1($password))
                ));
                if ($user != false) {
                    $_redirect = $this->request->getPost('redirect');
                    $_redirect = ($_redirect) ? $_redirect : $this->url->get('dashboard/index');
                    if($user->password != sha1($password)){ return $response->setJsonContent(['status'=>false,'form_error' => ['password' => 'Wrong password !']]); }
                    $this->_registerSession($user);
                    return $response->setJsonContent(['status'=>true,'msg'=>"Login Successful !",'redirect'=>$_redirect]); 
                    // if ($_redirect) { return $this->response->redirect($_redirect, true); }
                    // return $this->forward('dashboard/index');
                    // $this->flash->error('Wrong email/password');
                } else { return $response->setJsonContent(['status'=>false,'form_error' => ['email' => 'Invalid credentials']]); }
            } else { return $this->forward('session/index'); }
        }
    }

    public function endAction(){
        $this->session->remove('auth');
        $response = new Response();
        return $this->response->redirect($this->url->get(''), true);
    }

    function activate($inviteid) {
        $invitee = Users::findFirstById($inviteid);
        if (!$invitee) {
            $this->flash->error("Invitee was not found");
            return $this->dispatcher->forward( [ "controller" => "session" ] );
        }
        $invitee->active=1;
        if ($invitee->save() == false) {
            foreach ($invitee->getMessages() as $message) {
                $this->flash->error($message);
                return $this->dispatcher->forward( [ "controller" => "session" ] );
            }
        }
    }

    public function registerAction(){
    }

    public function forgotAction(){
    }
}