<?php
	use Phalcon\Mvc\View,
		Phalcon\Http\Response,
		Phalcon\Http\Request;
	class InvoiceAndPaymentsController extends ControllerBase
	{

	    public function initialize(){
	        $this->tag->setTitle('Invoice And Payments');
	        parent::initialize();
	    }

	    public function indexAction(){
	    	$auth = $this->session->get('auth');
	        $user = Users::findFirst($auth['id']);
	        $this->view->loggedInUser = $user;

	        $app = new App();
            $client_id = $app->get_client_id($this->login_user->id);
            // print_r( $client_id);exit;
            $invoiceQuery = "SELECT * FROM `invoice` JOIN `invoice_items` ON `invoice`.`id`=`invoice_items`.`invoice_id` WHERE `invoice`.`client_id`=".$client_id->client_id;
            $invoicePaidQuery = "SELECT * FROM `invoice` JOIN `invoice_items` ON `invoice`.`id`=`invoice_items`.`invoice_id` WHERE `invoice`.`client_id`=".$client_id->client_id." AND `invoice_items`.`status`='Paid'";
            $invoiceDueQuery = "SELECT * FROM `invoice` JOIN `invoice_items` ON `invoice`.`id`=`invoice_items`.`invoice_id` WHERE `invoice`.`client_id`=".$client_id->client_id." AND `invoice_items`.`status`='Due'";

            $invoiceList = $this->db->query($invoiceQuery);
            $invoiceList->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $invoiceList = $invoiceList->fetchAll($invoiceList);

            $invoicePaidList = $this->db->query($invoicePaidQuery);
            $invoicePaidList->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $invoicePaidList = $invoicePaidList->fetchAll($invoicePaidList);

            $invoiceDueList = $this->db->query($invoiceDueQuery);
            $invoiceDueList->setFetchMode(Phalcon\Db::FETCH_ASSOC);
            $invoiceDueList = $invoiceDueList->fetchAll($invoiceDueList);

	        // $invoiceData=Invoice::find(array(
                // "client_id = :client_id:", 
                // 'bind' => array('client_id' => $client_id->client_id)
            // ));

            $this->view->invoiceData = $invoiceList;
            $this->view->invoicePaidList = $invoicePaidList;
            $this->view->invoiceDueList = $invoiceDueList;

             /* start fo code for the freetrial session expiry */
		        $cookieCreatedDate = strtotime($this->login_user->created_at);
	            $cookieExpiryDate = strtotime("+7 day", $cookieCreatedDate);
	            $currentDate = strtotime(date("Y-m-d"));
	            
	            $dateDifference = $cookieExpiryDate - $currentDate;

	            // $subscriptions = Subscriptions::findFirst($client_id->client_id);
	            $subscriptions = Subscriptions::findFirst(array( 
                "client_id = :client_id:", 
                'bind' => array('client_id' => $client_id->client_id)
            ));

	            if (is_array($subscriptions)) {
	            	$status_subscription = ((int)$subscriptions['status']);
	            }

	            if (is_object($subscriptions)) {
	            	$status_subscription = ((int)$subscriptions->status);
	            }
	            if ( !$status_subscription ) {
	            	if ($dateDifference > 0) {
		                return $this->dispatcher->forward([ "controller" => "invoice-and-payments", "action" => "freetrial" ]);
		            }
		            else {
		                return $this->dispatcher->forward([ "controller" => "invoice-and-payments", "action" => "expired" ]);
		            }
	            }
            /* end of code for the freetrial session expiry */
	    }

	    public function freetrialAction(){
	    	$auth = $this->session->get('auth');
	        $user = Users::findFirst($auth['id']);
	        $this->view->loggedInUser = $user;
	    }

	    public function expiredAction(){
	    	$auth = $this->session->get('auth');
	        $user = Users::findFirst($auth['id']);
	        $this->view->loggedInUser = $user;
	    }

	    public function createPdfAction() {
		    // $this->view->disable();
		    // $userId = 1;
		    // $rez['rez'] = Users::findFirstById($userId);
		    // $html = $this->view->getRender('reports', 'pdf_report', $rez);
		    // $pdf = new mPDF();
		    // $pdf->WriteHTML($html, 2);
		    // $br = rand(0, 100000);
		    // $ispis = "Pobjeda Rudet-Izvjestaj-".$br;
		    // $pdf->Output($ispis, "I");

			require('fpdf.php');

			$pdf = new FPDF();
			$pdf->AddPage();
			$pdf->SetFont('Arial','B',16);
			$pdf->Cell(40,10,'Hello World!');
			$pdf->Output();
		}

	}