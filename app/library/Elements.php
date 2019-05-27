<?php

use Phalcon\Mvc\User\Component;

/**
 * Elements
 *
 * Helps to build UI elements for the application
 */
class Elements extends ControllerBase
{

    private $_headerMenu = array(
        '' => array(
           // 'main-menu' => array(
           //      // 'icon' => '<i class="fa fa-fw fa-dashboard"></i> ',
           //      'title_key' => 'main-menu',
           //      'action' => 'index'
           //  ),
           'dashboard' => array(
                //'icon' => '<i class="fa fa-fw fa-dashboard"></i> ',
                'icon' => '<i class="material-icons">select_all</i> ',
                'title_key' => 'dashboard',
                'action' => 'index'
            ),
            'application' => array(
                // 'icon' => '<i class="fa fa-fw fa-th-large"></i> ',
                //'icon' => '<i class="fa fa-th" aria-hidden="true"></i> ',
                'icon' => '<i class="material-icons">apps</i> ',
                'title_key' => 'application',
                'action' => 'index'
            ),
            'team-members' => array(
                //'icon' => '<i class="fa fa-fw fa-user"></i> ',
                'icon' => '<i class="material-icons">group_work</i> ',
                'title_key' => 'team_members',
                'action' => 'index'
            ),
            'invoice-and-payments' => array(
                //'icon' => '<i class="fa fa-fw fa-sticky-note-o"></i> ',
                'icon' => '<i class="material-icons">credit_card</i> ',
                'title_key' => 'invoice_payment',
                'action' => 'index'
            ),
            // 'contact-and-support' => array(
            //     'icon' => '<i class="fa fa-fw fa-list"></i> ',
            //     'title_key' => 'contact_support',
            //     'action' => 'index'
            // ),
            // 'account' => array(
            //     'icon' => '<i class="fa fa-fw fa-sliders"></i> ',
            //     'title_key' => 'account_settings',
            //     'action' => 'index'
            // ),



            'divider' => array(
                'caption' => '',
                'action' => 'index'
            ),
            // 'support' => array(
            //     // 'icon' => '<i class="fa fa-fw fa-sticky-note-o"></i> ',
            //     'title_key' => 'support',
            //     'action' => 'index'
            // ),
            'account' => array(
                // 'icon' => '<i class="fa fa-fw fa-sliders"></i> ',
                //'icon' => '<i class="fa fa-fw fa-cog" aria-hidden="true"></i> ',
                'icon' => '<i class="material-icons">settings</i> ',
                'title_key' => 'Settings',
                'action' => 'index'
            ),
            'contact-and-support' => array(
                // 'icon' => '<i class="fa fa-fw fa-list"></i> ',
                //'icon' => '<i class="fa fa-fw fa-question-circle" aria-hidden="true"></i> ',
                'icon' => '<i class="material-icons">help</i> ',
                'title_key' => 'contact_support',
                'action' => 'index'
            ),
            
            // 'announcements' => array(
            //     'icon' => '<i class="fa fa-fw fa-window-restore"></i> ',
            //     'title_key' => 'announcement',
            //     'action' => 'index'
            // ),
            // 'help-and-faq' => array(
            //     'icon' => '<i class="fa fa-fw fa-exclamation-circle"></i> ',
            //     'title_key' => 'help_faq',
            //     'action' => 'index'
            // ),
            // 'companies' => array(
            //     'caption' => '<i class="fa fa-fw fa-table"></i>Users',
            //     'action' => 'index'
            // ),
            //  'adminusers' => array(
            //     'caption' => '<i class="fa fa-fw fa-user"></i>Admin Users',
            //     'action' => 'index'
            // ),
            //  'mobiles' => array(
            //     'caption' => '<i class="fa fa-fw fa-phone"></i>Mobiles',
            //     'action' => 'index'
            // ),
            //  'feedback' => array(
            //     'caption' => '<i class="fa fa-fw fa-edit"></i>Feedbacks',
            //     'action' => 'index'
            // ),

        ),
 
          
    );
    
    
     private $_headerMenus = array(
        'navbar-left' => array(
            'index' => array(
                'caption' => 'Home',
                'action' => 'index'
            ),
           
        ),
        // 'navbar-right' => array(
        //     'session' => array(
        //         'caption' => 'Log In/Sign Up',
        //         'action' => 'index'
        //     ),
        // )
    );


    private $_tabs = array(
        '<i class="fa fa-fw fa-user"></i> Profile' => array(
            'controller' => 'dashboard',
            'action' => 'profile',
            'any' => false
        ),
        '<i class="fa fa-fw fa-envelope"></i> Inbox' => array(
            'controller' => 'companies',
            'action' => 'index',
            'any' => true
        ),
        '<i class="fa fa-fw fa-gear"></i> Settings' => array(
            'controller' => 'products',
            'action' => 'index',
            'any' => true
        ),
        '<i class="fa fa-fw fa-power-off"></i> Log Out' => array(
                'controller' => 'session',
                'action' => 'end',
                 'any' => false
            )
    );

    /**
     * Builds header menu with left and right items
     *
     * @return string
     */
    public function getMenu()
    {

        $auth = $this->session->get('auth');
        if ($auth) {
            $this->_headerMenu['']['session'] = array(
                'icon' => '<i class="material-icons">power_settings_new</i> ',
                'title_key' => 'log_out',
                'action' => 'end'
            );
        } else {
            unset($this->_headerMenu['navbar-left']['dashboard']);
        }

        $controllerName = $this->view->getControllerName();
        foreach ($this->_headerMenu as $position => $menu) {
            echo '<div class="collapse navbar-collapse navbar-ex1-collapse">';
            echo '<div class="left-ficha-navbar-scrollable">';
            echo '<ul class="nav navbar-nav side-nav', $position, '">';
            echo '<li class="logo"><img src="'.$this->url->get('images/logo.png').'"></li>';
            

            // echo '<li class="divider"></li>';
            foreach ($menu as $controller => $option) {

                if ($controller == 'divider') {
                    echo '<li class="divider"></li>';
                    continue;
                }
                if ($controller == 'main-menu') {
                    echo '<li class="common-li '.$controller.'">'.$this->view->t->_($option['title_key']).'</li>';
                    continue;
                }
                if ($controller == 'support') {
                    echo '<li class="common-li '.$controller.'">'.$this->view->t->_($option['title_key']).'</li>';
                    continue;
                }

                if ($controllerName == $controller) {
                    echo '<li class="active common-li '.$controller.'">';
                } else {
                    echo '<li class="common-li '.$controller.'">';
                }
                echo $this->tag->linkTo($controller . '/' . $option['action'], $option['icon'].$this->view->t->_($option['title_key']));
                echo '</li>';
            }
            echo '</ul>';
            // echo '<div class="sidebar-nav-footer"><span>'.$this->view->t->_('ficha_footer_subtitle').'</span></div>';
            //left-ficha-navbar-scrollable
            echo '</div>';

            //collapse navbar-collapse navbar-ex1-collapse
            echo '</div>';
        }

    }

    /**
     * Returns menu tabs
     */
    public function getTabs()
    {
		
        $controllerName = $this->view->getControllerName();
        $actionName = $this->view->getActionName();
        echo '<ul class="dropdown-menu">';

        foreach ($this->_tabs as $caption => $option) {
            if ($option['controller'] == $controllerName && ($option['action'] == $actionName || $option['any'])) { 
                echo '<li class="active">';
            } else {
                echo '<li>';
            } 
            echo $this->tag->linkTo($option['controller'] . '/' . $option['action'], $caption), '</li>';
        }
        echo '</ul>';
    }
    
     /**
     * Builds header menu with left and right items
     *
     * @return string
     */
    public function getMenus()
    {

        $auth = $this->session->get('auth');
        if ($auth) {
            $this->_headerMenus['navbar-right']['session'] = array(
                'caption' => 'Log Out',
                'action' => 'end'
            );
        } else {
            unset($this->_headerMenus['navbar-left']['dashboard']);
        }

        $controllerName = $this->view->getControllerName();
        foreach ($this->_headerMenus as $position => $menu) {
            echo '<div class="nav-collapse">';
            echo '<ul class="nav navbar-nav ', $position, '">';
            foreach ($menu as $controller => $option) {
                if ($controllerName == $controller) {
                    echo '<li class="active">';
                } else {
                    echo '<li>';
                }
                echo $this->tag->linkTo($controller . '/' . $option['action'], $option['caption']);
                echo '</li>';
            }
            echo '</ul>';
            echo '</div>';
        }

    }

}
