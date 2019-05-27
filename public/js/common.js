ajaxPanelXhr=false;
var generateIconCache = {};
function call_ajax(options,cb){

   var settings = {
       url : "",
       data : {},
       cache : false,
       type : 'POST',
       dataType : 'json',
       drop_old : false,
       appLoader:false,
       onSuccess: cb,
       beforeAjaxSubmit :function (data, self, options) {
       },
   };
   settings = $.extend(settings,options);
   if(settings.appLoader){
       appLoader.show(settings.appLoader);   
   }
   if(ajaxPanelXhr && settings.drop_old){ ajaxPanelXhr.abort(); appLoader.hide();}
   ajaxPanelXhr=$.ajax({
       url: settings.url, 
       data: settings.data,   
       cache: settings.cache, 
       type: settings.type,   
       success: function (response) {   
           settings.onSuccess(response);
           appLoader.hide();
       },
       beforeSend: function (data, self, options) {
           settings.beforeAjaxSubmit(data, self, options);
       },
       statusCode: {
           404: function () {
               //appAlert.error("404: Page not found.", {container: '.cd-panel-dynamic-content', animate: false});
               $().toastmessage('showToast', {
                  text     : JsLang.page_not_found_error,
                  sticky   : false,
                  position : 'bottom-right',
                  type     : 'error',
                  closeText: ''
                });

               appLoader.hide();
           }
       },
       error: function () {
           // appAlert.error("500: Internal Server Error.", {container: '.cd-panel-dynamic-content', animate: false});
           $().toastmessage('showToast', {
              text     : JsLang.server_error,
              sticky   : false,
              position : 'bottom-right',
              type     : 'error',
              closeText: ''
            });
           appLoader.hide();
       }
   });
}

//Loader
(function (define) {
    define(['jquery'], function ($) {
        return (function () {
            var appLoader = {
                show: show,
                hide: hide,
                options: {
                    container: 'body',
                    zIndex: "auto",
                    css: "",
                }
            };

            return appLoader;

            function show(options) {
                var $template = $("#app-loader");
                this._settings = _prepear_settings(options);
                if (!$template.length) {
                    var $container = $(this._settings.container);
                    if ($container.length) {
                        $container.append('<div id="app-loader" class="app-loader" style="z-index:' + this._settings.zIndex + ';' + this._settings.css + '"><div class="cssload-whirlpool"></div></div>');
                    } else {
                        // console.log("appLoader: container must be an html selector!");
                    }
                }
            }

            function hide() {
                var $template = $("#app-loader");
                if ($template.length) {
                    $template.remove();
                }
            }

            function _prepear_settings(options) {
                if (!options)
                    var options = {};
                return this._settings = $.extend({}, appLoader.options, options);
            }
        })();
    });
}(function (d, f) {
    window['appLoader'] = f(window['jQuery']);
}));


//custom app form controller
(function ($) {
    $.fn.fichaForm = function (options) {

        var defaults = {
            ajaxSubmit: true,
            showLoader: false,
            isModal: true,
            dataType: "json",
            validatorsmethod:{},
            validaterules:{},
            validatemessage:{},
            onModalClose: function () {
            },
            onSuccess: function () {
            },
            onError: function () {
                return true;
            },
            onSubmit: function () {
            },
            onAjaxSuccess: function () {
            },
            beforeAjaxSubmit: function (data, self, options) {
            }
        };
        var settings = $.extend({}, defaults, options);
        this.each(function () {
            if (settings.ajaxSubmit) {
                validateForm($(this), function (form) {
                    settings.onSubmit();
                    if (settings.isModal) {
                        maskModal($("#app-ajax-modal").find(".modal-dynamic-content"));
                    }
                    $(form).ajaxSubmit({
                        dataType: settings.dataType,
                        beforeSubmit: function (data, self, options) {
                          if(settings.showLoader){
                            appLoader.show(settings.showLoader);
                          }
                          settings.beforeAjaxSubmit(data, self, options);
                        },
                        success: function (result) {
                          appLoader.hide();
                          if(result.form_error) {
                            var _validator=$(form).validate();
                            _validator.showErrors(result.form_error);
                            return true;
                          }
                          settings.onAjaxSuccess(result);
                          if (result.status) {
                              settings.onSuccess(result);
                              if (settings.isModal) {
                                  closeAjaxModal(true);
                              }
                          }
                          else {
                            if (settings.onError(result)) {
                              if (settings.isModal) {
                                  unmaskModal();
                                  if (result.message) {
                                      // appAlert.error(result.message, {container: '.modal-body', animate: false});
                                  }
                              } else if (result.message) {
                                  // appAlert.error(result.message);
                              }
                            }
                          }
                        }
                    });
                });
            } 
            else {
                validateForm($(this));
            }
        });
        /*
         * @form : the form we want to validate;
         * @customSubmit : execute custom js function insted of form submission. 
         * don't pass the 2nd parameter for regular form submission
         */
        function validateForm(form, customSubmit) {
            //add custom method
            if("validator1" in settings.validatorsmethod){
                settings.validatorsmethod.validator1;
            }
            if("validator2" in settings.validatorsmethod){
                settings.validatorsmethod.validator2;
            }
            if("validator3" in settings.validatorsmethod){
                settings.validatorsmethod.validator3;
            }
            if("validator4" in settings.validatorsmethod){
                settings.validatorsmethod.validator4;
            }

            if("validator6" in settings.validatorsmethod){
                settings.validatorsmethod.validator6;
            }
            $.validator.addMethod("greaterThanOrEqual",
                    function (value, element, params) {
                        var paramsVal = params;
                        if (params && (params.indexOf("#") === 0 || params.indexOf(".") === 0)) {
                            paramsVal = $(params).val();
                        }
                        if (!/Invalid|NaN/.test(new Date(value))) {
                            return new Date(value) >= new Date(paramsVal);
                        }
                        return isNaN(value) && isNaN(paramsVal)
                                || (Number(value) >= Number(paramsVal));
                    }, 'Must be greater than {0}.');
            //add custom method
            $.validator.addMethod("dependsTo",
                    function (value, element, params) {
                        var valid = true;
                        if($(params).val()){
                            if (!value) {
                                valid = false;
                            }
                        }
                        return valid;
            });
            $(form).validate({
              rules:settings.validaterules,
              messages:settings.validatemessage,
                submitHandler: function (form) {
                    if (customSubmit) {
                        customSubmit(form);
                    } else {
                        return true;
                    }
                },
                highlight: function (element) {
                  $(element).closest('.input-wrapper').addClass('has-error');
                  $(element).addClass('error-input');
                },
                debug:true,
                unhighlight: function (element) {
                  $(element).removeClass('error-input');
                  $(element).closest('.input-wrapper').removeClass('has-error');
                },
                errorElement: 'div',
                errorClass: 'error-block-msg',
                ignore: ":hidden:not(.validate-hidden)",
                errorPlacement: function (error, element) {
                    //red-border
                    element.addClass('error-input');

                    //to add custom color to password inbox while Invalid credentials
                    if(error[0]['innerHTML'] == 'Invalid credentials')
                    {
                      //$('#login-password').addClass('error-input');
                      $('#login-password').css('border','solid 1px #ff0000');
                    }

                    // error.insertAfter(element);
                    
                    if($('div.toast-container.toast-position-top-right div').length < 1){
                      $().toastmessage('showToast', {
                        text     : error,
                        sticky   : false,
                        position : 'top-right',
                        type     : 'error',
                        closeText: ''
                      });
                  }
                },
            });
            //handeling the hidden field validation like select2
            $(".validate-hidden").click(function () {
                $(this).closest('.form-group').removeClass('has-error').find(".error-block-msg").hide();
            });
        }
        //show loadig mask on modal before form submission;
        function maskModal($maskTarget) {
            var padding = $maskTarget.height() - 80;
            if (padding > 0) {
                padding = Math.floor(padding / 2);
            }
            $maskTarget.append("<div class='modal-mask'><div class='circle-loader'></div></div>");
            //check scrollbar
            var height = $maskTarget.outerHeight();
            $('.modal-mask').css({"width": $maskTarget.width() + 30 + "px", "height": height + "px", "padding-top": padding + "px"});
            $maskTarget.closest('.modal-dialog').find('[type="submit"]').attr('disabled', 'disabled');
        }

        //remove loadig mask from modal
        function unmaskModal() {
            var $maskTarget = $(".modal-body");
            $maskTarget.closest('.modal-dialog').find('[type="submit"]').removeAttr('disabled');
            $(".modal-mask").remove();
        }

        //colse ajax modal and show success check mark
        function closeAjaxModal(success) {
            if (success) {
              toastmessage(showSuccessToast)
                $(".modal-mask").html("<div class='circle-done'><i class='fa fa-check'></i></div>");
                setTimeout(function () {
                    $(".modal-mask").find('.circle-done').addClass('ok');
                }, 30);
            }
            setTimeout(function () {
                $(".modal-mask").remove();
                // toggleAjaxSlickModal();
                settings.onModalClose();
            }, 1000);
        }
    };
})(jQuery);

// Jquery Toast Messages
(function($) {
    var settings = {
        inEffect:         {opacity: 'show'},  // in effect
        inEffectDuration: 600, // in effect duration in miliseconds
        stayTime:         4000, // time in miliseconds before the item has to disappear
        text:             '', // content of the item. Might be a string or a jQuery object. Be aware that any jQuery object which is acting as a message will be deleted when the toast is fading away.
        sticky:           true, // should the toast item sticky or not?
        type:             'notice', // notice, warning, error, success
        position:         'top-right', // top-left, top-center, top-right, middle-left, middle-center, middle-right ... Position of the toast container holding different toast. Position can be set only once at the very first call, changing the position after the first call does nothing
        closeText:        '', // text which will be shown as close button, set to '' when you want to introduce an image via css
        close:            null // callback function when the toastmessage is closed
    };

    var methods = {
      init : function(options)
      {
        if (options) {
            $.extend( settings, options );
        }
      },

      showToast : function(options)
      {
        var localSettings = {};
        $.extend(localSettings, settings, options);

        // declare variables
        var toastWrapAll, toastItemOuter, toastItemInner, toastItemClose, toastItemImage;

        toastWrapAll  = (!$('.toast-container').length) ? $('<div></div>').addClass('toast-container').addClass('toast-position-' + localSettings.position).appendTo('body') : $('.toast-container');
        toastItemOuter  = $('<div></div>').addClass('toast-item-wrapper');
        toastItemInner  = $('<div></div>').hide().addClass('toast-item toast-type-' + localSettings.type).appendTo(toastWrapAll).html($('<p>').append (localSettings.text)).animate(localSettings.inEffect, localSettings.inEffectDuration).wrap(toastItemOuter);
        toastItemClose  = $('<i></i>').addClass('material-icons').prependTo(toastItemInner).text('close').click(function() { $().toastmessage('removeToast',toastItemInner, localSettings) });
        toastItemImage  = $('<div></div>').addClass('toast-item-image').addClass('toast-item-image-' + localSettings.type).prependTo(toastItemInner);

        if(navigator.userAgent.match(/MSIE 6/i))
        {
          toastWrapAll.css({top: document.documentElement.scrollTop});
        }

        if(!localSettings.sticky)
        {
          setTimeout(function()
          {
            $().toastmessage('removeToast', toastItemInner, localSettings);
          },
          localSettings.stayTime);
        }
        return toastItemInner;
      },

      showNoticeToast : function (message)
      {
          var options = {text : message, type : 'notice'};
          return $().toastmessage('showToast', options);
      },

      showSuccessToast : function (message)
      {
          var options = {text : message, type : 'success'};
          return $().toastmessage('showToast', options);
      },

      showErrorToast : function (message)
      {
          var options = {text : message, type : 'error'};
          return $().toastmessage('showToast', options);
      },

      showWarningToast : function (message)
      {
          var options = {text : message, type : 'warning'};
          return $().toastmessage('showToast', options);
      },

      removeToast: function(obj, options)
      {
        obj.animate({opacity: '0'}, 600, function()
        {
          obj.parent().animate({height: '0px'}, 300, function()
          {
            obj.parent().remove();
          });
        });

        // callback
        if (options && options.close !== null)
        {
            options.close();
        }
      }
  };

  $.fn.toastmessage = function( method ) {

      // Method calling logic
      if ( methods[method] ) {
        return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
      } else if ( typeof method === 'object' || ! method ) {
        return methods.init.apply( this, arguments );
      } else {
        $.error( 'Method ' +  method + ' does not exist on jQuery.toastmessage' );
      }
  };
})(jQuery);

/*! Copyright 2011, Ben Lin (http://dreamerslab.com/)
* Licensed under the MIT License (LICENSE.txt).
*
* Version: 1.0.3
*
* Requires: jQuery 1.2.3+
*/
(function(a){a.preload=function(){var d=Object.prototype.toString.call(arguments[0])==="[object Array]"?arguments[0]:arguments;
var c=[];var b=d.length;for(;b--;){c.push(a("<img />").attr("src",d[b]));}};})(jQuery);

siteRun = function () {
    $(".animsition").animsition({
    inClass: 'fade-in',
    outClass: 'fade-out',
    inDuration: 800,
    outDuration: 500,
    linkElement: '.animsition-link',
    // e.g. linkElement: 'a:not([target="_blank"]):not([href^="#"])'
    loading: true,
    loadingParentElement: 'body', //animsition wrapper element
    loadingClass: 'loader',
    loadingInner: '', // e.g '<img src="loading.svg" />'
    timeout: false,
    timeoutCountdown: 5000,
    onLoadEvent: true,
    browser: [ 'animation-duration', '-webkit-animation-duration'],
    // "browser" option allows you to disable the "animsition" in case the css property in the array is not supported by your browser.
    // The default setting is to disable the "animsition" in a browser that does not support "animation-duration".
    overlay : false,
    overlayClass : 'animsition-overlay-slide',
    overlayParentElement : 'body',
    transition: function(url){ window.location.href = url; }
  });
}

dialogFx ={};
function closeAjaxDialog(success) {
  dialogFx.close();

    // if (success) {
    //     $("#app-ajax-modal .modal-dynamic-content").html("<div class='modal-mask'><div class='circle-done'><i class='fa fa-check'></i><h4>"+JsLang.data_saved_successfully+"</h4></div></div>");
    //     //animation
    //     $('#app-ajax-modal .modal-dynamic-content .modal-mask').fichaAnimate('fadeInUp', function () {
           
    //       setTimeout(function () {
    //           $("#app-ajax-modal .modal-dynamic-content .modal-mask").find('.circle-done').addClass('ok');
    //       }, 30);
    //       setTimeout(function () {
    //           $("#app-ajax-modal .modal-dynamic-content .modal-mask").remove();
    //           // toggleAjaxSlickModal();
    //           dialogFx.close();
    //       }, 1000);
    //     });
    // }
}

$.fn.extend({
    fichaAnimate: function (animationName, callback) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
            if (callback) {
              callback();
            }
        });
        return this;
    }
});

$(document).ready(function(){

  dialogFx = new DialogFx( document.getElementById("app-ajax-modal"),{onCloseDialog:CloseFxDialog} );

  $(document).on('click', '[data-act=ajax-modal-request]', function (e) {
      e.preventDefault();
      
      // console.log('Ajax Modal call');
      var data = {ajaxModal: 1},
        ajaxModal = $('#app-ajax-modal'),
        url = $(this).attr('data-action-url'),
        isLargeModal = $(this).attr('data-modal-lg'),
        title = $(this).attr('data-title');
      if (!url) {
          // console.log('Ajax Modal: Set data-action-url!');
          return false;
      }
      if (title) {
        ajaxModal.find('.app-ajax-modal-title').text(title);
      }
      // ajaxModal.find('.modal-dynamic-content').html("");
      $.each(this.attributes, function () {
          if (this.specified && this.name.match("^data-post-")) {
              var dataName = this.name.replace("data-post-", "");
              data[dataName] = this.value;
          }
      });
      ajaxModal.find('.modal-dynamic-content').empty();
      // appLoader.show({container: '#app-ajax-modal .modal-dynamic-content', css: "right:40%; top:45%;"});
      appLoader.show({container: '#app-ajax-modal .modal-dynamic-content'});
      // ajaxModal.addClass('is-visible');

      // ajaxModal.modal('show');
      dialogFx.open();

      ajaxModalXhr = $.ajax({
          url: url,
          data: data,
          cache: false,
          type: 'POST',
          success: function (response) {
            var res=$(response);
            ajaxModal.find('.modal-dynamic-content').html(res);  
            ajaxModal.find(".modal-dialog").removeClass("mini-modal");
            if (isLargeModal === "1") {
                ajaxModal.find(".modal-dialog").addClass("modal-lg");
            }
          },
          statusCode: {
              404: function () {
                  ajaxModal.find('.modal-dynamic-content').html("");
                  // appAlert.error("404: Page not found.", {container: '.modal-dynamic-content', animate: false});
              }
          },
          error: function () {
              ajaxModal.find('.modal-dynamic-content').html("");
              // appAlert.error("500: Internal Server Error.", {container: '.modal-dynamic-content', animate: false});
          }
      });
      return false;
  });

  //abort ajax request on modal close.
  // console.log(dialogFx);
  function CloseFxDialog(e) {
     $('#app-ajax-modal .modal-dynamic-content').html('');
    // console.log('modal close events',e);
    // $(this).find(".modal-dialog").removeClass("modal-lg").addClass("mini-modal");
  };


  siteRun();
  $.preload(
    'http://dev.fichapp.co/images/sidebar_menu_icon/dashboard_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/application_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/team_members_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/invoice_and_payment_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/contact_and_support_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/account_setting_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/annoucement_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/help_and_faq_icon_green.png',
    'http://dev.fichapp.co/images/sidebar_menu_icon/logout_icon_green.png',
    'http://dev.fichapp.co/images/map_icon_green.png',
    'http://dev.fichapp.co/images/progress_bar_icon_green.png',
    'http://dev.fichapp.co/images/pie_icon_green.png',
    'http://dev.fichapp.co/images/line_icon_green.png',
    //modal icons
    'http://dev.fichapp.co/images/modal_icons/age_range_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/coming_soon_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/coming_soon_icon1_green.png',
    'http://dev.fichapp.co/images/modal_icons/female_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/gender_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/location_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/male_icon_green.png',
    'http://dev.fichapp.co/images/modal_icons/phone_make_icon_green.png'
  );
});

/*Animation related function*/
//open close element with animate css 
  openAnimate = function (elem,slide_effects){
    setTimeout(function(){
      $(''+elem+'').removeClass('hide animated '+slide_effects+'').addClass('animated '+slide_effects+'');
        setTimeout(function(){
          $(''+elem+'').removeClass('animated '+slide_effects+'');
        },1000);
    },1);
  };
  closeAnimate = function (elem,slide_effects){
    setTimeout(function(){
      $(''+elem+'').removeClass('animated '+slide_effects+'').addClass('animated '+slide_effects+'');
        setTimeout(function(){
          $(''+elem+'').removeClass('animated '+slide_effects+'').addClass("hide");
        },1000);
    },1);
  };

  /* function to be called when above animation needed*/

  function fadeinup() {
    var time = 0;
    $(".radio_select" ).addClass("hide").each(function( index ) {
      setTimeout(function(){
        openAnimate(".radio_select:eq( "+index+" )",'fadeInUp');
      },time+=200);
    });
  }

  $(document).on('#reset-password-form','click',function(){
        alert('hola hola');
    });


   $(document).ready(function(){
      /* button animated hover class*/
     $(".ficha-btn, .log-btn, .update-btn").addClass("hoverable");
     $( ".ficha-btn, .log-btn, .update-btn" ).append( "<div class='anim'></div>" );
     /* float shadow hover class*/
     $(".social-footer ul li a").addClass("float-shadow");


      
        $(document).on('click',function(){
        $('.collapse').collapse('hide');
        })

        // ////////
        var readURL = function(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
        $('.profile-pic').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
        }
        }


        $(".file-upload").on('change', function(){
        readURL(this);
        var fd = new FormData();

        var files = $('#file')[0].files[0];

        fd.append('file',files);
        fd.append('uid',1);       
        // console.log(uploadurl);
            $.ajax({
                url:uploadurl,
                type:'post',
                data:fd,
                contentType: false,
                processData: false,
                success:function(response){
                // if(response != 0){
                //     $("#img").attr("src",response);
                //     $('.preview img').show();
                // }else{
                //     alert('File not uploaded');
                // }
                }
            });
        });

        $(".upload-button").on('click', function() {
        $(".file-upload").click();
        });


        $("#but_upload").click(function(){


        });
        ///////////

   });
       