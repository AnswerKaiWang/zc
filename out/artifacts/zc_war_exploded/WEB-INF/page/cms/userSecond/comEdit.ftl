<script>
$(function(){
	formValidate("#userSecondComAddForm",{
		zhizhao:{
			required: true
		},
		name:{
			required: true
		}
	})
	var firstPicIndex=0;
	$('#userSecondComAddForm a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		    var activeTab = $(e.target).text();
  		    if(activeTab=="证照上传"&&firstPicIndex==0){
				picPathFileUpload();
				firstPicIndex++;
  		    } 
	});
	//laydateToId('userEvaluateTime');
    laydateToId('conBirthday');
    laydateToId('qixian');
    laydateToId('faQixian');
    laydateToId('conQixian');
    $("#userEvaluateTime").on("blur",function(){
    	checkDate('userEvaluateTime');
    });
    $("#conBirthday").on("blur",function(){
    	checkDate('conBirthday');
    });
    $("#qixian").on("blur",function(){
    	checkDate('qixian');
    });
    $("#faQixian").on("blur",function(){
    	checkDate('faQixian');
    });
    $("#conQixian").on("blur",function(){
    	checkDate('conQixian');
    });
    $("#userSecondComAddForm #memberId").append("<option value='${userSecond.memberId}' selected>${member.userName}</option>");
  	$("#userSecondComAddForm #select2-memberId-container").html('${member.userName}');
})	

function userSecondSubmitForm(parentIndex){
	var s=$("#userSecondComAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			type: 'POST',
			data:$("#userSecondComAddForm").serializeArray(),
			url:"${base}/admin/userSecond/com/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('修改机构客户成功', 1);
					$('#userSecondComListMain #userSecondComTable').bootstrapTable("refresh")
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
</script>

<div style="width:800px;height:600px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="userSecondComAddForm">
	<ul class="nav nav-tabs">
   		<li class="active">
      		<a href="#userSecondComAddBaseInfo" data-toggle="tab">基本信息</a>
   		</li>
   		<li>
   			<a href="#userSecondComAddInfo" data-toggle="tab">机构信息</a>
   		</li>
   		<li>
   			<a href="#userSecondComAddContant" data-toggle="tab">委托联系人信息</a>
   		</li>
   		<li>
   			<a href="#userSecondComAddAttr" data-toggle="tab">附加信息</a>
   		</li>
   		<li>
   			<a href="#userSecondComZhengZhao" data-toggle="tab">证照上传</a>
   		</li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="userSecondComAddBaseInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户代码</label>
			    <div class="col-xs-10">
			       <input type="text" class="form-control" placeholder="客户代码/不填自动生成" readOnly name="userNo" id="userNo" value="${(userSecond.userNo)!}">
			        <input type="hidden"  name="id" value="${(userSecond.id)!}">
			        <input name="picPath" type="hidden" value="${(userSecondPic.picPath)!}" id="picPathAddFormUrl"/>
			    </div>
			    <!--
			    <label class="col-xs-2 control-label">专属财富顾问</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="memberId" id="memberId">
			        </select>
			    </div>
			    -->
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户名称</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="客户名称" name="name" id="name" value="${(userSecond.name)!}">
			    </div>
			</div>
			<hr >
			<div class="form-group">
				<label class="col-xs-2 control-label">手机号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机号码" name="comPhone" id="comPhone" value="${(userSecondCom.comPhone)!}">
			    </div>
			    <label class="col-xs-2 control-label">固定座机</label>
			    <div class="col-xs-4">
					<input type="text" class="form-control" placeholder="固定座机" name="comTel" id="comTel" value="${(userSecondCom.comTel)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">电子邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="电子邮箱" name="comEmail" id="comEmail" value="${(userSecondCom.comEmail)!}">
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
					prov: '${userSecondCom.province}',
					city: '${userSecondCom.city}',
					dist:null,
					nodata:"none",
					required:null
                });
            });
        </script>
			    <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邮编" name="comZip" id="comZip" value="${(userSecondCom.comZip)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">通讯地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="通讯地址" name="comAddr" id="comAddr" value="${(userSecondCom.comAddr)!}">
			    </div>
			</div>
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
			<hr />
			<div class="form-group">
				<label class="col-xs-2 control-label">邀请码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邀请码" name="welcomeCode" id="welcomeCode" value="${(userSecond.welcomeCode)!}">
			    </div>
			    <label class="col-xs-2 control-label">客户等级</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="userLevelId" id="userLevelId">
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
		</div>
		<div class="tab-pane fade" id="userSecondComAddInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">营业执照</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="营业执照" name="zhizhao" id="zhizhao" value="${(userSecondCom.zhizhao)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">执照期限</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="执照期限" name="qixian" id="qixian" value="${(userSecondCom.qixian)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">组织机构代码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="组织机构代码" name="daima" id="daima" value="${(userSecondCom.daima)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">税务登记证</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="税务登记证" name="shuiwu" id="shuiwu" value="${(userSecondCom.shuiwu)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">开户许可证</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="开户许可证" name="kaihu" id="kaihu" value="${(userSecondCom.kaihu)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">机构信用</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="机构信用" name="xinyong" id="xinyong" value="${(userSecondCom.xinyong)!}">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人姓名</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="法人姓名" name="faName" id="faName" value="${(userSecondCom.faName)!}">
			    </div>
			    <label class="col-xs-2 control-label">法人性别</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="faSex" id="faSex">
			        	<option value="">/</option>
                        <option value="true" [#if (userSecondCom.faSex)??&&userSecondCom.faSex]selected=selected[/#if]>女</option>
                        <option value="false" [#if (userSecondCom.faSex)??&&!userSecondCom.faSex]selected=selected[/#if]>男</option>
                    </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人证件类型</label>
			    <div class="col-xs-4">
				      <select class="form-control" name="faCardTypeId" id="faCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondCom.faCardTypeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			     <label class="col-xs-2 control-label">法人证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="法人证件号码" name="faCardNo" id="faCardNo" value="${(userSecondCom.faCardNo)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="法人证件期限" name="faQixian" id="faQixian" value="${(userSecondCom.faQixian)!}">
			    </div>
			</div>
			<hr >
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际股东或控制人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际股东或控制人" name="realControllerName" id="realControllerName" value="${(userSecondCom.realControllerName)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">股东或控制人住所</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="股东或控制人住所" name="realAddr" id="realAddr" value="${(userSecondCom.realAddr)!}">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondComAddContant">
			<br>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人姓名</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="姓名中文/拼音" name="conName" id="conName" value="${(userSecondContant.conName)!}">
			    	<input   value="true" name="useContant" type="hidden" >
			    </div>
			    <label class="col-xs-2 control-label">委托人性别</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="conSex" id="conSex">
			        	<option value="">/</option>
                        <option value="true" [#if (userSecondContant.conSex)??&&userSecondContant.conSex]selected=selected[/#if]>女</option>
                        <option value="false" [#if (userSecondContant.conSex)??&&!userSecondContant.conSex]selected=selected[/#if]>男</option>
                    </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人证件类型</label>
			    <div class="col-xs-4">
				      <select class="form-control" name="conCardTypeId" id="conCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondContant.conCardTypeId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">委托人证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="委托人证件号码" name="conCardNo" id="conCardNo" value="${(userSecondContant.conCardNo)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="conQixian" id="conQixian" value="${(userSecondContant.conQixian)!}">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人手机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="委托人手机" name="conPhone" id="conPhone" value="${(userSecondContant.conPhone)!}">
			    </div>
			    <label class="col-xs-2 control-label">委托人座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="座机" name="conTel" id="conTel" value="${(userSecondContant.conTel)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="委托人邮箱" name="conEmail" id="conEmail" value="${(userSecondContant.conEmail)!}">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人城市</label>
			    <div class="col-xs-10">
			         <select class="form-control" name="conCityId" id="conCityId">
			         	<option value="">未知</option>
			        	[@dict name="city" ]
                    	[#list dictList as st]
                    		<option value="${st.id}" [#if st.id==userSecondContant.conCityId]selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="地址" name="conAddr" id="conAddr" value="${(userSecondContant.conAddr)!}">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期" name="conBirthday" id="conBirthday" value="${(userSecondContant.conBirthday?string("yyyy-MM-dd"))!}">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondComAddAttr">
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
			    <label class="col-xs-2 control-label">预期年收入</label>
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
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">预期可投入资产</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="可投入金额" name="canTouru" id="canTouru" value="${(userSecondAttr.canTouru)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">邀请码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邀请码" name="welcomeCode" id="welcomeCode" value="${(userSecond.welcomeCode)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">内部备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="内部备注" name="innerNote" id="innerNote" >${userSecond.innerNote}</textarea>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondComZhengZhao">
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