<?php

class AboutController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('About us');
        parent::initialize();
    }

    public function indexAction()
    {
    	try {
	    	$email='test@domain.com';
	    	$App_user=new Appuser();
				$_app_user = $App_user->get(true);
				// $_app_user = $App_user->findFirst(array(
				//     "email = :email:",
				//     'bind' => array('email' => $email)
				// ));
				echo "<pre>";
				print_r($_app_user);
				foreach ($_app_user as $user) {
					// echo ;
					printf("name : %s , lat : %s , Long : %s <br />",$user->name,$user->lat,$user->long);
					# code...
				}
				die();
			}catch (Exception $e) {
			    // duplicate entry exception
			    echo $e->getMessage();
			    die();
			}
    }
}
