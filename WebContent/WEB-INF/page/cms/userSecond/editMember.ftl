<script>
$(function(){
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
	      		return {search: params.term,memberType:'caifuguwen',status:"use"}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
})	

function userSecondSubmitForm(parentIndex){
		var memberId=$("#userSecondPerAddForm #memberId").val();
		if(memberId==null||memberId==""){
			alertMsg('请选择财富顾问',0);
			return false;
		}
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{"ids":${ids},memberId:memberId},
			url:"${base}/admin/userSecond/updateUserMember.htm",
			traditional:true,
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('分配调整客户财富顾问成功', 1);
					if("${type}"=="per"){
						$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("refresh")
					}else{
						$('#userSecondComListMain #userSecondComTable').bootstrapTable("refresh")
					}
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
}
</script>

<div style="width:350px;height:100px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="userSecondPerAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">财富顾问</label>
			    <div class="col-xs-8">
			        <select class="form-control" name="memberId" id="memberId"></select>
			    </div>
			</div>
</form>
</div>