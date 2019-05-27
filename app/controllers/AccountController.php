<?php
	use Phalcon\Mvc\View,
		Phalcon\Http\Response,
		Phalcon\Http\Request;
	class AccountController extends ControllerBase
	{
	    public function initialize(){
	        $this->tag->setTitle('Account Settings');
	        parent::initialize();
	    }

	    public function indexAction(){ 
			$auth=$this->session->get('auth');
			$user = Users::findFirst($auth['id']);
			$this->view->loggedInUser = $user;

        	$client = new Client();
        	$country = new Country();
        	
        	$_country_code=$this->view->countries=$country->get_phonecode();
        	$_country_code=array_map(function($value){
        			return $value->phonecode;
        		}, $_country_code);

        	$this->view->client_details = $client->get_one($this->login_user->id);
        	$this->view->country_code = array_unique($_country_code);
		}

	    public function accountdataAction(){
			$this->view->disable();

	    	$request = new Request();
	    	$response = new Response();
	    	$userObj = $this->login_user;
	    	$res=['status'=>false];

	    	$response->setHeader("Content-Type", "application/json");

	    	if ($request->isPost() && $request->isAjax()) {
		    	$Users = new Users();
		    	$Client = new Client();

		    	$res = ['id' => $userObj->id];
		    	$id = $userObj->id;

		    	if ($request->getPost('security') == 'yes') {
		    			if($userObj->user_type=='client') {
							$Users=Users::findFirst(array(
								"(email = :email: OR username = :email:) AND password = :password: AND active = '1'",
								'bind' => ['email' => $request->getPost('email'), 'password' => sha1($request->getPost('currentpwd'))]
							));	
						} else {
							$Users=Users::findFirst(['email'=>$request->getPost('email')]);	
						}
			   					 	
						if(!$Users){
							return $response->setJsonContent(['msg'=>'You entered incorrect current password']);
						}

						$newPassword = sha1($request->getPost('confirmpwd'));

			    		$userData = [
			    				'password'	=> $newPassword,
								'fname' 	=> $request->getPost('txtFirstName'),
								'lname' 	=> $request->getPost('txtLastName'),
								'gender' 	=> $request->getPost('gender'),
								'email' 	=> $request->getPost('email'),
								'phone' 	=> '+'.$request->getPost('countrycode').'-'.$request->getPost('phone'),
							];
		    	}
		    	else {
					$userData = [
							'fname' 	=> $request->getPost('txtFirstName'),
							'lname' 	=> $request->getPost('txtLastName'),
							'gender' 	=> $request->getPost('gender'),
							'email' 	=> $request->getPost('email'),
							'phone' 	=> '+'.$request->getPost('countrycode').'-'.$request->getPost('phone'),
						];
		    	}
		    	
				$clientData = [
						'user_id'		=> $id,
						'country' 		=> $request->getPost('country'),
						'dob' 			=> $request->getPost('txtBirthday'),
						'company_name' 	=> $request->getPost('txtCompanyName'),
						'newsletter' 	=> $request->getPost('subscribe'),
					];

    			if ($Users->update_by($userData,['id'=>$id])) {
    				$this->setTranslation($dataaccountclient['language']);
	       			$res['language'] = $this->session->get('language'); 
    				$res['status']=true;
    				$res['msg'] = 'Data Updated Successfully'; 
    			}
	    		else {
	    			$res['data'] = $userData;
	    			$res['msg'] = 'Data saving error..!';
	    			$res['error'] = get_model_error($Users);
	    		}

	    		if ($Client->insert_or_update($clientData)){
		       		$res['msgC'] = 'Data Updated Successfully';
		       	}else {
	    			$res['dataC'] = $clientData;
	    			$res['msgC'] = 'Client Data saving error..!';
	    			$res['errorC'] = get_model_error($Client);
	    		}
			 	return $response->setJsonContent($res);
	        }
	        else {
				return $response->setJsonContent($res); 
	      	}
	    }
	}