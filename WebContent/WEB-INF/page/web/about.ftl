<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>关于我们-[@coAttr name="webSiteName" /]</title>
<link type="text/css" rel="stylesheet" href="${base}/front/style/global.css" />
<link type="text/css" rel="stylesheet" href="${base}/front/style/index.css" />
<script  type="text/javascript" src="${base}/front/js/jquery-1.9.1.min.js"></script>
<script  type="text/javascript" src="${base}/front/js/common.js"></script>
<!--[if lt IE 9]>
 <script src="${base}/front/js/ie/html5.js"></script> 
 <script src="${base}/front/js/ie/selectivizr-min.js"></script> 
<![endif]-->
</head>
<body>
[#assign currentPage="about"]
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>关于我们</span><a href="${base}/index.htm">首页</a>/<a href="${base}/about.htm" class="active">关于我们</a></div>
</div>
<!-- main s -->
  <div class="zccf">
      <div class="wrap">
      	<div class="ltxt">
        	<p class="ty_inner_title"><span>[@coAttr name="aboutName" /]</span><i>CURA WEALTH</i></p>
        	<div class="tc">[@coAttr name="aboutContant" /]</div>
        </div>
        <div class="Rimg"><img src="${base}/front/images/abd.jpg" alt=""></div>
      </div>
  </div>
  <div class="lxwm">
    <div class="wrap"> 
      <script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
      <div style="width:585px;height:358px;font-size:12px" id="map" class="lmap"></div>
      <script type="text/javascript">
          //创建和初始化地图函数：
          function initMap(){
            createMap();//创建地图
            setMapEvent();//设置地图事件
            addMapControl();//向地图添加控件
            addMapOverlay();//向地图添加覆盖物
          }
          function createMap(){ 
            map = new BMap.Map("map"); 
            map.centerAndZoom(new BMap.Point([@coAttr name="lng" /],[@coAttr name="lat" /]),15);
          }
          function setMapEvent(){
            map.enableScrollWheelZoom();
            map.enableKeyboard();
            map.enableDragging();
            map.enableDoubleClickZoom()
          }
          function addClickHandler(target,window){
            target.addEventListener("click",function(){
              target.openInfoWindow(window);
            });
          }
          function addMapOverlay(){
            var markers = [
              {content:"",title:"",imageOffset: {width:-46,height:-21},position:{lng:[@coAttr name="lng" /],lat:[@coAttr name="lat" /]}}
            ];
            for(var index = 0; index < markers.length; index++ ){
              var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
              var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap/images/icon.png",new BMap.Size(20,25),{
                imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
              })});
              var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(25,5)});
              var opts = {
                width: 200,
                title: markers[index].title,
                enableMessage: false
              };
              var infoWindow = new BMap.InfoWindow(markers[index].content,opts);
              marker.setLabel(label);
              addClickHandler(marker,infoWindow);
              map.addOverlay(marker);
            };
          }
          //向地图添加控件
          function addMapControl(){
            var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
            map.addControl(navControl);
          }
          var map;
            initMap();
        </script>
      <div class="lxtxt">
        <p class="ty_inner_title"><span>联系我们</span><i>CONTACT US</i></p>
        <ul>
          [@coAttr name="tel"][#if companyAttr??]<li><span>全国服务热线:&nbsp;&nbsp;${(companyAttr.contant)!}</span></li>[/#if][/@coAttr]
          [@coAttr name="email"][#if companyAttr??]<li><span>客服邮箱:&nbsp;&nbsp;${(companyAttr.contant)!}</span></li>[/#if][/@coAttr]
          [@coAttr name="serviceTime"][#if companyAttr??]<li><span>人工服务时间:&nbsp;&nbsp;${(companyAttr.contant)!}</span></li>[/#if][/@coAttr]
          [@coAttr name="zip"][#if companyAttr??]<li><span>邮编:&nbsp;&nbsp;${(companyAttr.contant)!}</span></li>[/#if][/@coAttr]
          [@coAttr name="tax"][#if companyAttr??]<li><span>传真:&nbsp;&nbsp;${(companyAttr.contant)!}</span></li>[/#if][/@coAttr]
        </ul>
      </div>
    </div>
  </div>
<!-- main e --> 
[#include "/web/common/footer.ftl"/]
<a href="javascript:void(0);" title="返回顶部" id="backtop"><img src="${base}/front/images/j1_03.png" width="45" height="45" alt=""></a>
</body>
</html>
