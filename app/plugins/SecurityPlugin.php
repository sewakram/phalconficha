<?php

use Phalcon\Acl;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory as AclList;

/**
 * SecurityPlugin
 *
 * This is the security plugin which controls that users only have access to the modules they're assigned to
 */
class SecurityPlugin extends Plugin
{
	/**
	 * Returns an existing or new access control list
	 *
	 * @returns AclList
	 */
	public function getAcl()
	{
		if (!isset($this->persistent->acl)) {

			$acl = new AclList();

			$acl->setDefaultAction(Acl::DENY);

			// Register roles
			$roles = [
				'users'  => new Role(
					'Users',
					'Member privileges, granted after sign in.'
				),
				'guests' => new Role(
					'Guests',
					'Anyone browsing the site who is not signed in is considered to be a "Guest".'
				)
			];

			foreach ($roles as $role) {
				$acl->addRole($role);
			}

			//Private area resources
			$privateResources = array(
				'companies'       		=> array('index', 'search', 'new', 'edit', 'save', 'create', 'delete','export'),
				'adminusers'      		=> array('index', 'search', 'new', 'edit', 'save', 'create', 'delete'),
				'dashboard'       		=> array('index', 'profile', 'register', 'forgot', 'home'),
				'feedback'        		=> array('index', 'search', 'new', 'edit', 'save', 'create', 'delete'),
				'mobiles'         		=> array('index', 'search', 'new', 'edit', 'save', 'create', 'delete', 'export'),
				'application'     		=> array('index','single_app','save_variable','export', 'connect_new_app', 'single_app_no_data','application_setting','dateWiseLocation', 'deleteVariable', 'barLineChartFilters', 'getNonActiveApps', 'get_api_keys', 'update_api_keys', 'home', 'polarAreaChartFilters', 'viewVariables','upload'),
				'test'            		=> array('index'),
				'underscore-check' 		=> array('index'),
				'account' 		  		=> array('index', 'accountdata'),
				'team-members'	  		=> array('index','share_app','sendemail', 'home', 'deleteInvitee','editInvitee'),
				'invoice-and-payments' 	=> array('index', 'freetrial', 'expired', 'createPdf'),
				'contact-and-support'  	=> array('index', 'contactData'),
				'announcements' 	  	=> array('index'),
				'help-and-faq' 		  	=> array('index'),
				'variable' 				=> array('index', 'add_variable', 'variable', 'variable_submit'),
				'location' 				=> array('index', 'get_user_location')
			);
			foreach ($privateResources as $resource => $actions) {
				$acl->addResource(new Resource($resource), $actions);
			}

			//Public area resources
			$publicResources = array(
				'index'      => array('index'),
				'about'      => array('index'),
				'register'   => array('index','forgot_password','reset_password'),
				'errors'     => array('show401', 'show404', 'show500', 'accessdenied'),
				'session'    => array('index', 'register', 'start', 'end', 'forgot'),
				'contact'    => array('index', 'send')
			);
			foreach ($publicResources as $resource => $actions) {
				$acl->addResource(new Resource($resource), $actions);
			}

			//Grant access to public areas to both users and guests
			foreach ($roles as $role) {
				foreach ($publicResources as $resource => $actions) {
					foreach ($actions as $action){
						$acl->allow($role->getName(), $resource, $action);
					}
				}
			}

			//Grant access to private area to role Users
			foreach ($privateResources as $resource => $actions) {
				foreach ($actions as $action){
					$acl->allow('Users', $resource, $action);
				}
			}

			//The acl is stored in session, APC would be useful here too
			$this->persistent->acl = $acl;
		}

		return $this->persistent->acl;
	}

	/**
	 * This action is executed before execute any action in the application
	 *
	 * @param Event $event
	 * @param Dispatcher $dispatcher
	 * @return bool
	 */
	public function beforeDispatch(Event $event, Dispatcher $dispatcher)
	{

		$auth = $this->session->get('auth');
		if (!$auth){
			$role = 'Guests';
		} else {
			$role = 'Users';
		}

		$controller = $dispatcher->getControllerName();
		$action = $dispatcher->getActionName();

		$acl = $this->getAcl();

		if (!$acl->isResource($controller)) {
			$dispatcher->forward([
				'controller' => 'errors',
				'action'     => 'show404'
			]);

			return false;
		}

		$allowed = $acl->isAllowed($role, $controller, $action);
		// var_dump($allowed);
		if ($allowed != Acl::ALLOW) {
			$dispatcher->forward(array(
				'controller' => 'errors',
				'action'     => 'show401'
			));
      // $this->session->destroy();
			return false;
		}
	}
}
