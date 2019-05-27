<div class="add-new-variable-modal">
	<form action="<?php echo $this->url->get('variable/variable_submit'); ?>" method="post">
		<div class="modal-subtitle text-center"> <?= $t->_("add_variable_para");?> </div>
		<ul class="options">
			<li>
				<?=modal_anchor(' <i class="icon-people icons"></i> <span class="add_variable_text">Gender </span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'gender', 'data-post-app_id' =>$app_id, 'data-title'=>'Gender', 'class'=>'radio_select']);?>
				<input type="radio" class="hide" name="gender" value="select_gender">
			</li>
			<li>
				<?=modal_anchor('<i class="icon-hourglass icons"></i> <span class="add_variable_text">Age range</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'age_range', 'data-post-app_id' =>$app_id, 'data-title'=>'Age Range', 'class'=>'radio_select' ]);?>
				<input type="radio" class="hide" name="age_range" value="age_range">
			</li>
			<li>
				<?=modal_anchor('<i class="icon-screen-smartphone icons"></i> <span class="add_variable_text">Phone models</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'mobile_make', 'data-post-app_id' =>$app_id, 'data-title'=>'Phone models', 'class'=>'radio_select' ]);?>
				<input type="radio" class="hide" name="mobile_make" value="mobile_make">
			</li>
			<li>
				<?=modal_anchor('<i class="icon-location-pin icons"></i> <span class="add_variable_text">Location</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'location', 'data-post-app_id' =>$app_id, 'data-title'=>'Locations', 'class'=>'radio_select' ]);?>
				<input type="radio" class="hide" name="location" value="location">
			</li> 
			<!-- <li class="disable-events"> -->
			<li>
				<?=modal_anchor('<i class="icon-calendar icons"></i> <span class="add_variable_text">Date</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'date', 'data-post-app_id' =>$app_id, 'data-title'=>'Date range', 'class'=>'radio_select']);?>
				<input type="radio" class="hide" name="date" value="date">
			</li>
			<li>
				<?=modal_anchor('<i class="icon-drawer icons"></i> <span class="add_variable_text coming-soon">Installed Applications</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'apps_installled', 'data-post-app_id' =>$app_id, 'data-title'=>'Installed Applications', 'class'=>'radio_select' ]);?>
				<input type="radio" class="hide" name="apps_installled" value="apps_installled">
			</li>
		</ul>
	</form>
	<div class="clearfix"></div>
</div>
<!-- Animation from bottom to top script -->

<script type="text/javascript">
	fadeinup();
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
	function generate_filter(options, app_id){
		var _for 		=	options.variable;
		var _for_title 	=	options.title;
		var _selected 	=	options.data;
		var _app_id		= 	app_id;
		var _list = $('.application-wrapper ul.variables-list li[data-list-for='+_for+']');
		var __list_ = '';
		
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
			$.each(_selected,function(i,e){					
				if(_for=='location') { 
					__list_+='<li data-lat="'+e+' data-lat="'+e+'">'+e+'</li>';
				}
				else{
					var _sudo_attr='';
					// if(_for=='age_range' && i=='end') {
					// 	_sudo_attr='data-content="'+JsLang.year.toLowerCase()+'"';
					// }
					__list_+='<li data-id="'+i+'" '+_sudo_attr+'>'+e+'</li>';	
				}
			});
		}
		var _list_inner='<ul class="inner-list">'+__list_+'</ul>';	
		// }else{
			// var _list_inner='<ul class="inner-list"><li>'+_selected+'</li></ul>';	
		// }
		var _list_lengths = $('ul.variables-list > li').size();
		if (_list_lengths >= 1) {
			if ( $('.no-filters-para') ) { $('.no-filters-para').hide(); }
		}else{
			if ( $('.no-filters-para') ) { $('.no-filters-para').show(); }
		}
		if(_list!=''){

			if (_list.length==0) {
								
				if(_for_title==''){
					$('.application-wrapper ul.variables-list').append('<li data-list-for="'+_for+'" class="div-'+_for+'"> <div class="variable-list-wrapper"> <span class="variable-list-filter">'+_for_title+'</span> <a href="#!" data-post-variable="'+_for+'" class="variable-filter remove-filter" data-post-app_id="'+_app_id+'" data-title="'+_for_title+'" data-act="ajax-modal-request" onclick="remove(this)" ><span class="close-wrapp"><i id="'+_app_id+'" value="'+_for+'" class="material-icons removefilters">close</i></span></a> <a href="#!" data-post-variable="'+_for+'" class="variable-filter edit-filter" data-post-app_id="'+_app_id+'" data-title="'+_for_title+'" data-act="ajax-modal-request" data-action-url="<?php echo $this->url->get('variable/variable')?>"><span class="edit-wrapp"><i class="material-icons">mode_edit</i></span></a> '+_list_inner+'</li>');
					if(_for_title.length!=0) { $('#filterDropdownOptions').append('<option class="baropt-'+_for+'">'+_for_title+'</option>'); }
				}
				
			}
			else {
				var _inner_list_obj=_list.find('ul.inner-list');
				if (_inner_list_obj.length==0) { _list.append(_list_inner); } 
				else { _list.find('ul.inner-list').replaceWith(_list_inner); }
				
			}
			
		}
	}
	function remove(link){
		
		// alert("link");
		var remove_filters = $(link).siblings('span').text().toLowerCase();
		var current_filter = $( "#filterDropdownOptions option:selected" ).text().toLowerCase();
		var polarcurrent_filter = $( "#polarFilterDropdownOptions option:selected" ).text().toLowerCase();
		var removeclassCount = $('.remove-filter').length;
			
		if (remove_filters === current_filter || remove_filters.concat(" range") === current_filter || remove_filters.substring(0, remove_filters.length-1) === current_filter) {
			// $('[id="no-filter-selected"]').nextAll().remove();
			$("#barlchart #no-filter-selected").remove();					
			$('#barchart').animate({height:0, opacity: 0}, 2000, function(){ $(link).hide(); } );					
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
			// $('[id="no-filter-selected"]').nextAll().remove();
			$('#mychart1').animate({height:0, opacity: 0}, 2000, function(){ $(link).hide(); } );
			$('#mychart1').hide();
			$('#leg_container').animate({height:0, opacity: 0}, 2000, function(){ $(link).hide(); } );
			$('#leg_container').hide();
			if (removeclassCount > 1) {
				// $('#polarFilterDropdownOptions').find('.baropt-apps_installled_select_filter').attr('selected', 'selected');
				$('#polarFilterDropdownOptions').val('Select filter').trigger('change');
			}
		}

		$(link).parent().parent().animate({height:0, opacity: 0}, 1500, function(){ $(link).parent().parent().remove(); } ); 
		$(".baropt-"+$(link).attr('data-post-variable')).remove(); // option selected removal
			$('[id="no-filter-selected"]').nextAll().remove();
		
		var dpv=$('.remove-filter').attr('data-post-variable');
		$.ajax({
			type: 'post',
			url: '<?php echo $this->url->get('application/deleteVariable'); ?>',	
			data: {
				id : $(link).attr('data-post-app_id'),
				variableName: $(link).attr('data-post-variable')
			},
			dataType: 'json',
			success: function (response) {
				if( dpv!='date' ) { $('.time-slider-wrapper').removeClass('hide'); }
				generate_filter(response.filter, response.data.app_id);
				if(response.filter.variable!=='location'){
					clearClusters();
					addClusters(response.location);
				}
				if($('div.toast-container.toast-position-bottom-right div').length < 1){
					$().toastmessage('showToast', {
						text     : 'Filter removed successfully',
						sticky   : false,
						position : 'bottom-right',
						type     : 'error',
						closeText: ''
					});
				}
			}
		});
		
	}
</script>
<!-- End of the animation script -->