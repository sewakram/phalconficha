<?php

use Phalcon\Flash;
use Phalcon\Session;
// use Phalcon\Mvc\Model\Manager as modelsManager;
use Phalcon\Mvc\Model\Query;


class DashboardController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Dashboard');
        parent::initialize();
    }

    public function indexAction()
    {
        $auth=$this->session->get('auth');
        $user = Users::findFirst($auth['id']);
        $this->view->loggedInUser = $user;
        
        $app = new App();
        $client_id = $app->get_client_id($this->login_user->id);
        
         // echo "<pre>";print_r($appInvited->superuid);die();
        $appUser = new Appuser();
        // to show invited app data points start
        $appInvited = Emailinvitation::findFirst(array( 
                // 'columns' => 'superuid',
                "user_id = :user_id: AND status = :status:", 
                'bind' => array('user_id' => $auth['id'], 'status' => 1)
            ));
        $inviteclient = $app->get_client_id($appInvited->superuid);
        $resultinvite = $appUser->daily_data_point($inviteclient->client_id);
        // to show invited app data points end
        $resultdefalt = $appUser->daily_data_point($client_id->client_id);
        if(!empty($resultinvite))
        {
         $result=array_merge($resultinvite,$resultdefalt);   
     }else{
        $result=$resultdefalt;
     }
        
        if (!$result) {
            return $this->forward('dashboard/home');
        }
        // $array = json_decode(json_encode($result), True);
        // $stack = array();
        // $stack['date']='2018-09-30';
        // $stack['value']='1';

        // array_push($array, $stack);
         // echo "<pre>";print_r($result);die();

        $this->view->datapoints = $result;
        
        // if (!empty($result)) {
        //     $this->view->datapoints = $result;
        // }
        // else{
        //     $this->view->datapoints == (object) ['date' => 'No-data-available', 'value' => 0];
        // }

        /* Start of code for the data analysis on the Popular gender summary*/
            $genderMaleQuery = "SELECT COUNT(*) as maleCount
                                FROM `app_user` 
                                JOIN `app` ON `app`.`id`=`app_user`.`app_id` 
                                JOIN `client` ON `client`.`id`=`app`.`client_id` 
                                WHERE `client`.`id`=".$client_id->client_id." AND `app_user`.`gender`='male'";

            $genderfemaleQuery = "SELECT COUNT(*) as femaleCount
                                FROM `app_user` 
                                JOIN `app` ON `app`.`id`=`app_user`.`app_id` 
                                JOIN `client` ON `client`.`id`=`app`.`client_id` 
                                WHERE `client`.`id`=".$client_id->client_id." AND `app_user`.`gender`='female'";

            $maleCountArray = $this->db->query($genderMaleQuery);
            $maleCountArray->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $maleCountArray = $maleCountArray->fetchAll($maleCountArray);

            $femaleCountArray = $this->db->query($genderfemaleQuery);
            $femaleCountArray->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $femaleCountArray = $femaleCountArray->fetchAll($femaleCountArray);
            

            if ((!empty($maleCountArray)) || (!empty($femaleCountArray))){
                $this->view->maleCount = ((int)($maleCountArray[0]['maleCount']));
                $this->view->femaleCount = ((int)($femaleCountArray[0]['femaleCount']));
                $this->view->totalDataPoints = ((int)($femaleCountArray[0]['femaleCount'])) + ((int)($maleCountArray[0]['maleCount']));
            }
            else {
                $this->view->maleCount = 0;
                $this->view->femaleCount = 0;
                $this->view->totalDataPoints = 0;
            }
        /* end of code for the data analysis on the Popular gender summary*/
        
        /* Start of code for the data analysis on the Age range summary*/
    		$ageQuery = "SELECT TIMESTAMPDIFF(YEAR, `app_user`.dob, NOW()) AS age, COUNT(*) as count 
                            FROM `app_user` 
                            JOIN `app` ON `app`.`id`=`app_user`.`app_id` 
                            JOIN `client` ON `client`.`id`=`app`.`client_id` 
                            WHERE `client`.`id`=".$client_id->client_id." 
                            GROUP BY age 
                            HAVING age > 0 
                            ORDER BY `count` DESC";

            $ageArray = $this->db->query($ageQuery);
            $ageArray->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $ageArray = $ageArray->fetchAll($ageArray);
            $agecounter = 0;
            $unprocessedAgeArray = [];
            if (!empty($ageArray)){
                $sizeAgeArray = sizeof($ageArray);
                for ($i=0; $i < $sizeAgeArray; $i++) {
                	array_push($unprocessedAgeArray, $ageArray[$i]['age']);
                	$agecounter = $agecounter + $ageArray[$i]['count'];
                }

                $maxindex=sizeof($unprocessedAgeArray)-1;
            // print_r($unprocessedAgeArray);
                
                rsort($unprocessedAgeArray);

                $this->view->ageCounter = $agecounter;
                $this->view->ageRangeMax = $unprocessedAgeArray[0];
                $this->view->ageRangeMin = $unprocessedAgeArray[$maxindex];
            }
            else {
                $this->view->ageCounter = 0;
                $this->view->ageRangeMax = 0;
                $this->view->ageRangeMin = 0;
            }
        /* end of code for the data analysis on the Age range summary*/

        /* Start of code for the data analysis on the Popular Location summary*/
            $locationQuery = "SELECT `app_user_location`.`city_id` as idc, COUNT(*) as locationCount, `city`.`name`, `city`.`country` 
                                FROM `app_user_location` 
                                JOIN `app_user` ON `app_user_location`.`app_user_id`=`app_user`.`id` 
                                JOIN `app` ON `app`.`id`=`app_user`.`app_id` 
                                JOIN `client` ON `client`.`id`=`app`.`client_id` 
                                JOIN `city` ON `app_user_location`.`city_id`=`city`.`id`
                                WHERE `client`.`id`=".$client_id->client_id." 
                                GROUP BY `app_user_location`.`city_id`
                                HAVING `app_user_location`.`city_id` = idc 
                                ORDER BY locationCount DESC";

            $citycountArray = $this->db->query($locationQuery);
            $citycountArray->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $citycountArray = $citycountArray->fetchAll($citycountArray);

            if (!empty($citycountArray)){
                $countryModel = new Country();
                $resultCountry = $countryModel->get_country($citycountArray[0]['country']);
                
                $this->view->maxCityCount = $citycountArray[0]['locationCount'];
                $this->view->cityNameWithMaxCount = $citycountArray[0]['name'];
                $this->view->countryNameWithMaxCount = $resultCountry[0]->name;
            }
            else {
                $this->view->maxCityCount = 0;
                $this->view->cityNameWithMaxCount = 'No City';
                $this->view->countryNameWithMaxCount = 'No Country';
            }
        /* end of code for the data analysis on the Popular Location summary*/

        /* Start of code for the data analysis on the Popular phone model summary*/
            $mobileBrandQuery = "SELECT model_name as model, COUNT(model_name) as count 
                                    FROM `app_user_stats` 
                                    JOIN `app_user` ON `app_user_stats`.`app_user_id`=`app_user`.`id` 
                                    JOIN `app` ON `app`.`id`=`app_user`.`app_id` 
                                    JOIN `client` ON `client`.`id`=`app`.`client_id` 
                                    WHERE `client`.`id`=".$client_id->client_id." 
                                    GROUP BY model_name 
                                    HAVING COUNT(model_name) > 1 
                                    ORDER BY count DESC";

            $mobilecountArray = $this->db->query($mobileBrandQuery);
            $mobilecountArray->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $mobilecountArray = $mobilecountArray->fetchAll($mobilecountArray);

            if (!empty($mobilecountArray)){
        		$this->view->modelName = $mobilecountArray[0]['model'];
                $this->view->modelCount = $mobilecountArray[0]['count'];
            }
            else {
                $this->view->modelName = 'No phone data';
                $this->view->modelCount = 0;
            }
        /* End of code for the data analysis on the Popular phone model summary*/
    }

    /**
     * Edit the active user profile
     *
     */
    public function profileAction()
    {
        //Get session info
        $auth = $this->session->get('auth');

        //Query the active user
        $user = Users::findFirst($auth['id']);
        if ($user == false) {
            return $this->forward('index/index');
        }

        if (!$this->request->isPost()) {
            $this->tag->setDefault('name', $user->name);
            $this->tag->setDefault('email', $user->email);
        } else {

            $name = $this->request->getPost('name', array('string', 'striptags'));
            $email = $this->request->getPost('email', 'email');

            $user->name = $name;
            $user->email = $email;
            if ($user->save() == false) {
                foreach ($user->getMessages() as $message) {
                    $this->flash->error((string) $message);
                }
            } else {
                $this->flash->success('Your profile information was updated successfully');
            }
        }
    }

    public function homeAction(){
        $auth=$this->session->get('auth');
        $user = Users::findFirst($auth['id']);
        // echo "<pre>"; print_r($user->fname); die();
        $this->view->loggedInUser = $user;
    }

}