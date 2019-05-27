<?php

class Emailparser {
// class EmailParser {	

    protected $_openingTag 	= '{{';
    protected $_closingTag 	= '}}';
    public 		$_emailValues	=	null;
    private		$_emailDefaultValues	=	null;
    public 		$_emailHtml 	= null;
    public 		$mail_template_name 	= null;


    // public function initialize() {
    // 	// parent::__construct();

    // }

    public function _get_mail_template($template_name='welcome') {
    	//default values
			$this->_emailDefaultValues=['current_year' => date('Y')];

    	$this->mail_template_name=$template_name;
    	$mail_template=new EmailTemplate();
    	$res=$mail_template->get($template_name);

			$mail_template_obj=new stdClass();
			foreach ($res as $value) {
				$_index=$value->title;
				$mail_template_obj->$_index=$value;
			}
			//set HTML template
			$_html=$mail_template_obj->header->body;
			$_html.=$mail_template_obj->$template_name->body;
			$_html.=$mail_template_obj->footer->body;
			//set Subject
			$this->Subject = $mail_template_obj->$template_name->subject;

			foreach ($this->_emailDefaultValues as $key => $value) {
			  $_html = str_replace($this->_openingTag . $key . $this->_closingTag, $value, $_html);
			}

			unset($mail_template_obj);
			return $_html;
    }

    public function render_template($template_name,$valuse_arr) {
    	// echo $template_name;die();
			$this->_emailHtml=$html=$this->_get_mail_template($template_name);
			$this->_emailValues=$valuse_arr;
			foreach ($this->_emailValues as $key => $value) {
			  $html 					= str_replace($this->_openingTag . $key . $this->_closingTag, $value, $html);
			  $this->Subject 	= str_replace($this->_openingTag . $key . $this->_closingTag, $value, $this->Subject);
			}
			// $this->_emailHtml=$html;
			// return $html;
			$this->MsgHTML($html);
    }
}