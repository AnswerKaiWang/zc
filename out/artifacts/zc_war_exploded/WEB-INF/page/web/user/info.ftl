<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>个人信息-个人中心-[@coAttr name="webSiteName" /]</title>
<link type="text/css" rel="stylesheet" href="${base}/front/style/global.css" />
<link type="text/css" rel="stylesheet" href="${base}/front/style/index.css" />
<script  type="text/javascript" src="${base}/front/js/jquery-1.9.1.min.js"></script>
<script  type="text/javascript" src="${base}/front/js/common.js"></script>
<script type="text/javascript" src="${base}/front/js/area.js" ></script>
<!--[if lt IE 9]>
 <script src="${base}/front/js/ie/html5.js"></script> 
 <script src="${base}/front/js/ie/selectivizr-min.js"></script> 
<![endif]-->
</head>
<body>
<div class="background_wraper">
[#assign currentPage="userCenter"]
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm">会员中心</a>/<a href="#" class="active">个人信息</a></div>
</div>
<!-- main s -->
<div class="main">
  <div class="inner_wrap">
     <div class="user_L">
      <div class="timg"> <img src="${base}[@coAttr name="userCenterLeftPic" /]" alt=""> <img src="${base}/front/images/gh.png" alt="" class="gh"> </div>
      <div class="l_menu">
          <ul>
          <li><a href="${base}/user/center.htm" class="aone">个人会员中心<i></i></a></li>
          <li><a href="#" class="aone">当前投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=current">投资汇总</a>
              <a href="${base}/user/current.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=current">分红明细</a>
              </li>
            </ol>
          </li>
           <li><a href="#" class="aone">历史投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=history">投资汇总</a>
              <a href="${base}/user/history.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=history">分红明细</a>
              </li>
            </ol>
          </li>
          <li><a href="${base}/user/fund.htm" class="aone">产品信息<i></i></a></li>
          <li class="active"><a href="#" class="aone active">我的账户<i></i></a>
            <ol>
              <li>
              	<a href="${base}/user/info.htm" class="active">个人信息</a>
              	<a href="${base}/user/protect.htm">安全中心</a>
              </li>
            </ol>
          </li>
        </ul>
      </div>
      <a href="${base}/user/loginout.htm" class="exit_login">退出登录</a>
    </div>
    <div class="user_R">
      <h3 class="r_ty_title">个人信息</h3>
      <div class="grxx">
        <ul>
          <li><span>基金账户：<i>${(user.userNo)!}</i></span></li>
          <li><span>客户姓名：<i>${(user.name)!}</i></span></li>
          <li><span>客户类型：<i>${(user.type.description)!}</i></span></li>
          <li><span>证件类型：<i>${(user.cardType.description)!}</i></span></li>
          <li><span>证件号码：<i>${(user.cardNo)!}</i></span></li>
          <li id="oldZip"><a href="javascript:;" onclick="showEdit('Zip')">编辑</a><span>邮政编码：<i>${(user.zip)!}</i></span></li>
          <li id="EditZip" style="display:none;">
              <div class="edit">
                <button type="submit" class="infoSubmit">确定</button><p><label>邮政编码</label><input type="text" class="ipt1" value="${(user.zip)!}" id="zip"></p>
              </div>
          </li>
          <li id="oldAddress"><a href="javascript:;" onclick="showEdit('Address')">编辑</a><span>通讯地址：<i>${(user.address)!}</i></span></li>
          <li id="EditAddress" style="display:none;">
              <div class="edit">
              <button type="submit" class="infoSubmit">确定</button>
              	<!--<div id="city">
                  <p><label>省</label><select id="s_province" name="s_province" ></select></p>
                  <p><label>市</label><select id="s_city" name="s_city" ></select></p>
                  <p><label>地区/县</label><select id="s_county" name="s_county"></select></p>
                </div>-->
                <p><label>详细地址</label><input type="text" class="ipt1" value="${(user.address)!}" id="address"></p>
              </div>
          </li>
          <li id="oldTel"><a href="javascript:;" onclick="showEdit('Tel')">编辑</a><span>电话号码：<i>${(user.tel)!}</i></span></li>
          <li id="EditTel" style="display:none;">
              <div class="edit">
                <button type="submit" class="infoSubmit">确定</button><p><label>电话号码</label><input type="text" class="ipt1" value="${(user.tel)!}" id="tel"></p>
              </div>
          </li>
          <li><span>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：<i>
          [#if (user.sex)??&&user.sex]
          	女
          [#elseif (user.sex)??&&!(user.sex)]
         	 男
          [/#if]
          </i></span></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!-- main e -->
<script type="text/javascript">
//opt0 = ["省份","地级市","市、县级市"];
//_init_area();
function showEdit(v){
	$("#old"+v).hide();
	$("#Edit"+v).show();
}
$(function(){
$(".infoSubmit").click(function(){
	$.ajax({
		type:"post",
		data:{address:$("#address").val(),
		zip:$("#zip").val(),
		tel:$("#tel").val()
		},
		url:"${base}/user/update.htm",
		dataType:"json",
		success:function(data){
			if(data.status=="00"){
				top.location.href="${base}/user/info.htm";
			}else{
			alert("系统错误");
			}
		},error:function(){
			alert("系统错误");
		}
	})

})

})
</script>
</div>
[#include "/web/common/footer.ftl"/]
</body>
</html>
