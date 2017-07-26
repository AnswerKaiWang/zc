<!-- 首页 -->
<!-- 用户到期提醒 -->
<script>
$(function(){
	$('#welcomeListMain #welcomeCertTable').bootstrapTable({
        url:'${base}/admin/main/welcome/cert/list.htm',
        queryParams:{"expireDays": '${expireDays}'},
        columns: [
        	{field: 'owner',title: '客户姓名',align: 'center',sortable:"true"},
        	{field: 'name',title: '客户证件名',align: 'center', sortable:"true"},
        	{field: 'expDate', title: '到期日期',align: 'center'}
        ]
    });
    $('#welcomeListMain #welcomeRiskTable').bootstrapTable({
        url:'${base}/admin/main/welcome/risk/list.htm',
        queryParams:{"expireDays": '${expireDays}'},
        columns: [
        	{field: 'name',title: '风险测评人姓名',align: 'center', sortable:"true"},
        	{field: 'expDate', title: '到期日期',align: 'center'}
        ]
    });
    $('#welcomeListMain #welcomeFundTable').bootstrapTable({
        url:'${base}/admin/main/welcome/fund/list.htm',
        queryParams:{"expireDays": '${expireDays}'},
        columns: [
        	{field: 'owner',title: '产品名',align: 'center',sortable:"true"},
        	{field: 'name',title: '产品纪要',align: 'center', sortable:"true"},
        	{field: 'expDate', title: '到期日期',align: 'center'}
        ]
    });
})
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="welcomeListMain">
	<!-- 证件到期 -->
	<div class="ibox">
        <div class="ibox-content">
			<table class="table table-bordered" id="welcomeCertTable"></table>
        </div>
	</div>
	<!-- 风险测评到期提醒 -->
	<div class="ibox">
        <div class="ibox-content">
			<table class="table table-bordered" id="welcomeRiskTable"></table>
        </div>
	</div>
	<!-- 产品纪要到期提醒 -->
	<div class="ibox">
        <div class="ibox-content">
			<table class="table table-bordered" id="welcomeFundTable"></table>
        </div>
	</div>
</div>
