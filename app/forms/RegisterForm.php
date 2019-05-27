<?php

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Password;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Validation\Validator\Alpha as AlphaValidator;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Regex as RegexValidator;
class RegisterForm extends Form
{

    public function initialize($entity = null, $options = null)
    {
        // Name
        $name = new Text('name');
        $name->setLabel('Full Name');
        $name->setFilters(array('striptags', 'string'));
        $name->addValidators(array(
            new PresenceOf(array(
                'message' => 'Name is required'
            )),
            // new AlphaValidator(
            // [
            // "message" => ":field must contain only letters",
            // ]
            // ),
            new RegexValidator(
            [
            "pattern" => "/^[ A-Za-z0-9.\/()!]+$/",
            "message" => ":field must contain only letters",
            ]
            )
            
        ));
        $this->add($name);

        // // Name
        // $name = new Text('lastname');
        // $name->setLabel('Last Name');
        // $name->setFilters(array('striptags', 'string'));
        // $name->addValidators(array(
        //     new PresenceOf(array(
        //         'message' => 'Lastname is required'
        //     )),
        //     new AlphaValidator(
        //     [
        //     "message" => ":field must contain only letters",
        //     ]
        //     )
            
        // ));
        

        // $this->add($name);

        // Email
        $email = new Text('email');
        $email->setLabel('Email');
        $email->setFilters('email');
        $email->addValidators(array(
            new PresenceOf(array(
                'message' => 'Email is required'
            )),
            new Email(array(
                'message' => 'Email is not valid'
            ))
        ));
        $this->add($email);
        
       

        // Password
        $password = new Password('password');
        $password->setLabel('Password');
        $password->addValidators(array(
            new PresenceOf(array(
                'message' => 'Password is required'
            )),
            new StringLength(
            [
            "min"            => 8,
            "messageMinimum" => "Password is too short",
            ]
            ),
            
        ));
        $this->add($password);

        // Confirm Password
        $repeatPassword = new Password('repeatPassword');
        $repeatPassword->setLabel('Confirm your Password');
        $repeatPassword->addValidators(array(
            new PresenceOf(array(
                'message' => 'Confirmation password is required'
            )),
            new StringLength(
            [
            "min"            => 8,
            "messageMinimum" => "Confirmation password is too short",
            ]
            ),
            
        ));
        $this->add($repeatPassword);
    }
}
