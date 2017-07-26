<script>
var companySecuritEditor1;
var companySecuritEditor2;
var companySecuritEditor3;
$(function(){
	formValidate("#companyAddForm",{
		name:{
			required: true
			},
		'at[domain]':{
		required: true
		}
	})
	var t = [
        'source',    
        'bold',
        'underline',
        'italic',
        'strikethrough',
        'eraser',
        'forecolor',
        'bgcolor',
        '|',
        'quote',
        'fontfamily',
        'fontsize',
        'head',
        'unorderlist',
        'orderlist',
        'alignleft',
        'aligncenter',
        'alignright'
     ];
	companySecuritEditor1 = new wangEditor('editor1');
    companySecuritEditor2 = new wangEditor('editor2');
    companySecuritEditor3 = new wangEditor('editor3');
    companySecuritEditor1.config.menus =t;
    companySecuritEditor2.config.menus =t;
    companySecuritEditor3.config.menus =t;
    companySecuritEditor1.create();
    companySecuritEditor2.create();
    companySecuritEditor3.create();
     companySecuritEditor1.$editorContainer.css('z-index', 40)
     companySecuritEditor2.$editorContainer.css('z-index', 30)
     companySecuritEditor3.$editorContainer.css('z-index', 20)
})	

function companySubmitForm(parentIndex){
	var s=$("#companyAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{
				"companySecurityCon1":companySecuritEditor1.$txt.html(),
				"companySecurityCon2":companySecuritEditor2.$txt.html(),
				"companySecurityCon3":companySecuritEditor3.$txt.html(),
				id:"${company.id}"
			},
			url:"${base}/admin/company/updateSecurity.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#companyListMain #companyTable').bootstrapTable("refresh");
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

<div style="width:800px;height:500px;padding:15px;overfolw:auto;">
<form class="form-horizontal" id="companyAddForm">
   
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">投资安全内容</label>
			    <div class="col-xs-7">
			        <div id="editor1">${at['companySecurityCon1']}</div>
			         <input type="hidden"  name="id"  value="${company.id}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">资金安全内容</label>
			    <div class="col-xs-7">
			    	<div id="editor2" >${at['companySecurityCon2']}</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">合法合规内容</label>
			    <div class="col-xs-7">
			        <div id="editor3" >${at['companySecurityCon3']}</div>
			    </div>
			</div>
			
</form>
</div>