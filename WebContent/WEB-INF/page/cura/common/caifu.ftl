<!-- 预约财富顾问弹窗 s -->
<div class="book_popup">
  <p class="title">预约财富顾问<span>财富顾问会在下个工作日内与您联系</span></p>
  <form action="" id="appointmentForm">
    <ul>
      <li><i class="ico ico-peoplefill"></i>
        <input type="text" class="ipt1" name="name" id="caifuName"  onblur="javascript:checkCnAndChar('caifuName');" placeholder="姓名" value="${loginSuccessKey.name}">
      </li>
      <li><i class="ico ico-shouji"></i>
        <input type="text" class="ipt1" name="phone" id="consultPhoneId"  onblur="javascript:checkMobile('consultPhoneId');" placeholder="手机号" value="${loginSuccessKey.phone}">
      </li>
      <li>
        <div id="select_linkage">
          <select name="province" class="prov select"  style="width: 143px;">
          </select>
          <select name="city" class="city select" style="width: 143px;" >
          </select>
        </div>
        <script type="text/javascript" src="${base}/frontCura/js/cityselect.js"></script> 
        <script type="text/javascript">
            $(function(){
                $("#select_linkage").citySelect({
                    url:'${base}/frontCura/js/city.min.js',
					prov:null,
					city:null,
					dist:null,
					nodata:"none",
					required:null
                });
            });
        </script> 
      </li>
      <li>
        <div class="pl_w">
          <input type="text" name="captcha" id="captcha" class="ipt1 yzm" placeholder="输入验证码">
        </div>
        <a href="javascript:void(0);" class="yzma"><img src="#" alt=""></a></li>
      <li>
        <button type="button" class="submit" id="appointmentSubmitBtn">预约服务</button>
      </li>
    </ul>
  </form>
</div>
<!-- 预约财富顾问弹窗 e --> 
<script type="text/javascript">
//placeholder
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
  //验证码
  $(".yzma").on("click",function(e){
  	 $(".yzma").html("").html('<img id="captcha" src="${base}/cura/appointment/captach.htm?rnd='+(new Date()).getTime()+'" alt="">');
  });
});
</script>
<script type="text/javascript">
$(function(){
	$('#show_book_popup').on('click', function(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  shadeClose :true,
		  content: $('.book_popup')//弹出预约财富顾问弹窗
		}); 
		$(".yzma").html("").html('<img id="captcha" src="${base}/cura/appointment/captach.htm?rnd='+(new Date()).getTime()+'" alt="">');
	});
	
	$("#appointmentSubmitBtn").on("click",function(){
		var params = {};
  		$.each($("#appointmentForm").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        });
        submitForm('${base}/cura/appointment/apply.htm',params,function(data){
        	alertNotification("提示","预约成功，财富顾问会在下个工作日内与您联系!","确定",function(){
        		layer.closeAll();
        	});
        });
	});
});
</script>
<script type="text/javascript">
$(function(){
    $('#select_linkage').find('.select2:first').find('.select2-selection__rendered').text("所在省份")
    $('#select_linkage').find('.select2:last').find('.select2-selection__rendered').text("所在城市")
});
$('.select').select2({
      theme: "classic",
       minimumResultsForSearch: Infinity
});
</script> 