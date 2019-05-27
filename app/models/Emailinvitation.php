<?php
use Phalcon\Mvc\Model\Validator\PresenceOf;
use Phalcon\Mvc\Model\Validator\Uniquenes;
// use Phalcon\Mvc\Model;

class Emailinvitation extends QueryBuilder{ 
  
  public $id;
  public $name;
  public $email;
  public $app_id;
  public $send_date;
  public $user_id;
  public $status;
  public $expiry_date;
  
  private $table='email_invitation';
  /**
  * Before create the user assign a password
  */
  public function beforeValidationOnCreate() {
    $this->status = 0;
    $this->user_id= 0;
    $this->expiry_date=date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s'). ' + 2 days'));
    $this->send_date=date('Y-m-d H:i:s');
  }

  public function initialize(){
    $this->setSource($this->table);
    parent::onConstruct($this->table);
  }

  public function permission($app_id,$user_id){
    $this->builder->select('permission_list,superuid,user_id');
    $this->builder->from('email_invitation,users');
    // $this->builder->join("users", "users.id = email_invitation.superuid", 'left');
    $this->builder->where('email_invitation.user_id',$user_id);
    $this->builder->where('email_invitation.app_id',$app_id);
    $this->builder->where('email_invitation.superuid !=',$user_id);
    // $this->builder->where('email_invitation.superuid !=','users.id');
    
    // echo $this->builder->get();
    // exit;
    return $this->get_row();
    // $sql = $this->builder->last_query();
    // print_r($sql);
  }
}