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
		}
	})
	/***
	$("#userSecondPerAddForm #memberId").select2({
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
  	});
	***/
	var firstPicIndex=0;
	$('#userSecondPerAddForm a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		    var activeTab = $(e.target).text();
  		    if(activeTab=="证照上传" && firstPicIndex==0){
				picPathFileUpload();
				firstPicIndex++;
  		    } 
	});
	$("#perCardNo").on("blur",function(){
    	checkID('perCardNo',function(ID){
    		var bir = "";
    		if(ID.length ==15){//3411111988991234
    			bir = ID.substring(6,12);
    		}else{//18 341111198809091234
    			bir = ID.substring(6,14);
    		}
    		var obir = $("#perBirthday").val();
    		if(!obir){
    			 $("#perBirthday").val(fmtDate(bir));
    		}
    	});
    });
    laydateToId('userEvaluateTime');
    laydateToId('conBirthday');
    $("#userEvaluateTime").on("blur",function(){
    	checkDate('userEvaluateTime');
    });
    $("#conBirthday").on("blur",function(){
    	checkDate('conBirthday');
    });
    laydateToId('perBirthday');
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
})
function addPicture(url){
	var row = "<div class='file-item thumbnail'><img src='${base}"+url+"' >";
	row = row +"<div class='cancel'>删除</div></div>";
	$("#fileList").append(row);
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
			var existPics = $("#picPath").val();
			existPics = existPics+","+res.url;
			//("#picPathPickerName").html(existPics+";"+res.url);
			$("#picPath").val(existPics);
			//$("#uploadResults").append("<img width='70px' height='50px' src='${base}"+res.url+"'>");
			//addPicture(res.url);
		}
	});
	fundFileUploader.on( 'fileQueued', function( file ) {
        var $li = $(
                '<div id="' + file.id + '" class="file-item thumbnail">' +
                    '<img>' +
                    '<div class="info">' + file.name + '</div>' +
                '</div>'
                ),
            $img = $li.find('img');

        $("#fileList").append( $li );
        ratio = window.devicePixelRatio || 1,
        // 缩略图大小
        thumbnailWidth = 50 * ratio,
        thumbnailHeight = 50 * ratio,
        // 创建缩略图
        fundFileUploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }
            $img.attr( 'src', src );
        }, thumbnailWidth, thumbnailHeight );
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
			url:"${base}/admin/userSecond/per/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加客户成功', 1);
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
   		<!--
   		<li>
   			<a href="#userSecondPerZhengZhao" data-toggle="tab">证照上传</a>
   		</li>
   		-->
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="userSecondPerAddBaseInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">客户代码</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="客户代码/不填自动生成" name="userNo" id="userNo" readOnly>
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
			    <label class="col-xs-2 control-label">客户姓名</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="姓名中文/拼音" name="perName" id="perName" value="">
			    </div>
			     <label class="col-xs-2 control-label">客户性别</label>
			      <div class="col-xs-4">
			        <select class="form-control" name="perSex" id="perSex">
			        	<option value="">/</option>
                        <option value="0">女</option>
                        <option value="1">男</option>
                    </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">手机号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机/保证唯一" name="perPhone" id="perPhone" value="">
			    </div>
			    <label class="col-xs-2 control-label">固定座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="座机" name="perTel" id="perTel" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">电子邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邮箱/保证唯一" name="perEmail" id="perEmail" value="">
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
					city:null,
					dist:null,
					nodata:"none",
					required:null
                });
            });
        </script>
			    <label class="col-xs-2 control-label">邮编</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="邮编" name="perZip" id="perZip" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">通讯地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="通讯地址" name="perAddr" id="perAddr" value="">
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
		</div>
		<!-- 个人信息 -->
		<div class="tab-pane fade" id="userSecondPerAddInfo">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件类型</label>
			    <div class="col-xs-4">
				     <select class="form-control" name="perCardTypeId" id="perCardTypeId">
	                    [@dict name="perCardType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">证件号码</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件号码/保证唯一" name="perCardNo" id="perCardNo">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="perQixian" id="perQixian" value="">
			    </div>
			    <label class="col-xs-2 control-label">证件发证机关</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="证件发证机关" name="perJiguan" id="perJiguan" value="">
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期" name="perBirthday" id="perBirthday" value="">
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
                    		<option value="${st.id}">${st.name}</option>
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
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">工作单位</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="工作单位" name="gongzuoCompany" id="gongzuoCompany" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">职务</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="职位" name="gongzuoZhiwei" id="gongzuoZhiwei" value="">
			    </div>
			     <label class="col-xs-2 control-label">学历</label>
			     <div class="col-xs-4">
			         <select class="form-control" name="perXueliId" id="perXueliId">
			         	<option value="">未知</option>
			        	[@dict name="xueli" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
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
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
			<hr />
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际自然人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际自然人" name="ziranPer" id="ziranPer" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">实际受益人</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="实际受益人" name="shouyiPer" id="shouyiPer" value="">
			    </div>
			</div>
		</div>
		
		<!-- 委托人 -->
		<div class="tab-pane fade" id="userSecondPerAddContant">
			<br />
			<div class="form-group">
			    <label class="col-xs-2 control-label">启用委托联系人</label>
			    <div class="col-xs-10">
			    	<div class="checkbox-inline ">
			    	<label>
			        <input type="checkbox" class="checkbox" value="true" name="useContant">启用
			        </label>
			        </div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">委托人姓名</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="姓名中文/拼音" name="conName" id="conName" value="">
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
			        <input type="text" class="form-control" placeholder="证件号码" name="conCardNo" id="conCardNo" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">证件有效期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="证件有效期" name="conQixian" id="conQixian" value="">
			    </div>
			</div>
			<hr/>
			<div class="form-group">
			    <label class="col-xs-2 control-label">手机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="手机/保证唯一" name="conPhone" id="conPhone" value="">
			    </div>
			    <label class="col-xs-2 control-label">座机</label>
			    <div class="col-xs-4">
			        <input type="text" class="form-control" placeholder="座机" name="conTel" id="conTel" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">邮箱</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="邮箱/保证唯一" name="conEmail" id="conEmail" value="">
			    </div>
			</div>
			<hr/>
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
			        <input type="text" class="form-control" placeholder="邮编" name="conZip" id="conZip" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">联系地址</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="联系地址" name="conAddr" id="conAddr" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">出生日期</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control laydate-icon" placeholder="出生日期" name="conBirthday" id="conBirthday">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="userSecondPerAddAttr">
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
			<div class="form-group">
			    <label class="col-xs-2 control-label">可投入金融资产</label>
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
			<div class="form-group">
			    <label class="col-xs-2 control-label">其他备注</label>
			    <div class="col-xs-10">
			        <textarea type="text" class="form-control" placeholder="备注" name="innerNote" id="innerNote" ></textarea>
			    </div>
			</div>
		</div>
	</div>
</form>
</div>