<?php
// use Phalcon\Mvc\Model;
// use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Mvc\Model\Validator\PresenceOf;
use Phalcon\Mvc\Model\Validator\Email as EmailValidator;
use Phalcon\Mvc\Model\Validator\Uniqueness;


class Appuser extends QueryBuilder{
  private $table='app_user';
  public function initialize(){
    parent::onConstruct($this->table);
    $this->setSource($this->table);
  }

	public function validation(){
		$required=[/*'device_id',*/'email','gender'];
    foreach ($required as $field) {
      $this->validate(new PresenceOf([
        'field' => $field,
        'message' => ":field is required",
      ]));
    }

    $this->validate(new EmailValidator([
      'field' => 'email'    
    ]));

    // $this->validate(new Uniqueness([
    //   'field' => 'device_id'    
    // ]));

    if ($this->validationHasFailed() === true) {
        return false;
    }
  }

  public function get_one($option=array()){

    if(is_array($option) && count($option)>0){
      $this->builder->select('*');
      $this->builder->from($this->table);
      if(isset($option['id'])){
      	$this->builder->where("id",$option['id']);
    	}else if(isset($option['email'])){
        $this->builder->where("email",$option['email']);
      }else if(isset($option['device_id'])){
      	$this->builder->where("device_id",$option['device_id']);
    	}
      return $this->get_row();
    }else{
      return false;
    }
  }

	public function get($location=false){
		$columns=["au.id", "au.name"];
    $this->builder->select($columns);
    $this->builder->from($this->table);
    if($location){
    	$this->builder->select(["ul.lat", "ul.long"]);
    	$this->builder->join("app_user_location as ul", "ul.app_user_stats_id = au.id",'left');	
    }
    return $this->get_result();
    // echo "<pre>";
    // print_r($columns);die();
    // $this->builder->columns($columns);
    // return $this->builder->getPhql();
    // return $this->builder->getQuery()->getSingleResult();
    // return $this->builder->getQuery()->getSql();
    // return $this->builder->getQuery()->execute();
  }

  public function daily_data_point($client_id){
    
    $this->builder->select('DATE(app_user.created_at) as date');
    $this->builder->select('COUNT(*) as value');
    $this->builder->from($this->table);
    $this->builder->join("app", "app.id = app_user.app_id",'left'); 
    $this->builder->join("client", "client.id = app.client_id",'left'); 
    $this->builder->where("client.id",$client_id);
    $this->builder->group_by("YEAR(app_user.created_at), MONTH(app_user.created_at), DAY(app_user.created_at)");
// echo $this->builder->get();
    // exit;
    return $this->get_result();
  }

}