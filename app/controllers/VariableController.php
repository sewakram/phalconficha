<?php
use Phalcon\Mvc\View,
    Phalcon\Http\Response,
    Phalcon\Http\Request;

class VariableController extends ControllerBase{
    public function initialize(){
        $this->tag->setTitle('Variable');
        parent::initialize();
    }

    public function indexAction(){
    }

    public function add_variableAction(){
        $this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
        $this->view->variable=$this->request->getPost('variable');
        $this->view->app_id=$this->request->getPost('app_id');
    }

    public function variableAction(){
        $this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );

        $app_user = new Appuser();
        $this->view->variable = $_variable = $this->request->getPost('variable');
        $this->view->app_id = $this->request->getPost('app_id');

        $app = new App();
        $client_id = $app->get_client_id($this->login_user->id);

        $variableTableData = Variable::findFirst(array( 
            "user_id = :user_id: AND app_id = :app_id:", 
            'bind' => array('user_id' => $client_id->client_id, 'app_id'=>$this->request->getPost('app_id'))
        ));

        $variableDataFilters = ($variableTableData) ? json_decode($variableTableData->filters) : false;
        $_filter_data=isset($variableDataFilters->$_variable) ? $variableDataFilters->$_variable : false;
      
        if ($_variable == 'location') {
            $columns = ["DISTINCT(city.name)"];
            $app_user->builder->select($columns);
            $app_user->builder->from("app_user");
            $app_user->builder->join("app_user_location", "app_user.id = app_user_location.app_user_id", 'left');
            $app_user->builder->join("city", "city.id = app_user_location.city_id", 'left');
            $app_user->builder->where('app_user.app_id', $this->request->getPost('app_id'));
            $app_user->builder->where('city.name !=', NULL);
            $app_user->builder->group_by("app_user_location.city_id");
            $cityTableData = $app_user->get_result();
            $sql = $app_user->builder->last_query();
            // echo "<pre>";print_r($sql);exit;
            // $view->disable(); exit;
            $this->view->cityTableData = $cityTableData;

        }

        if ($_variable == 'apps_installled') {
            $columns = ["DISTINCT(installed_application.app_name)"];
            $app_user->builder->select($columns);
            $app_user->builder->from("app_user");
            $app_user->builder->join("installed_application", "app_user.id = installed_application.app_user_id", 'left');
            $app_user->builder->where('app_user.app_id', $this->request->getPost('app_id'));
            $app_user->builder->where('installed_application.app_name !=', NULL);
            $app_user->builder->group_by("installed_application.app_name");

            $installedAppData = $app_user->get_result();
            $sql = $app_user->builder->last_query();

            $this->view->installedAppData = $installedAppData;
        }

        if ($_variable == 'mobile_make') {
            $columns = ["DISTINCT(app_user_stats.model_name)"];
            $app_user->builder->select($columns);
            $app_user->builder->from("app_user");
            $app_user->builder->join("app_user_stats", "app_user.id = app_user_stats.app_user_id", 'left');
            $app_user->builder->where('app_user.app_id', $this->request->getPost('app_id'));
            $app_user->builder->where('app_user_stats.model_name !=', NULL);
            $app_user->builder->group_by("app_user_stats.model_name");

            $mobileMakeData = $app_user->get_result();
            $sql = $app_user->builder->last_query();
            
            $this->view->mobileMakeData = $mobileMakeData;
        }
        $this->view->filterData = $_filter_data;

    }

    public function variable_submitAction(){
        $this->view->setRenderLevel(
            View::LEVEL_ACTION_VIEW
        );
        $this->view->variable=$this->request->getPost('variable_submit');
        $this->view->app_id=$this->request->getPost('app_id');
    }
}