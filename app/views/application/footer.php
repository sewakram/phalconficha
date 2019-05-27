<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the #content div and all content after
 *
 * @package Nisarg
 */
?>
	</div><!-- #content -->
	<div class="footer-bottom-area bg-dark-light section-padding-sm hide" style="
    background: #323232 !important;color: #ffffff!important;">
                <div class="container">
                    <div class="row widgets footer-widgets">

                        <div class="col-lg-3 col-md-6 col-12">
                            <div class="single-widget widget-about">
                                <h5 class="widget-title" style="color: #ffffff; font-family: "Raleway", sans-serif;font-weight: 700;margin-bottom: 30px;letter-spacing: 0.5px;position: relative;
    padding-bottom: 15px;font-size:2.0rem">About Blog</h5>
                                <!-- <img src="http://designmaker.co.in/wp-content/uploads/2018/11/breakfast.jpg" alt="about widget image"> -->
                                <p>This blog is to encourage people to live a happy and healthy life. Its not just the food we take or the exercise we normally do. There are many other things that is important to be a happy healthy person. <a href="www.designmaker.co.in">Readmore...</a></p>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-12">
                            <div class="single-widget widget-quick-links">
                                <!-- <h5 class="widget-title" style="color: #ffffff; font-family: "Raleway", sans-serif;font-weight: 700;margin-bottom: 30px;letter-spacing: 0.5px;position: relative;
    padding-bottom: 15px;font-size:2.0rem">Quick links</h5> -->
                                 <!-- <div><ul>
                                    <li><a href="#">Sitemap</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                    <li><a href="#">Your Account</a></li>
                                    <li><a href="#">Advanced Search</a></li>
                                    <li><a href="#">Contact Us</a></li>
                                </ul> </div> -->
            <?php dynamic_sidebar( 'sidebar2' ); ?>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-12">
                            <div class="single-widget widget-quick-links">
                                <h5 class="widget-title" style="color: #ffffff; font-family: "Raleway", sans-serif;font-weight: 700;margin-bottom: 30px;letter-spacing: 0.5px;position: relative;
    padding-bottom: 15px;font-size:2.0rem">Social networking</h5>
                                    <ul>
                                    <li><a href="#" class="fa fa-facebook"></a></li>
                                    <li><a href="#" class="fa fa-twitter"></a></li>
                                    <li><a href="#" class="fa fa-linkedin"></a></li>
                                    <li><a href="#" class="fa fa-instagram"></a></li>
                                    </ul>
                                    <!-- <ul>
                                    <li><a href="#"> <i class="fab fa-facebook-f"></i>Shipping Policy</a></li>
                                    <li><a href="#">Compensation First</a></li>
                                    <li><a href="#">My Account</a></li>
                                    <li><a href="#">Return Policy</a></li>
                                    <li><a href="#">Contact Us</a></li>
                                </ul> -->
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6 col-12">
                            <div class="single-widget widget-contact">
                                <h5 class="widget-title" style="color: #ffffff; font-family: "Raleway", sans-serif;font-weight: 700;margin-bottom: 30px;letter-spacing: 0.5px;position: relative;
    padding-bottom: 15px;font-size:2.0rem">Contact Us</h5>
                                <!-- <ul>
                                    <li class="address">
                                        <span class="icon"><i class="fa fa-map-marker"></i></span>
                                        <p>Address : No 100 Baria Sreet 100/2  Jaipur City, IN.</p>
                                    </li>
                                    <li class="phone">
                                        <span class="icon"><i class="fa fa-phone"></i></span>
                                        <p><a href="#">+91 7568 54 3012</a></p>
                                    </li>
                                    <li class="fax">
                                        <span class="icon"><i class="fa fa-fax"></i></span>
                                        <p><a href="#">+91 7568 54 3012</a></p>
                                    </li>
                                    <li class="email">
                                        <span class="icon"><i class="fa fa-envelope-o"></i></span>
                                        <p><a href="#">dkstudioin@gmail.com</a></p>
                                    </li>
                                </ul> -->
                                    <div class="well well-sm" style="color:black">
                                    <form class="form-horizontal" action="" method="post">
                                    <fieldset>
                                    <!-- <legend class="text-center">Contact us</legend> -->

                                    <!-- Name input-->
                                    <div class="form-group">
                                    <!-- <label class="col-md-3 control-label" for="name">Name</label> -->
                                    <div class="col-md-12 ">
                                    <input id="name" name="name" type="text" placeholder="Your name" class="form-control">
                                    </div>
                                    </div>

                                    <!-- Email input-->
                                    <div class="form-group">
                                    <!-- <label class="col-md-3 control-label" for="email">Your E-mail</label> -->
                                    <div class="col-md-12">
                                    <input id="email" name="email" type="text" placeholder="Your email" class="form-control">
                                    </div>
                                    </div>

                                    <!-- Message body -->
                                    <div class="form-group">
                                    <!-- <label class="col-md-3 control-label" for="message">Your message</label> -->
                                    <div class="col-md-12">
                                    <textarea class="form-control" id="message" name="message" placeholder="Please enter your message here..." rows="5"></textarea>
                                    </div>
                                    </div>


                                    <!-- Form actions -->
                                    <div class="form-group">
                                    <div class="col-md-12">
                                    <button type="submit" class="btn btn-primary btn-sm">Submit</button>
                                    </div>
                                    </div>
                                    </fieldset>
                                    </form>
                                    </div>
                                    
                            </div>
                        </div>

                    </div>
                </div>
            </div>
	<footer id="colophon" class="site-footer" role="contentinfo">
	    
		<div class="site-info">
			<?php echo '&copy; '.date( 'Y' ); ?>
			<span class="sep"> | </span>
			
			<?php
			$nisarg_theme_url_str = '<a href="'.esc_url( 'https://designmaker.co.in' ).'" rel="designer">Designmaker</a>';
			printf( esc_html__( '%1$s', 'nisarg' ), $nisarg_theme_url_str );
			?>
		</div><!-- .site-info -->
	</footer><!-- #colophon -->
</div><!-- #page -->
<?php wp_footer(); ?>

</body>
</html>
