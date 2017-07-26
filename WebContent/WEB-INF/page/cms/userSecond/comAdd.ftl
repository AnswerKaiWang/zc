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
	/***
	$("#userSecondComAddForm #memberId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/member/searchMemberList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term,memberType:'caifuguwen'}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});**/
	var firstPicIndex=0;
	$('#userSecondComAddForm a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		    var activeTab = $(e.target).text();
  		    if(activeTab=="证照上传"&&firstPicIndex==0){
				picPathFileUpload();
				firstPicIndex++;
  		    } 
	});
	laydateToId('userEvaluateTime');
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
})	
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
	var s=$("#userSecondComAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			type: 'POST',
			data:$("#userSecondComAddForm").serializeArray(),
			url:"${base}/admin/userSecond/com/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加机构客户成功', 1);
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
   		<!--
   		<li>
   			<a href="#userSecondComZhengZhao" data-toggle="tab">证照上传</a>
   		</li>
   		-->
	</ul>
	<div class="tab-content">
		<!-- 基础信息 -->
		<div class="tab-pane fade in active" id="userSecondComAddBaseInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户代码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="客户代码自动生成" name="userNo" id="userNo" readOnly>
			        <input name="picPath" type="hidden" value="" id="picPathAddFormUrl"/>
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
			    <label class="col-xs-2 control-label">客户名称</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="机构名称" name="name" id="name">
			    </div>
			</div>
			<hr />
			<div class="form-group">
				<label class="col-xs-2 control-label">手机号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机号码" name="comPhone" id="comPhone" value="">
			    </div>
			    <label class="col-xs-2 control-label">固定座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="固定座机" name="comTel" id="comTel" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">电子邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="电子邮箱" name="comEmail" id="comEmail">
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
					prov: null,
					city: null,
					dist:null,
					nodata:"none",
					required:null
                });
            });
        </script>
			    <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邮编" name="comZip" id="comZip" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">通讯地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="通讯地址" name="comAddr" id="comAddr" value="">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户风险等级</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="userRiskLevelId" id="userRiskLevelId">
			        	[@dict name="riskLevel" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">风险评测时间</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control laydate-icon" placeholder="风险评测时间" name="userEvaluateTime" id="userEvaluateTime" value="">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">邀请码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邀请码" name="welcomeCode" id="welcomeCode" value="">
			    </div>
			    <label class="col-xs-2 control-label">客户等级</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="userLevelId" id="userLevelId">
			        	[@dict name="userLevel" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
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
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">信息来源</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="infoSourceId" id="infoSourceId">
			        	[@dict name="infoSource" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="备注" name="note" id="note"></textarea>
			    </div>
			</div>
			<!-- 
			<div class="form-group">
			    <label class="col-xs-2 control-label">状态</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="status" id="status">
			        	<option value="use">启用</option>
			        	<option value="finish">禁用</option>
			        </select>
			    </div>
			</div>
			-->
		</div>
		<!-- 基础信息 -->
		<div class="tab-pane fade" id="userSecondComAddInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">公司营业执照</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="公司营业执照" name="zhizhao" id="zhizhao" value="">
			    </div>
			    <label class="col-xs-2 control-label">执照有效期</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control laydate-icon" placeholder="执照有效期" name="qixian" id="qixian" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">组织机构代码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="组织机构代码" name="daima" id="daima" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">税务登记证号</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="税务登记证号" name="shuiwu" id="shuiwu" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">开户许可证号</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="开户许可证号" name="kaihu" id="kaihu" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">机构信用代码证</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="机构信用代码证" name="xinyong" id="xinyong" value="">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人姓名</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="法人姓名" name="faName" id="faName" value="">
			    </div>
			    <!-- 
			    <label class="col-xs-2 control-label">法人性别</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="faSex" id="faSex">
			        	<option value="">/</option>
                        <option value="true">女</option>
                        <option value="false">男</option>
                    </select>
			    </div>
			    -->
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人证件类型</label>
			    <div class="col-xs-4">
				     <select class="form-control" name="faCardTypeId" id="faCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			     <label class="col-xs-2 control-label">法人证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="法人证件号码" name="faCardNo" id="faCardNo" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">法人证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="法人证件有效期" name="faQixian" id="faQixian" value="">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际股东或控制人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际股东或控制人" name="realControllerName" id="realControllerName" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">股东或控制人住所</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="股东或控制人住所" name="realAddr" id="realAddr" value="">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondComAddContant">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人姓名</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="姓名中文/拼音" name="conName" id="conName" value="">
			        <input   value="true" name="useContant" type="hidden" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件类型</label>
			    <div class="col-xs-4">
				     <select class="form-control" name="conCardTypeId" id="conCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件号码" name="conCardNo" id="conCardNo">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="conQixian" id="conQixian" value="">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">手机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机" name="conPhone" id="conPhone" value="">
			    </div>
			    <label class="col-xs-2 control-label">座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="座机" name="conTel" id="conTel" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邮箱" name="conEmail" id="conEmail" value="">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">所在城市</label>
			    <div class="col-xs-4">
			         <select class="form-control" name="conCityId" id="conCityId">
			         	<option value="">未知</option>
			        	[@dict name="city" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			     <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邮编" name="comZip" id="comZip" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">联系地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="联系地址" name="conAddr" id="conAddr" value="">
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期" name="conBirthday" id="conBirthday" value="">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondComAddAttr">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">其他手机号码1</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="其他手机号码1" name="phoneOne" id="phoneOne" value="">
			    </div>
			     <label class="col-xs-2 control-label">其他手机号码2</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="其他手机号码2" name="phoneTwo" id="phoneTwo" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">年收入</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="yearIncomeId" id="yearIncomeId">
			        	<option value="">未知</option>
			        	[@dict name="yearIncome" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">可投入的金融资产</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="canTouru" id="canTouru">
			        	<option value="">未知</option>
			        	[@dict name="yearIncome" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户状态</label>
			    <div class="col-xs-10">
			        <select class="form-control" name="status" id="status">
			        	<option value="use">启用</option>
			        	<option value="finish">禁用</option>
			        </select>
			    </div>
			</div>
			<hr/>
			<div class="form-group">
			    <label class="col-xs-2 control-label">其他备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="其他备注" name="note" id="note" ></textarea>
			    </div>
			</div>
			<!--
			<div class="form-group">
			    <label class="col-xs-2 control-label">邀请码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邀请码" name="welcomeCode" id="welcomeCode" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">内部备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="内部备注" name="innerNote" id="innerNote" ></textarea>
			    </div>
			</div>
			-->
		</div>
		<!--
		<div class="tab-pane fade" id="userSecondComZhengZhao">
			<br >
			<div class="form-group">
				<label class="col-xs-2 control-label">证照类型</label>
			    <div class="col-xs-2">
			        <select class="form-control" name="status" id="status">
			        	<option value="use">身份证</option>
			        	<option value="finish">军官证</option>
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">证照名称</label>
			    <div class="col-xs-2">
			        <input type="text" class="form-control" placeholder="证照名称" name="picName" id="picName" value="">
			    </div>
			    <label class="col-xs-2 control-label">有效期</label>
			    <div class="col-xs-2">
			        <input type="text" class="form-control laydate-icon" placeholder="证照名称" name="有效期" id="picYouxiaoqi" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">选择证照</label>
			    <div class="col-xs-10">
			    	<div id="picPathPickerName"></div>
			    	<div id="picPathFilePicker">选择</div>
			    </div>
			</div>
		</div>
		-->
	</div>
</form>
</div>