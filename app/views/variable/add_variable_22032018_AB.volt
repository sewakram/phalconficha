<div class="add-new-variable-modal">
	<form action="<?php echo $this->url->get('variable/variable_submit'); ?>" method="post">
		<div class="modal-subtitle text-center">
			<?= $t->_("add_variable_para");?>
		</div>
		<ul class="options">
			<li>
				<?=modal_anchor(' <i class="fa fa-venus-mars fa-3x"></i> <span class="add_variable_text">Gender </span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'gender', 'data-post-app_id' =>$app_id, 'data-title'=>'Gender']);?>
				<input type="radio" class="hide" name="gender" value="select_gender">
			</li>
			<li>
				<?=modal_anchor('<i class="fa fa-age-range fa-3x"></i> <span class="add_variable_text">Age range</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'age_range', 'data-post-app_id' =>$app_id, 'data-title'=>'Age Range' ]);?>
				<input type="radio" class="hide" name="age_range" value="age_range">
			</li>
			<li>
				<?=modal_anchor('<i class="fa fa-tablet fa-3x"></i> <span class="add_variable_text">Phone models</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'mobile_make', 'data-post-app_id' =>$app_id, 'data-title'=>'Phone models' ]);?>
				<input type="radio" class="hide" name="mobile_make" value="mobile_make">
			</li>
			<li>
				<?=modal_anchor('<i class="fa fa-map-marker fa-3x"></i> <span class="add_variable_text">Location</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'location', 'data-post-app_id' =>$app_id, 'data-title'=>'Locations' ]);?>
				<input type="radio" class="hide" name="location" value="location">
			</li> 
			<!-- <li class="disable-events"> -->
			<li>
				<?=modal_anchor('<i class="fa fa-tasks fa-3x"></i> <span class="add_variable_text">Date</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'date', 'data-post-app_id' =>$app_id, 'data-title'=>'Date' ]);?>
				<input type="radio" class="hide" name="date" value="date">
			</li>
			<li>
				<?=modal_anchor('<i class="fa fa-pie-chart fa-3x"></i> <span class="add_variable_text coming-soon">Installed Applications</span>',['url' => $this->url->get('variable/variable'), 'data-post-variable' =>'apps_installled', 'data-post-app_id' =>$app_id, 'data-title'=>'Installed Applications' ]);?>
				<input type="radio" class="hide" name="apps_installled" value="apps_installled">
			</li>
		</ul>
	</form>
	<div class="clearfix"></div>
</div>