<script>
$(function(){
	formValidate("#userSecondPerAddForm",{
		perCardNo:{
			required: true
		},
		perName:{
			required: true
		},
		perPhone:{
			required: true
		},
		perEmail:{
			//email:true
		},
		userNo:{
			required:true
		}
	})
  	var firstPicIndex=0;
	$('#userSecondPerAddForm a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		    var activeTab = $(e.target).text();
  		    if(activeTab=="证照上传"&&firstPicIndex==0){
				picPathFileUpload();
				firstPicIndex++;
  		    } 
	});
	//laydateToId('userEvaluateTime');
    laydateToId('conBirthday');
    laydateToId('perBirthday');
    $("#userEvaluateTime").on("blur",function(){
    	checkDate('userEvaluateTime');
    });
    $("#conBirthday").on("blur",function(){
    	checkDate('conBirthday');
    });
    $("#perBirthday").on("blur",function(){
    	checkDate('perBirthday');
    });
    laydateToId('conQixian');
    $("#conQixian").on("blur",function(){
    	checkDate('conQixian');
    });
    laydateToId('perQixian');
    $("#perQixian").on("blur",function(){
    	checkDate('perQixian');
    });
    $("#userSecondPerAddForm #memberId").append("<option value='${userSecond.memberId}' selected>${member.userName}</option>");
  	$("#userSecondPerAddForm #select2-memberId-container").html('${member.userName}');
});	
function picPathFileUpload(){
	var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#picPathFilePicker',
    	auto:true,
    	compress: false
	});
	
	fundFileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#picPathPickerName").html("")
			$("#picPathAddFormUrl").val("")
		}else{
			$("#picPathPickerName").html("<a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>")
			$("#picPathAddFormUrl").val(res.url)
		}
	});
	fundFileUploader.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
		$("#picPathAddFormUrl").val("")
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});

}
function userSecondSubmitForm(parentIndex){
	var s=$("#userSecondPerAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userSecondPerAddForm").serializeArray(),
			url:"${base}/admin/userSecond/per/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('修改客户成功', 1);
					$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("refresh")
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	}
}
</script>

<div style="width:800px;height:600px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="userSecondPerAddForm">
	<ul class="nav nav-tabs">
   		<li class="active">
      		<a href="#userSecondPerAddBaseInfo" data-toggle="tab">基本信息</a>
   		</li>
   		<li>
   			<a href="#userSecondPerAddInfo" data-toggle="tab">个人信息</a>
   		</li>
   		<li>
   			<a href="#userSecondPerAddContant" data-toggle="tab">委托联系人信息</a>
   		</li>
   		<li>
   			<a href="#userSecondPerAddAttr" data-toggle="tab">附加信息</a>
   		</li>
   		<li>
   			<a href="#userSecondPerZhengZhao" data-toggle="tab">证照上传</a>
   		</li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="userSecondPerAddBaseInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户代码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="客户代码/不填自动生成" name="userNo" id="userNo" readOnly value="${(userSecond.userNo)!}">
			        <input type="hidden"  name="id" value="${(userSecond.id)!}">
			        <input name="picPath" type="hidden" value="${(userSecondPic.picPath)!}" id="picPathAddFormUrl"/>
			    </div>
			    <!--
			    <label class="col-xs-2 control-label">专属财富顾问</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="memberId" id="memberId" readOnly>
			        </select>
			    </div>
			    -->
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户姓名</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="客户姓名中文/拼音" name="perName" id="perName" value="${(userSecondPer.perName)!}">
			    </div>
			     <label class="col-xs-2 control-label">客户性别</label>
			      <div class="col-xs-4">
			        <select class="form-control" name="perSex" id="perSex">
			        	<option value="">/</option>
                        <option value="0" [#if (userSecondPer.perSex)??&&userSecondPer.perSex]selected=selected[/#if]>女</option>
                        <option value="1" [#if (userSecondPer.perSex)??&&!userSecondPer.perSex]selected=selected[/#if]>男</option>
                    </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">手机号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机/保证唯一" name="perPhone" id="perPhone" value="${(userSecondPer.perPhone)!}">
			    </div>
			    <label class="col-xs-2 control-label">固定座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="固定座机" name="perTel" id="perTel" value="${(userSecondPer.perTel)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">电子邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邮箱/保证唯一" name="perEmail" id="perEmail" value="${(userSecondPer.perEmail)!}">
			    </div>
			</div>
			<hr />
			<script type="text/javascript" src="${base}/static/common/js/cityselect.js"></script> 
			<div class="form-group">
			    <label class="col-xs-2 control-label">所在城市</label>
			    <div class="col-xs-4" id="select_linkage">
			        <select name="province" class="prov select control-label " style="width:45%;"></select>
          			<select name="city" class="city select control-label" style="width:45%;"></select>
			    </div>
		<script type="text/javascript">
            $(function(){
                $("#select_linkage").citySelect({
                    url:'${base}/static/common/js/city.min.js',
					prov: '${userSecondPer.province}',
					city: '${userSecondPer.city}',
					dist:null,
					nodata:"none",
					required:null
                });
            });
        </script>
			    <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-2">
			        <input type="text" class="form-control" placeholder="邮编" name="perZip" id="perZip" value="${(userSecondPer.perZip)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">通讯地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="通讯地址" name="perAddr" id="perAddr" value="${(userSecondPer.perAddr)!}">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户风险等级</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="userRiskLevelId" id="userRiskLevelId">
			        	[@dict name="riskLevel" ]
                    	[#list dictList as st]
                    		[#if st.id==userSecond.userRiskLevelId]
                    			<option value="${st.id}" selected=selected>${st.name}</option>
                    		[/#if]
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">风险评测时间</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control laydate-icon" placeholder="风险评测时间" readOnly name="userEvaluateTime" id="userEvaluateTime" value="${(userSecond.userEvaluateTime)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">邀请码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邀请码" name="welcomeCode" id="welcomeCode" value="${(userSecond.welcomeCode)!}">
			    </div>
			    <label class="col-xs-2 control-label">客户等级</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="userLevelId" disabled="disabled" id="userLevelId">
			        	[@dict name="userLevel" ]
                    	[#list dictList as st]
                    		[#if st.id==userSecond.userLevelId]
                    		<option value="${st.id}" selected>${st.name}</option>
                    		[/#if]
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户来源</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="customerSourceId" id="customerSourceId">
			        	[@dict name="customerSource" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecond.customerSourceId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">信息来源</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="infoSourceId" id="infoSourceId">
			        	[@dict name="infoSource" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecond.infoSourceId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="备注" name="note" id="note">${(userSecond.note)!}</textarea>
			    </div>
			</div>
			<!-- 
			<div class="form-group">
			    <label class="col-xs-2 control-label">状态</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="status" id="status">
			        	<option value="use" [#if userSecondPer.status=="use"]selected=selected[/#if]>启用</option>
			        	<option value="finish" [#if userSecondPer.status=="finish"]selected=selected[/#if]>禁用</option>
			        </select>
			    </div>
			</div>
			-->
		</div>
		<div class="tab-pane fade" id="userSecondPerAddInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件类型</label>
			    <div class="col-xs-4">
				     <select class="form-control" name="perCardTypeId" id="perCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondPer.perCardTypeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件号码/保证唯一" name="perCardNo" id="perCardNo" value="${(userSecondPer.perCardNo)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="perQixian" id="perQixian" value="${(userSecondPer.perQixian)!}">
			    </div>
			    <label class="col-xs-2 control-label">证件发证机关</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件发证机关" name="perJiguan" id="perJiguan" value="${(userSecondPer.perJiguan)!}">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期"
			        	 name="perBirthday" id="perBirthday" value="${(userSecondPer.perBirthday?string("yyyy-MM-dd"))!}">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">职业</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="perZhiyeId" id="perZhiyeId">
			        	<option value="">未知</option>
			        	[@dict name="zhiye" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondPer.perZhiyeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">所属行业</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="perHangyeId" id="perHangyeId">
			         	<option value="">未知</option>
			        	[@dict name="suoshuhangye" ]
	                    	[#list dictList as st]
	                    		<option value="${st.id}" [#if st.id==userSecondPer.perHangyeId]selected=selected[/#if]>${st.name}</option>
	                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">工作单位</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="工作单位" name="gongzuoCompany" id="gongzuoCompany" value="${(userSecondPer.gongzuoCompany)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">职务</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="职务" name="gongzuoZhiwei" id="gongzuoZhiwei" value="${(userSecondPer.gongzuoZhiwei)!}">
			    </div>
			     <label class="col-xs-2 control-label">学历</label>
			     <div class="col-xs-4">
			          <select class="form-control" name="perXueliId" id="perXueliId">
			         	<option value="">未知</option>
			        	[@dict name="xueli" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondPer.perXueliId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">国籍</label>
			    <div class="col-xs-10">
			         <select class="form-control" name="perCountryId" id="perCountryId">
			        	<option value="">未知</option>
			        	[@dict name="country" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondPer.perCountryId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际自然人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际自然人" name="ziranPer" id="ziranPer" value="${(userSecondPer.ziranPer)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际受益人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际受益人" name="shouyiPer" id="shouyiPer" value="${(userSecondPer.shouyiPer)!}">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondPerAddContant">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">启用委托联系人</label>
			    <div class="col-xs-10">
			    	<div class="checkbox-inline ">
			    	<label>
			        <input type="checkbox" class="checkbox" value="true" name="useContant" [#if (userSecondContant)??]checked=checked[/#if]>启用
			        </label>
			        </div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人姓名</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="姓名中文/拼音" name="conName" id="conName" value="${(userSecondContant.conName)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">证件类型</label>
			    <div class="col-xs-4">
				     <select class="form-control" name="conCardTypeId" id="conCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondContant.conCardTypeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件号码" name="conCardNo" id="conCardNo" value="${(userSecondContant.conCardNo)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="conQixian" id="conQixian" value="${(userSecondContant.conQixian)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">手机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机/保证唯一" name="conPhone" id="conPhone" value="${(userSecondContant.conPhone)!}">
			    </div>
			    <label class="col-xs-2 control-label">座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="座机" name="conTel" id="conTel" value="${(userSecondContant.conTel)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邮箱/保证唯一" name="conEmail" id="conEmail" value="${(userSecondContant.conEmail)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">所在城市</label>
			    <div class="col-xs-4">
			         <select class="form-control" name="conCityId" id="conCityId">
			         	<option value="">未知</option>
			        	[@dict name="city" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondContant.conCityId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邮编" name="conZip" id="conZip" value="${(userSecondContant.conZip)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">联系地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="联系地址" name="conAddr" id="conAddr" value="${(userSecondContant.conAddr)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期" name="conBirthday" readOnly  id="conBirthday" value="${(userSecondContant.conBirthday?string("yyyy-MM-dd"))!}">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondPerAddAttr">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">其他手机号码1</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="其他手机号码1" name="phoneOne" id="phoneOne" value="${(userSecondAttr.phoneOne)!}">
			    </div>
			    <label class="col-xs-2 control-label">其他手机号码2</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="其他手机号码2" name="phoneTwo" id="phoneTwo" value="${(userSecondAttr.phoneTwo)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">年收入</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="yearIncomeId" id="yearIncomeId">
			        	<option value="" >未知</option>
			        	[@dict name="yearIncome" ]
                    	[#list dictList as st]
                    		<option value="${st.id}"  [#if st.id==userSecondAttr.yearIncomeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">可投入金额</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="canTouru" id="canTouru">
			        	<option value="">未知</option>
			        	[@dict name="yearIncome" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondAttr.canTouru]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户状态</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="status" id="status">
			        	<option value="use" [#if st.id==userSecond.status]selected=selected[/#if]>启用</option>
			        	<option value="finish" [#if st.id==userSecond.status]selected=selected[/#if]>禁用</option>
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">其他备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="其他备注" name="innerNote" id="innerNote" >${(userSecond.innerNote)!}</textarea>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondPerZhengZhao">
				<br >
				[#list userSecondPics as pic]
    				<div class="form-group">
						<label class="col-xs-2 control-label">${pic_index +1}: 证照类型</label>
					    <div class="col-xs-2">
					        <select class="form-control" name="cardTypeId" id="cardTypeId" disabled>
					        	<option value="1" [#if 1==pic.cardTypeId]selected=selected[/#if]>身份证</option>
					        	<option value="2" [#if 2==pic.cardTypeId]selected=selected[/#if]>军官证</option>
					        </select>
					    </div>
					    <label class="col-xs-2 control-label">证照名称</label>
					    <div class="col-xs-2">
					        <input type="text" class="form-control" placeholder="证照名称"
					        	 name="picName" id="picName" value="${(pic.picName)!}" readOnly>
					    </div>
					    <label class="col-xs-2 control-label">有效期</label>
					    <div class="col-xs-2">
					        <input type="text" class="form-control" placeholder="有效期"
					         name="picYouxiaoqi" id="picYouxiaoqi" value="${(pic.picYouxiaoqi)!}" readOnly>
					    </div>
					</div>
					<div class="form-group">
				    <label class="col-xs-2 control-label">证照</label>
				    <div class="col-xs-10">
				    	[#list pic.files as f]
				    		<a href="${base}${f.picPath}" target="_blank">${f.picPath}</a><br>
				    	[/#list]
				    </div>
					</div>
					<hr/>
    			[/#list]
		</div>
	</div>
</form>
</div>