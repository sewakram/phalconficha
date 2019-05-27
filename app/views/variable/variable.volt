<?=modal_anchor($t->_("back_to_variables"),['url' => $this->url->get('variable/add_variable'), 'data-post-variable' =>'add_variable', 'data-post-app_id' =>$app_id, 'data-title'=>$t->_("add_variable"), 'class'=>'modal-back']);?>

<style type="text/css">
	.btn-default:hover, .btn-default:focus{ background-color:#ededed !important; }
</style>

<div class="variable-wrapper">
	<form action="<?php echo $this->url->get('variable/variable_submit'); ?>" id="add_variable_form" method="post">
		<input type="hidden" name="variable" value="<?=$variable;?>" />
		<input type="hidden" name="app_id" value="<?=$app_id;?>" />
		<?php
			if($variable == 'gender'){
				$_gender = array(
					$t->_("both_genders") 	=> "icon-people",
					$t->_("female") 		=> "icon-user-female",
					$t->_("male") 			=> "icon-user"
				);
				?>
				<div class="col-sm-12">
					<input type="hidden" name="title" value="Gender">
					<input type="hidden" name="modal_title" value="Gender">
					<div class="modal-subtitle text-center">
						<?= $t->_("gender_variable_para");?>
					</div>
					<ul class="options selectable">
						<?php foreach ($_gender as $key => $icon) {
							$_chk = '';
							$active = '';

							if($filterData && isset($filterData->data)){
								//$_chk = in_array($key, $filterData->data) ? 'checked="checked"' : "";
								//$active = in_array($key, $filterData->data) ? 'class="active"' : "";
							}
							?>
							<li <?=$active?> >
								<span class="radio-select">
									<input type="radio" class="hide" name="gender" value="<?=$key;?>" id="gender_<?=$key;?>" <?=$_chk;?>>
									<label class="<?=$icon;?> icons" for="gender_<?=$key;?>"></label>
									<span><?=ucfirst($key);?></span>
								</span>
							</li> <?php 
						} ?>
					</ul>
				</div>
				<?php
			}

			if($variable == 'age_range'){
				$start_age = '';
				$end_age = '';
				if($filterData && isset($filterData->data)){
					$start_age = $filterData->data->age_range_start;
					$end_age = $filterData->data->age_range_end;
				} ?>
				<input type="hidden" name="title" value="Age range">
				<input type="hidden" name="modal_title" value="Select age range">
				<div id="age_range_options">
					<p class="modal-subtitle text-center"><?= $t->_("age_range_variable_para");?></p>
					<div class="row age-range-middle-content">
						<div class="col-md-6 form-group">
							<p><?= $t->_("initial_age_range");?></p>
							<div class="input-group">
								<span class="input-group-btn">
									<button type="button" class="btn minus btn-default btn-number" data-type="minus" disabled="disabled" data-field="age_range_start">
										<span class="glyphicon glyphicon-minus"></span>
									</button>
								</span>
								<input type="text" class="form-control input-number placeholder" name="age_range_start" id="age_range_start" placeholder="00" value="<?php echo $start_age; ?>" min="1" max="100" required="required">
								<span class="input-group-btn">
									<button type="button" class="btn plus btn-default btn-number" data-type="plus" data-field="age_range_start">
										<span class="glyphicon glyphicon-plus"></span>
									</button>
								</span>
							</div>
						</div>
						<div class="col-md-6 form-group">
							<p><?= $t->_("final_age_range");?></p>
							<div class="input-group">
								<span class="input-group-btn">
									<button type="button" class="btn minus btn-default btn-number2" data-type="minus" disabled="disabled" data-field="age_range_end">
										<span class="glyphicon glyphicon-minus"></span>
									</button>
								</span>
								<input type="text" class="form-control input-number2 placeholder" name="age_range_end"  id="age_range_end" placeholder="00"  value="<?php echo $end_age; ?>" min="1" max="100" required="required">
								<span class="input-group-btn">
									<button type="button" class="btn plus btn-default btn-number2" data-type="plus" data-field="age_range_end">
										<span class="glyphicon glyphicon-plus"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="clearfix"></div><div class="clearfix"></div>
					<div class="form-group" style="margin-top: 10px;">
						<button type="submit" class="btn-warning btn"><?= $t->_("set_age_range");?></button>
					</div>
				</div> <?php
			}

			if($variable == 'mobile_make'){
				$_models = array(
					$t->_("all_models") => "icon-grid",
					$t->_("custom_models") => "icon-equalizer",
				); ?>
				<input type="hidden" name="title" value="Phone Models">
				<input type="hidden" name="modal_title" value="Phone Models">
				<p class="modal-subtitle text-center"><?= $t->_("phone_models_variable_para");?></p>
				<div class="row mobile-make-middle-content">
					<ul class="options">
						<?php foreach ($_models as $key => $icon) {
							$_chk = '';
							$active = '';
							if($filterData && isset($filterData->data)){
								$_chk = "";
								// $_chk = in_array($key, $filterData->data) ? 'checked="checked"' : "";
								// $active = in_array($key, $filterData->data) ? 'class="active"' : "";
								$active = "";
							}
							?>
							<li class="<?php $active; echo ($icon=='icon-grid')? 'selectable':''?>">
								<a data-toggle="pill" href="<?php echo ($icon=='icon-grid')? '#allmodel':'#custmodel'?>">
									<span class="radio-select">
										<input type="radio" class="hide" name="models" value="<?=$key;?>" id="models_<?=$key;?>" <?=$_chk;?>>
											<i class="<?=$icon;?> icons"></i>
											<span><?=ucfirst($key);?></span>
									</span>
								</a>
							</li> <?php
						} ?>
					</ul>
				</div>
				<div id="allmodel" class="checkable tab-pane fade in active">
					<?php

					$all_models=array();
					foreach ($mobileMakeData as $maker) {
					//$all_models=explode(',', $maker->model_name);
					array_push($all_models, $maker->model_name);
					}
					$all_models1=json_encode($all_models);
					// echo str_replace('"',"'",json_encode($all_models));exit;
					 // echo $all_models1;
					?>
					<input type="radio" class="hide" name="all" value='<?php echo $all_models1;?>' id="models_all_models">
				</div>
				<div id="custmodel" class="tab-pane fade">
					<span class="available-phone-model-text"><?= $t->_("select_available_phone");?>: </span>
					<div class="select-mobile-make-wrapper" data-toggle="buttons">
						<select class="form-control" id="select_mobile_make" name="mobile_make[]" multiple="multiple" class="required">
							<?php
								$_selected_data = ($filterData && isset($filterData->data)) ? array_keys((array)$filterData->data) : array();
								foreach ($mobileMakeData as $maker) {
									// $_chk = in_array($maker->model_name, $_selected_data) ? 'selected="selected"' : "";
									printf('<option value="%s" %s>%s</option>',$maker->model_name, $_chk, $maker->model_name);
								}
							?>
						</select>
						<?php 
							/*$_mobileValue = (array)$filterData->data;
							$i=0;
							foreach ($mobile_make as $maker) {
								if($i==30){ break; }
								$i++;
								$_chk = '';
								$active = '';
								if($filterData && isset($filterData->data)){
									$_chk = in_array($maker->id, array_keys($_mobileValue)) ? 'checked="checked"' : "";
									$active = in_array($maker->id, array_keys($_mobileValue)) ? 'class="btn ficha-select-btn active"' : 'class="btn ficha-select-btn"';	
								} ?>
								<label for="<?=$variable.'_'.$maker->id;?>" <?=$active;?> > <?=$maker->brand_name; ?>
									<input type="checkbox" name="<?=$variable.'_'.$maker->id;?>" data-id="<?=$maker->id;?>" value="<?=$maker->brand_name;?>" id="<?=$variable.'_'.$maker->id;?>" <?=$_chk;?> >
								</label> <?php
							}*/
						?> 
						<div class="form-group">
							<button class="btn-warning btn" type="submit"><?= $t->_("set_phone_models");?></button>
						</div>
		      		</div>
	      		</div> <?php
			}

			if($variable == 'location'){
				$_models = array(
					$t->_("all_locations") 		=> "icon-globe",
					$t->_("custom_locations") 	=> "icon-equalizer",
				);
				?>
				<input type="hidden" name="title" value="Location">
				<input type="hidden" name="modal_title" value="Location">
				<p class="modal-subtitle text-center"><?= $t->_("location_variable_para");?></p>
				<div class="row location-middle-content">
					<ul class="options ">
						<?php foreach ($_models as $key => $icon) {
							$_chk = '';
							$active = '';
							if($filterData && isset($filterData->data)){
								//$_chk = in_array($key, $filterData->data) ? 'checked="checked"' : "";
								//$active = in_array($key, $filterData->data) ? 'class="active"' : "";
							} ?>
							<li class="<?php $active; echo ($icon=='icon-globe')? 'selectable':''?>">
								<a data-toggle="pill" href="<?php echo ($icon=='icon-globe')? '#allloc':'#custloc'?>">
									<span class="radio-select">
										<input type="radio" class="hide" name="location" value="<?=$key;?>" id="location_<?=$key;?>" <?=$_chk;?>>
										<i class="<?=$icon;?> icons"></i><!-- <i class="far fa-sliders-v"></i> -->
										<span><?=ucfirst($key);?></span>
									</span>
								</a>
							</li> <?php 
						} ?>
					</ul>
				</div>
				<div id="allloc" class="checkable tab-pane fade in active">
					<?php

					$all_locations=array();
					foreach ($cityTableData as $location) {
					//$all_models=explode(',', $maker->model_name);
					array_push($all_locations, $location->name);
					}
					$all_locations1=json_encode($all_locations);
					
					?>
					<input type="checkbox" class="hide" name="all" value='<?php echo $all_locations1;?>' id="models_all_locations">
				</div>
				<div id="custloc" class="tab-pane fade">
					<div class="g-map-autocomplete">
						<span class="available-phone-model-text"><?= $t->_("select_available_location");?>: </span>
						<select class="form-control" id="autocomplete2" name="location[]" multiple="multiple" class="required">
							<?php
								$_selected_data = ($filterData && isset($filterData->data)) ? array_keys((array)$filterData->data) : array();
								foreach ($cityTableData as $maker) {
									printf('<option value="%s" %s>%s</option>', $maker->name, $_chk, $maker->name);
								}
							?>
						</select>
						<div class="form-group">
							<button class="btn-warning btn" type="submit"><?= $t->_("set_locations");?></button>
						</div>
					</div>
				</div> <?php
			}

			if($variable == 'date'){
				$startdate = '';
				$enddate = '';
				if($filterData && isset($filterData->data)){
					$startdate = $filterData->data->datestart;
					$enddate = $filterData->data->dateend;
				}
				?>
				<input type="hidden" name="title" value="Date range">
				<input type="hidden" name="modal_title" value="Date range">
				<p class="modal-subtitle text-center"><?= $t->_("date_variable_para");?></p>
				<div class="well">
					<strong><?= $t->_("important");?></strong><span><?= $t->_("important_date_range_para");?></span>
				</div>
				<div class="row age-range-middle-content date-range-middle-content">
					<div class="col-md-6 form-group">
						<p><?= $t->_("initial_date_range");?></p>
						<div class="date-picker-wrapp input-group">
							<input type="text" id="date_range_start" name="datestart" class="form-control date placeholder" placeholder="2018/03/14" data-rule-required="true" value="<?=$startdate?>">
							<label class="input-group-addon btn" for="date_range_start">
								<img src="<?=$this->url->get('images/single_app_with_data_icons/calender_hd.png');?>" width="25" height="25">
							</label>
						</div>
					</div>
					<div class="col-md-6 form-group">
						<p><?= $t->_("final_date_range");?></p>
						<div class="date-picker-wrapp input-group">
							<input type="text" id="date_range_end" name="dateend" class="form-control date placeholder" placeholder="2018/03/30" value="<?=$enddate?>">
							<label class="input-group-addon btn" for="date_range_end">
								<img src="<?=$this->url->get('images/single_app_with_data_icons/calender_hd.png');?>" width="25" height="25">
							</label>
						</div>
					</div>
				</div>
				<div class="clearfix"></div><div class="clearfix"></div>
				<div class="g-map-autocomplete">
					<div class="form-group" style="margin-top: 10px;">
						<button class="btn-warning btn" type="submit"><?= $t->_("set_date_range");?></button>
					</div>
				</div> <?php
			}

			if($variable == 'apps_installled'){
				$_apps = array(
					$t->_("all_applications") 		=> "icon-layers",
					$t->_("custom_applications") 	=> "icon-equalizer",
				); ?>
				<input type="hidden" name="title" value="Installed Applications">
				<input type="hidden" name="modal_title" value="Installed Applications">
				<p class="modal-subtitle text-center"><?= $t->_("apps_installled_variable_para");?></p>
				<div class="row location-middle-content install-applications-middle-content">
					<ul class="options">
						<?php foreach ($_apps as $key => $icon) {
							$_chk = '';
							$active = '';
							if($filterData && isset($filterData->data)){
								$_chk = in_array($key, $filterData->data) ? 'checked="checked"' : "";
								$active = in_array($key, $filterData->data) ? 'class="active"' : "";
							} ?>
							<li class="<?php $active; echo ($icon=='icon-layers')? 'selectable':''?>">
								<a data-toggle="pill" href="<?php echo ($icon=='icon-layers')? '#allapp':'#custapp'?>">
									<span class="radio-select">
										<input type="radio" class="hide" name="apps" value="<?=$key;?>" id="apps_<?=$key;?>" <?=$_chk;?>>
										<i class="<?=$icon;?> icons"></i><!-- <i class="far fa-sliders-v"></i> -->
										<span><?=ucfirst($key);?></span>
									</span>
								</a>
							</li> <?php
						} ?>
					</ul>
				</div>
				<div id="allapp" class="checkable tab-pane fade in active">
					<?php

					$all_apps=array();
					foreach ($installedAppData as $singleapp) {
					//$all_models=explode(',', $maker->model_name);
					array_push($all_apps, $singleapp->app_name);
					}
					$all_apps1=json_encode($all_apps);
					// echo str_replace('"',"'",json_encode($all_models));exit;
					 // echo $all_models1;
					?>
					<input type="radio" class="hide" name="all" value='<?php echo $all_apps1;?>' id="models_all_applications">
					<!-- <input type="radio" class="hide" name="<?=$variable;?>" value="all_applications" id="models_all_applications"> -->
				</div>
				<div id="custapp" class="tab-pane fade">
					<div class="select-mobile-make-wrapper" data-toggle="buttons">
						<span class="available-phone-model-text"><?= $t->_("select_installed_applications");?>: </span>
				        <select class="form-control" id="applications" name="applications[]" multiple="multiple" class="required">
							<?php
								$_selected_data = ($filterData && isset($filterData->data)) ? array_keys((array)$filterData->data) : array();
								foreach ($installedAppData as $app) {
									//$_chk = in_array($app->app_name, $_selected_data) ? 'selected="selected"' : "";
									printf('<option value="%s" %s>%s</option>',$app->app_name, $_chk, ucfirst($app->app_name));
								}
							?>
						</select>
				         
						<div class="form-group">
							<button class="btn-warning btn" type="submit"><?= $t->_("set_installed_apps");?></button>
						</div>
		      		</div>
	      		</div> <?php 
			}
		?>
	</form>
	<div class="clearfix"></div>
</div>

<!-- Animation from bottom to top script -->
	<script type="text/javascript">
		var time = 0;
		$(".radio-select" ).addClass("hide").each(function( index ) {
	       setTimeout(function(){
	            openAnimate(".radio-select:eq( "+index+" )",'fadeInUp');
	       },time+=200);
	    });
	</script>
<!-- End of the animation script -->

<script type='text/javascript'>
	$(document).ready(function() {
		// $('#age_range_start').change(function(e){
			
		// 	if(this.value > $('#age_range_end').val())
		// 	{
		// 		this.focus().css('border', '1px solid #c80000');
		// 				return false;
		// 	}
		// });
		// $('[id="no-filter-selected"]').nextAll().remove();
		function chooseOptionToast() {
			if($('div.toast-container.toast-position-bottom-right div').length < 1){
				$().toastmessage('showToast', {
		            text     : 'Please choose an option',
		            sticky   : false,
		            position : 'bottom-right',
		            type     : 'error',
		            closeText: ''
		        });
		    }
		}

		$('#age_range_start').val();
		var length;
		/*Toggle Button code*/
	        // $('.btn-toggle').click(function() {
	        //     $(this).find('.btn').toggleClass('active');  
	            
	        //     if($(this).find('.btn-primary').length >0) {
	        //         $(this).find('.btn').toggleClass('btn-primary');
	        //     }
	            
	        //     $(this).find('.btn').toggleClass('btn-default');
	        // });
        /*End of toggle b utton code*/
		 
		$("#select_mobile_make").select2({ placeholder: "Select Phone", });
		$("#autocomplete2").select2({ placeholder: "Select Location", });
		$("#applications").select2({ placeholder: "Select App", });

		var request = {
			type:'post',
			url:'<?=$this->url->get('application/save_variable'); ?>',
			data:{},
		};

		<?php if($variable == 'location') { ?>	
			var location_btn_count=0;
			var autocomplete;
			var countries = ['uk','us', 'in', 'gt'];
			var autocompleteSelectedData = [];

			function initAutocomplete() {
				var input = document.getElementById('autocomplete');

				var options = {
				   types: ['(cities)'],
				   componentRestrictions: {country: countries}
				};

				autocomplete = new google.maps.places.Autocomplete(input, options);

				google.maps.event.addListener(autocomplete, 'place_changed', function () {
					var _bounds = new google.maps.LatLngBounds();
		            var place = autocomplete.getPlace();
					if (place.geometry.viewport) {
					  // Only geocodes have viewport.
					  _bounds.union(place.geometry.viewport);
					} else {
					  _bounds.extend(place.geometry.location);
					}

					map.fitBounds(_bounds);
					if(map.getZoom()>8){
						map.setZoom(8);	
					}
		            var placesObj = new Object();
		            placesObj.city = place.name;
		            placesObj.latitude = place.geometry.location.lat();
		            placesObj.longitude = place.geometry.location.lng();
		            placesObj.formatted_address = place.formatted_address;
		            generate_city_btn(placesObj);
		            autocompleteSelectedData.push(placesObj);   
		            request.data=getdata();
					call_ajax(request, form_success);
					return false;
		        });
			}

			$('#autocomplete').on('keyup keypress', function(e) {
			  var keyCode = e.keyCode || e.which;
			  if (keyCode === 13) { 
			    e.preventDefault();
			    return false;
			  }
			});

			$("#autocomplete").focusin(function(){
				// function geolocate() {
				if (navigator.geolocation) {
				  navigator.geolocation.getCurrentPosition(function(position) {
				    var geolocation = {
				      lat: position.coords.latitude,
				      lng: position.coords.longitude
				    };
				    var circle = new google.maps.Circle({
				      center: geolocation,
				      radius: position.coords.accuracy
				    });
				    autocomplete.setBounds(circle.getBounds());
				  });
				}
				// }
			});

			function generate_city_btn(obj){
				location_btn_count++;
				var location_btn='<span class="btn ficha-btn hide">'+obj.city+' <i class="close fa fa-close"></i><input type="hidden" value="'+obj.city+'" name="location['+location_btn_count+'][city]"><input type="hidden" value="'+obj.latitude+'" name="location['+location_btn_count+'][lat]"><input type="hidden" value="'+obj.longitude+'" name="location['+location_btn_count+'][long]"><input type="hidden" value="'+obj.formatted_address+'" name="location['+location_btn_count+'][formatted_address]"></span>';
				$(".location-btn-group").html(location_btn);
			}

			var locations_data=<?=isset($filterData->data) ? json_encode($filterData->data) : '{}'; ?>;
			$.each(locations_data,function(i,e){
				generate_city_btn({city:e.city,latitude:e.lat,longitude:e.long});
				$("#autocomplete").val(e.formatted_address);
			});

			// $(".location-btn-group span.ficha-btn i.close").click(function(){
			// 	$(this).parent('span.ficha-btn').remove();
			// });

			// $(document).ready(function(){
			//initAutocomplete();
		<?php } ?>

		<?php if($variable == 'age_range') { ?>
			$.validator.addMethod("greaterThanOrEqual",
			  function (value, element, params) {
			      var paramsVal = params;
			      if (params && (params.indexOf("#") === 0 || params.indexOf(".") === 0)) {
			        paramsVal = $(params).val();
			      }
			     
			      return (Number(value) >= Number(paramsVal));
			  }, 'Must be greater than {0}.');

			$("#add_variable_form").validate({
				submitHandler: function (form) { // for demo
				  	request.data=getdata();
					call_ajax(request, form_success);
					return false;
				},
				highlight: function (element) {
					// $(element).closest('.form-group').addClass('has-error');
					$(element).addClass('error-input');

				},
				unhighlight: function (element) {
					$(element).removeClass('error-input');
				    // $(element).closest('.form-group').removeClass('has-error');
				},
			});
		<?php } ?>

		<?php if($variable == 'date') { ?>
			function dateToast(text) {
				if($('div.toast-container.toast-position-bottom-right div').length < 1){
					$().toastmessage('showToast', {
						text     : text,
						sticky   : false,
						position : 'bottom-right',
						type     : 'error',
						closeText: ''
					});
				}
			}
			
			$("#add_variable_form").validate({
				submitHandler: function (form) { // for demo
				  	//hide slider
		    		$('.time-slider-wrapper').addClass('hide');
		    		// Datee Range tab

					var startdaterange = $('#date_range_start');
					var enddaterange = $('#date_range_end');
					if(startdaterange.val() == ''){
						startdaterange.focus().css('border', '1px solid #c80000');
						dateToast('Start date should not be empty');
						return false;
					}
					if( enddaterange.val() == ''){
						enddaterange.focus().css('border', '1px solid #c80000');
						dateToast('End date should not be empty');
						return false;
					}

					if(enddaterange.val() <= startdaterange.val()){
						enddaterange.focus().css('border', '1px solid #c80000');
						dateToast('End date should be greater than Start date');
						return false;
					}
					request.data=getdata();
					call_ajax(request, form_success);
					return false;
				},
				highlight: function (element) {
					// $(element).closest('.form-group').addClass('has-error');
					$(element).addClass('error-input');
				},
				unhighlight: function (element) {
					$(element).removeClass('error-input');
				    // $(element).closest('.form-group').removeClass('has-error');
				},
			});
		<?php } else { ?>
			$("#add_variable_form button[type=submit]").click(function(e){
				e.preventDefault();

				<?php if( ($variable == 'mobile_make') ) { ?>
					if( !$('#select_mobile_make').val() ) {
						chooseOptionToast();
						return false;
					}
				<?php } ?>

				<?php if( ($variable == 'location') ) { ?>
					if( !$('#autocomplete2').val() ) {
						chooseOptionToast();
						return false;
					}
				<?php } ?>

				<?php if( ($variable == 'apps_installled') ) { ?>
					if( !$('#applications').val() ) {
						chooseOptionToast();
						return false;
					}
				<?php } ?>


				/* Applying form validatin */

				/* $(".add-var-btn").click(function(e){
					if ($('#select_mobile_make').val() == null) {
						$('#select_mobile_make').focus();
						return false;
					}
					if ($('#autocomplete2').val() == null) {
						$('#autocomplete2').focus();
						return false;
					}
					if ($('#applications').val() == null) {
						$('#applications').focus();
						return false;
					}
				});*/
				
				// Age Range tab
				<?php if( ($variable == 'age_range') ) { ?>
					var startagerange = $('#age_range_start');
					var endagerange = $('#age_range_end');
					if(startagerange.val() == ''){
						startagerange.focus().css('border', '1px solid #c80000');
						return false;
					}
					if( endagerange.val() == '' ){
						endagerange.focus().css('border', '1px solid #c80000');
						return false;
					}
					if(endagerange.val() <= startagerange.val()){
						endagerange.focus().css('border', '1px solid #c80000');
						return false;
					}	
				<?php } ?>
				/* End of Applying form validatin */
				request.data=getdata();
				call_ajax(request, form_success);
				return false;
			});
		<?php } ?>

		$("#add_variable_form ul.selectable li").click(function(e){
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
			$(this).find('input').prop('checked',true).trigger('change');
			// $(this).find('input').trigger('change');
			e.preventDefault();
			request.data=getdata();
			call_ajax(request, form_success);
			return false;
		});

		$("#add_variable_form ul li.selectable").click(function(e){
			var allval=$('#add_variable_form .checkable').find('input').val();
			if(allval==="[]"){

				e.preventDefault();
				if($('div.toast-container.toast-position-bottom-right div').length < 1){
				
					$().toastmessage('showToast', {
			            text     : "Location not found",
			            sticky   : false,
			            position : 'bottom-right',
			            type     : 'success',
			            closeText: ''
			        });
		   		}
			}
			else{
			$(this).siblings().removeClass('active');
			$(this).addClass('active');
			$('#add_variable_form .checkable').find('input').prop('checked',true).trigger('change');
			// $(this).find('input').trigger('change');

			e.preventDefault();
			request.data=getdata();
			call_ajax(request, form_success);
			return false;
			}
		});

		// $("#add_variable_form ul li.selectable").click(function(e){
		// 	e.preventDefault();
		// 	closeAjaxDialog('Please choose custom option');
			
		// 	$().toastmessage('showToast', {
	 //            text     : 'Please choose custom option',
	 //            sticky   : false,
	 //            position : 'bottom-right',
	 //            type     : 'error',
	 //            closeText: ''
	 //        });
		// });

	 	function getdata() {
	 		var inputs_arr1=$('#add_variable_form').serialize();
	 		return inputs_arr1;
	 		var inputs_arr=$('#add_variable_form').serializeArray();
			var _data={};
			$.each(inputs_arr,function(i,e){
				_data[e.name]=e.value;
			});
			return _data;
	 	}	 	

		function generate_filter(options, app_id){
			var _for 		=	options.variable;
			var _for_title 	=	options.title;
			var _selected 	=	options.data;
			var _app_id		= 	app_id;
			var _list=$('.application-wrapper ul.variables-list li[data-list-for='+_for+']');
			// if(typeof(_selected)=='object'){
			var __list_='';

			if(_for=='gender'){
				__list_+='<li data-lat="'+_selected+' data-long="'+_selected+'">'+_selected+'</li>';
			}

			if(_for=='age_range') { 
				__list_+='<li> From '+_selected['age_range_start']+' to '+_selected['age_range_end']+'</li>';
			}

			if(_for=='date') { 
				__list_+='<li> Start date: '+_selected['datestart']+'<br> End date: '+_selected['dateend']+'</li>';
			}

			if(_for !='gender' && _for !='age_range' && _for !='date') {
				var counter=0;
				$.each(_selected,function(i,e) {
					if(_for=='location') {
						if(i<3){
							__list_+='<li data-lat="'+e+' data-lat="'+e+'">'+e+'</li>';
						}else{
							counter++;
						}
					}
					else {
						var _sudo_attr='';
						// if(_for=='age_range' && i=='end') {
						// 	_sudo_attr='data-content="'+JsLang.year.toLowerCase()+'"';
						// }	
						if(i<3){					
						 __list_+='<li data-id="'+i+'" '+_sudo_attr+'>'+e+'</li>';
						}else{
							counter++;
						}
					}
				});
				// console.log("hollaw",_selected);
				__list_+='<li title="'+_selected+'" data-id="'+_for+'" data-toggle="tooltip" data-placement="right">'+counter+' more models</li>';
            }

			var _list_inner='<ul class="inner-list">'+__list_+'</ul>';
			
			if (_list.length==0) {	
				$('.application-wrapper ul.variables-list').append('<li data-list-for="'+_for+'" class="div-'+_for+'"> <div class="variable-list-wrapper"> <span class="variable-list-filter">'+_for_title+'</span> <a href="#!" data-post-variable="'+_for+'" class="variable-filter remove-filter" data-post-app_id="'+_app_id+'" data-title="'+_for_title+'" data-act="ajax-modal-request" onclick="remove(this)" ><span class="close-wrapp"><i id="'+_app_id+'" value="'+_for+'" class="material-icons removefilters">close</i></span></a> <a href="#!" data-post-variable="'+_for+'" class="variable-filter edit-filter" data-post-app_id="'+_app_id+'" data-title="'+_for_title+'" data-act="ajax-modal-request" data-action-url="<?=$this->url->get('variable/variable'); ?>"><span class="edit-wrapp"><i class="material-icons">mode_edit</i></span></a> '+_list_inner+'</li>');
				if(_for_title!=''){
					if(_for_title.length!=0){
	        			$('#filterDropdownOptions').append('<option class="baropt-'+_for+'">'+_for_title+'</option>');
	        			$('#polarFilterDropdownOptions').append('<option class="baropt-'+_for+'">'+_for_title+'</option>');
	        		}
				}
        		if ($('.no-filters-para')) {
        			$('.no-filters-para').hide();
        		}
			}
			else {
				var _inner_list_obj=_list.find('ul.inner-list');
				if(_inner_list_obj.length==0){
					_list.append(_list_inner);
				}else{
					_list.find('ul.inner-list').replaceWith(_list_inner);	
				}
			}
			$('#barchart').show();
			$('#no-filter-selected').remove();
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
		}

		var app_id='';

		function form_success(res){
			closeAjaxDialog(res.status);
			// var dpcount=res.location;
			
			if (res.location != '') {
				var toastSuccess = 'Filter applied successfully';
			}
			
			if (res.location == '') {
				var toastSuccess = 'Data points not available';
			}

			if($('div.toast-container.toast-position-bottom-right div').length < 1){
				
				$().toastmessage('showToast', {
		            text     : toastSuccess,
		            sticky   : false,
		            position : 'bottom-right',
		            type     : 'success',
		            closeText: ''
		        });
		    }
	        	/*$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );	
				$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');	
				$('#mychart1').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
				$('#mychart1').hide();*/
			app_id=res.data.app_id;
			generate_filter(res.filter, res.data.app_id);
			
			clearClusters();
			addClusters(res.location);	

		  	
			barLineChartFiltersAjax(app_id, ($( "#filterDropdownOptions option:selected" ).text()), ($(".btn-toggle").find('.active').val() ), ('Showing averaged accumulative data within the selected '+($( "#filterDropdownOptions option:selected" ).text())) );
			var filterPolar = $( "#polarFilterDropdownOptions option:selected" ).text();
			polarAreaChartFiltersAjax(app_id,(filterPolar),("AND"),('Showing averaged accumulative data within the selected ') + (filterPolar) );
		}

		function barLineChartFiltersAjax(appId, filter, logicalOperator, barchartTitle) {
			$.ajax({
				type: 'post',
				url: '<?php echo $this->url->get('application/barLineChartFilters'); ?>',	
				data: {
					filter: filter,
					logicalOperator: logicalOperator,
					app_id: appId
				},
				dataType: 'json',
				success: function (response) {
					if (response.length >0){
						initBarChart(response, logicalOperator, barchartTitle);
					}
				}				
			});
		}

		function polarAreaChartFiltersAjax(appId, filter, logicalOperator, polarChartTitle) {
			$.ajax({
				type: 'post',
				url: '<?php echo $this->url->get('application/polarAreaChartFilters'); ?>',	
				data: {
					filter: filter,
					// logicalOperator: logicalOperator,
					logicalOperator: 'AND',
					app_id: appId
				},
				dataType: 'json',
				success: function (response) {
					if (response.length >0){
						if (Chart1) {
							Chart1.destroy();
						}
						initPolarAreaChart('right', 'mychart1', response, polarChartTitle);
					    if ($(window).width() < 1024) {
							Chart1.destroy();
							initPolarAreaChart('right', 'mychart1', response, polarChartTitle);
					    }
					}
					else {
						var toastSuccess = 'No Data to show on Polar Area chart';
						if($('div.toast-container.toast-position-bottom-right div').length < 1){
							$().toastmessage('showToast', {
					            text     : toastSuccess,
					            sticky   : false,
					            position : 'bottom-right',
					            type     : 'error',
					            closeText: ''
					        });
					    }
					}
				}				
			});
		}

		$( "#filterDropdownOptions" ).unbind("change").change(function(){
	    	var dropDownFilter = $( "#filterDropdownOptions option:selected" ).text();
			var logicalOperator = $(".btn-toggle").find('.active').val();			
			var textTitle2 = 'Showing averaged accumulative data within the selected '+dropDownFilter;
			var app_id=$( ".remove-filter" ).attr('data-post-app_id');
			$("#filterDropdownOptions .baropt-apps_installled_select_filter").removeAttr("selected");
			if (dropDownFilter === "Select filter") {
					$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(this).hide(); } );
					$('#barlchart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				}else{
					$('#barchart').show();
					$('#barchart').removeAttr("style");
					$("#no-filter-selected").remove();
					barLineChartFiltersAjax(app_id,dropDownFilter, logicalOperator, textTitle2);
				}
			
	    });
	    
	    $( "#polarFilterDropdownOptions" ).unbind("change").change(function(){
	    	var polardropDownFilter = $( "#polarFilterDropdownOptions option:selected" ).text();
			var polarlogicalOperator = $(".polarChart-toggle").find('.active').val();
			var polarTitle2 = 'Showing averaged accumulative data within the selected '+polardropDownFilter;
			var app_id=$( ".remove-filter" ).attr('data-post-app_id');
			$("#polarFilterDropdownOptions .baropt-apps_installled_select_filter").removeAttr("selected");
			if (polardropDownFilter === "Select filter") {
				$('#mychart1').hide();
				$('#leg_container').hide();
				$('.polarareachart').append('<div id="no-filter-selected"><center><h5>Please select some filters<h5></center></div>');
				console.log('if');

			}else{
				$('#mychart1').show();
				$('#leg_container').show();
				// $('#mychart1').removeAttr("style");
				// $('#leg_container').removeAttr("style");
				// $('#mychart1').hide();
				// $('#leg_container').hide();
				$('#mychart1').css("display","block");
				$('#leg_container').css("display","block");
				console.log('else');
				$(".polarareachart #no-filter-selected").remove();
				polarAreaChartFiltersAjax(app_id, polardropDownFilter, polarlogicalOperator, polarTitle2);
			}
			
	    });

		// $(".remove-filter").click(function(){
		// 	var removeclassCount = $('.remove-filter').length;
		// 	$(".baropt-"+$(this).attr('data-post-variable')).remove(); // option selected removal
		// 	$(".div-"+$(this).attr('data-post-variable')).animate({height:0, opacity: 0}, 1500, function(){ $(this).remove(); } );
			
    	//	$.ajax({
		// 		type: 'post',
		// 		url: '<?php #echo $this->url->get('application/deleteVariable'); ?>',	
		// 		data: {
		// 			id : $(this).attr('data-post-app_id'),
		// 			variableName: $(this).attr('data-post-variable')
		// 		},
		// 		dataType: 'json',
		// 		success: function (response) {
		// 			generate_filter(response.filter, response.data.app_id);
		// 			barLineChartFiltersAjax($(this).attr('data-post-app_id'), ($( "#filterDropdownOptions option:selected" ).text()), ( $(".btn-toggle").find('.active').val() ), ('Showing averaged accumulative data within the selected '+($( "#filterDropdownOptions option:selected" ).text())) );
		// 			// if(response.filter.variable!=='location'){
		// 				clearClusters();
		// 				addClusters(response.location);
		// 			// }
		// 			toastHistory.Clear();
		// 			$().toastmessage('showToast', {
		// 				text     : 'Filter removed successfully',
		// 				sticky   : false,
		// 				position : 'bottom-right',
		// 				type     : 'success',
		// 				closeText: '',
		// 			});
		// 		}				
		// 	});
		// 	if( ($( "#polarFilterDropdownOptions option" ).length) == '0' ) {
		// 		$('#mychart1').hide();
		// 		$('.polarareachart').append('<div id="no-filter-selected-polar"><center><h5>Please select some filters<h5></center></div>');
		// 	}
		// });

		$('.btn-number').click(function(e){
		    e.preventDefault();
		    
		    fieldName = $(this).attr('data-field');
		    type      = $(this).attr('data-type');
		    var input = $("input[name='"+fieldName+"']");
		    var currentVal = parseInt(input.val());

		    if (isNaN(currentVal)) { currentVal = 0; }

		    if (!isNaN(currentVal)) {
		        if(type == 'minus') {
		            if(currentVal > input.attr('min')) {
		                input.val(currentVal - 1).change();
		            } 
		            if(parseInt(input.val()) == input.attr('min')) {
		                $(this).attr('disabled', true);
		            }
		        } else if(type == 'plus') {
		            if(currentVal < input.attr('max')) {
		                input.val(currentVal + 1).change();
		            }
		            if(parseInt(input.val()) == input.attr('max')) {
		                $(this).attr('disabled', true);
		            }
		        }
		    } else {
		        input.val(0);
		    }
		});

		$('.input-number').focusin(function(){
		   $(this).data('oldValue', $(this).val());
		});

		$('.input-number').change(function() {
		    minValue =  parseInt($(this).attr('min'));
		    maxValue =  parseInt($(this).attr('max'));
		    valueCurrent = parseInt($(this).val());
		    
		    name = $(this).attr('name');
		    if(valueCurrent >= minValue) {
		        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        $(this).val($(this).data('oldValue'));
		    }
		    if(valueCurrent <= maxValue) {
		        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        $(this).val($(this).data('oldValue'));
		    }
		});

		$(".input-number").keydown(function (e) {
		    // Allow: backspace, delete, tab, escape, enter and .
		    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
		         // Allow: Ctrl+A
		        (e.keyCode == 65 && e.ctrlKey === true) || 
		         // Allow: home, end, left, right
		        (e.keyCode >= 35 && e.keyCode <= 39)) {
		             // let it happen, don't do anything
		             return;
		    }
		    // Ensure that it is a number and stop the keypress
		    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
		        e.preventDefault();
		    }
		});

		$('.btn-number2').click(function(e){
		    e.preventDefault();
		    
		    fieldName = $(this).attr('data-field');
		    type      = $(this).attr('data-type');
		    var input = $("input[name='"+fieldName+"']");
		    var currentVal = parseInt(input.val());

		    if (isNaN(currentVal)) { currentVal = 0; }
		    
		    if (!isNaN(currentVal)) {
		        if(type == 'minus') {		            
		            if(currentVal > input.attr('min')) {
		                input.val(currentVal - 1).change();
		            } 
		            if(parseInt(input.val()) == input.attr('min')) {
		                $(this).attr('disabled', true);
		            }
		        } else if(type == 'plus') {
		            if(currentVal < input.attr('max')) {
		                input.val(currentVal + 1).change();
		            }
		            if(parseInt(input.val()) == input.attr('max')) {
		                $(this).attr('disabled', true);
		            }
		        }
		    } else {
		        input.val(0);
		    }
		});
		
		$('.input-number2').focusin(function(){

		   $(this).data('oldValue', $(this).val());
		});
		
		$('.input-number2').change(function() {
		    minValue =  parseInt($(this).attr('min'));
		    maxValue =  parseInt($(this).attr('max'));
		    valueCurrent = parseInt($(this).val());
		    
		    name = $(this).attr('name');
		    if(valueCurrent >= minValue) {
		        $(".btn-number2[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        $(this).val($(this).data('oldValue'));
		    }
		    if(valueCurrent <= maxValue) {
		        $(".btn-number2[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        $(this).val($(this).data('oldValue'));
		    }
		});
		
		$(".input-number2").keydown(function (e) {
	        // Allow: backspace, delete, tab, escape, enter and .
	        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
	             // Allow: Ctrl+A
	            (e.keyCode == 65 && e.ctrlKey === true) || 
	             // Allow: home, end, left, right
	            (e.keyCode >= 35 && e.keyCode <= 39)) {
	                 // let it happen, don't do anything
	                 return;
	        }
	        // Ensure that it is a number and stop the keypress
	        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
	            e.preventDefault();
	        }
	    });

		$('#date_range_start').bootstrapMaterialDatePicker ({
			format : 'YYYY/MM/DD',
			time: false,
			clearButton: true,
			maxDate : new Date()
		});

		$('#date_range_end').bootstrapMaterialDatePicker ({
			format : 'YYYY/MM/DD',
			time: false,
			clearButton: true,
			maxDate : new Date()
		});

	});
</script>