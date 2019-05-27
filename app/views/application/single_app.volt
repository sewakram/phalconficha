{{ content() }}
<?php

// var_export($generate_and_export_reports);exit;
	$variableFilters = ($variableData) ? json_decode($variableData->filters) : false;
	$locationCity = [];
	$jsonLocationData = json_encode($locationData);
?>
<link rel="stylesheet" href="<?=$this->url->get("js/amcharts/amcharts/plugins/export/export.css");?>" type="text/css" media="all" />
<script type="text/javascript" src="<?=$this->url->get("js/amcharts/amcharts/pie.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/amcharts/amcharts/amcharts.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/amcharts/amcharts/radar.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/amcharts/amcharts/plugins/export/export.min.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/amcharts/amcharts/themes/light.js");?>"></script>

<style type="text/css">
	.btn.active { background-color: #ccced1!important; }
	.btn-default:hover, .btn-default:focus { background-color: transparent !important; }
	.export-current-data-btn-wrapp form{float: left;margin-right: 10px;}   
	#mychart1{
		opacity: 2!important;
		/*display: block;
		width: 100%;*/
		/*overflow-x: scroll;*/
		
	}
	.tooltip-inner {
	min-width: 150px;
	max-width:150px!important;
	max-height:150px!important;
	overflow-y:auto;
	overflow-x:hidden;
	}
	/*fffffffffffff*/
	.chart-legend li span{
	display: inline-block;
	width: 12px;
	height: 12px;
	margin-right: 5px;
	}

	.chart-legend{
	height:250px;
	overflow:auto;
	}

	.chart-legend ul{ display: block; }

	.chart-legend ul li{
	cursor:pointer;
	display: inline-block;
    padding: 20px;
    width: 50%;
	}

	.strike{
	text-decoration: line-through !important;
	}

	/*.float-left{
	float:left;
	}*/
	/*fffffffffffff*/
	/* width */
.tooltip-inner::-webkit-scrollbar {
    width: 5px;
}

/* Track */
.tooltip-inner::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey; 
    border-radius: 5px;
}
 
/* Handle */
.tooltip-inner::-webkit-scrollbar-thumb {
    background: red; 
    border-radius: 5px;
}

/* Handle on hover */
.tooltip-inner::-webkit-scrollbar-thumb:hover {
    background: #b30000; 
}
</style>
<script type="text/javascript"> var uploadurl='<?php echo $this->url->get("application/upload");?>';</script>
<section class="application-wrapper">
	<div class="applicationheadtab">
		<div class="app-header row plain-color">
	      	<div class="col-xs-12 col-sm-5 col-md-5 application-tab-wrap">
		      	<div class="display-flex-wrapp">
			      	<div class="app-logo-wrapp">
				      	<?php $inviteid = $this->dispatcher->getParam('inviteid');
					      	$iconurl=!empty($inviteid)? '/'.$app->thumbnail : '../'.$app->thumbnail; ?>
			      		<img class="app-logo" src="<?php echo $iconurl; ?>">
			      	</div>
			      	<div class="app-title-wrapp">
			      		<h1 class="app-title"><?=ucfirst($app->app_title);?></h1>
			        	<h5 class="app-desc"><?=$t->_("app_subtitle"); ?></h5>
			      	</div>
		      	</div>
	      	</div>
	      	<div class="col-xs-12 col-sm-7 col-md-7 main-app-point application-tab-wrap">
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="down-arrow-img"></span>
                                <span class="user-name"><span class="user-name"><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname[0]).".";?></span></span>
                                <span class="user-img-wrapp"><img class="profile-icon profile-pic" src="<?php echo ($loggedInUser->pic)? $this->url->get($loggedInUser->pic):'/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png'?>" /></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <div class="navbar-login">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <p class="text-center upload_profile-wrap">

                                                    <img class="profilepi profile-pic" src="<?php echo ($loggedInUser->pic)? $this->url->get($loggedInUser->pic):'/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png'?>" />
                                                    <!-- <span class="glyphicon glyphicon-user icon-size"></span> -->
                                                    <i class="fa fa-camera upload-button"></i>
                                                    <div class="p-image">
                                                
                                                    <input class="file-upload" type="file" id="file" accept="image/*"/>
                                                    </div>
                                                </p>
                                            </div>
                                            <div class="col-lg-8">
                                                <p class="text-left"><strong><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname);?></strong></p>
                                                <p class="text-left small"><?=$loggedInUser->email;?></p>
                                                <p class="text-left">
                                                    <a href="<?=$this->url->get('account/index');?>" class="btn btn-primary btn-block btn-sm"><?=$t->_("update_profile"); ?></a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="navbar-login navbar-login-session">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <p>
                                                    <a href="<?=$this->url->get('session/end');?>" class="btn btn-danger btn-block"><?=$t->_("log_out"); ?></a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <?php  if ((!empty($app_integration)==true || !empty($app_setting)==true) && $permission!=null){ ?>
                    <div class="button_and_input_wrapp ">
                        <h5 class="connectapp"><i class="fa fa-cog" aria-hidden="true"></i><a href="<?=$this->url->get('application/single_app_no_data/'.$app->id);?>"><?= ' '.$t->_("application_settings"); ?></a></h5>
                    </div>
                    <? }else if ((!empty($app_integration)==false || !empty($app_setting)==false) && $permission==null){ ?>
					<div class="button_and_input_wrapp ">
					<h5 class="connectapp"><i class="fa fa-cog" aria-hidden="true"></i><a href="<?=$this->url->get('application/single_app_no_data/'.$app->id);?>"><?= ' '.$t->_("application_settings"); ?></a></h5>
					</div>
                    	<?php } ?>
                    <div class="button_and_input_wrapp cog-wrapp">
                        <h5 class="connectapp"><?= $totalDataPoints[1].' '.$t->_("total_data_points"); ?></h5>
                    </div>                    
                </div>
			</div>
		</div>
	</div>
	<div class="row box-section">
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 background-white">		<!-- nav section -->
			<div class="seperator">
						
				<?php  if ((!empty($generate_and_export_reports)==true) && $permission!=null){ ?>
				<?=modal_anchor($t->_('add_variable').'<i class="material-icons">add</i>', ['url' => $this->url->get('variable/add_variable'), 'class'=> 'btn ficha-btn ficha-blue-btn addvariable', 'data-post-variable' =>'add_variable', 'data-post-app_id' =>$app->id, 'data-title'=>$t->_('data_points_variable') ]);?>
				<? }else if ((!empty($generate_and_export_reports)==false) && $permission==null){ ?>
				<?=modal_anchor($t->_('add_variable').'<i class="material-icons">add</i>', ['url' => $this->url->get('variable/add_variable'), 'class'=> 'btn ficha-btn ficha-blue-btn addvariable', 'data-post-variable' =>'add_variable', 'data-post-app_id' =>$app->id, 'data-title'=>$t->_('data_points_variable') ]);?>
				<?php } ?>
				<hr>
				<?php if (!empty((array)$variableFilters)) { ?>
					<h4><span class="markerCount"><?=$totalDataPoints[1].' '.strtolower($t->_("total_data_points"));?></span></h4>
					<h6><?=$t->_('active_variable');?></h6>
					<div class="no-filters-para" style="display: none;">
						<p class="variable-filter-para"><?=$t->_('active_variable_para');?></p>
					</div>
				<?php } ?>
				<?php if (empty((array)$variableFilters)) { ?>
					<h4><span class="markerCount"><?=$totalDataPoints[1].' '.strtolower($t->_("total_data_points"));?></span></h4>
					<h6><?=$t->_('active_variable_subtitle');?></h6>
					<div class="no-filters-para">
						<p class="variable-filter-para"><?=$t->_('active_variable_para');?></p>
					</div>
				<?php } ?>
			</div>
			<ul class="variables-list">
				<?php if (is_array($variableFilters) || is_object($variableFilters)) { 
					
					if (isset($variableFilters->location->data)) { $locationVariableFilters = $variableFilters->location->data; }
					if (isset($variableFilters->mobile_make->data)) { $phoneVariableFilters = $variableFilters->mobile_make->data; }
					if (isset($variableFilters->apps_installled->data)) { $appsVariableFilters = $variableFilters->apps_installled->data; }
					// print_r($locationVariableFilters);exit;
					$_url=$this->url->get('variable/variable');
					foreach ($variableFilters as $variable_name => $val) {
						array_push($locationCity, $variable_name); ?>
						<li data-list-for="<?=$val->variable;?>" class="<?='div-'.$val->variable;?>">
							<div class="variable-list-wrapper">
								<?="<span class='variable-list-filter'>".ucfirst($t->_($val->variable))."</span>".
								modal_anchor('<span class="close-wrapp"><i id="$app->id" value="$val->variable;" class="material-icons removefilters">close</i></span>',[ 'data-post-variable' =>$val->variable, 'class'=> 'variable-filter remove-filter', 'data-post-app_id' =>$app->id, 'data-title'=> $t->_($val->variable) ]).
								modal_anchor('<span class="edit-wrapp"><i class="material-icons">mode_edit</i></span>',['url' => $_url, 'data-post-variable' =>$val->variable, 'class'=> 'variable-filter edit-filter', 'data-post-app_id' =>$app->id, 'data-title'=> $t->_($val->variable) ]);?>
							</div>
							<?php if (isset($val->data) && count($val->data)>0) {
								$_inner_li='';
								if ($val->variable == 'location') {
									$i=0;
									foreach ($val->data as $inner_list) {
							  			$_inner_li.='<li data-city="'.$inner_list.'" >'.ucfirst($inner_list).'</li>';
							  			$i++;
							  			if ($i ==3) {
							  				$_inner_li.='<li title="'.implode(", ", $locationVariableFilters).'" data-toggle="tooltip" data-placement="right">'.(sizeof($locationVariableFilters)-3).' more locations</li>';
							  				break;
							  			}
									}
								}
								elseif ($val->variable == 'gender') { 

									$_inner_li.='<li data-title="'.$val->title.' data-variable="'.$val->variable.'">'.ucfirst($val->data).'</li>'; 
								}
								elseif ($val->variable == 'age_range'){
									foreach ($val->data as $_li_key => $inner_list) { 
										$ageArray[$_li_key] = $inner_list; 
									}
									$_inner_li.='<li data-id="'.$_li_key.'">From '.ucfirst($ageArray['age_range_start']).' to '.ucfirst($ageArray['age_range_end']).'</li>';
								}
								elseif ($val->variable == 'mobile_make'){
									$i=0;
									foreach ($val->data as $_li_key => $inner_list) {
										$_inner_li.='<li data-id="'.$_li_key.'">'.ucfirst($inner_list).'</li>';
										$i++;
							  			if ($i ==3) {
							  				$_inner_li.='<li title="'.implode(", ", $phoneVariableFilters).'" data-toggle="tooltip" data-placement="right">'.(sizeof($phoneVariableFilters)-3).' more Phone Models</li>';
							  				break;
							  			}
									}
								}
								elseif ($val->variable == 'apps_installled'){
									$i=0;
									foreach ($val->data as $_li_key => $inner_list) {
										$_inner_li.='<li data-id="'.$_li_key.'">'.ucfirst($inner_list).'</li>';
										$i++;
							  			if ($i ==3) {
							  				$_inner_li.='<li title="'.implode(", ", $appsVariableFilters).'" data-toggle="tooltip" data-placement="right">'.(sizeof($appsVariableFilters)-3).' more Installed Apps</li>';
							  				break;
							  			}
									}
								}
								elseif ($val->variable == 'date'){
									foreach ($val->data as $_li_key => $inner_list) { 
										$dateArray[$_li_key] = $inner_list; 
									}
									$_inner_li.='<li data-id="'.$_li_key.'"><span class="start-date-span"> Start date: '.ucfirst($dateArray['datestart']).'</span>'.'<span class="end-date-span"> End date: '.ucfirst($dateArray['dateend']).'</span></li>';
								}
								echo '<ul class="inner-list">'.$_inner_li.'</ul>';
							} ?>
					  	</li> <?php
					}
				} ?>
			</ul>
		</div>
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 visual-section">		<!-- visual and map section -->
			<div class="col-sm-12 btn-rows">
				<div class="visual-type"><h2><?=$t->_('visual_types');?></h2></div>
				<div class="visual-type-icon-wrapp">
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item active">
							<a class="nav-link" data-toggle="tab" href="#fichamap-pane" role="tab"> <i class="fa fa-map-o"></i> </a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#barlchart" id="bartab" role="tab"> <i class="fa fa-bar-chart"></i> </a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#piechart" id="areatab" role="tab"> <i class="fa fa-pie-chart fa-2x"></i> </a>
						</li>
					</ul>
				</div>
				
				<div class="export-current-data-btn-wrapp">
					<!-- {{url('application/export')}} -->
				<?php  if ((!empty($generate_and_export_reports)==true) && $permission!=null){ ?>
					<form method="POST" action="{{url('application/export')}}">
						<input type="hidden" name="mydata" value='<?php echo $jsonLocationData; ?>'>
						<button  type="submit" class="btn ficha-btn ficha-blue-btn" />
							<?=$t->_('Export');?> <i class="material-icons">keyboard_tab</i> </button>
					</form>
					<? }else if ((!empty($generate_and_export_reports)==false) && $permission==null){ ?>
					<form method="POST" action="{{url('application/export')}}">
						<input type="hidden" name="mydata" value='<?php echo $jsonLocationData; ?>'>
						<button  type="submit" class="btn ficha-btn ficha-blue-btn" />
						<?=$t->_('Export');?> <i class="material-icons">keyboard_tab</i> </button>
					</form>
				<?php } ?>
					<a class="btn ficha-btn ficha-blue-btn" href="{{url('application/viewVariables/')}}<?=$app->id;?>"><?=$t->_('Variables List');?></a>
				</div>
			
			</div>
			<div class="tab-content col-sm-12">
				<div id="fichamap-pane" class="tab-pane active">
					<div class="time-slider-wrapper <?php echo (isset($variableFilters->date))? 'hide':''; ?>">
						<div id="time-range row">
						    <div class="col-md-3">
						    	<div class="date-picker-wrapp input-group">						    	
							    	<input type="text" id="date" name="date" class="date" placeholder="Today" />
							    	<label class="input-group-addon btn" for="date">
								       <img src="<?=$this->url->get('images/single_app_with_data_icons/calender_hd.png');?>" height="15" width="15">
								    </label>
						    	</div>
						    </div>
						    <div class="sliders_step1 col-md-9 widthmanage"> 
								<div class="range-holder">
					            	<span class="glyphicon glyphicon-play play-button" id="play"></span>
					            	<span class="glyphicon glyphicon-pause play-button" id="stop"></span>
					            	<span class="glyphicon glyphicon-repeat" id="repeat"></span>
									<div id="pr-slider" class="dragdealer">
										<div class="stripe">
											<div class="handle">
												<div class="infobox"> <div class="innerbox"> <div class="info-price"></div> </div> </div>
												<div class="square"></div>	
											</div>
										</div>
									</div>
								</div>
						    </div>
						</div>
					</div>
					<div id="fichamap"></div>
				</div>
				<div style="clear: both;"></div>
				<div id="barlchart" class="tab-pane">
					<div class="barlchart-header-wrapp">
                        <div class="col-md-12">
							<div class="row">
			              		<div class="col-sm-4 form-group">
			              			<div class="filter-otion-wrappp">
										<div class="form-group">
											<select class="form-control" id="filterDropdownOptions">												
											  	<?php if (!empty($locationCity)) {
											  		echo "<option class='baropt-apps_installled_select_filter' value = 'Select filter'>Select filter</option>";
											  	 foreach ($locationCity as $key) {
											  		if ($key == 'gender') { echo '<option class="baropt-gender" value = "'.$key.'">Gender</option>'; }
											  		if ($key == 'age_range') { echo '<option class="baropt-age_range" value = "'.$key.'">Age range</option>'; }
											  		if ($key =='mobile_make'){echo '<option class="baropt-mobile_make" value = "'.$key.'">Phone models</option>';}
											  		if ($key == 'location') { echo '<option class="baropt-location" value = "'.$key.'">Location</option>'; }
											  		if ($key == 'date') { echo '<option class="baropt-date" value = "'.$key.'">Date range</option>'; }
											  		if ($key == 'apps_installled') { echo '<option class="baropt-apps_installled" value = "'.$key.'">Installed Application</option>'; }
											  	} } ?>
											</select>
										</div>
									</div>
			             		</div>
			               		<div class="col-sm-8 form-group tabview-wrap">
			              			<div class="variable-logic-operator-wrapp">
										<span class="variable-logic-operator-text"><?= $t->_("logic_operator");?>: </span>
										<i class="fa fa-question-circle-o"></i> 
										<div class="btn-group btn-toggle barchart-toggle"> 
											<button class="btn btn-primary active" value="AND"><?= $t->_("and");?></button>
											<button class="btn btn-default" value="OR"><?= $t->_("or");?></button>
										</div>
									</div>
			             		</div>
				            </div> 
        				</div>
					</div>
					<div id="barchart" class="tab-pane"></div>
				</div>
				<div style="clear: both;"></div>
				<div id="piechart" class="tab-pane">
				    <div class="barlchart-header-wrapp ">
						<div class="filter-otion-wrappp col-sm-12 pie-border">
							<div class="form-group col-sm-4 tabpie-wrap">
								<select class="form-control pie-control" id="polarFilterDropdownOptions">
									
								  	<?php if (!empty($locationCity)) {
								  		echo "<option class='baropt-apps_installled_select_filter' value = 'Select filter'>Select filter</option>";
									  	foreach ($locationCity as $key) {
									  		if ($key == 'gender') { echo '<option class="baropt-gender" value = "'.$key.'">Gender</option>'; }
									  		if ($key == 'age_range') { echo '<option class="baropt-age_range" value = "'.$key.'">Age range</option>'; }
									  		if ($key == 'mobile_make') { echo '<option class="baropt-mobile_make" value = "'.$key.'">Phone models</option>'; }
									  		if ($key == 'location') { echo '<option class="baropt-location" value = "'.$key.'">Location</option>'; }
									  		if ($key == 'date') { echo '<option class="baropt-date" value = "'.$key.'">Date range</option>'; }
									  		if ($key == 'apps_installled') { echo '<option class="baropt-apps_installled" value = "'.$key.'">Installed Application</option>'; }
									  	} }
								  	?>
								</select>
							</div>
							<!-- polar chart logical start -->
							<div class="col-sm-8 form-group tabview-wrap">
			              			<div class="variable-logic-operator-wrapp">
										<span class="variable-logic-operator-text"><?= $t->_("logic_operator");?>: </span>
										<i class="fa fa-question-circle-o"></i> 
										<div class="btn-group btn-toggle polarChart-toggle"> 
											<button class="btn btn-primary active" value="AND"><?= $t->_("and");?></button>
											<button class="btn btn-default" value="OR"><?= $t->_("or");?></button>
										</div>
									</div>
			             		</div>
							<!-- polar chart logical end -->
						</div>
					</div>
					<div style="clear: both;"></div>
					<div class="row polarareachart">
						<!-- <canvas id="mychart1" class="mychart1 chartjs-render-monitor" width="800" height="406"></canvas>
						<div id="js-legend" class="chart-legend"></div> -->
						<!-- fffffff -->
						<div class="float-left">
						<div class="float-left" style="max-width:100%">

						<canvas id="mychart1" class="mychart1 chartjs-render-monitor" width="500px" height="300px"></canvas>
						</div>
						<div class="float-left" style="max-width:98%" id="leg_container">

						<div id="js-legend" class="chart-legend">
						</div>

						</div>
						<!-- fffffffff -->
				    </div>
				</div>
			</div>
		</div> <!-- visual and map section ends -->
	</div> <!-- box section ends -->
</section>

<link rel="stylesheet" href="<?=$this->url->get("css/bootstrap-material-datetimepicker.css");?>" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="<?=$this->url->get("css/jquery-ui191.css");?>" />

<script type="text/javascript" src="<?=$this->url->get("js/d3.min.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/jquery-ui.min.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/moment-with-locales.min.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/bootstrap-material-datetimepicker.js");?>"></script>

<script type="text/javascript">
	/*!
 * jQuery UI Touch Punch 0.2.3
 *
 * Copyright 2011–2014, Dave Furfero
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Depends:
 *  jquery.ui.widget.js
 *  jquery.ui.mouse.js
 */
 !function(a){function f(a,b){if(!(a.originalEvent.touches.length>1)){a.preventDefault();var c=a.originalEvent.changedTouches[0],d=document.createEvent("MouseEvents");d.initMouseEvent(b,!0,!0,window,1,c.screenX,c.screenY,c.clientX,c.clientY,!1,!1,!1,!1,0,null),a.target.dispatchEvent(d)}}if(a.support.touch="ontouchend"in document,a.support.touch){var e,b=a.ui.mouse.prototype,c=b._mouseInit,d=b._mouseDestroy;b._touchStart=function(a){var b=this;!e&&b._mouseCapture(a.originalEvent.changedTouches[0])&&(e=!0,b._touchMoved=!1,f(a,"mouseover"),f(a,"mousemove"),f(a,"mousedown"))},b._touchMove=function(a){e&&(this._touchMoved=!0,f(a,"mousemove"))},b._touchEnd=function(a){e&&(f(a,"mouseup"),f(a,"mouseout"),this._touchMoved||f(a,"click"),e=!1)},b._mouseInit=function(){var b=this;b.element.bind({touchstart:a.proxy(b,"_touchStart"),touchmove:a.proxy(b,"_touchMove"),touchend:a.proxy(b,"_touchEnd")}),c.call(b)},b._mouseDestroy=function(){var b=this;b.element.unbind({touchstart:a.proxy(b,"_touchStart"),touchmove:a.proxy(b,"_touchMove"),touchend:a.proxy(b,"_touchEnd")}),d.call(b)}}}(jQuery);

	/*https://github.com/skidding/dragdealer*/
	// below function is for drag slider (motion slider)
	(function(root,factory){if(typeof define==="function"&&define.amd){define(factory)}else{root.Dragdealer=factory()}})(this,function(){var Dragdealer=function(wrapper,options){this.bindMethods();this.options=this.applyDefaults(options||{});this.wrapper=this.getWrapperElement(wrapper);if(!this.wrapper){return}this.handle=this.getHandleElement(this.wrapper,this.options.handleClass);if(!this.handle){return}this.init();this.bindEventListeners()};Dragdealer.prototype={defaults:{disabled:false,horizontal:true,vertical:false,slide:true,steps:0,snap:false,loose:false,speed:.1,xPrecision:0,yPrecision:0,handleClass:"handle"},init:function(){this.value={prev:[-1,-1],current:[this.options.x||0,this.options.y||0],target:[this.options.x||0,this.options.y||0]};this.offset={wrapper:[0,0],mouse:[0,0],prev:[-999999,-999999],current:[0,0],target:[0,0]};this.change=[0,0];this.stepRatios=this.calculateStepRatios();this.activity=false;this.dragging=false;this.tapping=false;this.reflow();if(this.options.disabled){this.disable()}},applyDefaults:function(options){for(var k in this.defaults){if(!options.hasOwnProperty(k)){options[k]=this.defaults[k]}}return options},getWrapperElement:function(wrapper){if(typeof wrapper=="string"){return document.getElementById(wrapper)}else{return wrapper}},getHandleElement:function(wrapper,handleClass){var childElements=wrapper.getElementsByTagName("div"),handleClassMatcher=new RegExp("(^|\\s)"+handleClass+"(\\s|$)"),i;for(i=0;i<childElements.length;i++){if(handleClassMatcher.test(childElements[i].className)){return childElements[i]}}},calculateStepRatios:function(){var stepRatios=[];if(this.options.steps>1){for(var i=0;i<=this.options.steps-1;i++){stepRatios[i]=i/(this.options.steps-1)}}return stepRatios},setWrapperOffset:function(){this.offset.wrapper=Position.get(this.wrapper)},calculateBounds:function(){var bounds={top:this.options.top||0,bottom:-(this.options.bottom||0)+this.wrapper.offsetHeight,left:this.options.left||0,right:-(this.options.right||0)+this.wrapper.offsetWidth};bounds.availWidth=bounds.right-bounds.left-this.handle.offsetWidth;bounds.availHeight=bounds.bottom-bounds.top-this.handle.offsetHeight;return bounds},calculateValuePrecision:function(){var xPrecision=this.options.xPrecision||Math.abs(this.bounds.availWidth),yPrecision=this.options.yPrecision||Math.abs(this.bounds.availHeight);return[xPrecision?1/xPrecision:0,yPrecision?1/yPrecision:0]},bindMethods:function(){this.onHandleMouseDown=bind(this.onHandleMouseDown,this);this.onHandleTouchStart=bind(this.onHandleTouchStart,this);this.onDocumentMouseMove=bind(this.onDocumentMouseMove,this);this.onWrapperTouchMove=bind(this.onWrapperTouchMove,this);this.onWrapperMouseDown=bind(this.onWrapperMouseDown,this);this.onWrapperTouchStart=bind(this.onWrapperTouchStart,this);this.onDocumentMouseUp=bind(this.onDocumentMouseUp,this);this.onDocumentTouchEnd=bind(this.onDocumentTouchEnd,this);this.onHandleClick=bind(this.onHandleClick,this);this.onWindowResize=bind(this.onWindowResize,this)},bindEventListeners:function(){addEventListener(this.handle,"mousedown",this.onHandleMouseDown);addEventListener(this.handle,"touchstart",this.onHandleTouchStart);addEventListener(document,"mousemove",this.onDocumentMouseMove);addEventListener(this.wrapper,"touchmove",this.onWrapperTouchMove);addEventListener(this.wrapper,"mousedown",this.onWrapperMouseDown);addEventListener(this.wrapper,"touchstart",this.onWrapperTouchStart);addEventListener(document,"mouseup",this.onDocumentMouseUp);addEventListener(document,"touchend",this.onDocumentTouchEnd);addEventListener(this.handle,"click",this.onHandleClick);addEventListener(window,"resize",this.onWindowResize);var _this=this;this.interval=setInterval(function(){_this.animate()},25);this.animate(false,true)},unbindEventListeners:function(){removeEventListener(this.handle,"mousedown",this.onHandleMouseDown);removeEventListener(this.handle,"touchstart",this.onHandleTouchStart);removeEventListener(document,"mousemove",this.onDocumentMouseMove);removeEventListener(this.wrapper,"touchmove",this.onWrapperTouchMove);removeEventListener(this.wrapper,"mousedown",this.onWrapperMouseDown);removeEventListener(this.wrapper,"touchstart",this.onWrapperTouchStart);removeEventListener(document,"mouseup",this.onDocumentMouseUp);removeEventListener(document,"touchend",this.onDocumentTouchEnd);removeEventListener(this.handle,"click",this.onHandleClick);removeEventListener(window,"resize",this.onWindowResize);clearInterval(this.interval)},onHandleMouseDown:function(e){Cursor.refresh(e);preventEventDefaults(e);stopEventPropagation(e);this.activity=false;this.startDrag()},onHandleTouchStart:function(e){Cursor.refresh(e);stopEventPropagation(e);this.activity=false;this.startDrag()},onDocumentMouseMove:function(e){Cursor.refresh(e);if(this.dragging){this.activity=true}},onWrapperTouchMove:function(e){Cursor.refresh(e);if(!this.activity&&this.draggingOnDisabledAxis()){if(this.dragging){this.stopDrag()}return}preventEventDefaults(e);this.activity=true},onWrapperMouseDown:function(e){Cursor.refresh(e);preventEventDefaults(e);this.startTap()},onWrapperTouchStart:function(e){Cursor.refresh(e);preventEventDefaults(e);this.startTap()},onDocumentMouseUp:function(e){this.stopDrag();this.stopTap()},onDocumentTouchEnd:function(e){this.stopDrag();this.stopTap()},onHandleClick:function(e){if(this.activity){preventEventDefaults(e);stopEventPropagation(e)}},onWindowResize:function(e){this.reflow()},enable:function(){this.disabled=false;this.handle.className=this.handle.className.replace(/\s?disabled/g,"")},disable:function(){this.disabled=true;this.handle.className+=" disabled"},reflow:function(){this.setWrapperOffset();this.bounds=this.calculateBounds();this.valuePrecision=this.calculateValuePrecision();this.updateOffsetFromValue()},getStep:function(){return[this.getStepNumber(this.value.target[0]),this.getStepNumber(this.value.target[1])]},getValue:function(){return this.value.target},setStep:function(x,y,snap){this.setValue(this.options.steps&&x>1?(x-1)/(this.options.steps-1):0,this.options.steps&&y>1?(y-1)/(this.options.steps-1):0,snap)},setValue:function(x,y,snap){this.setTargetValue([x,y||0]);if(snap){this.groupCopy(this.value.current,this.value.target);this.updateOffsetFromValue();this.callAnimationCallback()}},startTap:function(){if(this.disabled){return}this.tapping=true;this.setWrapperOffset();this.setTargetValueByOffset([Cursor.x-this.offset.wrapper[0]-this.handle.offsetWidth/2,Cursor.y-this.offset.wrapper[1]-this.handle.offsetHeight/2])},stopTap:function(){if(this.disabled||!this.tapping){return}this.tapping=false;this.setTargetValue(this.value.current)},startDrag:function(){if(this.disabled){return}this.dragging=true;this.setWrapperOffset();this.offset.mouse=[Cursor.x-Position.get(this.handle)[0],Cursor.y-Position.get(this.handle)[1]]},stopDrag:function(){if(this.disabled||!this.dragging){return}this.dragging=false;var target=this.groupClone(this.value.current);if(this.options.slide){var ratioChange=this.change;target[0]+=ratioChange[0]*4;target[1]+=ratioChange[1]*4}this.setTargetValue(target)},callAnimationCallback:function(){var value=this.value.current;if(this.options.snap&&this.options.steps>1){value=this.getClosestSteps(value)}if(!this.groupCompare(value,this.value.prev)){if(typeof this.options.animationCallback=="function"){this.options.animationCallback.call(this,value[0],value[1])}this.groupCopy(this.value.prev,value)}},callTargetCallback:function(){if(typeof this.options.callback=="function"){this.options.callback.call(this,this.value.target[0],this.value.target[1])}},animate:function(direct,first){if(direct&&!this.dragging){return}if(this.dragging){var prevTarget=this.groupClone(this.value.target);var offset=[Cursor.x-this.offset.wrapper[0]-this.offset.mouse[0],Cursor.y-this.offset.wrapper[1]-this.offset.mouse[1]];this.setTargetValueByOffset(offset,this.options.loose);this.change=[this.value.target[0]-prevTarget[0],this.value.target[1]-prevTarget[1]]}if(this.dragging||first){this.groupCopy(this.value.current,this.value.target)}if(this.dragging||this.glide()||first){this.updateOffsetFromValue();this.callAnimationCallback()}},glide:function(){var diff=[this.value.target[0]-this.value.current[0],this.value.target[1]-this.value.current[1]];if(!diff[0]&&!diff[1]){return false}if(Math.abs(diff[0])>this.valuePrecision[0]||Math.abs(diff[1])>this.valuePrecision[1]){this.value.current[0]+=diff[0]*this.options.speed;this.value.current[1]+=diff[1]*this.options.speed}else{this.groupCopy(this.value.current,this.value.target)}return true},updateOffsetFromValue:function(){if(!this.options.snap){this.offset.current=this.getOffsetsByRatios(this.value.current)}else{this.offset.current=this.getOffsetsByRatios(this.getClosestSteps(this.value.current))}if(!this.groupCompare(this.offset.current,this.offset.prev)){this.renderHandlePosition();this.groupCopy(this.offset.prev,this.offset.current)}},renderHandlePosition:function(){if(this.options.horizontal){this.handle.style.left=String(this.offset.current[0])+"px"}if(this.options.vertical){this.handle.style.top=String(this.offset.current[1])+"px"}},setTargetValue:function(value,loose){var target=loose?this.getLooseValue(value):this.getProperValue(value);this.groupCopy(this.value.target,target);this.offset.target=this.getOffsetsByRatios(target);this.callTargetCallback()},setTargetValueByOffset:function(offset,loose){var value=this.getRatiosByOffsets(offset);var target=loose?this.getLooseValue(value):this.getProperValue(value);this.groupCopy(this.value.target,target);this.offset.target=this.getOffsetsByRatios(target)},getLooseValue:function(value){var proper=this.getProperValue(value);return[proper[0]+(value[0]-proper[0])/4,proper[1]+(value[1]-proper[1])/4]},getProperValue:function(value){var proper=this.groupClone(value);proper[0]=Math.max(proper[0],0);proper[1]=Math.max(proper[1],0);proper[0]=Math.min(proper[0],1);proper[1]=Math.min(proper[1],1);if(!this.dragging&&!this.tapping||this.options.snap){if(this.options.steps>1){proper=this.getClosestSteps(proper)}}return proper},getRatiosByOffsets:function(group){return[this.getRatioByOffset(group[0],this.bounds.availWidth,this.bounds.left),this.getRatioByOffset(group[1],this.bounds.availHeight,this.bounds.top)]},getRatioByOffset:function(offset,range,padding){return range?(offset-padding)/range:0},getOffsetsByRatios:function(group){return[this.getOffsetByRatio(group[0],this.bounds.availWidth,this.bounds.left),this.getOffsetByRatio(group[1],this.bounds.availHeight,this.bounds.top)]},getOffsetByRatio:function(ratio,range,padding){return Math.round(ratio*range)+padding},getStepNumber:function(value){return this.getClosestStep(value)*(this.options.steps-1)+1},getClosestSteps:function(group){return[this.getClosestStep(group[0]),this.getClosestStep(group[1])]},getClosestStep:function(value){var k=0;var min=1;for(var i=0;i<=this.options.steps-1;i++){if(Math.abs(this.stepRatios[i]-value)<min){min=Math.abs(this.stepRatios[i]-value);k=i}}return this.stepRatios[k]},groupCompare:function(a,b){return a[0]==b[0]&&a[1]==b[1]},groupCopy:function(a,b){a[0]=b[0];a[1]=b[1]},groupClone:function(a){return[a[0],a[1]]},draggingOnDisabledAxis:function(){return!this.options.horizontal&&Cursor.xDiff>Cursor.yDiff||!this.options.vertical&&Cursor.yDiff>Cursor.xDiff}};var bind=function(fn,context){return function(){return fn.apply(context,arguments)}};var addEventListener=function(element,type,callback){if(element.addEventListener){element.addEventListener(type,callback,false)}else if(element.attachEvent){element.attachEvent("on"+type,callback)}};var removeEventListener=function(element,type,callback){if(element.removeEventListener){element.removeEventListener(type,callback,false)}else if(element.detachEvent){element.detachEvent("on"+type,callback)}};var preventEventDefaults=function(e){if(!e){e=window.event}if(e.preventDefault){e.preventDefault()}e.returnValue=false};var stopEventPropagation=function(e){if(!e){e=window.event}if(e.stopPropagation){e.stopPropagation()}e.cancelBubble=true};var Cursor={x:0,y:0,xDiff:0,yDiff:0,refresh:function(e){if(!e){e=window.event}if(e.type=="mousemove"){this.set(e)}else if(e.touches){this.set(e.touches[0])}},set:function(e){var lastX=this.x,lastY=this.y;if(e.pageX||e.pageY){this.x=e.pageX;this.y=e.pageY}else if(e.clientX||e.clientY){this.x=e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft;this.y=e.clientY+document.body.scrollTop+document.documentElement.scrollTop}this.xDiff=Math.abs(this.x-lastX);this.yDiff=Math.abs(this.y-lastY)}};var Position={get:function(obj){var curleft=0,curtop=0;if(obj.offsetParent){do{curleft+=obj.offsetLeft;curtop+=obj.offsetTop}while(obj=obj.offsetParent)}return[curleft,curtop]}};return Dragdealer});
</script>
<script type="text/javascript" src="<?=$this->url->get("js/chartjs/Chart.min.js");?>"></script>
<script type="text/javascript" src="<?=$this->url->get("js/chartjs/Chart.bundle.min.js");?>"></script>
<script type="text/javascript">
	map = {};
	markerCluster = false;
	var count;
	var loca = <?=$jsonLocationData;?>;
	$( "#export" ).click(function(){
		$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/export'); ?>',	
					data: {mydata: loca},
					dataType: 'json',
					success: function (response) {
					}				
				});
	});
	/* Maps*/
		function initMap() {
			map = new google.maps.Map(document.getElementById('fichamap'), {
			    zoom: 13,
				mapTypeControl: false,
				streetViewControl: false,
				fullscreenControl: false,
			    center: {lat: 15.7835, lng: -85.2308},
			    zoomControl: true,
		        zoomControlOptions: {
		          position: google.maps.ControlPosition.LEFT_BOTTOM
		        },
				styles: [
					{"featureType": "landscape.man_made", "elementType": "geometry", "stylers": [{"color": "#f7f1df"}]},
					{"featureType": "landscape.natural", "elementType": "geometry", "stylers": [{"color": "#d0e3b4"}]},
					{"featureType": "landscape.natural.terrain", "elementType": "geometry", "stylers": [{ "visibility": "simplified"}]},
					{"featureType": "poi", "elementType": "labels", "stylers": [{ "visibility": "off"}]},
					{"featureType": "poi.business", "elementType": "all", "stylers": [{ "visibility": "off"}]},
					{"featureType": "poi.park", "elementType": "geometry", "stylers": [{"color": "#bde6ab" }, { "visibility": "simplified"}]},
					{"featureType": "road", "elementType": "geometry.stroke", "stylers": [{ "visibility": "off"}]},
					{"featureType": "road", "elementType": "labels", "stylers": [{ "visibility": "off"}]},
					{"featureType": "road.highway", "elementType": "geometry.fill", "stylers": [{"color": "#ffe15f"}]},
					{"featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{"color": "#efd151"}]},
					{"featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [{"color": "#ffffff"}]},
					{"featureType": "road.local", "elementType": "geometry.fill", "stylers": [{"color": "black"}]},
					{"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#a2daf2"}]}
				]
			});

			// var marker = new google.maps.Marker({
			// position: {lat: 15.7835, lng: -85.2308},
			// map: map,
			// title: 'Hello World!'
			// });


		}

		function addClusters(locations){
			// alert("holaw");

			// str = JSON.stringify(locations, null, 4); // (Optional) beautiful indented output.
			// Create an array of alphabetical characters used to label the markers.
			var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			var markerBounds = new google.maps.LatLngBounds();
			// Add some markers to the map.
			// Note: The code uses the JavaScript Array.prototype.map() method to
			// create an array of markers based on a given "locations" array.
			// The map() method here has nothing to do with the Google Maps API.
			// locationdate=new Date(locations.created_at);

			var markers = locations.map(function(location, i) {
				randomPoint = new google.maps.LatLng(Number(location.lat), Number(location.long));
				markerBounds.extend(randomPoint);
				return new google.maps.Marker({
					position: {lat: Number(location.lat), lng: Number(location.long)},
					// label: (i+1).toString()
				});
			});
			map.fitBounds(markerBounds);
			////////////////////
			zoomChangeBoundsListener = google.maps.event.addListenerOnce(map, 'bounds_changed', function(event) {
				if(map.getZoom()>8){
				map.setZoom(8);	
				}
			});
			////////////////////
			// Add a marker clusterer to manage the markers.
			// {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'}
			markerCluster = new MarkerClusterer(map, markers,{imagePath:"<?=$this->url->get('images/clusters/m');?>"});
			count = markers.length;
			// $(".markerCount").text(count+' Data Points');
			$(".info-price").html('Overall '+count+' DPs');

			$( "#export" ).click(function(){
			$.ajax({
			type: 'post',
			url: '<?php echo $this->url->get('application/export'); ?>',	
			data: {mydata: locations},
			dataType: 'json',
			success: function (response) {
			}				
			});
			});
		}

		function clearClusters() {
			// e.preventDefault();
			// e.stopPropagation();
			if(markerCluster){ markerCluster.clearMarkers(); }
		}
	/* End Of Maps*/

	/* Bar Line Chart*/
		function initBarChart(filterOptionData, logicalOperator, barcharttitle) {
			AmCharts.addInitHandler(function(chart) {
				// check if there are graphs with autoColor: true set
				for(var i = 0; i < chart.graphs.length; i++) {
					var graph = chart.graphs[i];
					if (graph.autoColor !== true){ continue; }
					var colorKey = "autoColor-"+i;
					graph.lineColorField = colorKey;
					graph.fillColorsField = colorKey;
					for(var x = 0; x < chart.dataProvider.length; x++) { chart.dataProvider[x][colorKey] = '#'+(Math.random()*0xFFFFFF<<0).toString(16); }
				}
			}, ["serial"]);

			var chart = AmCharts.makeChart("barchart", {
				"allLabels": [{
				  "text": "Data Points",
				  "size": 15, "color": "#A9A9A9",
				  "x": 0, "y": "50%",
				  "rotation": 270,
				  "width": "100%",
				  "verticalPadding": 8,
				  "align": "middle"
				}],
			  	"type": "serial",
			  	"titles": [{
				  	"id": "bar-chart-title-top",
					"text": barcharttitle,
					"size": 15, "bold": false, "color": "#A9A9A9",
				}],
				"hideCredits":true,
				"addClassNames": true,
				"theme": "light",
				"autoMargins": false,
				"marginLeft": 30, "marginRight": 8, "marginTop": 10, "marginBottom": 26,
				"balloon": {
					"adjustBorderColor": false,
					"horizontalPadding": 10, "verticalPadding": 8,
					"color": "#ffffff"
				},
				"dataProvider": filterOptionData,
				"valueAxes": [{ "axisAlpha": 0, }],
				"startDuration": 1,
				"graphs": [{
						"alphaField": "alpha",
						"balloonText": "<span style='font-size:12px;'>[[title]] in [[category]]:<br><span style='font-size:20px;'>[[value]]</span> [[additional]]</span>",
						"fillAlphas": 1,
						"title": "Data Points",
						"fillColors": "#DCDCDC",
						"fixedColumnWidth": 50,
						"type": "column",
						"valueField": "yplot",
						"showBalloon": false,
						"dashLengthField": "dashLengthColumn",
						"autoColor": true
					}, {
						"id": "graph2",
						"balloonText": "<span style='font-size:12px;'>[[title]] in [[category]]:<br><span style='font-size:20px;'>[[value]]</span> [[additional]]</span>",
						"bullet": "round",
						"lineColor": "#00bfff",
						"lineThickness": 3,
						"bulletSize": 15,
						"bulletBorderAlpha": 1,
						"bulletColor": "#fff",
						"useLineColorForBulletBorder": true,
						"bulletBorderThickness": 3,
						"fillAlphas": 0,
						"lineAlpha": 1,
						"type": "smoothedLine",
						"title": "Data Points",
						"valueField": "yplot",
						"dashLengthField": "dashLengthLine"
				}],
			    "chartScrollbar": {
			        "graph": "g1",
			        "oppositeAxis":false,
			        "offset":30,
			        "scrollbarHeight": 80,
			        "backgroundAlpha": 0,
			        "selectedBackgroundAlpha": 0.1,
			        "selectedBackgroundColor": "#888888",
			        "graphFillAlpha": 0,
			        "graphLineAlpha": 0.5,
			        "selectedGraphFillAlpha": 0,
			        "selectedGraphLineAlpha": 1,
			        "autoGridCount":true,
			        "color":"#AAAAAA"
			    },
			    "chartCursor": {
			        "pan": true,
			        "valueLineEnabled": true,
			        "valueLineBalloonEnabled": true,
			        "cursorAlpha":1,
			        "cursorColor":"#258cbb",
			        "limitToGraph":"g1",
			        "valueLineAlpha":0.2,
			        "valueZoomable":true
			    },
			    "valueScrollbar":{
					"oppositeAxis":false,
					"offset":50,
					"scrollbarHeight":10
			    },
				"categoryField": "xplot",
				"categoryAxis": {
					"gridPosition": "start",
					"axisAlpha": 0,
					"tickLength": 0,
					"gridThickness":0
				},
				"export": { "enabled": false }
			});
		}
	/* End Of Bar Line Chart*/

	/* Polar Area Chart*/
		var Chart1 = '';
	    function initPolarAreaChart(positions, chartId, response, polarChartTitle) {
			var d1 = ([response[0]]);
			var d2 = ([response[1]]);
			var d3 = ([response[2]]);

			var config = {
		        type: 'polarArea',
				data: {
					datasets: [{
						data: d1[0],
						backgroundColor: d3[0],
						label: 'Polar Area Chart'
					}],
					labels: d2[0]
				},

				options: {
					layout: {
			            padding: { left: 0, right: 0, top: 0, bottom: 0 },
			        },
					responsive: true,
					maintainAspectRatio: true,
					legend: {
						position: positions,
			            display: false,
			            labels: {
			                fontSize: 12, boxWidth: 20, fontColor: '#748aa7',
			            },

					},
					
					title: {
						display: true, padding: 50, text: polarChartTitle, fontColor: '#A9A9A9',fontSize: 14
					},
					animation: {
						animateScale: true, animateRotate: true
					},
				},
				
			};
			var elem1 = document.getElementById("mychart1");
			
			if (typeof elem1 !== 'undefined' && elem1 !== null) {
				var ctx = document.getElementById(chartId).getContext("2d");
				$(elem1).css('display','block');
				Chart1 = new Chart(ctx, config);
				document.getElementById('js-legend').innerHTML = Chart1.generateLegend();
				return Chart1;

			}

	    }
	/* End Of Polar Area Chart*/

	$(document).ready(function() {
		$('[id="no-filter-selected"]').nextAll().remove();
		$('.nav-item.active').click(function(){
		map.setZoom(2);
		});

		$('#areatab').click(function(){
		$('[id="no-filter-selected"]').nextAll().remove();
		});
		// $(".row .polarareachart #mychart1").css("opacity", "2 !important");
		var length;

		$(".infobox").hide();
		$('[data-toggle="tooltip"]').tooltip({ trigger: "manual" , html: true, animation:false})
		.on("mouseenter", function () {
		var _this = this;
		$(this).tooltip("show");
		$(".tooltip").on("mouseleave", function () {
		$(_this).tooltip('hide');
		});
		})
		.on("mouseleave", function () {
		var _this = this;
		setTimeout(function () {
		if (!$(".tooltip:hover").length) {
		$(_this).tooltip("hide");
		}
		}, 300);
		});
		/////////////////////
		// $('#dropdownMenu').tooltip({
		// selector: "li[data-toggle=tooltip]",
		// placement: "right"
		// })

		// var hover = false;
		// var li=0;
		// var $TT = $('.variables-list li ul.inner-list');
		// $('body').on('mouseenter', '.tooltip,.variables-list li ul.inner-list li[data-toggle="tooltip"]', function () {
		// hover = true;
		// })
		// $('.variables-list li ul.inner-list li').on('mouseenter', function() {
		// hover=false;
		// $('.tooltip').hide();
		// })
		// $('body').on('mouseleave', function() {
		// $('.tooltip').hide();
		// })
		// $('.variables-list li ul.inner-list').on('hide.bs.tooltip', function () {  
		// return !hover;
		// }) 
		/////////////////////
		//indicates whether the mouse over tooltip
 
		// //////////////////////
		/* Removal for filters Start*/
			function remove_filter(options){
				$('[id="no-filter-selected"]').nextAll().remove();
				var _for 		=	options.variable;
				var _for_title 	=	options.title;
				var _selected 	=	options.data;
				var _list=$('.application-wrapper ul.variables-list li[data-list-for='+_for+']');
				var __list_='';
				$('[id="no-filter-selected"]').nextAll().remove();
				if(_for=='gender'){ __list_+='<li data-lat="'+_selected+' data-long="'+_selected+'">'+_selected+'</li>'; }

				if(_for !='gender') { 	
					$.each(_selected,function(i,e){					
						if(_for=='location') {  __list_+='<li data-lat="'+e+' data-lat="'+e+'">'+e+'</li>'; } 
						else {
							var _sudo_attr='';
							if(_for=='age_range' && i=='end') { _sudo_attr='data-content="'+JsLang.year.toLowerCase()+'"'; }
							__list_+='<li data-id="'+i+'" '+_sudo_attr+'>'+e+'</li>';	
						}
					});
	            }

				var _list_inner='<ul class="inner-list">'+__list_+'</ul>';

				if (_list.length==0) { $('.application-wrapper ul.variables-list').append(''); }
				else {
					var _inner_list_obj=_list.find('ul.inner-list');
					if(_inner_list_obj.length==0){ _list.append(_list_inner); }
					else { _list.find('ul.inner-list').replaceWith(_list_inner); }
				}

				var _list_lengths = $('ul.variables-list > li').size();
				
				if (_list_lengths > 1) {
					if ( $('.no-filters-para') ) { $('.no-filters-para').hide(); }
				}else{
					if ( $('.no-filters-para') ) { $('.no-filters-para').show(); }
				}

				$().toastmessage('showToast', {
		            text     : 'Filter removed successfully',
		            sticky   : false,
		            position : 'bottom-right',
		            type     : 'success',
		            closeText: ''
		        });


			}
			
			$( ".remove-filter" ).click(function(){
				var filterdrop = $( "#filterDropdownOptions option" ).length;
				var dpv = $('.remove-filter').attr('data-post-variable');
				var remove_filters = $(this).siblings('span').text().toLowerCase();
				var current_filter = $( "#filterDropdownOptions option:selected" ).text().toLowerCase();
				var polarcurrent_filter = $( "#polarFilterDropdownOptions option:selected" ).text().toLowerCase();
				var removeclassCount = $('.remove-filter').length;
				if (remove_filters === current_filter || remove_filters.concat(" range") === current_filter || remove_filters.substring(0, remove_filters.length-1) === current_filter) {
					$('[id="no-filter-selected"]').nextAll().remove();
					$("#barlchart #no-filter-selected").remove();					
					$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );					
					$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');					
					if (removeclassCount > 1) {
						// $('#filterDropdownOptions').find('.baropt-apps_installled_select_filter').attr('selected', 'selected');
						$('#filterDropdownOptions').val('Select filter').trigger('change');
					}
				}
				if(remove_filters === polarcurrent_filter || remove_filters.concat(" range") === polarcurrent_filter || remove_filters.substring(0, remove_filters.length-1) === polarcurrent_filter){
					$('[id="no-filter-selected"]').nextAll().remove();
					$(".polarareachart #no-filter-selected").remove();
					$('.polarareachart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
					$('#mychart1').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
					$('#leg_container').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
					$('#mychart1').hide();
					$('#leg_container').hide();
					if (removeclassCount > 1) {
						// $('#polarFilterDropdownOptions').find('.baropt-apps_installled_select_filter').attr('selected', 'selected');
						$('#polarFilterDropdownOptions').val('Select filter').trigger('change');
					}
					$('[id="no-filter-selected"]').nextAll().remove();

				}

				if($( ".remove-filter" ).siblings('span').length<1)
				{
				$('#polarFilterDropdownOptions').val('Select filter').trigger('change');	
				}

				$(".baropt-"+$(this).attr('data-post-variable')).remove(); // option selected removal
				barLineChartFiltersAjax( ($( "#filterDropdownOptions option:selected" ).text()), ( $(".btn-toggle").find('.active').val() ), ('Showing averaged accumulative data within the selected '+($( "#filterDropdownOptions option:selected" ).text())) );
				polarAreaChartFiltersAjax( ($( "#polarFilterDropdownOptions option:selected" ).text()), ( $(".btn-toggle").find('.active').val() ), ('Showing averaged accumulative data within the selected '+($( "#polarFilterDropdownOptions option:selected" ).text())) );
				$(".div-"+$(this).attr('data-post-variable')).animate({height:0, opacity: 0}, 1500, function(){ $(this).remove(); } );
				$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/deleteVariable'); ?>',	
					data: {
						id : $(this).attr('data-post-app_id'),
						variableName: $(this).attr('data-post-variable')
					},
					dataType: 'json',
					success: function (response) {
						remove_filter(response.filter);
						if(dpv!='date'){ $('.time-slider-wrapper').removeClass('hide'); }
						if(response.filter.variable!=='location'){ clearClusters(); addClusters(response.location); }
					}				
				});
			});
		/* Removal for filters end */

		/* Drop Downs selections */
			// if($( "#filterDropdownOptions" ).text()== false ) {
			if($( "#filterDropdownOptions" ).text()== false ) {
				
				$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
				$('#mychart1').hide();
				$('#leg_container').hide();
				$('.polarareachart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				$('#polarFilterDropdownOptions').append('<option class="baropt-apps_installled_select_filter" value = "Select filter">Select filter</option>');
				$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				$('#filterDropdownOptions').append('<option class="baropt-apps_installled_select_filter" value = "Select filter">Select filter</option>');
			}
			else {
				$('#barchart').show();
				$('#mychart1').show();
				$('#leg_container').show();
				$('#barchart').removeAttr("style");
				$('#mychart1').hide();
				$('#leg_container').hide();
				$('.polarareachart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
				$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
			}
			
			if($( "#polarFilterDropdownOptions" ).text() == true ) {
				$('#mychart1').show();
				$('#leg_container').show();
				$('#mychart1').css("display","block");
				$('#leg_container').css("display","block");
				
			}
				 
			var barFilter = $( "#filterDropdownOptions option:selected" ).text();
			if (barFilter) {				
				var textTitle1 = 'Showing averaged accumulative data within the selected '+(barFilter);
				barLineChartFiltersAjax( barFilter , $(".btn-toggle").find('.active').val(), textTitle1 );
			}

			var polarFilter = $( "#polarFilterDropdownOptions option:selected" ).text();			
			if (polarFilter) {
				var polarTitle1 = 'Showing averaged accumulative data within the selected '+(polarFilter);
				polarAreaChartFiltersAjax( polarFilter , $(".btn-toggle").find('.active').val(), polarTitle1 );
			}
			else { $('#chartdiv').append('<div class="col-sm-12"><h5>Please select some filters<h5></div>'); }

		    $( "#filterDropdownOptions" ).unbind("change").on("change", function(){
		    	var dropDownFilter = $( "#filterDropdownOptions option:selected" ).text();
				var logicalOperator = $(".btn-toggle").find('.active').val();
				var textTitle2 = 'Showing averaged accumulative data within the selected '+dropDownFilter;
				$("#filterDropdownOptions .baropt-apps_installled_select_filter").removeAttr("selected");
				if (dropDownFilter === "Select filter") {
					$("#barlchart #no-filter-selected").remove();		
					$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
					$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				}else{
					barLineChartFiltersAjax(dropDownFilter, logicalOperator, textTitle2);	
				}
		    });

		    $( "#polarFilterDropdownOptions" ).unbind("change").on("change", function(){
		    	var polardropDownFilter = $( "#polarFilterDropdownOptions option:selected" ).text();
				var polarlogicalOperator = $(".polarChart-toggle").find('.active').val();
				var polarTitle2 = 'Showing averaged accumulative data within the selected '+polardropDownFilter;
				$("#polarFilterDropdownOptions .baropt-apps_installled_select_filter").removeAttr("selected");
				if (polardropDownFilter === "Select filter") {
					$('#mychart1').hide();
					$('#leg_container').hide();
					$('.polarareachart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
					$('[id="no-filter-selected"]').nextAll().remove();
				}else{

					polarAreaChartFiltersAjax(polardropDownFilter, polarlogicalOperator, polarTitle2);
				}
		    });
	    /* Drop Downs selections */

		/*Toggle Button code*/
			$('.barchart-toggle').click(function() {
				/* toggle class */
				$(this).find('.btn').toggleClass('active');			    
			    if ($(this).find('.btn-primary').length>0) { $(this).find('.btn').toggleClass('btn-primary'); }
			    $(this).find('.btn').toggleClass('btn-default');

				var dropDownFilter = $( "#filterDropdownOptions option:selected" ).text();
				var logicalOperator = $(".barchart-toggle").find('.active').val();
				var textTitle3 = 'Showing averaged accumulative data within the selected '+dropDownFilter;
				barLineChartFiltersAjax(dropDownFilter, logicalOperator, textTitle3);
			});

			$('.polarChart-toggle').click(function() {
				/* toggle class */
				$(this).find('.btn').toggleClass('active');			    
			    if ($(this).find('.btn-primary').length>0) { $(this).find('.btn').toggleClass('btn-primary'); }
			    $(this).find('.btn').toggleClass('btn-default');

				var polardropDownFilter = $( "#polarFilterDropdownOptions option:selected" ).text();
				var polarlogicalOperator = $(".polarChart-toggle").find('.active').val();
				var textTitle3 = 'Showing averaged accumulative data within the selected '+polardropDownFilter;
				console.log(polarlogicalOperator);
				polarAreaChartFiltersAjax(polardropDownFilter, polarlogicalOperator, textTitle3);
			});
		/*End of toggle b utton code*/

		/* Ajax calls for bar and polar chart */
			function barLineChartFiltersAjax(filter, logicalOperator, barchartTitle) {
				$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/barLineChartFilters'); ?>',	
					data: {
						filter: filter,
						logicalOperator: logicalOperator,
						app_id: <?=$app->id;?>
					},
					dataType: 'json',
					success: function (response) {
						if (response.length > 0){
							initBarChart(response, logicalOperator, barchartTitle);							
							$('#barchart').show();
							$('#barchart').removeAttr("style");
							$("#barlchart #no-filter-selected").remove();
						}
						else {	
							var removeclassCount = $('.remove-filter').length;
							$("#barlchart #no-filter-selected").remove();					
							$('#barchart').animate({height:0, opacity: 0}, 200, function(){ $(this).hide(); } );					
							$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');			
							if (removeclassCount > 1) {
								$('#filterDropdownOptions').val('Select filter').trigger('change');
								// $('#filterDropdownOptions').find('.baropt-apps_installled_select_filter').attr('selected', 'selected');
							}
							var toastSuccess = 'No Data to show on Bar chart';
							$().toastmessage('showToast', {
					            text     : toastSuccess,
					            sticky   : false,
					            position : 'bottom-right',
					            type     : 'error',
					            closeText: ''
					        });
						}
					}				
				});
			}

			function polarAreaChartFiltersAjax(filter, logicalOperator, polarChartTitle) {
				$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/polarAreaChartFilters'); ?>',	
					data: {
						filter: filter,
						logicalOperator: logicalOperator,
						// logicalOperator: 'AND',
						app_id: <?=$app->id;?>
					},
					dataType: 'json',
					success: function (response) {
						
						if (response.length >0 && $.isEmptyObject(response[0])===false){
							if (Chart1) {
								console.log("test1");
								Chart1.destroy();

							}
							initPolarAreaChart('right', 'mychart1', response, polarChartTitle);
						    if ($(window).width() < 1024) {
								console.log("test2");

								Chart1.destroy();
								initPolarAreaChart('right', 'mychart1', response, polarChartTitle);
						    }

							$('#mychart1').show();
							$('#leg_container').show();
							$('#mychart1').css("display","block");
							$('#leg_container').css("display","block");
							$(".polarareachart #no-filter-selected").remove();
						   
						}
						else {
							$('[id="no-filter-selected"]').nextAll().remove();
							var toastSuccess = 'No Data to show on Polar Area chart';
							$().toastmessage('showToast', {
					            text     : toastSuccess,
					            sticky   : false,
					            position : 'bottom-right',
					            type     : 'error',
					            closeText: ''
					        });
							
						}
					}				
				});
			}
		/* End of Ajax calls for bar and polar chart */

		$(".addvariable, .variable-filter").click(function(){  $("div#app-ajax-modal").addClass("add-new-variable-btn-for-model");  });

		/* Single app time slider starts */
	        showPlay();

	        var date = new Date();
			var dd = date.getDate();
			var mm = date.getMonth()+1; //January is 0!
			var yyyy = date.getFullYear();

			if(dd<10) { dd = '0'+dd; } 

			if(mm<10) { mm = '0'+mm; }

	        var date = yyyy + '-' + mm + '-' + dd;
			var stop = false;
			var currentFrame = 0;
			var interval;
			var speed = 1000; // time between frames in 

			$('input:text[name="date"]').change(function(){
		       date = $(this).val();
		       if (count) {
					$(".infobox").hide();
		             	currentFrame = 0;
		             	$('.stripe').css('width', '0%');
				        $('.handle').css('left', '0%');
						markerCluster.clearMarkers();
						<?php 
			             	if(count($locationData)>0){ echo "addClusters(".json_encode($locationData).")"; }
						?>
	            }
	            else {
	            	if($('div.toast-container.toast-position-top-right div').length < 1){
	            	var toastSuccess = 'No Data Count available';
					$().toastmessage('showToast', {
			            text     : toastSuccess,
			            sticky   : false,
			            position : 'top-right',
			            type     : 'error',
			            closeText: ''
			        });
					}
	            }
		       dateFilterAjax(date);
			});

			function dateFilterAjax(date) {
				$(".infobox").show();
				$.ajax({
					type: 'post',
					url: '<?php echo $this->url->get('application/dateWiseLocation'); ?>',
					data: {
						date:date,
						app_id: <?=$app->id;?>
					},
					dataType: 'json',
					success: function (response) {
						if (response.length >0){
							var count = response.length;
							var timer = date.slice(11, 13);
							if (timer <=12) { timer = timer+' AM';	/* 02 AM, 10 AM Format */ }
							else{
								if ((timer-12) < 10) { timer = '0'+(timer-12)+' PM';  /* 02 PM Format */ }
								else{ timer = (timer-12)+' PM';	 /* 10 PM Format */ }
							}

							if(markerCluster){ markerCluster.clearMarkers(); }
							addClusters(response);
							$(".info-price").html(timer+' / '+count+' DP');
						}
					}				
				});
			}

	        $('#stop').click( function() {
	            if (count) {
					$(".infobox").show();
		            stop = true;
		        	showPlay();
	            	togglePlay();
	            }
	            else {
	            	if($('div.toast-container.toast-position-top-right div').length < 1){
					$().toastmessage('showToast', {
			            text     : 'No Data Count available',
			            sticky   : false,
			            position : 'top-right',
			            type     : 'error',
			            closeText: ''
			        });
					}
	            }
	        });
	        
	        $('#play').click( function() {

	            if (count) {
					$(".infobox").show();
		            stop = false;
		            showPause();
	             	togglePlay();
	            }
	            else {
	            	if($('div.toast-container.toast-position-bottom-right div').length < 1){
	            	var toastSuccess = 'No Data Count available';
					$().toastmessage('showToast', {
			            text     : toastSuccess,
			            sticky   : false,
			            position : 'bottom-right',
			            type     : 'error',
			            closeText: ''
			        });
					}
	            }
	        });

	        $('#repeat').click( function() {
            	$(".infobox").hide();
	            if (!stop) {
	            	stop = true;
             		togglePlay();
	            }
		        showPlay();
	            currentFrame = 0;
	            $('.stripe').css('width', '0%');
			    $('.handle').css('left', '0%');
			    $('input:text[name="date"]').attr('value', '');
				markerCluster.clearMarkers();
				<?php if(count($locationData)>0){ echo "addClusters(".json_encode($locationData).")"; } ?>
	        });
	        
	        function showPause() { 	$('#play').hide(); $('#stop').show(); }
	        
	        function showPlay() {	$('#stop').hide(); $('#play').show(); }

			/* The code responsible for animating the motion map data */
			var timer;
			function timedCount() {
			    timer = setTimeout(timedCount, 500);
			    
			}

			
			// function for toggle starts here
				function togglePlay(dragval) {	
					
					if(dragval){ currentFrame = dragval; }
					console.log("interval: ",interval);
					if ( interval ) {
						clearTimeout(timer);
						timedCount();	
						
						showPlay();	
										
						// check if animation is playing (interval is set)
						clearInterval( interval );		// stop playing (clear interval)
						interval=null;
						$('.stripe').css('width', currentFrame+'%');
						$('.handle').css('left', currentFrame+'%');
					}
				  	else {
				  		clearTimeout(timer);
				  		timedCount();
						showPause();
						
					    // start playing
					    interval = setInterval( function () {
							currentFrame++;	// iterate the frame
							if ( currentFrame >= 100 ){ currentFrame = 0; }
					        $('.stripe').css('width', currentFrame+'%');
					        $('.handle').css('left', currentFrame+'%');
					        var n = $(".stripe").css("width");
					        // var n = $(".stripe").css("width");		this gives width's value in px format
					        // var n = $('.stripe')[0].style.width;		// this gives width's value in % format
					       
					        var parsedWidth = parseInt(currentFrame);		// parsed value of width attribute
							if (parsedWidth > 0 && parsedWidth < 4) { var processedDate0 = date+' 00';  dateFilterAjax(processedDate0);  }
							if (parsedWidth > 4 && parsedWidth < 8) {   var processedDate1 = date+' 01';  dateFilterAjax(processedDate1);  }
							if (parsedWidth > 8 && parsedWidth < 12) {  var processedDate2 = date+' 02';  dateFilterAjax(processedDate2);  }
							if (parsedWidth > 12 && parsedWidth < 16) { var processedDate3 = date+' 03';  dateFilterAjax(processedDate3);  }
							if (parsedWidth > 16 && parsedWidth < 20) { var processedDate4 = date+' 04';  dateFilterAjax(processedDate4);  }
							if (parsedWidth > 20 && parsedWidth < 24) { var processedDate5 = date+' 05';  dateFilterAjax(processedDate5);  }
							if (parsedWidth > 24 && parsedWidth < 28) { var processedDate6 = date+' 06';  dateFilterAjax(processedDate6);  }
							if (parsedWidth > 28 && parsedWidth < 32) { var processedDate7 = date+' 07';  dateFilterAjax(processedDate7);  }
							if (parsedWidth > 32 && parsedWidth < 36) { var processedDate8 = date+' 08';  dateFilterAjax(processedDate8);  }
							if (parsedWidth > 36 && parsedWidth < 40) { var processedDate9 = date+' 09';  dateFilterAjax(processedDate9);  }
							if (parsedWidth > 40 && parsedWidth < 44) { var processedDate10 = date+' 10'; dateFilterAjax(processedDate10); }
							if (parsedWidth > 44 && parsedWidth < 48) { var processedDate11 = date+' 11'; dateFilterAjax(processedDate11); }
							if (parsedWidth > 48 && parsedWidth < 52) { var processedDate12 = date+' 12'; dateFilterAjax(processedDate12); }
							if (parsedWidth > 52 && parsedWidth < 56) { var processedDate13 = date+' 13'; dateFilterAjax(processedDate13); }
							if (parsedWidth > 56 && parsedWidth < 60) { var processedDate14 = date+' 14'; dateFilterAjax(processedDate14); }
							if (parsedWidth > 60 && parsedWidth < 64) { var processedDate15 = date+' 15'; dateFilterAjax(processedDate15); }
							if (parsedWidth > 64 && parsedWidth < 68) { var processedDate16 = date+' 16'; dateFilterAjax(processedDate16); }
							if (parsedWidth > 68 && parsedWidth < 72) { var processedDate17 = date+' 17'; dateFilterAjax(processedDate17); }
							if (parsedWidth > 72 && parsedWidth < 76) { var processedDate18 = date+' 18'; dateFilterAjax(processedDate18); }
							if (parsedWidth > 76 && parsedWidth < 80) { var processedDate19 = date+' 19'; dateFilterAjax(processedDate19); }
							if (parsedWidth > 80 && parsedWidth < 84) { var processedDate20 = date+' 20'; dateFilterAjax(processedDate20); }
							if (parsedWidth > 84 && parsedWidth < 88) { var processedDate21 = date+' 21'; dateFilterAjax(processedDate21); }
							if (parsedWidth > 88 && parsedWidth < 92) { var processedDate22 = date+' 22'; dateFilterAjax(processedDate22); }
							if (parsedWidth > 92 && parsedWidth < 96) { var processedDate23 = date+' 23'; dateFilterAjax(processedDate23); }
							if (parsedWidth > 96) { var processedDate24 = date+' 00'; dateFilterAjax(processedDate24); }
							if (parsedWidth == 99) {
								$(".infobox").show();
					            stop = true;
					        	showPlay();
				            	togglePlay();
							}
					    }, speed );
				  	}
				}
			// function for toggle ends here

			/* Below script is for horizontal slider bar */
				new Dragdealer('pr-slider', {
			    	animationCallback: function(x, y) {
			      	  var slider_value = ((Math.round(x * 100)));
			      	  if(slider_value>0){ togglePlay(slider_value); }
				      var stripe_width = slider_value+1;
				      $(".stripe").css("width", ""+stripe_width+"%");
				      if(slider_value > 0 && slider_value < 6){ var processedDate1 = date+' 01'; dateFilterAjax(processedDate1); }
				      if(slider_value > 5 && slider_value < 37){
					      if(slider_value > 5){  var processedDate2 = date+' 02'; dateFilterAjax(processedDate2);  }	
					      if(slider_value > 9){  var processedDate3 = date+' 03'; dateFilterAjax(processedDate3);  }	
					      if(slider_value > 13){ var processedDate4 = date+' 04'; dateFilterAjax(processedDate4);  }
					      if(slider_value > 17){ var processedDate5 = date+' 05'; dateFilterAjax(processedDate5);  }
					      if(slider_value > 21){ var processedDate6 = date+' 06'; dateFilterAjax(processedDate6);  }
					      if(slider_value > 25){ var processedDate7 = date+' 07'; dateFilterAjax(processedDate7);  }
					      if(slider_value > 29){ var processedDate8 = date+' 08'; dateFilterAjax(processedDate8);  }
					      if(slider_value > 33){ var processedDate9 = date+' 09'; dateFilterAjax(processedDate9);  }					      
				      }				      
				      if(slider_value > 38 && slider_value < 83){
					      if(slider_value > 38){ var processedDate10 = date+' 10'; dateFilterAjax(processedDate10); }
					      if(slider_value > 42){ var processedDate11 = date+' 11'; dateFilterAjax(processedDate11); }					      
					      if(slider_value > 46){ var processedDate12 = date+' 12'; dateFilterAjax(processedDate12); }      
					      if(slider_value > 50){ var processedDate13 = date+' 13'; dateFilterAjax(processedDate13); }					      
					      if(slider_value > 54){ var processedDate14 = date+' 14'; dateFilterAjax(processedDate14); }
					      if(slider_value > 58){ var processedDate15 = date+' 15'; dateFilterAjax(processedDate15); }
					      if(slider_value > 62){ var processedDate16 = date+' 16'; dateFilterAjax(processedDate16); }
					      if(slider_value > 66){ var processedDate17 = date+' 17'; dateFilterAjax(processedDate17); }
					      if(slider_value > 68){ var processedDate18 = date+' 18'; dateFilterAjax(processedDate18); }
					      if(slider_value > 72){ var processedDate19 = date+' 19'; dateFilterAjax(processedDate19); }
					      if(slider_value > 76){ var processedDate20 = date+' 20'; dateFilterAjax(processedDate20); }
					      if(slider_value > 80){ var processedDate21 = date+' 21'; dateFilterAjax(processedDate21); }
				      }				      
				      if(slider_value > 83){ var processedDate22 = date+' 22'; dateFilterAjax(processedDate22); }
				    }
				});			   
			/* end of script for horizontal slider bar */
        /* Single app time slider ends */
	
		$('.date').bootstrapMaterialDatePicker({ weekStart : 0, time: false, clearButton: true, maxDate : new Date() }); // date picker
		$('ul.inner-list li[data-id=end]').attr('data-content',JsLang.year.toLowerCase());
		<?php if(count($locationData)>0){ echo "addClusters(".json_encode($locationData).")"; } ?>
	});
</script>
<script src="<?=$this->url->get("js/map/markerclusterer.js");?>"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCq-fo0gCMC-nZpvJD9199SnZRxqvl1FU4&libraries=places&callback=initMap"></script>

<script>
	$(document).ready(function(){
     
     $( '.main-right-wrapper #wrapper .application-wrapper .filter-otion-wrappp .tabpie-wrap' ).append( "<div class='location-wrap'></div>" );
     $('.searchapp').attr('tab-index','-1');
     
	})

</script>