<?php
	date_default_timezone_set('Asia/Calcutta');
	use Phalcon\Http\Response;
	use	Phalcon\Http\Request;
	use	Phalcon\Mvc\Micro;
	use	Phalcon\Db\Column;   

	define("APP_PATH", __DIR__ . '/../');
	include 'vendor/autoload.php';
	//include helper function
	include __DIR__ . '/../app/helper/model.php';

	use NumPHP\Core\NumArray;
	use NumPHP\LinAlg\LinAlg;

	$app = new Micro();
	$loader = new \Phalcon\Loader(); // Use Loader() to autoload our model

	$loader->registerDirs(array(__DIR__ . '/../app/models/',))->register();

	$di = new \Phalcon\DI\FactoryDefault();

	//Set up the database service
	$_ip = $app->request->getClientAddress();

	if($_ip == '::1') {
		// local database
		$di->set('db', function(){
			return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
				"host" => "localhost",
				"username" => "root",
				"password" => "",
				"dbname" => "fichappc_InVenture"
			));
		});
	}
	else {
		// Server database
		$di->set('db', function(){
			return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
				"host" => "localhost",
				"username" => "fichappc",
				"password" => "Moroni2012.",
				"dbname" => "fichappc_InVenture_v2"
			));
		});
	}

	$di->set('config', function() {
		return new \Phalcon\Config\Adapter\Ini("./config/config.ini");
	});

	$app = new \Phalcon\Mvc\Micro($di);	//Create and bind the DI to the application
	$response = new Response();
	
	
	$response->setHeader("Content-Type", "application/json");	//set default response as json format

	//set error handler
	//set_error_handler("customError");
	/******************************************* API CALLS ************************************************************/
	
	$app->post('/user/register', function() use ($app,$response) {
		$request = new Request();
		// try{
	    $result= $app->request->getPost("api_key");
	    // echo "<pre>";var_dump($result);
		// }   
		// catch(Exception $e){
		// var_dump($e->getMessage());
		// echo " Line=".$e->getLine(), "\n";exit;
		// }
	    $app_user=new Appuser();
	    $api_key=$app->request->getPost('api_key');
	    // echo $_REQUEST['api_key'];
	    // echo "<pre>";var_dump($api_key);exit;

	    $api_key_result = App::findFirstByApi_key($api_key);

	    if (!$api_key) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }
	    elseif (!$app->request->getPost('api_key')) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }

	    if($api_key != $api_key_result->api_key){ return $response->setJsonContent(['status' => false,'msg' => 'API key not matched']); }

	    // $appresults = Appuser::findFirst(array("device_id = :device_id: AND app_id = :app_id:", 'bind' => array('device_id' => $app->request->getQuery('device_id'),'app_id' => $app->request->getQuery('app_id')) ));
	    $appresults = Appuser::findFirst(array("device_id = :device_id:", 'bind' => array('device_id' => $app->request->getPost('device_id')) ));

        if ($appresults) {
        	$updatearr = array(
    			"app_id"	=> 	$app->request->getPost('app_id'),
    			"device_id"	=> 	$appresults->device_id,
    			"dob"		=> 	$app->request->getPost('dob'),
    			"gender"	=> 	$app->request->getPost('gender'),
    			"email"		=> 	$app->request->getPost('email'),
    			"phone"		=> 	$app->request->getPost('phone'),
            );

			// $_is_save = $appresults->save($updatearr);
			if($appresults->save($updatearr)){
			$appdata = App::findFirst($appresults->app_id);
				$appdata->active=1;
				if ($appdata->save() === false) {
                    // echo "Sorry, we can't update the right now: \n";
                    return $response->setJsonContent(['status'=>true, 'msg'=>'Sorry, we can`t update the right now:']);
                    $messages = $appdata->getMessages();

                    foreach ($messages as $message) {
                        echo $message, "\n";
                    }

                    // $res['status'] = true;
                    // $res['msg'] = 'Error occurred while updating.';
                    // return $response->setJsonContent($res);
                }
                return $response->setJsonContent(['status'=>true, 'msg'=>'Registration successful', 'data'=>['app_user_id'=>$appresults->id]]);
              }
			
        }
        else{
		    $_insert= array(
				'app_id'    => $app->request->getPost('app_id'),
				'device_id' => $app->request->getPost('device_id'),
				'dob'       => $app->request->getPost('dob'),
				'gender'    => $app->request->getPost('gender'),
				'email'     => $app->request->getPost('email'),
				'phone'     => $app->request->getPost('phone'),
		    );
	    // echo "<pre>";var_dump($_insert);exit;

		    if($app_user->save($_insert)) {
		    	/////////////////
		    	// echo $app_user->app_id;exit;
				$appdata = App::findFirst($app_user->app_id);
				$appdata->active=1;
				if ($appdata->save() === false) {
                    // echo "Sorry, we can`t update the right now: \n";
                    return $response->setJsonContent(['status'=>true, 'msg'=>'Sorry, we can`t update the right now:']);
                    $messages = $appdata->getMessages();

                    foreach ($messages as $message) {
                        echo $message, "\n";
                    }

                    // $res['status'] = true;
                    // $res['msg'] = 'Error occurred while updating.';
                    // return $response->setJsonContent($res);
                }
    //             else {
    //                 // $res['status'] = true;
    //                 // $res['msg'] = 'Invitee update successfully from this application.';
    //                 // return $response->setJsonContent($res);
				// return $response->setJsonContent( ['status'=>true, 'msg'=>'Welcome', 'data'=>['app_user_id'=>$appresults->id]] );
    //             }
				
			
		    	/////////////////
				return $response->setJsonContent(['status'=>true, 'msg'=>'Registration successful', 'data'=>['app_user_id'=>$app_user->id]]); 
		    }
		    else { return $response->setJsonContent(['status' => false, 'msg' => 'data not save', 'error' => get_model_error($app_user)]); }
        }
	});




	$app->post('/user/location/save', function() use ($app,$response) {
	    $api_key = $app->request->getPost('api_key');
	    $api_key_result = App::findFirstByApi_key($api_key);

	    if (!$api_key) {
			return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']);
	    }
	    elseif (!$app->request->getPost('api_key')) {
			return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']);
	    }

	    if($api_key != $api_key_result->api_key){
			return $response->setJsonContent(['status' => false,'msg' => 'API key not matched']);
	    }

	    $user_loc = new AppuserLocation();
	    $user_city = new City();

	    $_lat = $app->request->getPost('lat');
	    $_long = $app->request->getPost('long');
	    $app_user_id = $app->request->getPost('app_user_id');

	    $city_data = $user_city->get_city_id($_lat, $_long);

	    $city_db_result = City::findFirstByName($city_data);

	    if ($city_db_result->id) {
			$city_id = $city_db_result->id;
	    }
	    else {
			$cityData = (explode(', ', $city_data));
			$cityDataSize = (sizeof($cityData));
			$cntrydata = $user_city->getCountryData(($cityData[$cityDataSize-1]));

			$user_city->name = $cityData[$cityDataSize-2];
			$user_city->country = $cntrydata->iso;
			$user_city->latitude = $_lat;
			$user_city->longitude = $_long;

			if ($user_city->save()) {
				$city_id = $user_city->id;
			}
			else {
				// echo "Umh, We can't store robots right now: \n";
				return $response->setJsonContent(['status'=>true, 'msg'=>'Umh, We can`t store robots right now: \n']);
				$messages = $user_city->getMessages();
				foreach ($messages as $message) { echo $message, "\n"; }
			}
	    }

	    $_insert_loc= array(
			'lat'         => $_lat,
			'long'        => $_long,
			'app_user_id' => $app_user_id,
			'city_id'     => $city_id,
			'created_at'  => date("Y-m-d H:i:s"),
	    );
	    
	    if($user_loc->save($_insert_loc)) {
			return $response->setJsonContent(['status'=>true,'msg'=>'User location save','data'=>['inserted_id'=>$user_loc->id]]);
	    }
	    else {
			return $response->setJsonContent(['status' => false,'msg' => 'User location not save','error' => get_model_error($user_loc)]);
	    }
	});

	$app->post('/user/installed_app/save', function() use ($app,$response) {
		$api_key = $app->request->getPost('api_key');
		$api_key_result = App::findFirstByApi_key($api_key);

		if (!$api_key) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }
		elseif (!$app->request->getPost('api_key')) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }

		if($api_key != $api_key_result->api_key){ return $response->setJsonContent(['status' => false,'msg' => 'API key not matched']); }
		
		$app_user_id    = $app->request->getPost('app_user_id');
		$installed_app  = $app->request->getPost('installed_app');
		$installed_app_model  = new InstalledApp();
		$_insert = array();

		$ch = str_replace(']',"", str_replace('[',"", str_replace('"',"", $app->request->getPost('installed_app'))));
		$ch = explode(',', $ch);

		foreach ($ch as $value) {
			$_insert[]=array(
				'app_user_id' => $app_user_id, 
				'app_name'    => $value, 
			);
		}

		$is_insert=$installed_app_model->insert_batch($_insert);

		if($is_insert) { return $response->setJsonContent(['status' => true,'msg'=>'installed application saved','data'=>['user_id'=>$app_user_id]]);  }
		else { return $response->setJsonContent(['status' => false,'msg' => 'installed application not saved','error' => get_model_error($installed_app_model)]); }
	});

	$app->post('/user/stats/save', function() use ($app,$response) {
		$api_key = $app->request->getPost('api_key');
		$api_key_result = App::findFirstByApi_key($api_key);

		if (!$api_key) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }
		elseif (!$app->request->getPost('api_key')) { return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']); }

		if($api_key != $api_key_result->api_key){ return $response->setJsonContent(['status' => false,'msg' => 'API key not matched']); }
   
		/*
			* Code for Price calculator
			* Code by Akash Bhiwgade at Webgile solutions
			* the below code uses functions from /public_html/dev/app/helper/model.php
			* Two input arrays are used as specified by client and they are passed to function to get the equation (X'X)^(-1)X'Y
			* The output yielded by the above equation is put in the formula (B_0 + B_1*sam + B_2*ss) to get the price for the mobile brands
		*/

		$threeByThreeInput = Array(
			Array(1, 1, 4),
			Array(1, 0, 5),
			Array(1, 1, 6)
		);

		$threeByOneInput = Array(
			Array(500),
			Array(600),
			Array(200)
		);

		$priceEstimate = multiplyThreeByThreeWithThreeByOneArray(multiplyThreeByThreeArray(inverseThreeByThreeArray(multiplyThreeByThreeArray(transposeArray($threeByThreeInput), $threeByThreeInput)), transposeArray($threeByThreeInput)), $threeByOneInput);  // (X'X)^(-1)X'Y

		/*
			* The above statement can also be written as below
			* $transposeReturned = transposeArray($threeByThreeInput); // X'
			* $multipliedThreebyThreeReturned = multiplyThreeByThreeArray($transposeReturned, $threeByThreeInput);  // X'X
			* $inverseReturned = inverseThreeByThreeArray($multipliedThreebyThreeReturned);  // (X'X)^(-1)
			* $multipliedThreebyThreeReturned2 = multiplyThreeByThreeArray($inverseReturned, $transposeReturned);  // (X'X)^(-1)X'
			* $priceEstimate = multiplyThreeByThreeWithThreeByOneArray(multipliedThreebyThreeReturned2, $threeByOneInput); // (X'X)^(-1)X'Y
		*/
    
		$mobileBrand = 1;
		$screenSize = 5;
		$price = $priceEstimate[0][0] + ($priceEstimate[1][0]*$mobileBrand) + ($priceEstimate[2][0]*$screenSize);  // (B_0 + B_1*sam + B_2*ss)

		/** end of price calculator code */

		$os_version = $app->request->getPost('os_version');
		$battery_stat = $app->request->getPost('battery_stat');
		
		$imei=$app->request->getPost('imei');
		if(!$imei){
			return $response->setJsonContent(['status'=>false,'msg' => 'data not save','error' => ['imei'=>'imei number is required']]);
		}
		if(!validateImei($imei)){
			return $response->setJsonContent(['status'=>false,'msg' => 'data not save','error' => ['imei'=>'invalid imei number']]);
		}

		$user_stats=new AppuserStats();
		$MobileMaker= new MobileMaker();
		
		$maker_id = $MobileMaker->get_maker_id($app->request->getPost('manufacturer'));

		$_insert= array(
			'app_user_id' 			=> 	$app->request->getPost('app_user_id'),
			'model_name' 			=> 	$app->request->getPost('model_name'),
			'model_number' 			=> 	$app->request->getPost('model_number'),
			'price' 				=> 	$price,
			'ram' 					=> 	$app->request->getPost('ram'),
			'screen_dimension' 		=> 	$app->request->getPost('screen_dimension'),
			'screen_resolution' 	=> 	$app->request->getPost('screen_resolution'),
			'screen_size' 			=> 	$app->request->getPost('screen_size'),
			'network' 				=> 	$app->request->getPost('network'),
			'no_of_contacts' 		=> 	$app->request->getPost('no_of_contacts'),
			'maker' 				=> 	$maker_id,
			'average_call_per_day' 	=> 	$app->request->getPost('average_call_per_day'),
			'average_sms_per_day' 	=> 	$app->request->getPost('average_sms_per_day'),
			'total_disc_space' 		=> 	$app->request->getPost('total_disc_space'),
			'used_disc_space' 		=> 	$app->request->getPost('used_disc_space'),
			'battery_remaining' 	=> 	$app->request->getPost('battery_remaining'),
			'lat' 					=> 	$app->request->getPost('lat'),
			'long' 					=> 	$app->request->getPost('long'),
			'stats_updated_time' 	=> 	$app->request->getPost('stats_updated_time'),
			'imei' 					=> 	$imei,
			'ip' 					=> 	$app->request->getClientAddress(),
			'os_version' 			=> 	$os_version,
			'battery_stat' 			=> 	$battery_stat,
		);
		if($user_stats->insert_or_update($_insert)) {
			return $response->setJsonContent(['status'=>true,'msg'=>'data saved','data'=>['user_id'=>$app->request->getPost('app_user_id')]]); 
		}
		else { return $response->setJsonContent(['status' => false,'msg' => 'data not save','error' => get_model_error($user_stats)]); }
	});

	$app->get('/user/get', function() use ($app,$response) {
		$api_key = $app->request->get('api_key');

		// if (!$api_key) {
		//   return $response->setJsonContent(['status'=>false,'msg'=>'Please provide api_key','data'=>$app->request->get()]);
		// }
		// elseif (!$app->request->getPost('api_key')) {
		//   return $response->setJsonContent(['status' => false,'msg' => 'Please provide API key']);
		// }

		$api_key_result = App::findFirstByApi_key($api_key);

		if($api_key != $api_key_result->api_key){ return $response->setJsonContent(['status' => false,'msg' => 'API key not matched']); }

		$email= $app->request->get('email');
		$id = $app->request->get('id');
		$device_id = $app->request->get('device_id');
		
		if($email || $id || $device_id) {
			$app_user=new Appuser();
			$response->setJsonContent(['status'=>true,'data'=>$app_user->get_one($app->request->get())]); 
		}
		else { $response->setJsonContent(['status'=>false,'msg'=>'please provide user\'s device_id or id','data'=>$app->request->get()]);  }
		return $response;
	});

	$app->notFound(function () use ($app) {
		$app->response->setStatusCode(404, "Not Found")->sendHeaders();
		echo 'Page not found!';
	});

	$app->handle();
?>