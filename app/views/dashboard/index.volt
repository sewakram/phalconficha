<style type="text/css">
    g[Attributes Style] {
        transform: translate(795, 63);
        visibility: hidden !important;
        display: none!important;
    }
    /*.amcharts-chart-div{max-width:900px!important;}*/
</style>
<script type="text/javascript"> var uploadurl='<?php echo $this->url->get("application/upload");?>';</script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<!-- <script type="text/javascript" src="https://github.com/amcharts/responsive/blob/master/responsive.min.js"></script>
 -->{{ content() }}
<?php 
    $currentDate = date('F d');
    $weekStartDateFromCurrentDate = date('F d', strtotime('-6 days', strtotime($currentDate)));

    $nextPrevWeekArray = dateShuffle($currentDate, $weekStartDateFromCurrentDate);
    
    $currentWeekArray = [
        'currentDate'                       => $currentDate,
        'weekStartDateFromCurrentDate'      => $weekStartDateFromCurrentDate,
    ];

    function dateShuffle($currentDate, $weekStartDateFromCurrentDate) {
        $nextWeekStartDateFromCurrentDate = date('F d', strtotime('-1 days', strtotime($weekStartDateFromCurrentDate)));
        $nextWeekEndDateFromCurrentDate = date('F d', strtotime('-6 days', strtotime($nextWeekStartDateFromCurrentDate)));
        
        $prevWeekStartDateFromCurrentDate = date('F d', strtotime('-1 days', strtotime($nextWeekEndDateFromCurrentDate)));
        $prevWeekEndDateFromCurrentDate = date('F d', strtotime('-6 days', strtotime($prevWeekStartDateFromCurrentDate)));

            $nextPrevWeekArray = [
                'nextWeekStartDateFromCurrentDate'  => $nextWeekStartDateFromCurrentDate,
                'nextWeekEndDateFromCurrentDate'    => $nextWeekEndDateFromCurrentDate,
                'prevWeekStartDateFromCurrentDate'  => $prevWeekStartDateFromCurrentDate,
                'prevWeekEndDateFromCurrentDate'    => $prevWeekEndDateFromCurrentDate,
            ];

        return $nextPrevWeekArray;
    }

    if ($femaleCount > $maleCount) {
        $genderPopular = [
            "gender"    => "Female",
            "count"     => $femaleCount,
        ];
    }
    else {
        $genderPopular = [
            "gender"    => "Male",
            "count"     => $maleCount,
        ];
    }
?>
<section class="dashboard-wrapper">
    <div class="dashboard">
        <div class="app-header row plain-color">
            <div class="col-sm-8">
                <h1 class="app-title"><?=$t->_("dashboard"); ?></h1>
                <h5 class="app-desc"><?=$t->_("dashboard_info"); ?></h5>
            </div>
            <div class="col-sm-4 main-app-point">
                <div class="collapse navbar-collapse logout-wrap">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="down-arrow-img"></span>
                                <span class="user-name"><?php echo ucfirst($loggedInUser->fname)." ".ucfirst($loggedInUser->lname[0]).".";?></span>
                                <span class="user-img-wrapp"><img class="profile-icon profile-pic" src="<?php echo ($loggedInUser->pic)? $this->url->get($loggedInUser->pic):'/images/82092abcffa42dae1d948bb7bed4bb01139322c4.png'?>" /></span>
                                <!-- <span class="glyphicon glyphicon-user"></span>  -->
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
                                                    <a href="/account/index" class="btn btn-primary btn-block btn-sm update-btn"><?=$t->_("update_profile"); ?></a>
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
                                                    <a href="/session/end" class="btn btn-danger btn-block log-btn"><?=$t->_("log_out"); ?></a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="dashboard-main-content-wrappp">
        <div class="statistics-general">
            <div class="row top-details-wrapp">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <span class="general-text"><?=$t->_("general_data_points_statistics"); ?></span>
                </div>
                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12 data-points-wrapp">
                    <div class="col-lg-6 col-md-6 col-xs-12 col-xs-12 data-points-wrapp-inn">
                        <div class="col-sm-3 col-xs-3 date-range-wrap">
                        <span class="data-point-count dateRangeCount"></span>
                        </div>
                        <div class="col-sm-9 col-xs-9 data-point">
                        <span class="data-point-wrapp">
                            <span class="data-point-big-text"><?=$t->_("data_points_in_range"); ?></span>
                            <span class="data-point-small-text fromdate"></span>
                        </span>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-xs-12 col-xs-12 data-points-wrapp-inn">
                        <div class="col-sm-3 col-xs-3 date-range-wrap">
                         <span class="data-point-count"><?=$totalDataPoints;?></span>
                        </div>
                        <div class="col-sm-9 col-xs-9">
                         <span class="data-point-wrapp">
                                <span class="data-point-big-text"><?=$t->_("total_data_points"); ?></span>
                                <span class="data-point-small-text"><?=$t->_("available_and_active"); ?></span>
                         </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row col-md-12 line-chart-wrapper">
                <div class="line-chart">
                    <div id="chartdiv"></div>
                    <div class="padding-top">
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 left-nav">
                            <a onclick="navChart(-7)" class="btn btn-default btn-md nav-anchor"><span class="glyphicon glyphicon-chevron-left"></span></a> 
                            <!-- <?//= "<span class='date-range date-prev'>"."From ".$nextPrevWeekArray['prevWeekEndDateFromCurrentDate']." to ".$nextPrevWeekArray['prevWeekStartDateFromCurrentDate']."</span>"; ?> -->
                            <span class="prevweek date-range date-prev"></span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 desc-date"> <center><h4>
                            <!-- <?//= "<span class='date-range date-current'>"."From ".$nextPrevWeekArray['nextWeekEndDateFromCurrentDate']." to ".$nextPrevWeekArray['nextWeekStartDateFromCurrentDate']."</span>"; ?> -->
                            <span class="date-range date-current fromdate"></span>
                            <span hide class="to_diff"></span>
                        </h4></center> </div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 right-nav widthmanage">
                            <!-- <?//= "<span class='date-range date-next'>"."From ".$currentWeekArray['weekStartDateFromCurrentDate']." to ".$currentWeekArray['currentDate']."</span>"; ?> -->
                            <span class="nextweek date-range date-next"></span>
                            <a onclick="navChart(7)" class="btn btn-default btn-md nav-anchor"><span class="glyphicon glyphicon-chevron-right"></span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="overview-graph">
            <span class="general-overview-text"><?=$t->_("general_overview"); ?></span>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 overview-graph-count-wrapp">
                      <div class="col-sm-3 col-xs-3 date-range-wrap">
                      <span class="data-point-count"><?php echo $genderPopular['count']; ?></span>
                      </div>
                      <div class="col-sm-9 col-xs-9">
                        <span class="data-point-wrapp">
                            <span class="data-point-big-text"><?=$t->_("popular_gender"); ?></span>
                            <span class="data-point-small-text"><?php echo $genderPopular['gender']; ?></span>
                        </span>
                       </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 overview-graph-count-wrapp">
                      <div class="col-sm-3 col-xs-3 date-range-wrap">
                        <span class="data-point-count"><?php echo $maxCityCount; ?></span>
                      </div>
                       <div class="col-sm-9 col-xs-9">
                        <span class="data-point-wrapp">
                            <span class="data-point-big-text"><?=$t->_("popular_location"); ?></span>
                            <span class="data-point-small-text"><?php echo $cityNameWithMaxCount.", ".$countryNameWithMaxCount; ?></span>
                        </span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 overview-graph-count-wrapp">
                      <div class="col-sm-3 col-xs-3 date-range-wrap">
                       <span class="data-point-count"><?=$modelCount?></span>
                      </div>
                       <div class="col-sm-9 col-xs-9">
                        <span class="data-point-wrapp">
                            <span class="data-point-big-text"><?=$t->_("popular_phone_model"); ?></span>
                            <span class="data-point-small-text"><?=$modelName?></span>
                        </span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 overview-graph-count-wrapp">
                    <div class="col-sm-3 col-xs-3 date-range-wrap">
                    <span class="data-point-count"><?=$ageCounter?></span>
                    </div>
                     <div class="col-sm-9 col-xs-9">
                    <span class="data-point-wrapp">
                        <span class="data-point-big-text"><?=$t->_("popular_age_range"); ?></span>
                        <span class="data-point-small-text"><?php echo $ageRangeMin.' to '.$ageRangeMax; ?> years</span>
                    </span>
                    </div>
                </div>
            </div>
        </div>
    </div>   
</section>

<script type="text/javascript">
    $(function() {   
        $('#chartdiv').bind('dragstart', function(event) { event.preventDefault() });

    });
    
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    <?php 
    // print_r($datapoints);
    if (!empty($datapoints)) { ?>
        var chart = AmCharts.makeChart("chartdiv", {
            "hideCredits": true,
            "type": "serial",
            "zoomOutText": '',
            "theme": "light",
            "marginRight": 40,
            "marginLeft": 40,
            "autoMarginOffset": 20,
            "dataDateFormat": "YYYY-MM-DD",
            "valueAxes": [{
                "id": "v1",
                "axisAlpha": 0,
                "position": "left",
                "ignoreAxisWidth":true
            }],
            "balloon": {
                "borderThickness": 1,
                "shadowAlpha": 0
            },
            "graphs": [{
                "id": "g1",
                "balloon":{
                  "drop":true,
                  "adjustBorderColor":false,
                  "color":"#ffffff",                  
                },
                "bullet": "round",
                "bulletBorderAlpha": 1,
                "bulletColor": "#FFFFFF",
                "bulletSize": 5,
                "hideBulletsCount": 50,
                "lineThickness": 2,
                "title": "red line",
                "useLineColorForBulletBorder": true,
                "valueField": "value",
                "type":"smoothedLine",
                "balloonText": "<span style='font-size:18px;'>[[value]]</span>",
                "fillAlphas": 0.2
                
            }],
            // "chartScrollbar": {
            //     "graph": "g1",
            //     "oppositeAxis":false,
            //     "offset":30,
            //     "scrollbarHeight": 80,
            //     "backgroundAlpha": 0,
            //     "selectedBackgroundAlpha": 0.1,
            //     "selectedBackgroundColor": "#888888",
            //     "graphFillAlpha": 0,
            //     "graphLineAlpha": 0.5,
            //     "selectedGraphFillAlpha": 0,
            //     "selectedGraphLineAlpha": 1,
            //     "autoGridCount":true,
            //     "color":"#AAAAAA"
            // },
            "chartCursor": {
                "pan": false,
                "valueLineEnabled": true,
                "valueLineBalloonEnabled": true,
                "cursorAlpha":1,
                "cursorColor":"#258cbb",
                "limitToGraph":"g1",
                "valueLineAlpha":0.2,
                "valueZoomable":true,
                "selectWithoutZooming":true
            },
            // "valueScrollbar":{
            //   "oppositeAxis":false,
            //   "offset":50,
            //   "scrollbarHeight":10
            // },
            "categoryField": "date",
            
            "categoryAxis": {
                "parseDates": true,
                "dashLength": 1,
                "minorGridEnabled": true,
                "boldPeriodBeginning":false,
                "labelFunction": function(valueText, date, categoryAxis) {
                return date.getDate();
                }
            },
            "responsive": {
            "enabled": true,
            "rules": [
            // at 400px wide, we hide legend
            {
            "maxWidth": 360,
            "overrides": {
            "legend": {
            "enabled": false
            }
            }
            },

            // at 300px or less, we move value axis labels inside plot area
            // the legend is still hidden because the above rule is still applicable
            {
            "maxWidth": 360,
            "overrides": {
            "valueAxes": {
            "inside": true
            }
            }
            },

            // at 200 px we hide value axis labels altogether
            {
            "maxWidth": 360,
            "overrides": {
            "valueAxes": {
            "labelsEnabled": false
            }
            }
            }

            ]
            },
            "export": {
                "enabled": true
            },
            "dataProvider": <?php echo json_encode($datapoints); ?>,
            "mouseWheelZoomEnabled": false,
        });

        function hideme1(){
            if($('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,28)"]').is(":visible"))
            {
                var selector1 = $('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,28)"]');
                selector1.attr('visibility','hidden');
            }
            else{
                setTimeout(function(){
                    hideme1();
                },100);
            }
        }
        hideme1();
    <?php } else{ ?>

        $(".nav-anchor").removeAttr("onclick");

        $(".dateRangeCount").html('0');

        var chart = AmCharts.makeChart("chartdiv", {
            "hideCredits": true,
            "type": "serial",
            "theme": "light",
            "zoomOutText": '',
            "marginRight": 10,
            "marginLeft": 10,
            "autoMarginOffset": 20,
            "dataDateFormat": "YYYY-MM-DD",
            "valueAxes": [{
                "id": "v1",
                "axisAlpha": 0,
                "position": "left",
                "ignoreAxisWidth":true
            }],
            "balloon": {
                "borderThickness": 1,
                "shadowAlpha": 0
            },
            "graphs": [{
                "id": "g1",
                "balloon":{
                  "drop":true,
                  "adjustBorderColor":false,
                  "color":"#ffffff"
                },
                "bullet": "round",
                "bulletBorderAlpha": 1,
                "bulletColor": "#FFFFFF",
                "bulletSize": 5,
                "hideBulletsCount": 50,
                "lineThickness": 2,
                "title": "red line",
                "useLineColorForBulletBorder": true,
                "valueField": "value",
                "type":"smoothedLine",
                "balloonText": "<span style='font-size:18px;'>[[value]]</span>"
            }],
            // "chartScrollbar": {
            //     "graph": "g1",
            //     "oppositeAxis":false,
            //     "offset":30,
            //     "scrollbarHeight": 80,
            //     "backgroundAlpha": 0,
            //     "selectedBackgroundAlpha": 0.1,
            //     "selectedBackgroundColor": "#888888",
            //     "graphFillAlpha": 0,
            //     "graphLineAlpha": 0.5,
            //     "selectedGraphFillAlpha": 0,
            //     "selectedGraphLineAlpha": 1,
            //     "autoGridCount":true,
            //     "color":"#AAAAAA"
            // },
            "chartCursor": {
                "pan": false,
                "valueLineEnabled": true,
                "valueLineBalloonEnabled": true,
                "cursorAlpha":1,
                "cursorColor":"#258cbb",
                "limitToGraph":"",
                "valueLineAlpha":0.2,
                "valueZoomable":true,
                "selectWithoutZooming":true
            },
            
            // "valueScrollbar":{
            //   "oppositeAxis":false,
            //   "offset":50,
            //   "scrollbarHeight":10
            // },
            "categoryField": "date",
            "categoryAxis": {
                "parseDates": true,
                "dashLength": 1,
                "minorGridEnabled": true
            },
            "export": {
                "enabled": true
            },
            "dataProvider": [
                {
                    'date':'',
                    'value':0
                }
            ],
            "mouseWheelZoomEnabled": false,
            "titles": [
                {
                    "text": "No data points available to display Line Chart, please add an application",
                    "size": 18,
                    "bold": false
                }
            ]
        });
        
        function hideme(){
            if($('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,63)"]').is(":visible"))
            {
                var selector = $('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,63)"]');
                selector.attr('visibility','hidden');
            }
            else{
                setTimeout(function(){
                        hideme();
                },100);
            }
        }
        hideme();
    <?php } ?>
    
    chart.addListener("rendered", zoomChart);

    zoomChart();

    function processDate(inputDate) {
        var day = inputDate.getDate();
        // console.log("day",day);
        var endday = day + 7;
        var month = inputDate.getMonth() + 1;
        var year = inputDate.getFullYear();

        if (day < 10) {
          day = '0' + day;
          endday = '0' + endday;
        }
        if (month < 10) {
          month = '0' + month;
        }
        
        return (year + "-" + month + "-" + day);
    }

    function zoomChart() {
        // calculate new start date and end dates

        /* Below code is for current week dates*/
        var fromdate = new Date();
        var todate = new Date();

        // fromdate.setDate(fromdate.getDate()-7);
        var fromday = moment(fromdate).subtract(7, 'days');//fromdate.getDate();
        // var frommonth = monthNames[fromdate.getMonth()];
        var today = moment(todate);//todate.getDate();
        // var tomonth = monthNames[todate.getMonth()];

        var arr = <?php print_r(json_encode($datapoints)); ?>;
        var count = 0;
        $(document).ready(function(){
            $( window ).load(function(){
                console.log("fromdate",fromday.format("YYYY-MM-DD"));
                console.log("today",today.format("YYYY-MM-DD"));
                
                $.each(arr, function(index, value){
                    console.log("db date",value.date);
                    if (value.date >= (fromday.format("YYYY-MM-DD")) && value.date < (today.format("YYYY-MM-DD"))){
                        count = count+parseInt(value.value);
                        console.log(count);
                    }
                });
                    $(".dateRangeCount").html(count)
            });
        });
        
        /* below code prev week dates*/
        var prevfromdate = new Date();
        // prevfromdate.setDate(prevfromdate.getDate()-14);
        var prevfromday = moment(prevfromdate).subtract(14, 'days');//prevfromdate.getDate();
        // var prevfrommonth = monthNames[prevfromdate.getMonth()];

        /* Below code is for the next week dates*/
        var nextTodate = new Date();
        // nextTodate.setDate(nextTodate.getDate()+7);
        var nextToday = moment(nextTodate).add(7, 'days');//nextTodate.getDate();
        // var nextTomonth = monthNames[nextTodate.getMonth()];
        
        /* Appending date range to the respective span tags*/

        /* current week date span*/
        $(".fromdate").html('From '+fromday.format("MMMM")+' '+fromday.format("DD")+' To '+today.format("MMMM")+' '+today.subtract(1, 'days').format("DD"));
        
        /* prev week date span */
        $(".prevweek").html('From '+prevfromday.format("MMMM")+' '+prevfromday.format("DD")+' To '+fromday.format("MMMM")+' '+(fromday.subtract(1, 'days').format("DD")));
        
        /* next week date span*/
        $(".nextweek").html('From '+today.add(1, 'days').format("MMMM")+' '+(today.format("DD"))+' To '+nextToday.format("MMMM")+' '+nextToday.subtract(1, 'days').format("DD"));
        
        // chart.zoomToIndexes(chart.dataProvider.length-7, chart.dataProvider.length);

        chart.zoomToDates(new Date(fromday.add(1, 'days').format("YYYY-MM-DD")), new Date(today.format("YYYY-MM-DD")));
    }

    function navChart(days) {
        // if(new Date(chart.startDate) >= chart.chartData[0].category){

            // var dif= moment(new Date(chart.startDate)).diff(moment(chart.chartData[0].category), 'days');
            // console.log("diday",dif);
        //     if(days==7){
        //     var from = moment(new Date(chart.startDate)).add(dif, 'days');
        //     }else{
        //     var from = moment(new Date(chart.startDate)).subtract(7, 'days');
        //     }
              
        // }else{
            ////////
                if(days==7){
                var from = moment(new Date(chart.startDate)).add(7, 'days');
                }else{
                var from = moment(new Date(chart.startDate)).subtract(7, 'days');

                }
            ///////
        // }
      // calculate new start date and end dates
      console.log("chart.startDate",chart.startDate);
      console.log("chart.endDate",chart.endDate);
      
      console.log("navfrom",new Date(from.format("YYYY-MM-DD")));
      // from.setDate(from.getDate() + days);
      // console.log("afternavfrom",from);

      // var to = new Date(chart.endDate);
      if(days==7){
      var to = moment(new Date(chart.endDate)).add(6, 'days');
     }else{
      var to = moment(new Date(chart.endDate)).subtract(7, 'days');

     }
      console.log("navto",to.format("YYYY-MM-DD"));

      // to.setDate(to.getDate() + days);
      // console.log("afternavto",to);
      console.log('bound',chart.chartData[0].category);
      console.log('bound2',chart.chartData[chart.chartData.length-1].category);
      // check bounds



      // zoom chart
      //$(".fromdate").html('From ' + monthNames[from.getMonth()] + ' ' + from.getDate() + ' To ' + monthNames[to.getMonth()] + ' ' +to.getDate());

      /* Start of Dates Change code */
    
            // var then = new Date();
            // console.log('from',from);
            // var then = new Date();
            // var next = new Date();
            // var next = new Date();
            // console.log("next",next);
            // console.log('to'+to);
            // then.setDate (from.getDate() - 7);
            // console.log("days",days);
              
             // var monthIndex = then.getMonth(); 
             //alert(monthNames[to.getMonth()+1]);
            // next.setDate (to.getDate() + 7);
            // console.log("plusnext",next);
            
             // var day1 = next.getDate(); 
             // console.log("day1",day1);
             // var monthIndex1 = next.getMonth(); 
             // var extra='';
             // var exmonth='';
             // next.setDate (to.getDate());
             // if(to.getDate()==31){
              // extra+=to.getDate();
              // extra=moment(to).add(1, 'days');
              var day = moment(new Date(from.format("YYYY-MM-DD"))).subtract(7, 'days');
              var day1=moment(new Date(to.format("YYYY-MM-DD"))).add(7, 'days');
              // extra+=moment(extra).format("DD");
              // extra.setDate (to.getDate() + 1);
              // console.log("extra",extra);
              // console.log("to",to);

              //alert('if'+extra) 
              // exmonth+=monthNames[to.getMonth()]; 
             // }else{
             //    exmonth+=monthNames[to.getMonth()+1];
             //    extra+=next.getDate()+1;
             //    //alert('else'+extra)
             // }
      /* End of Dates Change code */

      //$(".prevweek").html('From ' + (monthNames[from.getMonth()] + ' ' + day) + ' To ' + monthNames[from.getMonth()] + ' '+(from.getDate()-1));

      //$(".nextweek").html('From '+monthNames[to.getMonth()] + ' ' + extra + ' To ' + monthNames[to.getMonth()] + ' '  + day1);
      if ( new Date(from.format("YYYY-MM-DD")) <= chart.chartData[0].category ) {
        $(".left-nav :nth-child(1)").hide();
      }else{
        $(".left-nav :nth-child(1)").show();
        $(".nav-anchor :nth-child(1)").removeAttr("style");
      }

      if (new Date(to.format("YYYY-MM-DD")) >= chart.chartData[chart.chartData.length-1].category ) {
        $(".right-nav :nth-child(2)").hide();
      }else{
        $(".right-nav :nth-child(2)").show();
        $(".nav-anchor :nth-child(1)").removeAttr("style");
      }
     //    var diff=moment(chart.chartData[0].category).diff(moment(new Date(from.format("YYYY-MM-DD"))), 'days');
     //    var lessfrom=from.add(diff+1, 'days').hours(0).minutes(0).seconds(0).milliseconds(0);
     //    // from = new Date(chart.chartData[0].category);
     //    // to=moment(new Date(chart.chartData[0].category)).add(10, 'days');
     //    // // to.setDate(from.getDate() + 10);
     //    // from.setHours(0, 0, 0);
     //    // from=moment(from);
     //    var current =$(".date-current").text();
     //  var previous=$(".date-prev").text();
     //  var nextdate=$(".date-next").text();
     //  console.log("lessfrom",lessfrom.format("YYYY-MM-DD HH:mm:ss"),to.format("YYYY-MM-DD"));
     //  /////////////////
     //  if(days==-7){
     //    $(".prevweek").html('From ' + day.format("MMMM") + ' '+day.format("DD") + ' To ' + from.format("MMMM") + ' ' + from.subtract(1, 'days').format("DD"));
     //    $(".fromdate").html('From ' + lessfrom.add(1, 'days').format("MMMM") + ' '+lessfrom.format("DD") + ' To ' + to.format("MMMM") + ' ' + to.subtract(1, 'days').format("DD"));
     //    $(".nextweek").html(current);
     //  }else{
     //    $(".nextweek").html('From '+to.format("MMMM") + ' ' + to.add(1, 'days').format("DD") + ' To ' + day1.format("MMMM") + ' '  + day1.format("DD"));
     //    $(".fromdate").html(nextdate);
     //    $(".prevweek").html(current);
     //  }
     // //////////////////
     //  }else
     //   if (new Date(to.format("YYYY-MM-DD")) >= chart.chartData[chart.chartData.length-1].category ) {
     //    to = new Date(chart.chartData[chart.chartData.length-1].category);
     //    from=moment(new Date(chart.chartData[chart.chartData.length-1].category)).subtract(10, 'days');

     //    // from.setDate(to.getDate() - 10);
     //    to.setHours(23, 59, 59);
     //    to=moment(to);
     //    var current =$(".date-current").text();
     //  var previous=$(".date-prev").text();
     //  var nextdate=$(".date-next").text();
     //  // console.log("from",from);
     //  /////////////////
     //  if(days==-7){
     //    $(".prevweek").html('From ' + day.format("MMMM") + ' '+day.format("DD") + ' To ' + from.format("MMMM") + ' ' + from.subtract(1, 'days').format("DD"));
     //    $(".fromdate").html(previous);
     //    $(".nextweek").html(current);
     //  }else{
     //    $(".nextweek").html('From '+to.format("MMMM") + ' ' + to.add(1, 'days').format("DD") + ' To ' + day1.format("MMMM") + ' '  + day1.format("DD"));
     //    $(".fromdate").html(nextdate);
     //    $(".prevweek").html(current);
     //  }
     // //////////////////
     //  }else{
        var current =$(".date-current").text();
      var previous=$(".date-prev").text();
      var nextdate=$(".date-next").text();
      // console.log("from",from);
      /////////////////
      if(days==-7){
        $(".prevweek").html('From ' + day.format("MMMM") + ' '+day.format("DD") + ' To ' + from.format("MMMM") + ' ' + from.subtract(1, 'days').format("DD"));
        $(".fromdate").html(previous);
        $(".nextweek").html(current);
      }else{
        $(".nextweek").html('From '+to.format("MMMM") + ' ' + to.add(1, 'days').format("DD") + ' To ' + day1.format("MMMM") + ' '  + day1.format("DD"));
        $(".fromdate").html(nextdate);
        $(".prevweek").html(current);
      }
     //////////////////
      // }

      

      var arr = <?php print_r(json_encode($datapoints)); ?>;

         // if(moment(from).add(1, 'days').format("YYYY-MM-DD") < moment(chart.chartData[0].category).format("YYYY-MM-DD")){
         //                    console.log("i am inside");
         //                    /* var newval=moment(chart.chartData[0].category).add(negtvdif, 'days').format("YYYY-MM-DD");*/
                              
         //                        var obj = {};
         //                        obj['date'] = "2018-09-01";
         //                        obj['value'] = "1";
         //                        // arr.push(obj);
         //                        arr.unshift(obj);
                                
         //                    }

                 
      console.log("data",arr);
      var count = 0;
      // var dp;

      console.log("finaldate",from.format("YYYY-MM-DD"),to.format("YYYY-MM-DD"));
      // var test = new Date();
      // var test1 = new Date();
      // test = from;
      // test1 = to;
      // console.log("test"+test);
      // test1.setDate(test1.getDate()-1);
      // console.log("test"+test1);
       //  var formatedless=lessfrom.format("YYYY-MM-DD HH:mm:ss");
       // console.log("lessfrom2",formatedless,to.format("YYYY-MM-DD"),chart.chartData[0].category);
      // if ( new Date(from.format("YYYY-MM-DD HH:mm:ss")) <= chart.chartData[0].category ) {
      //  console.log("lessfrom2",new Date(from.format("YYYY-MM-DD HH:mm:ss")),to.format("YYYY-MM-DD"),chart.chartData[0].category);
      //   if(days==-7){
      //   chart.zoomToDates(new Date(from.format("YYYY-MM-DD")), new Date(to.add(1, 'days').format("YYYY-MM-DD")));

      //   }
      //   // else{
      //   // chart.zoomToDates(new Date(from.format("YYYY-MM-DD")), new Date(to.format("YYYY-MM-DD")));

      //   // }
      // }else{
        console.log("else",moment(chart.startDate).format("YYYY-MM-DD"),moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD"));
            if(days==-7){
                var strt=moment(chart.endDate).format("YYYY-MM-DD");
                var end=moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD");
                console.log(strt,end);
                var chk = moment(strt).isSame(end);

                var differe=moment(to.format("YYYY-MM-DD")).diff(end, 'days');
                console.log(differe);

                if (chk)   { console.log("test1");
                    //////////////
                        $(document).ready(function(){
                        $.each(arr, function(index, value){
                        if (value.date > (from.format("YYYY-MM-DD")) && value.date <= (to.format("YYYY-MM-DD"))){
                        count = count+parseInt(value.value);
                        console.log(from.format("YYYY-MM-DD"),value.date,to.format("YYYY-MM-DD"),count);
                        }
                        });
                        $(".dateRangeCount").html(count)
                        });
                    /////////////
                    // var diff= moment(chart.chartData[chart.chartData.length-1].category).diff(moment(to), 'days');
                    chart.zoomToDates(new Date(from.add(1, 'days').format("YYYY-MM-DD")), new Date(moment(chart.startDate).format("YYYY-MM-DD")));
                    // console.log("diff",diff);
                }else{ console.log("test2");
                    //////////////
                    $(document).ready(function(){

                        ////////////////////////

                        var negtvdif= moment(from.format("YYYY-MM-DD")).add(1, 'days').diff(moment(chart.chartData[0].category).format("YYYY-MM-DD"), 'days');
                        // console.log("negative difference",negtvdif);
                        console.log("negative",moment(from).add(1, 'days').format("YYYY-MM-DD"),moment(chart.chartData[0].category).format("YYYY-MM-DD"));

                     /*   if(moment(from).add(1, 'days').format("YYYY-MM-DD") < moment(chart.chartData[0].category).format("YYYY-MM-DD")){
                            console.log("i am inside");
                             var newval=moment(chart.chartData[0].category).add(negtvdif, 'days').format("YYYY-MM-DD");
                                console.log("negtvdif",negtvdif,newval);
                                var obj = {};
                                obj['date'] = "2018-09-01";
                                obj['value'] = "1";
                                // arr.push(obj);
                                arr.unshift(obj);
                                
                            }*/
                        ///////////////////////////
                    $.each(arr, function(index, value){
                       console.log(index+"????????????????"+typeof value.date); 

                    if (value.date > (from.format("YYYY-MM-DD")) && value.date < (to.format("YYYY-MM-DD"))){
                    count = count+parseInt(value.value);
                    console.log("mycount"+count);
                    console.log(from.format("YYYY-MM-DD"),value.date,to.format("YYYY-MM-DD"),count);
                    }
                    });

                    

                    console.log('negativediff array',arr);
                    $(".dateRangeCount").html(count)
                    });
                    /////////////
                chart.zoomToDates(new Date(from.add(1, 'days').format("YYYY-MM-DD")), new Date(to.format("YYYY-MM-DD")));  
                }
            

            }else{ console.log("test3");
                        
                        var n = moment(chart.startDate).isSame(chart.chartData[0].category);
                    if(n){ console.log("test4");
                        //////////////

                        $(document).ready(function(){

                        $.each(arr, function(index, value){
                            console.log("ready",moment(from).subtract(1, 'days').format("YYYY-MM-DD")+"and"+to.format("YYYY-MM-DD"));
                        if (value.date >= (moment(from).subtract(1, 'days').format("YYYY-MM-DD")) && value.date <= (to.format("YYYY-MM-DD"))){
                             // console.log("ready",value.value);

                        count = count+parseInt(value.value);
                        // alert(count);
                        console.log(from.format("YYYY-MM-DD"),value.date,to.format("YYYY-MM-DD"),count);
                        }
                        });
                        $(".dateRangeCount").html(count);
                        });
                        /////////////
                        console.log("if",from,chart.chartData[0].category);
                    var dif= moment(from).diff(moment(chart.chartData[0].category), 'days');
                    console.log("diday",dif);
                    chart.zoomToDates(new Date(moment(chart.endDate).format("YYYY-MM-DD")), new Date(to.format("YYYY-MM-DD")));

                    }else{ console.log("test5");
                        //////////////
                        $(document).ready(function(){
                            // console.log('mychk',to.format("YYYY-MM-DD"),moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD"))
                             var diflast= moment(to.format("YYYY-MM-DD")).subtract(1, 'days').diff(moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD"), 'days');
                            console.log(moment(to).subtract(1, 'days').format("YYYY-MM-DD")+">"+moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD"))
                            

                        $.each(arr, function(index, value){
                        
                        if(moment(to).subtract(1, 'days').format("YYYY-MM-DD") > moment(chart.chartData[chart.chartData.length-1].category).format("YYYY-MM-DD")){
                                newval=moment(value.date).add(diflast, 'days');
                                var obj = {};
                                obj['date'] = "2018-10-29";//newval;
                                obj['value'] = 0;
                                arr.push(obj);
                            }   

                        if (value.date >= (from.format("YYYY-MM-DD")) && value.date < (to.format("YYYY-MM-DD"))){
                        count = count+parseInt(value.value);
                        console.log(from.format("YYYY-MM-DD"),value.date,to.format("YYYY-MM-DD"),count);
                        }

                        });
                        console.log('finddiff',arr);

                        $(".dateRangeCount").html(count)
                        });
                        /////////////
                        console.log("elsesewak");
                    chart.zoomToDates(new Date(from.format("YYYY-MM-DD")), new Date(to.format("YYYY-MM-DD")));

                    }

            }

       // }

      
        function hideme2(){
            if ( ($('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,63)"]').is(":visible")) ) {
                var selector = $('#chartdiv .amcharts-main-div .amcharts-chart-div svg g[transform="translate(1021,63)"]');
                selector.attr('visibility','hidden');
            }
            else {
                setTimeout(function(){
                        hideme2();
                },100);
            }
        }
        hideme2();
    }
</script>