<?php
error_reporting(E_ALL);
error_reporting(E_ERROR | E_WARNING | E_PARSE);
    use Phalcon\Mvc\View,
        Phalcon\Http\Response,
        Phalcon\Http\Request;
    class ApplicationController extends ControllerBase {
        public function initialize(){
            $this->tag->setTitle('Application');
            parent::initialize();
        }

        public function indexAction(){
            $auth = $this->session->get('auth');
            // print_r($auth);
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;

            $app = new App();
            $request = new Request();
            $response = new Response();

            $cookieCreatedDate = strtotime($this->login_user->created_at);
            $cookieExpiryDate = strtotime("+7 day", $cookieCreatedDate);
            $currentDate = strtotime(date("Y-m-d"));

            $dataPointsCount = Appuser::find([
                'columns' => 'COUNT(*) AS count, app_id',
                'group' => 'app_id'
            ]);

            $dataPointsCountProcessed = [];

            foreach ($dataPointsCount as $key) {
                array_push($dataPointsCountProcessed, $key->app_id);
                array_push($dataPointsCountProcessed, $key->count);
            }

            $this->view->dataPointsCountProcessed = $dataPointsCountProcessed;

            /* start fo code for the documenation session expiry */
	            $dateDifference = $cookieExpiryDate - $currentDate;
	            if ($dateDifference > 0) {
	                $this->view->expiryDocumentation = true;
	            }
	            else{
	                $this->view->expiryDocumentation = false;
	            }

	            $this->view->cookieCreatedDate = $cookieCreatedDate;
	            $this->view->cookieExpiryDate = $cookieExpiryDate;
	            $this->view->currentDate = $currentDate;
            /* end of code for the documentation session expiry */

            /* start of code for Deletion of app from the single app no data page */
                if ($request->getPost('delete_app')) {
                    $app_id = $request->getPost('delete_app');//$request->getPost('applicationid');
                    $variable_result = Variable::findFirst(array( "app_id = :app_id:", 'bind' => array('app_id' => $app_id)));
                    $result = App::findFirst($app_id);
                    // echo"<pre>";print_r($result);exit;
                    if ($result !== false) {
                        if ($result->delete() === true && $variable_result->delete() === true) {
                            return $response->setJsonContent(['status'=>true, 'msg'=>"Deletion Successful !", 'redirect'=> $this->url->get('application/index')]);
                        }
                    }
                }
            /* End of code for the deletion of app from the single app no data page*/

            /* start of code for fetching the list of invited apps*/
                $appInvited = Emailinvitation::find(array( 
                    'columns' => 'app_id',
                    "user_id = :user_id: AND status = :status:", 
                    'bind' => array('user_id' => $auth['id'], 'status' => 1)
                ));
                
                $invitedAppIds = array();
                $invitedAppkeys = array();
                $test1 = array();

                foreach ($appInvited as $key /*=> $value*/) {
                    if (is_numeric($key->app_id)) {
                        $test = App::findFirst($key->app_id);
                        foreach ($test as $key2 => $value2 ){
                            if($key2 != 'builder') { 
                                array_push($invitedAppIds, $value2); 
                                array_push($invitedAppkeys, $key2); 
                            }
                        }
                        $a1 = array_combine($invitedAppkeys,$invitedAppIds);
                        array_push($test1, $a1);
                    }
                }
                /* start if code to fetch the list of the all, active and pending to be active apps */
    	            if ($this->login_user->user_type == 'client') {
                        // echo "hello";
    	                $client_id = $app->get_client_id($this->login_user->id);

    	                $resapps = $app->get_apps($client_id->client_id, false, 1);
                        $respendingApps = $app->get_apps($client_id->client_id, false, 0);

                        $resAllApps = $app->get($client_id->client_id);
                        // array_push($resAllApps, $test1);
                        $resAllAppsplus=array_merge($resAllApps,$test1);
                        // echo "<pre>";print_r($resAllAppsplus);
                        // echo "<pre>";print_r($resAllApps);exit;

                        if ($resapps || $respendingApps || $test1) {
                            $this->view->apps = $resapps;
                            $this->view->pendingApps = $respendingApps;
                            $this->view->allApps = $resAllAppsplus;
                            $this->view->invitedApps = $test1;
                        }
                        else{
                            return $this->forward('application/home');
                        }
                    }
                    else {
                        $this->view->apps = $app->get_apps();
                    }
                /* end of code for the fetching of the active and the pending to be active apps list*/
            /* end of code for fetching the list of invited apps */
        }

        public function single_appAction(){
            $request = new Request();
            $auth = $this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;

            $app_id = $this->dispatcher->getParam("app_id");
            $inviteid = $this->dispatcher->getParam('inviteid');
            $inviteedata = Emailinvitation::findFirst($inviteid);
            // print_r($this->login_user->id);exit;
            if ($this->login_user->id!=$inviteedata->superuid && !empty($inviteid))
             {
             $this->updateinvitee($inviteid, $this->login_user->id);
             }
            
            $app = new App();
            $emailinvitation = new Emailinvitation();
            
            
            $result=$app->get_one($app_id);
            $client_id = $app->get_client_id($this->login_user->id);
            // print_r($client_id);exit;
            $app_verify = App::findFirst(array( 
                "id = :id: AND client_id = :client_id:", 
                'bind' => array('id' => $app_id,'client_id'=>$client_id->client_id)
            )); 

            $appInvited = Emailinvitation::find(array( 
                'columns' => 'app_id',
                "user_id = :user_id: AND app_id = :app_id: AND status = :status:", 
                'bind' => array('user_id' => $auth['id'], 'app_id' => $app_id, 'status' => 1)
            ));
           // echo"<pre>"; print_r($appInvited->superuid);exit;
            if (!$app_verify) {
                $invit = 0;
                foreach ($appInvited as $key) {
                    $invit = ($key->app_id);
                }
                $invit = isset($key->app_id)?($key->app_id):0;

                if ($invit) {
                    if($inviteid){
                        if( !empty($inviteid) && (strtotime($inviteedata->expiry_date) > strtotime(date('Y-m-d H:i:s')) ) ){
                            $updateinvitee=$this->updateinvitee($inviteid,$auth['id']);
                            $this->flash->success('Welcome !');
                        }
                        if(strtotime($inviteedata->expiry_date) < strtotime(date('Y-m-d H:i:s'))){
                            $this->flash->error('Your activation link is expired');
                        }
                    }
                    elseif (!$inviteedata->app_id) {
                        $this->flash->error( "You don't have permission to see this app" );
                        $this->dispatcher->forward([ "controller" => "errors", "action" => "accessdenied" ]);
                        return false;
                    }
                }
                else{
                    if ($user->user_type != 'admin') {
                        $this->flash->error( "You don't have permission to see this app" );
                        $this->dispatcher->forward([ "controller" => "errors", "action" => "accessdenied" ]);
                        return false;
                    }
                }
            }

            $totalDataPointsQueryResult = Appuser::find([
                'columns' => 'COUNT(*) AS count, app_id',
                "conditions" => "app_id LIKE $app_id"
            ]);
            
            $totalDataPoints = [];
            
            foreach ($totalDataPointsQueryResult as $key) {
                array_push($totalDataPoints, $key->app_id);
                array_push($totalDataPoints, $key->count);
            }
            
            $this->view->totalDataPoints = $totalDataPoints;
            $this->view->app=$result;
            
            $variable_model = new Variable();
            $variableData=Variable::findFirst(array( 
                 "user_id = :user_id: AND app_id = :app_id:", 
                // "app_id = :app_id:", 
                'bind' => array('user_id'=>$client_id->client_id,'app_id'=>$app_id)
            ));
            if(empty($variableData)){
              
            $singleinviteddata = Emailinvitation::findfirst(array( 
                'columns' => 'app_id,superuid',
                "user_id = :user_id: AND app_id = :app_id: AND status = :status:", 
                'bind' => array('user_id' => $auth['id'], 'app_id' => $app_id, 'status' => 1)
            ));

            $user_id = $app->get_client_id($singleinviteddata->superuid);
            
                $variableData=Variable::findFirst(array( 
                 "user_id = :user_id: AND app_id = :app_id:", 
                // "app_id = :app_id:", 
                'bind' => array('user_id'=>$user_id->client_id,'app_id'=>$app_id)
            ));

            }
            $this->view->variableData = $variableData;
            // print_r($variableData);exit;
            if ($variableData) {
                $_filtersData = json_decode($variableData->filters);
                $locationData = $this->variableDataFilter($_filtersData, $app_id,$sql);
               // if(empty($locationData))
               //  $this->flash->error( "You don't have permission to see this app" );
                $this->view->locationData = $locationData;
               }

            $permission=$emailinvitation->permission($app_id,$auth['id']);
            // print_r($permission);exit;
            if($permission && ($permission->permission_list!='null')){
                // print_r($permission->permission_list);
                // exit;
             $generate_and_export_reports=in_array("generate_and_export_reports", json_decode($permission->permission_list));
             $app_setting=in_array("application_settings", json_decode($permission->permission_list));
             $app_integration=in_array("integration_key", json_decode($permission->permission_list));
            // $application_settings=in_array("application_settings", json_decode($permission->permission_list));
            // $integration_key=in_array("integration_key", json_decode($permission->permission_list));
                
              // $this->view->generate_and_export_reports =$application_settings;  
              // $this->view->generate_and_export_reports =$integration_key;  
            }
            else{
                $generate_and_export_reports=false;
                $app_setting=false;
                $app_integration=false;
            }
            // var_dump(!empty($app_integration),!empty($app_setting));

            $this->view->generate_and_export_reports =$generate_and_export_reports;
            $this->view->app_setting =$app_setting;
            $this->view->app_integration =$app_integration;
            $this->view->permission =$permission->permission_list;
        }

        public function save_variableAction(){
            $request = new Request();
            $response = new Response();
            $response->setHeader("Content-Type", "application/json");
            $_data = $request->getPost();
            $_variable = $request->getPost('variable');
            $_all = $request->getPost('all');
            // echo $_variable;exit;
            $app_id = $request->getPost('app_id');
            // print_r($_data);exit;
            $res = ['status'=>false];
            if (!$app_id) {
                $res['errors'] = ['app_id'=>"app_id is required"];
                return $response->setJsonContent($res);   
            }

            $_filters = array();
            if ((isset($_data[$_variable])) || isset($_data)) {
                if ($_variable == 'gender') { $_filters = $_data[$_variable]; }
                elseif ($_variable == 'location') { $_filters = $_data[$_variable]; }
                elseif ($_variable == 'age_range') {
                    // $_filters = $_data[$_variable];
                    $_filters['age_range_start'] = $_data['age_range_start'];
                    $_filters['age_range_end'] = $_data['age_range_end'];
                } 
                elseif ($_variable == 'mobile_make') {
                	$_filters = $_data[$_variable];
            // print_r($_filters);exit;

                    // $mobile_make = new MobileMaker();
                    // $_filters = $mobile_make->get_all([ 'id'=>$_data[$_variable] ],'array');
                    // $_filters = (is_array($_filters) && count($_filters)>0) ? array_column($_filters, 'brand_name','id') : false;  
                }
                elseif ($_variable == 'apps_installled') { $_filters = $_data['applications']; }
                elseif ($_variable == 'date') {
                    $_filters['datestart'] = $_data['datestart'];
                    $_filters['dateend'] = $_data['dateend'];
                }
                else { $_filters = [$_data[$_variable]]; }
            }
            else {
				foreach ($_data as $key => $val) {
					if ( preg_match( '/'.$_variable.'_(?P<digit>\w+)/', $key,$match ) ) { $_filters[$match['digit']] = $val; }
					else { continue; }
				}
            }

            $variable_model = new Variable();
            $app = new App();
            $client_id = $app->get_client_id($this->login_user->id);
            $old_data = Variable::findFirst(array( 
                "user_id = :user_id: AND app_id = :app_id:", 
                'bind' => array('user_id' => $client_id->client_id,'app_id'=>$app_id)
            ));
            $data = array();
            if($old_data) { $data = json_decode($old_data->filters,true); }
            if(isset($_all)){
              $data[$_variable] = $_frontend_filter = [
                "title"    => $request->getPost('title'),
                "variable" => $_variable,
                "data"     => json_decode($_all,true),
            ];  
        }
        else{
            $data[$_variable] = $_frontend_filter = [
                "title"    => $request->getPost('title'),
                "variable" => $_variable,
                "data"     => $_filters,
            ];
        }
        
            $_insert_arr = array(
                "user_id"       => $client_id->client_id,
                "app_id"        => $request->getPost('app_id'),
                "filters"       => json_encode($data),
                "modified_at"   => date("Y-m-d H:i:s"),
            );
        
			if ($old_data) { $_is_save = $old_data->save($_insert_arr); }
			else { $_is_save = $variable_model->create($_insert_arr); }

			if ($_is_save) {
				$res['status'] = true;
				$res['msg'] = 'database Updated.';
				$res['data'] = $_insert_arr;
				$res['filter'] = $_frontend_filter;
                $res['location'] = $this->variableDataFilter($data, $app_id,$sql);
				$res['sql'] = $sql;
			}
			else {
				$_is_save = $variable_model->save($_insert_arr);
				$res['msg'] = 'database not save.';
				$res['errors'] = ($old_data) ? get_model_error($old_data) : get_model_error($variable_model);
			}
            // echo "<pre>";print_r($res['filter']);exit;
            return $response->setJsonContent($res);
        }

        public function deleteVariableAction() {
            $request = new Request();
            $response = new Response();
            
            $response->setHeader("Content-Type", "application/json");
            
            $variableName = $request->getPost('variableName');
            $app_id = $request->getPost('id');
            
            $app = new App();
            $variable_model = new Variable();
            
            $client_id = $app->get_client_id($this->login_user->id);
            
            $old_data = Variable::findFirst(array( 
                "user_id = :user_id: AND app_id = :app_id:", 
                'bind' => array('user_id' => $client_id->client_id,'app_id'=>$app_id)
            ));

            $filtersDecoded = json_decode($old_data->filters);
            unset($filtersDecoded->$variableName);

            $_insert_arr = array(
                "user_id"       => $client_id->client_id,
                "app_id"        => $app_id,
                "filters"       => json_encode($filtersDecoded),
                "modified_at"   => date("Y-m-d H:i:s"),
            );

			$_is_save = $old_data->save($_insert_arr);
			
			if ($_is_save) {
				$res['status'] = true;
				$res['msg'] = 'database Updated.';
				$res['data'] = $_insert_arr;
				$res['filter'] = $filtersDecoded;
				$res['location'] = $this->variableDataFilter(json_decode(($old_data->filters)), $app_id);
				// $res['sql'] = $sql;
			}
            else {
                $_is_save = $variable_model->save($_insert_arr);
                $res['msg'] = 'database not save.';
                $res['errors'] = ($old_data) ? get_model_error($old_data) : get_model_error($variable_model);
            }

            return $response->setJsonContent($res);
        }

        public function exportAction(){


            $request = new Request();
            $data = json_decode($request->getPost('mydata'),true);
            $exdata=array();
            foreach ($data as $key => $value) {
               array_push($exdata, array_values($value));
            }
            //exit;
            $this->array_to_csv_download($exdata,'export.csv',',');
            //

            $this->view->disable();
            exit;
            
        }

        private function array_to_csv_download($array, $filename = "export.csv", $delimiter=";",$status=null)
        {

        $f = fopen('php://memory', 'w+');
        $headers = ['DOB','Gender','Email','Lat','Long','Age','Created Date'];

        fputcsv($f, $headers);
        foreach ($array as $line) {
        fputcsv($f, $line, $delimiter);
        }
        fseek($f, 0);
        header('Content-Type: application/csv');
        header('Content-Disposition: attachment; filename="'.$filename.'"');
        fpassthru($f);
        exit;
        }
        function outputCSV($data) {
            $outputBuffer = fopen("php://output", 'w');
            foreach($data as $val) {
                // var_dump($val);

            fputcsv($outputBuffer, $val);
            }
            fclose($outputBuffer);
            exit;
        }
        function variableDataFilter($filteredData, $app_id,&$sql=false) {
            // echo "<pre>";print_r($filteredData);exit;

            $filteredData=json_decode(json_encode($filteredData), false);

            $arr1 = (array)$filteredData;
            $app_user_location = new AppuserLocation();
            $columns = ["app_user.dob","app_user.gender","app_user.email","app_user_location.lat","app_user_location.long, TIMESTAMPDIFF(YEAR, app_user.dob, CURDATE()) as age", "app_user.created_at"];

            $app_user_location->builder->select($columns);
            $app_user_location->builder->from("app_user");
            // $app_user_location->builder->join("app_user_stats", "app_user.id = app_user_stats.app_user_id", 'left');
            $app_user_location->builder->join("app_user_location", "app_user_location.app_user_id = app_user.id", 'left');
            $app_user_location->builder->where('app_user.app_id', $app_id);
            $app_user_location->builder->where('app_user.app_id', $app_id);
            
            if( (isset($filteredData->gender)) ) {
                if (($filteredData->gender->data == 'Male')) { $app_user_location->builder->where('app_user.gender', 'male'); }
                else if (($filteredData->gender->data == 'female')) { $app_user_location->builder->where('app_user.gender', 'female'); }
                else { $app_user_location->builder->where_in('app_user.gender', ['male', 'female']); }
            }

            if( (isset($filteredData->age_range)) && (isset($filteredData->age_range->data)) ){
                $app_user_location->builder->where('TIMESTAMPDIFF(YEAR, app_user.dob, CURDATE()) BETWEEN '.$filteredData->age_range->data->age_range_start.' AND '.$filteredData->age_range->data->age_range_end,null,false);
            }

            if( (isset($filteredData->location)) && (isset($filteredData->location->data))){
                $_selectedLocations = (array)$filteredData->location->data;
                $app_user_location->builder->join("city","app_user_location.city_id = city.id",'left');
                // $app_user_location->builder->where_in('city.name', $loca);
                // $app_user_location->builder->select('COUNT(*) as DP, city.name as city');
                // $app_user_location->builder->group_by('city.id');
                // $app_user_location->builder->join("city","app_user_location.city_id = city.id",'left');
                $app_user_location->builder->where_in('city.name', array_values($_selectedLocations));
            }

            if ( (isset($filteredData->mobile_make)) && (isset($filteredData->mobile_make->data)) ) {
                $_mobileBrands = (array)($filteredData->mobile_make->data);
                // print_r($_mobileBrands);exit;
                $app_user_location->builder->distinct('app_user_stats.model_name');
                $app_user_location->builder->select( "app_user_stats.model_name", "app_user_stats.model_number", "app_user_stats.lat", "app_user_stats.long"/*, "app_user_stats.city_id", "installed_application.app_name",*/ );
                if(count($_mobileBrands)){
                    $app_user_location->builder->join("app_user_stats", "app_user_stats.app_user_id = app_user.id", 'left');
                    // $app_user_location->builder->join("mobile_maker", "app_user_stats.maker = mobile_maker.id", 'left');
                    // if($_mobileBrands=='all_models'){
                    //     $app_user = new Appuser();
                    //     $columns = ["DISTINCT(app_user_stats.model_name)"];
                    //     $app_user->builder->select($columns);
                    //     $app_user->builder->from("app_user");
                    //     $app_user->builder->join("app_user_stats", "app_user.id = app_user_stats.app_user_id", 'left');
                    //     $app_user->builder->where('app_user.app_id', $this->request->getPost('app_id'));
                    //     $app_user->builder->where('app_user_stats.model_name !=', NULL);
                    //     $app_user->builder->group_by("app_user_stats.model_name");

                    //     $mobileMake = $app_user->get_result();
                    //     $mobileMakeData=json_encode($mobileMake);
                    //     print_r($mobileMakeData);exit;
                    //     $app_user_location->builder->where_in('app_user_stats.model_name ', $mobileMakeData);
                    // }else{
                        $app_user_location->builder->where_in('app_user_stats.model_name ', $_mobileBrands);
                    // }
                    
                }
            }

            if ( (isset($filteredData->date)) && (isset($filteredData->date->data)) ) {
                $app_user_location->builder->where('app_user.created_at >=', $filteredData->date->data->datestart);
                $app_user_location->builder->where('app_user.created_at <=', $filteredData->date->data->dateend);
            }

            // if ((empty($filteredData->date))) { $app_user_location->builder->where('app_user_location.created_at LIKE ', date('Y-m-d').'%'); }

            if ( (isset($filteredData->apps_installled)) && (isset($filteredData->apps_installled->data)) ) {
            	$app_user_location->builder->join("installed_application", "app_user.id = installed_application.app_user_id", 'left');
                $installedApps = (array)($filteredData->apps_installled->data);
                $app_user_location->builder->distinct('installed_application.app_name');
                // $app_user_location->builder->select("installed_application.app_name");
                if(count($installedApps)){
                    $app_user_location->builder->where_in('installed_application.app_name ', $installedApps);
                }
            }

            $app_user_location->builder->group_by('app_user.id');

            $_locationResult = $app_user_location->get_result();
            $sql = $app_user_location->builder->last_query();
            return $_locationResult;
        }

        public function connect_new_appAction(){
            $this->view->setRenderLevel(
                View::LEVEL_ACTION_VIEW
            );
        }

        public function single_app_no_dataAction(){
            $auth=$this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;

            $request = new Request();
            $response = new Response();
            $response->setHeader("Content-Type", "application/json");

            $applicationname = $request->getPost('applicationname');
            $binaryname = $request->getPost('binaryname');
            $apitype = $request->getPost('apitype');
                    
            // Inserting form data to app table
            $app = new App();
            $emailinvitation = new Emailinvitation();
            $app->builder->select('app.app_title');
            $app->builder->from("app");
            $app->builder->where('app.app_title', $applicationname);

            $appnamedetails = $app->get_result();
            if ($appnamedetails) {
                return $response->setJsonContent('This Application name is existing..!');
            }

            $Variable = new Variable();

            // Insert the same app id in the variable table to display the map data
            $client_id = $app->get_client_id($this->login_user->id);
            $_insert_array = array(
                "app_title"             => $applicationname,
                "client_id"             => $client_id->client_id,
                "android_binary_name"   => $binaryname,
                "api_type"              => $apitype,
                "active"                => 0,
                "thumbnail"             => "images/logos/logotest2.png",
                "api_key"               => md5(uniqid(rand(), true))
            );

            if ($app->save($_insert_array) === true) {
                $_inserted_entities = array(
                    "id"                    => $app->id,
                    "app_title"             => $app->app_title,
                    "client_id"             => $app->client_id,
                    "active"                => $app->active,
                    "android_binary_name"   => $app->android_binary_name,
                    "api_type"              => $app->api_type,
                    "api_key"               => $app->api_key
                );
                //if(!empty($_inserted_entities)){
                $this->view->insertedEntities = $_inserted_entities;
                //}
                $_insertVariable = array(
                    "user_id"             => $client_id->client_id,
                    "app_id"              => $app->id,
                    "filters"             => ' ',
                );
                
                if ($Variable->save($_insertVariable) === true) {
                    $this->view->v = $Variable;
                    return $response->setJsonContent('Application connected successfully..!');
                }
            }

            $app_id = $this->dispatcher->getParam("app_id");
             // print_r($app_id);exit;

            $permission=$emailinvitation->permission($app_id,$auth['id']);
            // print_r($permission);exit;
            if($permission && ($permission->permission_list!='null')){
                // print_r($permission->permission_list);
                // exit;
             $app_setting=in_array("application_settings", json_decode($permission->permission_list));
             $app_integration=in_array("integration_key", json_decode($permission->permission_list));
             
            }else{
                $app_setting=true;
                $app_integration=true;
            }
            $this->view->app_setting =$app_setting;
            $this->view->app_integration =$app_integration;

        }

       
        public function getNonActiveAppsAction(){
            $request = new Request();
            $response   = new Response();
            $auth = $this->session->get('auth');
            $app_id = $request->getPost('app_id'); // Get app id passed
            
            $app = new App();
            
            $client_id = $app->get_client_id($this->login_user->id); // get client id from the logged in user
            $a=array();
            $apps1 = $app->get_apps($client_id->client_id, $app_id, 0); // get the specific app from app id
             if(!empty($apps1))
             array_push($a,json_decode(json_encode($apps1[0]), true));
            if(empty($apps1)){
                $apps2 = $app->get_active_apps($client_id->client_id, $app_id,1);
             if(!empty($apps2))
             array_push($a,json_decode(json_encode($apps2[0]), true));

            }
            // var_export(json_decode(json_encode($apps2[0]),true));exit;

            $invitedata = Emailinvitation::findFirst(array( 
                // 'columns' => 'app_id',
                "user_id = :user_id: AND app_id = :app_id: AND status = :status:", 
                'bind' => array('user_id' => $auth['id'], 'app_id' => $app_id, 'status' => 1)
                ));
            // echo $invitedata->superuid;exit;
            if(empty($apps2)&& !empty($invitedata->superuid)){
                // echo "sewak";exit;
                
                $client_idinv = $app->get_client_id($invitedata->superuid);
                // echo $app_id;
                $apps3 = $app->get_active_apps($client_idinv->client_id, $app_id,1);
             if(!empty($apps3))
                array_push($a,json_decode(json_encode($apps3[0]), true));

            }
            // $apps = array_merge($apps1,$apps2,$apps3);
            $apps=json_decode(json_encode($a), true);
            // print_r($apps);exit;

            $_inserted_entities = array(
                "id"                    => $apps[0]['id'],
                "app_title"             => $apps[0]['app_title'],
                "client_id"             => $apps[0]['client_id'],
                "active"                => $apps[0]['active'],
                "android_binary_name"   => $apps[0]['android_binary_name'],
                "api_type"              => $apps[0]['api_type'],
                "thumbnail"             => $apps[0]['thumbnail'],
                "api_key"               => $apps[0]['api_key']
            );

            return $response->setJsonContent($_inserted_entities);
        }

        public function dateWiseLocationAction(){
            $request = new Request();
            $response = new Response();
            $response->setHeader("Content-Type", "application/json");
            $_date = $request->getPost('date');
            $app_id = $request->getPost('app_id');

            $app = new App();
            $client_id = $app->get_client_id($this->login_user->id);

            $variable_model = new Variable();
            $variableData=Variable::findFirst(array( 
                "user_id = :user_id: AND app_id = :app_id:", 
                'bind' => array('user_id' => $client_id->client_id,'app_id'=>$app_id)
            ));

            $filteredData = json_decode($variableData->filters);

            $app_user_location = new AppuserLocation();
            $columns = ["app_user_location.lat","app_user_location.long", "app_user_location.created_at"];
            $app_user_location->builder->select($columns);
            $app_user_location->builder->from("app_user");
            
            $app_user_location->builder->join("app_user_location","app_user_location.app_user_id=app_user.id",'left');
            $app_user_location->builder->join("installed_application","installed_application.app_user_id=app_user.id",'left');
            if ( isset($filteredData->gender) ) {
                if ( ($filteredData->gender->data == 'Male' || $filteredData->gender->data == 'female') ) {
                    $app_user_location->builder->where('app_user.gender', $filteredData->gender->data);
                }
                elseif ($filteredData->gender->data == 'Both Genders') {
                    $app_user_location->builder->where_in('app_user.gender', ['Male', 'female']);
                }
            }

            if(isset($filteredData->age_range)){
                $app_user_location->builder->where('TIMESTAMPDIFF(YEAR, app_user.dob, CURDATE()) BETWEEN '.$filteredData->age_range->data->age_range_start.' AND '.$filteredData->age_range->data->age_range_end, null, false);   
            }

            if(isset($filteredData->location)){
                // $loca = $filteredData->location->data;
                // $city;
                // foreach ($loca as $key => $value) {
                //     $city = $value->formatted_address;  // Pune, Maharashtra, India
                //     $cityArray = explode(',', $city);   //Pune
                // }
                // $app_user_location->builder->join("city","app_user_location.city_id = city.id",'left');
                // $app_user_location->builder->where('city.name', $cityArray[0]);
                
                $_selectedLocations = (array)$filteredData->location->data;
                $app_user_location->builder->join("city","app_user_location.city_id = city.id",'left');
                $app_user_location->builder->where_in('city.name', array_values($_selectedLocations));
            }

            if (isset($filteredData->mobile_make)) {
                $_mobileBrands = (array)($filteredData->mobile_make->data);
                if(count($_mobileBrands)){
                    $app_user_location->builder->join("app_user_stats", "app_user_stats.app_user_id = app_user.id", 'left');
                    // $app_user_location->builder->join("mobile_maker", "app_user_stats.maker = mobile_maker.id", 'left');
                    $app_user_location->builder->where_in('app_user_stats.model_name ', $_mobileBrands);
                }
            }

            if ( (isset($filteredData->apps_installled)) && (isset($filteredData->apps_installled->data)) ) {
                $installedApps = (array)($filteredData->apps_installled->data);
                $app_user_location->builder->select("installed_application.app_name");
                if(count($installedApps)){
                    $app_user_location->builder->where_in('installed_application.app_name ', $installedApps);
                }
            }
            // echo $_date;exit;
            if (isset($_date)) {
                $app_user_location->builder->where('app_user_location.created_at LIKE', $_date."%");
            }
            if (isset($app_id)) {
                $app_user_location->builder->where('app_user.app_id', $app_id);
            }
            $app_user_location->builder->group_by("app_user.id");
            
            $_locationResult = $app_user_location->get_result();

            $sql = $app_user_location->builder->last_query();
            // print_r($sql);
            return $response->setJsonContent($_locationResult);
        }

        public function barLineChartFiltersAction(){
            $request 	= new Request();
            $response 	= new Response();
            $response->setHeader("Content-Type", "application/json");

            /* Getting values from the Ajax call */
            $filter 			= $request->getPost('filter');
            $logicalOperator 	= $request->getPost('logicalOperator');
            $app_id 			= $request->getPost('app_id');

            /* Retrieving variable filters */
            $app 			= new App();
            $client_id 		= $app->get_client_id($this->login_user->id);
        	$variableData 	= Variable::findFirst( array( 
					                "user_id = :user_id: AND app_id = :app_id:", 
					                'bind' => array(
					                	'user_id' => $client_id->client_id, 
					                	'app_id'=>$app_id
					                )
					            ));            
            $filtersData 	= json_decode($variableData->filters);

            /* Creating query based on filters */
            $app_user = new Appuser();

            if ($filter == 'Gender') {
                $genderFromDB = $filtersData->gender->data;

                $columns = ["COUNT(*) as yplot","gender as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                // $app_user->builder->where('app_user.app_id', $app_id);
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->group_by("app_user.gender");
                }
                elseif ($logicalOperator == 'AND') {
                    if ($genderFromDB == "Both Genders") {
                        $app_user->builder->where("gender LIKE '%'");
                    } else {
                        $app_user->builder->where_in('app_user.gender', $genderFromDB);
                    }
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->group_by("app_user.gender");
                }
            }

            if ($filter == 'Age range') {
            	/* retrive age range */
            	$agestart = $filtersData->age_range->data->age_range_start;
            	$ageend = $filtersData->age_range->data->age_range_end;

            	$columns = ["COUNT(*) as yplot,(YEAR(NOW())-YEAR(app_user.dob)) as xplot"];
	            $app_user->builder->select($columns);
	            $app_user->builder->from("app_user");
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('(YEAR(NOW())-YEAR(app_user.dob)) > ', 0);

	            }
	            elseif ($logicalOperator == 'AND') {
	                $app_user->builder->where('(YEAR(NOW())-YEAR(app_user.dob)) >= ', $agestart);
                	$app_user->builder->where('(YEAR(NOW())-YEAR(app_user.dob)) <= ', $ageend);
	            }
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->group_by("(YEAR(NOW())-YEAR(app_user.dob))");
            }

            if ( ($filter == 'Phone models') || ($filter == 'Phone Models') ) {
            	$columns = ["COUNT(*) as yplot, app_user_stats.model_name as xplot"];
	            $app_user->builder->select($columns);
	            $app_user->builder->from("app_user");
            	$app_user->builder->join("app_user_stats", "app_user.id = app_user_stats.app_user_id", 'left');
                if ($logicalOperator == 'OR') {
	                $app_user->builder->where('app_user_stats.model_name !=', NULL);
	            }
	            else
                if ($logicalOperator == 'AND') {
	                $app_user->builder->where_in('app_user_stats.model_name', (array)$filtersData->mobile_make->data);
                    $app_user->builder->where('app_user_stats.model_name !=', NULL);
	            }
                $app_user->builder->where('app_user.app_id', $app_id);
            	$app_user->builder->group_by("app_user_stats.model_name");
            }

            if ($filter == 'Location') {
	            $columns = ["COUNT(DISTINCT(app_user_location.app_user_id))  as yplot, app_user_location.city_id, city.name as xplot"];
	            $app_user->builder->select($columns);
	            $app_user->builder->from("app_user");
            	$app_user->builder->join("app_user_location", "app_user.id = app_user_location.app_user_id", 'left');
            	$app_user->builder->join("city", "city.id = app_user_location.city_id", 'left');
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('city.name !=', NULL);
	            }
	            elseif ($logicalOperator == 'AND') {
	                $app_user->builder->where_in('city.name', (array)$filtersData->location->data);
                    $app_user->builder->where('city.name !=', NULL);
	            }
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->group_by("city.name");
            }

            if ($filter == 'Date range') {
	            $columns = ["COUNT(*)  as yplot, DATE_FORMAT(app_user.created_at, '%Y-%m-%d') as xplot"];
	            $app_user->builder->select($columns);
	            $app_user->builder->from("app_user");
                if ($logicalOperator == 'OR') {
	                $app_user->builder->where('app_user.app_id', $app_id);
	            }
	            elseif ($logicalOperator == 'AND') {
	                $app_user->builder->where("DATE_FORMAT(app_user.created_at, '%Y-%m-%d') >= ", $filtersData->date->data->datestart);
	                $app_user->builder->where("DATE_FORMAT(app_user.created_at, '%Y-%m-%d') <= ", $filtersData->date->data->dateend);
		            $app_user->builder->where('app_user.app_id', $app_id);
	            }
            	$app_user->builder->group_by("DATE_FORMAT(app_user.created_at, '%d')");
            }

            if ( ($filter == 'Installed Application') || ($filter == 'Installed Applications') ) {
            	$columns = ["COUNT(DISTINCT(installed_application.app_user_id)) as yplot, installed_application.app_name as xplot"];
	            $app_user->builder->select($columns);
	            $app_user->builder->from("app_user");
            	$app_user->builder->join("installed_application", "app_user.id = installed_application.app_user_id", 'left');
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('installed_application.app_name !=', NULL);
	            }
	            elseif ($logicalOperator == 'AND') {
	                $app_user->builder->where_in('installed_application.app_name', (array)$filtersData->apps_installled->data);
                    $app_user->builder->where('installed_application.app_name !=', NULL);
	            }
                $app_user->builder->where('app_user.app_id', $app_id);

            	$app_user->builder->group_by("installed_application.app_name");
            }

			/* Executing query*/
            $filtersResult = $app_user->get_result();
            $sql = $app_user->builder->last_query();
            // echo $sql;exit;
// echo "<pre>";print_r($filtersResult);die();
            return $response->setJsonContent($filtersResult); /* Return response*/
        }

        function updateinvitee($inviteid,$authid) {
            $invitee = Emailinvitation::findFirstById($inviteid);
            if (!$invitee) {
                $this->flash->error("Invitee was not found");
                return $this->dispatcher->forward( ["controller" => "session"]);
            }
            $invitee->status=1;
            $invitee->user_id=$authid;
            if ($invitee->save() == false) {
                foreach ($invitee->getMessages() as $message) {
                    $this->flash->error($message);
                    return $this->dispatcher->forward(["controller" => "session"]);
                }
            }
        }

        public function get_api_keysAction(){
            $auth = $this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;

            $app = new App();
            $request = new Request();
            
            $app_id = $request->get('app_id');
            
            $apikey = App::findFirst($app_id);
            $_apikey = ($apikey->api_key);
            // echo($_apikey); die();

            $this->view->apiKey = $_apikey;
            $this->view->app_id = $app_id;
            $app_res = $app->get_one($app_id);
            $this->view->app_res = $app_res;
        }

        public function update_api_keysAction(){
            $auth = $this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;

            $app = new App();
            $request = new Request();
            $response = new Response();
            
            $app_id = $request->getPost('app_id');
            $api_key = $request->getPost('api_key');

            $app_res = $app->get_one($app_id);

            $app->id = $app_id;
            $app->api_key = $api_key;
            $app->app_title = $app_res->app_title;
            $app->client_id = $app_res->client_id;
            $app->created_at = date("Y-m-d H:i:s");
            $app->active = $app_res->active;
            $app->thumbnail = $app_res->thumbnail;

            if ($app->save() == false){
                return $response->setJsonContent('Unable to update');
            }
            else {
                // $this->flash->success("The API Key is been updated");
                return $response->setJsonContent('The API Key is been updated');
            }            
        }

        public function homeAction(){
            $auth=$this->session->get('auth');
            $user = Users::findFirst($auth['id']);
            $this->view->loggedInUser = $user;
        }

        public function polarAreaChartFiltersAction(){
            $request    = new Request();
            $response   = new Response();
            $response->setHeader("Content-Type", "application/json");

            /* Getting values from the Ajax call */
            $filter             = $request->getPost('filter');
            $logicalOperator    = $request->getPost('logicalOperator');
            // echo $logicalOperator;exit;
            $app_id             = $request->getPost('app_id');

            /* Retrieving variable filters */
            $app            = new App();
            $client_id      = $app->get_client_id($this->login_user->id);
            $variableData   = Variable::findFirst( array( 
                                    "user_id = :user_id: AND app_id = :app_id:", 
                                    'bind' => array(
                                        'user_id' => $client_id->client_id, 
                                        'app_id'=>$app_id
                                    )
                                ));            
            $filtersData    = json_decode($variableData->filters);

            /* Creating query based on filters */
            $app_user = new Appuser();

            if ($filter == 'Gender') {
                $genderFromDB = $filtersData->gender->data;
                $columns = ["COUNT(*) as yplot","gender as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                // $app_user->builder->where('app_user.app_id', $app_id);
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);

                    $app_user->builder->group_by("app_user.gender");
                }
                elseif ($logicalOperator == 'AND') {
                    if ($genderFromDB == "Both Genders") {
                        $app_user->builder->where("(Gender='Male' OR Gender='female')");
                    } else {
                        $app_user->builder->where_in('app_user.gender', $genderFromDB);
                    }
                    $app_user->builder->where('app_user.app_id', $app_id);

                    $app_user->builder->group_by("app_user.gender");

                }
            }

            if ($filter == 'Age range') {
                /* retrive age range */
                $agestart = $filtersData->age_range->data->age_range_start;
                $ageend = $filtersData->age_range->data->age_range_end;

                $columns = ["COUNT(*) as yplot, (YEAR(NOW())-YEAR(app_user.dob)) as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                elseif ($logicalOperator == 'AND') {
                    $app_user->builder->where('(YEAR(NOW())-YEAR(app_user.dob)) >= ', $agestart);
                    $app_user->builder->where('(YEAR(NOW())-YEAR(app_user.dob)) <= ', $ageend);
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                $app_user->builder->group_by("(YEAR(NOW())-YEAR(app_user.dob))");
            }

            if ( ($filter == 'Phone models') || ($filter == 'Phone Models') ) {
                $columns = ["COUNT(*) as yplot, app_user_stats.model_name as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                $app_user->builder->join("app_user_stats", "app_user.id = app_user_stats.app_user_id", 'left');
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->where('app_user_stats.model_name !=', NULL);
                }
                elseif ($logicalOperator == 'AND') {
                    $app_user->builder->where_in('app_user_stats.model_name', (array)$filtersData->mobile_make->data);
                    $app_user->builder->where('app_user_stats.model_name !=', NULL);
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                $app_user->builder->group_by("app_user_stats.model_name");
            }

            if ($filter == 'Location') {
                $columns = ["COUNT(DISTINCT(app_user_location.app_user_id))  as yplot, app_user_location.city_id, city.name as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                $app_user->builder->join("app_user_location", "app_user.id = app_user_location.app_user_id", 'left');
                $app_user->builder->join("city", "city.id = app_user_location.city_id", 'left');
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->where('city.name !=', NULL);
                }
                elseif ($logicalOperator == 'AND') {
                    $app_user->builder->where_in('city.name', (array)$filtersData->location->data);
                    $app_user->builder->where('city.name !=', NULL);
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                $app_user->builder->group_by("city.name");
            }

            if ($filter == 'Date range') {
                $columns = ["COUNT(*)  as yplot, DATE_FORMAT(app_user.created_at, '%Y-%m-%d') as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                elseif ($logicalOperator == 'AND') {
                    $app_user->builder->where("DATE_FORMAT(app_user.created_at, '%Y-%m-%d') >= ", $filtersData->date->data->datestart);
                    $app_user->builder->where("DATE_FORMAT(app_user.created_at, '%Y-%m-%d') <= ", $filtersData->date->data->dateend);
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                $app_user->builder->group_by("DATE_FORMAT(app_user.created_at, '%d')");
            }

            if ( ($filter == 'Installed Application') || ($filter == 'Installed Applications') ) {
                $columns = ["COUNT(DISTINCT(installed_application.app_user_id)) as yplot, installed_application.app_name as xplot"];
                $app_user->builder->select($columns);
                $app_user->builder->from("app_user");
                $app_user->builder->join("installed_application", "app_user.id = installed_application.app_user_id", 'left');
                if ($logicalOperator == 'OR') {
                    $app_user->builder->where('app_user.app_id', $app_id);
                    $app_user->builder->where('installed_application.app_name !=', NULL);
                }
                elseif ($logicalOperator == 'AND') {
                    $app_user->builder->where_in('installed_application.app_name', (array)$filtersData->apps_installled->data);
                    $app_user->builder->where('installed_application.app_name !=', NULL);
                    $app_user->builder->where('app_user.app_id', $app_id);
                }
                $app_user->builder->group_by("installed_application.app_name");
            }

            /* Executing query*/
            $filtersResult = $app_user->get_result();
            $sql = $app_user->builder->last_query();
            // echo $sql;exit;

            $countArrayforPolarChart = [];
            $labelArrayforPolarChart = [];
            $colorArrayforPolarChart = [];
            $arrayforPolarChart = [];

            function random_color_part() { return str_pad( dechex( mt_rand( 0, 255 ) ), 2, '0', STR_PAD_LEFT); }
            function random_color() { return random_color_part() . random_color_part() . random_color_part(); }

            foreach ($filtersResult as $key) {
                array_push($countArrayforPolarChart, (int)$key->yplot);
                array_push($labelArrayforPolarChart, $key->xplot);
                array_push($colorArrayforPolarChart, '#'.random_color());
            }
            $arrayforPolarChart = [$countArrayforPolarChart, $labelArrayforPolarChart, $colorArrayforPolarChart];
            return $response->setJsonContent($arrayforPolarChart); /* Return response*/
        }

        public function viewVariablesAction(){
        	$request 	= new Request();
            $filter 	= $request->get();
            $data = explode('/', $filter['_url']);
            $app_id = end($data);
            $this->view->app_id = $app_id;

            $appUser = new Appuser();

            $appUser->builder->select('*');
            $appUser->builder->from("app_user");
            $appUser->builder->where('app_user.app_id', $app_id);

            $appUserResult = $appUser->get_result();
            $sql = $appUser->builder->last_query();
            $this->view->appUserResult = $appUserResult;

            $appuserStats = new AppuserStats();
            $appuserStats->builder->select('app_user_stats.*');
            $appuserStats->builder->from("app_user_stats");
            $appuserStats->builder->join("app_user", "app_user.id = app_user_stats.app_user_id", 'left');
            $appuserStats->builder->where('app_user.app_id', $app_id);

            $appuserStatsResult = $appuserStats->get_result();
            $sql1 = $appuserStats->builder->last_query();
            $this->view->appuserStatsResult = $appuserStatsResult;


            $InstalledApp = new InstalledApp();
            $InstalledApp->builder->distinct('installed_application.app_name');
            $appuserStats->builder->select('installed_application.id');
            $InstalledApp->builder->from("installed_application");
            $InstalledApp->builder->join("app_user", "app_user.id = installed_application.app_user_id", 'left');
            $InstalledApp->builder->where('app_user.app_id', $app_id);

            $InstalledAppResult = $InstalledApp->get_result();
            $sql2 = $InstalledApp->builder->last_query();
            $this->view->InstalledAppResult = $InstalledAppResult;
        }


        public function uploadAction(){
                $auth = $this->session->get('auth');
                // print_r($auth);exit;
                /* Getting file name */
                $filename = $_FILES['file']['name'];
                // echo "sewak".$filename;exit;
                /* Location */
                $location = "upload/".$filename;
                $uploadOk = 1;
                $imageFileType = pathinfo($location,PATHINFO_EXTENSION);

                /* Valid extensions */
                $valid_extensions = array("jpg","jpeg","png");

                /* Check file extension */
                if(!in_array(strtolower($imageFileType), $valid_extensions)) {
                $uploadOk = 0;
                }

                if($uploadOk == 0){
                echo 0;
                }else{
                
                try{

                   
                /* Upload file */
                if(move_uploaded_file($_FILES['file']['tmp_name'],$location)){
                    // $config = new ConfigIni("../app/config/config.ini");
          // print_r($this->db);exit;
                 // echo 'inside if'.$location;exit;
                $result = Users::find(array( 
                    'columns' => 'pic',
                    "id = :id:", 
                    'bind' => array('id' => $auth['id'])
                ));
                echo count($result);
                // $result = mysqli_query($conn, "SELECT pic FROM users where id='".$auth['id']."'");
                $rowcount=count($result);
                
                if($rowcount==0){
                 $users = new Users();
                $users->pic=$location;
                if ($users->save() == false) {
                foreach ($users->getMessages() as $message) {
                $this->flash->error($message);
                return $this->dispatcher->forward(["controller" => "session"]);
                }
                } 
                // $sql= mysqli_query($conn,"INSERT INTO users(pic) VALUES('".$location."')");
                }else{
                    $user = Users::findFirst($auth['id']);
                    // $users->pic=$location;
                     $user->pic=$location;
                    if ($user->save() == false) {
                    foreach ($result->getMessages() as $message) {
                    $this->flash->error($message);
                    return $this->dispatcher->forward(["controller" => "session"]);
                    }
                    }

                // $sql = mysqli_query($conn,"UPDATE users SET pic='".$location."' WHERE id='".$auth['id']."'");

                }
                }else{
                    echo 'test'.$location;exit;
                echo 0;
                }
              }
                catch(Exception $e){
              var_dump($e->getMessage());
              echo " Line=".$e->getLine(), "\n";
              }
         }  
        }
    }