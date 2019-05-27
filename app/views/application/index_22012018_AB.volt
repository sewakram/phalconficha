{{ content() }}
<section class="application-wrapper">
		
	<div class="application">
	  <div class="app-header row plain-color">
      <div class="col-sm-9">
        <h1 class="app-title"><?=$t->_("application"); ?></h1>
        <h5 class="app-desc"><?=$t->_("application_info"); ?></h5>
      </div>
      <div class="col-sm-3 main-app-point">
      	<button class="btn ficha-btn">
      		<?=$t->_("connect_app"); ?> &nbsp; <i class="glyphicon glyphicon-arrow-right" aria-hidden="true"></i>
      	</button>
      </div>
	  </div>
	</div>

	<div class="application-list-wrapper">
		<ul class="application-list">
			<?php
			foreach ($apps as $app) {
				printf('
							<li>
								<a href="%s"><img src="%s"></a>
								<h5>%s</h5>
								<span>%s</span>
							</li>
							',
							$this->url->get('application/'.$app->id),
							$this->url->get($app->thumbnail),
							$app->app_title,
							sprintf("%s ".$t->_("data_points"),rand(500,2000))
						);
			}
			?>
			<li>
				<a href="#!" id="connect_new_app"><img src="<?=$this->url->get('images/connect_new_app_hd_icon.png');?>"></a>
			</li>			
		</ul>
	</div>

</section>