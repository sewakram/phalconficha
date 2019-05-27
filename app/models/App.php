<?php
// use Phalcon\Mvc\Model;
// use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Mvc\Model\Validator\PresenceOf;
use Phalcon\Mvc\Model\Validator\Uniquenes;


class App extends QueryBuilder{
  private $table='app';
  public function initialize(){
    $this->setSource($this->table);
    parent::onConstruct($this->table);
  }

	public function validation(){
		$required=['app_title','client_id','active'];
    foreach ($required as $field) {
      $this->validate(new PresenceOf([
        'field' => $field,
        'message' => ":field is required",
      ]));
    }

    if ($this->validationHasFailed() === true) {
        return false;
    }
  }

  public function get_one($id){

    $this->builder->select('*');
    $this->builder->from($this->table);
    if($id){
    	$this->builder->where("id",$id);
  	}
    return $this->get_row();
  }

	public function get($client_id=false,$app_id=false){
    // echo $client_id;
    $this->builder->select('*');
    $this->builder->from($this->table);
    if($client_id){
      $this->builder->where('client_id',$client_id);
    }
    if($app_id){
      $this->builder->where('id',$app_id);
    }
    // return $this->builder->get();
    // die();
    return $this->get_result();
  }

  public function get_apps($client_id=false, $app_id=false, $active = 1){
    $this->builder->select('*');
    $this->builder->from($this->table);
    if($client_id){
      $this->builder->where('client_id',$client_id);
    }
    if($app_id){
      $this->builder->where('id',$app_id);
    }
    
    $this->builder->where('active',$active);
    // echo $this->builder->get();exit;
    return $this->get_result();
  }

  public function get_client_id($user_id){
    $this->builder->select('client.id as client_id, client.user_id as user_id');
    $this->builder->from('users');
    $this->builder->join('client', 'users.id = client.user_id', 'left');
    $this->builder->where('users.id',$user_id);
    
    return $this->get_row();
  }
  
  public function get_active_apps($client_id=false,$app_id=false, $active = 1){
    $this->builder->select('*');
    $this->builder->from($this->table);
    if($client_id){
      $this->builder->where('client_id',$client_id);
    }
    if($app_id){
      $this->builder->where('id',$app_id);
    }
    
    $this->builder->where('active',$active);
     // echo $this->builder->get();exit;
    return $this->get_result();
  }

}