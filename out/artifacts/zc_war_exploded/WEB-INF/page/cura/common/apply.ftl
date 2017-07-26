<!-- 活动报名弹窗 s -->
<div class="sign_popup">
  <p class="title">活动报名<span>感谢您的报名，我们会尽快联系您</span></p>
  <form action="" id="actApplyForm">
  	<input type="hidden" name="activityId" id="activityId" />
    <ul>
      <li>
        <label>姓名：</label>
        <span class="placeholder_wrap"><input type="text" class="ipt1" id="name" name="name" placeholder="请输入您的姓名"></span>
      </li>
      <li>
        <label>电话：</label>
        <span class="placeholder_wrap"><input type="text" class="ipt1" id="phone" name="phone" placeholder="请输入您的电话号码"></span>
      </li>
      <li>
        <label>人数：</label>
        <span class="placeholder_wrap"><input type="number" class="ipt1" id="memberNum" name="memberNum" placeholder="请输入您参加活动的人数"></span>
      </li>
      <li>
        <input type="button" class="submit" value="我要参加" id="submitApplyBtn">
      </li>
    </ul>
  </form>
</div>
<!-- 活动报名弹窗 e --> 
<!-- 预约成功弹窗 s -->
<div class="bookingfinish_popup">
  <p class="title">预约成功</p>
  <p class="txt">财富顾问会在下一个工作日内与您联系</p>
  <p class="y_button"><a href="javascript:void(0);" class="a1 close_bookingfinish_popup">完成预约</a><a href="#" class="a2">预约查询</a></p>
</div>
<!-- 预约成功弹窗 e --> 
<script type="text/javascript">
//placeholder
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
});
</script>
<script type="text/javascript">

function openApply(actId){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  shadeClose :true,
		  content: $('.sign_popup')//弹出活动报名弹窗
		});
		$("#actApplyForm #activityId").val(actId);	
}

$(function(){
	$("#submitApplyBtn").on("click",function(){
			var name = $("#actApplyForm #name").val();
			if(!name){
				alertNotification("提示","请输入姓名!","确定");
				return false;
			}
			var phone = $("#actApplyForm #phone").val();
			if(!name){
				alertNotification("提示","请录入电话!","确定");
				return false;
			}
			var memberNum = $("#actApplyForm #memberNum").val();
			if(!memberNum){
				alertNotification("提示","请录入人数!","确定");
				return false;
			}
	      	var params = {};
	  		$.each($("#actApplyForm").serializeArray(),function(key,value){
	        		params[value.name]=value.value;
	        });
	        submitForm('${base}/cura/activity/apply.htm',params,
	        	function(dd){
	        	layer.closeAll();
	        	layer.open({
		 	 		type: 1,
		  			title: false,
		  			closeBtn:2,
		 	 		area : ['auto' , 'auto'],
		  			shadeClose :true,
		  			content: $('.bookingfinish_popup')//弹出预约成功弹窗
				});
	        }); 
	});
		
	//确定预约按钮(关闭弹窗)	
	$('.close_bookingfinish_popup').on('click', function(){
		layer.closeAll();
	});
		
});
</script>