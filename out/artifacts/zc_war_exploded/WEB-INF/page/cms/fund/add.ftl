<script>
var introEditor;
var detailEditor;
var strategyEditor;
$(function(){
	formValidate("#fundAddForm",{
		name:{
			required: true
			},
		no:{
			required: true
		},
		fundStatus:{
			required: true
		},
		pageIndex:{
			required: true,
			digits:true
		}
            
	});
	laydateInit('setupTime');
	laydateInit('cashTime');
	laydateInit('collectStartTime');
	laydateInit('collectEndTime');
	laydateInit('buyStartTime');
	laydateInit('buyEndTime');
	$("#addRecord").on("click",function(){
		//添加一行
		addRow();
	});
	introEditor = new wangEditor('fundIntro');
    introEditor.config.uploadImgUrl = '${base}/admin/upload.htm';
    introEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
    introEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
    introEditor.config.hideLinkImg = true;
    introEditor.create();
    
    
    strategyEditor = new wangEditor('fundStrategy');
    strategyEditor.config.uploadImgUrl = '${base}/admin/upload.htm';
    strategyEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
    strategyEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
    strategyEditor.config.hideLinkImg = true;
    strategyEditor.create();
    
    detailEditor = new wangEditor('fundDetail');
    detailEditor.config.uploadImgUrl = '${base}/admin/upload.htm';
    detailEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
    detailEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
    detailEditor.config.hideLinkImg = true;
    detailEditor.create();
  	$("#gpFund").on("blur",function(){
  		$(this).val(fmtCurrency($(this).val()));
  	});
  	$("#planCollectMoney").on("blur",function(){
  		$(this).val(fmtCurrency($(this).val()));
  	});
  	
  	//文件上传
  	var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#coverFileBtn',
    	auto:true,
    	compress: false
	});
	fundFileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#cover").val("")
		}else{
			$("#cover").val(res.url)
		}
	});
	fundFileUploader.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
		$("#cover").val("")
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
});	

function bindDS(n){
	laydateToId('rs_'+n);
}
function bindDE(n){
	laydateToId('re_'+n);
}
var rowNum =0;
function addRow(){
	rowNum = rowNum+1;
	var row = '<div class="form-group" id="row_'+rowNum+'_1">'
				+'<label class="col-xs-2 control-label">名称</label><div class="col-xs-6"><input type="text" class="form-control" placeholder="名称" name="records['+rowNum+'].name"></div>'
				+'<label class="col-xs-2 control-label">总金额</label><div class="col-xs-2"><input type="number" class="form-control" placeholder="总金额" id="rm_'+rowNum+'" name="records['+rowNum+'].totalMoney"></div>'
			    +'</div>'
			    +'<div class="form-group" id="row_'+rowNum+'_2">'
			     +'<label class="col-xs-2 control-label">起始日期</label><div class="col-xs-2"><input type="text" onclick="javascript:bindDS('+rowNum+');" class="form-control" placeholder="起始日期" id="rs_'+rowNum+'" name="records['+rowNum+'].startTime"></div>'
			    +'<label class="col-xs-2 control-label">截止日期</label><div class="col-xs-2"><input type="text" onclick="javascript:bindDE('+rowNum+');" class="form-control" placeholder="截止日期" id="re_'+rowNum+'" name="records['+rowNum+'].endTime"></div>'
			    +'<label class="col-xs-2 control-label">存续天数</label><div class="col-xs-2"><input type="number" class="form-control" placeholder="存续天数" name="records['+rowNum+'].storeDays"></div>'
			    +'</div>'
			    +'<div class="form-group" id="row_'+rowNum+'_3">'
			    +'<label class="col-xs-2 control-label">备注</label><div class="col-xs-9"><input type="text" class="form-control" placeholder="备注" name="records['+rowNum+'].remark"></div>'
			    +'<div class="col-xs-1" id="record_'+rowNum+'" style="cursor:pointer;" onclick="javascript:delRecord('+rowNum+');">-</div>'
			+'</div><hr id="row_'+rowNum+'_4">';
	$("#fundAddRecordTarget").append(row);
	//
	//$('#rs_'+rowNum).on("click",function(){
	//	laydateToId('rs_'+rowNum);
	//});
	//$('#re_'+rowNum).on("click",function(){
	//	laydateToId('re_'+rowNum);
	//});
	//
	$("#re_"+rowNum).on("blur",function(){
		checkDate("re_"+rowNum);
	});
	$("#rs_"+rowNum).on("blur",function(){
		checkDate("rs_"+rowNum);
	});
	$("#rm_"+rowNum).on("blur",function(){
		$(this).val(fmtCurrency($(this).val()));
	});
}
function delRecord(index){
	$("div[id^='row_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
	$("hr[id^='row_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
}
function laydateInit(sid){
	laydate({
   		fixed:true,
   		elem: '#'+sid,
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
}

function fundAddSubmitForm(parentIndex){
	var s=$("#fundAddForm").validate().form();
	if(s){
		//对textarea进行赋值
		$("#fundIntro").html(introEditor.$txt.text());
		$("#fundDetail").html(detailEditor.$txt.text());
		$("#fundStrategy").html(strategyEditor.$txt.text());
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundAddForm").serializeArray(),
			url:"${base}/admin/fund/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#fundListMain #fundTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="fundAddForm">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#fundAddBaseInfo" data-toggle="tab">产品基本信息</a></li>
	   	 <li><a href="#fundAddTarget" data-toggle="tab">基金概要</a></li>
	     <li><a href="#fundAddOtherTarget" data-toggle="tab">其他信息</a></li>
	     <li><a href="#fundAddRecordTarget" data-toggle="tab">产品纪要</a></li>
	     <li><a href="#fundAddIntroTarget" data-toggle="tab">产品特点</a></li>
	     <li><a href="#fundAddStrategyTarget" data-toggle="tab">产品策略</a></li>
	     <li><a href="#fundAddDetailTarget" data-toggle="tab">产品详情</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="fundAddBaseInfo">
			<br />
			[@shiro.hasPermission name="canSeeCompany"]
			<div class="form-group">
			    <label class="col-xs-2 control-label">基金管理人</label>
			    <div class="col-xs-4">
			         <select class="form-control" name="companyId" id="companyId">
                          [#list companys as sta]
                             <option value="${sta.id}">${sta.companyAbbr}</option>
                          [/#list]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">排序编号</label>
			    <div class="col-xs-4">
			         <input type="number" class="form-control" placeholder="排序编号" name="pageIndex" id="pageIndex" value="${nextIndex}">
			    </div>
			</div>
			[/@shiro.hasPermission]
			<div class="form-group">
				<label class="col-xs-2 control-label">产品代码</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="产品代码" name="no" id="no">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">系列名称</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="系列名称" name="seriesName" id="seriesName">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">产品名称</label>
			    <div class="col-xs-10">
			        <input type="text" class="form-control" placeholder="产品名称" name="name" id="name">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">产品类别</label>
			    <div class="col-xs-4">
			    	 <select class="form-control" name="type" id="type">
                        [@dict name="fundType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			     <label class="col-xs-2 control-label">法律形式</label>
			    <div class="col-xs-4">
			    	<select name="lawWay" id="lawWay" class="form-control">
			    		[@dict name="fundLawWay" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">产品风险等级</label>
			    <div class="col-xs-10">
			    	<select name="riskLevel" id="riskLevel" class="form-control">
			    		[@dict name="fundRiskLevel" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">产品特点</label>
			    <div class="col-xs-10">
			        <textarea class="form-control" name="fundNature" id="fundNature"></textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-2 control-label">Banner显示</label>
			    <div class="col-xs-4">
			        <select class="form-control" name="frontStatus" id="frontStatus">
			        	<option value=0>否</option>
			        	<option value=1>是</option>
			        </select>
			    </div>
			    <label class="col-xs-2 control-label">图片</label>
			    <div class="col-xs-2">
			        <input class="form-control" readOnly name="cover" id="cover">
			    </div>
			    <div class="col-xs-2" id="coverFileBtn">选择</div>
			</div>
			<hr>
			<div class="form-group">
			    <label class="col-xs-2 control-label">产品状态</label>
			    <div class="col-xs-4">
			    	 <select class="form-control" name="fundStatus" id="fundStatus">
                        [@dict name="fundStatus" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			     <label class="col-xs-2 control-label">是否显示</label>
			    <div class="col-xs-4">
			    	<select name="showStatus" id="showStatus" class="form-control">
			    		<option value="0">不显示</option>
			    		<option value="1">显示</option>
			    	</select>
			    </div>
			</div>
		</div>
		<!-- 基金概要 -->
		<div class="tab-pane fade" id="fundAddTarget">
				<br />
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金备案号</label>
				    <div class="col-xs-9">
				    	<input type="text" class="form-control" placeholder="备案号" name="beiNo" id="beiNo">
				    </div>
				</div>
				<!--
				<div class="form-group">
					<label class="col-xs-3 control-label">基金管理人</label>
				    <div class="col-xs-9">
						<select class="form-control" name="manager" id="manager"> </select>
				    </div>
				</div>
				<div class="form-group">
			    <label class="col-xs-3 control-label">基金托管人</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="基金托管人" name="truster" id="truster">
			    </div>
				</div>
				-->
				<hr>
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金规模</label>
				    <div class="col-xs-9">
				    	<input type="text" class="form-control" placeholder="基金规模" name="size" id="size">
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-xs-3 control-label">起投金额（个人）</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control" placeholder="起投金额" name="startPerMoney" id="startPerMoney">
				    </div>
				    <label class="col-xs-3 control-label">起投金额（公司）</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control" placeholder="起投金额" name="startComMoney" id="startComMoney">
				    </div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">递增金额</label>
				    <div class="col-xs-9">
				    	<input type="text" class="form-control" name="incrMoney"  placeholder="递增金额" id="incrMoney">
				    </div>
				</div>
				<hr>
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金期限</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control" placeholder="基金期限" name="deadline" id="deadline">
				    </div>
				    <label class="col-xs-3 control-label">基金存续期（月）</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control" placeholder="基金存续期" name="storePeriod" id="storePeriod">
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-xs-3 control-label">收益分配周期</label>
				    <div class="col-xs-9">
				    	<select class="form-control" id="duration"  name="duration">
				    		[@dict name="fundDuration" ]
	                    	[#list dictList as st]
	                    		<option value="${st.id}">${st.name}</option>
	                    	[/#list]
	                    	[/@dict]
				    	</select>
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金成立日</label>
				    <div class="col-xs-3">
				        <input type="text" class="form-control laydate-icon" placeholder="基金成立日" name="setupTime" id="setupTime">
				    </div>
				     <label class="col-xs-3 control-label">基金清算日</label>
				    <div class="col-xs-3">
				        <input type="text" class="form-control laydate-icon" placeholder="基金清算日" name="cashTime" id="cashTime">
				    </div>
				</div>	
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金募集起始日期</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control laydate-icon" placeholder="基金募集起始日期" name="collectStartTime" id="collectStartTime">
				    </div>
				    <label class="col-xs-3 control-label">基金募集截止日期</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control laydate-icon" placeholder="基金募集截止日期" name="collectEndTime" id="collectEndTime">
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-xs-3 control-label">基金认购缴款起始日期</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control laydate-icon" placeholder="基金认购缴款起始日期" name="buyStartTime" id="buyStartTime">
				    </div>
				    <label class="col-xs-3 control-label">基金认购缴款截止日期</label>
				    <div class="col-xs-3">
				    	<input type="text" class="form-control laydate-icon" placeholder="基金认购缴款截止日期" id="buyEndTime" name="buyEndTime">
				    </div>
				</div>
		</div>
		<!-- 其他信息 -->
		<div class="tab-pane fade" id="fundAddOtherTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">基金经理</label>
			    <div class="col-xs-9">
					<input type="text" class="form-control" placeholder="基金经理" id="fundManager" name="fundManager">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">GP出资额（万元）</label>
			    <div class="col-xs-9">
					<input type="text" class="form-control" placeholder="GP出资额（万元）" id="gpFund" name="gpFund">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">预约募集总额</label>
			    <div class="col-xs-9">
					<input type="text" class="form-control" placeholder="预约募集总额" id="planCollectMoney" name="planCollectMoney">
			    </div>
			</div>
			<hr/>
			<div class="form-group">
			    <label class="col-xs-3 control-label">托管信息</label>
			    <div class="col-xs-3">
					<select class="form-control" id="trustInfo" name="trustInfo">
						<option value="0">无托管</option>
						<option value="1">国信托管</option>
					</select>
			    </div>
			    <label class="col-xs-3 control-label">托管编号</label>
			    <div class="col-xs-3">
					<input type="text" class="form-control" placeholder="托管编号" id="trustNo" name="trustNo">
			    </div>
			</div>
		</div>
		<!-- 产品纪要 -->
		<div class="tab-pane fade" id="fundAddRecordTarget">
			<br>
			<label class="col-xs-12 control-label" id="addRecord" style="cursor:pointer;">+</label>
			<!--
			<div class="form-group">
			    <label class="col-xs-1 control-label">名称</label>
			    <label class="col-xs-2 control-label">起始日期</label>
			    <label class="col-xs-2 control-label">截止日期</label>
			    <label class="col-xs-2 control-label">存续天数</label>
			    <label class="col-xs-2 control-label">总金额</label>
			    <label class="col-xs-2 control-label">备注</label>
			    <label class="col-xs-1 control-label" id="addRecord" style="cursor:pointer;">+</label>
			</div> -->
			
		</div>
		<div class="tab-pane fade" id="fundAddIntroTarget">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="fundIntro" name="fundIntro"></textarea>
				</div>
			</div> 
		</div>
		<div class="tab-pane fade" id="fundAddStrategyTarget">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="fundStrategy" name="fundStrategy"></textarea>
				</div>
			</div> 
		</div>
		<div class="tab-pane fade" id="fundAddDetailTarget">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea  style="height:400px;" id="fundDetail" name="fundDetail"></textarea>
				</div>
			</div> 
		</div>
	</div>
</form>
</div>