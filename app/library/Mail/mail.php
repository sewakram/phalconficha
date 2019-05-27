<?php
    require_once('class.phpmailer.php');
    //include __DIR__ . "class.phpmailer.php";
  
    function sendmail($to,$subject,$message)
    {
      $config = new \Phalcon\Config\Adapter\Ini("../app/config/config.ini");
      $Username= $config['mail']['Username'];
      $Password= $config['mail']['Password'];
      $mail             = new PHPMailer();
      $body             = $message;
      $mail->IsSMTP();
      //$mail->SMTPDebug  = 2;
      $mail->SMTPAuth   = true;    
      $mail->Host       = "smtp.gmail.com";
      $mail->Port       = 587;
      $mail->Username   = "$Username";
      $mail->Password   = "$Password";
      $mail->SMTPSecure = 'tls';
      $mail->SetFrom("$Username", "Genba");
      $mail->Subject    = $subject;
               
      $mail->MsgHTML($body);
      $address = $to;
      $mail->AddAddress($address);
      /*if(!$mail->Send())
          echo "Message was not sent <br />PHPMailer Error: " . $mail->ErrorInfo;
      else
          echo "Message has been sent";*/
      if(!$mail->Send()) {
          return 0;
      } else {
          return 1;
      }
    }
?>