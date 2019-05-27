<?php
use Phalcon\Mvc\User\Component;
use Phalcon\Http\Request;



class Utils extends Component
{

  //$this->utils->getExpiryDate("NOW",$slab->validity,"add");
  public function curlGET($url,$param=''){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url.'?'.$param); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);   
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
  }

  public function getSegment(){
    $uri_segments = explode("/", $this->request->getUri());
    $segments=$uri_segments;
      end($uri_segments); 
      $key = key($uri_segments);
      $last_segment = $segments[$key];
      if($last_segment==''){
        $last_segment=$segments[$key-1];
      }
      return $last_segment;
    
  }

  public function curlPOST($url,$param){
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
  }

  public function export($data){
    // print_r(get_object_vars($data));die();
    if(count($data)>0){
      $_1st=reset($data);
      if(is_array($_1st)){
        $keys=array_keys($_1st);
      }else{
        $keys=array_keys(get_object_vars($_1st)); 
      }
      require_once(APP_PATH.'app/library/php-export-data.class.php');
      $excel = new ExportDataExcel('browser','export.xls');
      $excel->initialize();
      $excel->addRow($keys);
      // print_r($data);
      foreach ($data as $value) {
        $data=array();
         // print_r($value);
        foreach ($keys as $key){
         // print_r($value->$key);
          // print_r($value);
          $data[]=$value;
          // $data[]=$value->$key;
        }
        $excel->addRow($data);
      }
      $excel->finalize(); 
    }
  }


}//end class
?>



