<script>
$(function(){
});
</script>
<div style="width:800px;height:600px;padding:15px;">
<form class="form-horizontal" id="questionHisAddForm">
	<br>
	[#list his as t]
      	  <h3>${t.index}.${t.title}</h3>
      	  [#list t.subjects as s]
	      <h4>${s.sort}、${s.subject}</h4>
	      <ul>
	      	 [#list s.answers as a]
	        	<li><label><input type="radio" name="topic${s.sort}" [#if a.checked == 0] checked [/#if] ><i>${a.prefix}、${a.answer}</i></label></li>
	         [/#list]
	      </ul>
	      [/#list]
      [/#list]
</form>
</div>