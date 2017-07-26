package com.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bo.FundBo;
import com.bo.FundEditVo;
import com.bo.FundSaveBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Company;
import com.entity.Fund;
import com.entity.FundApply;
import com.enums.DictionaryType;
import com.enums.FundStatus;
import com.enums.FundType;
import com.service.CompanyService;
import com.service.DictionaryService;
import com.service.FundApplyService;
import com.service.FundService;
import com.util.CommonUtils;

@Controller("adminFundController")
@RequestMapping("/admin/fund")
public class FundController extends AdminBaseController{
	
	@Resource
	private FundService fundService;
	@Resource
	private CompanyService companyService;
	@Resource
	private FundApplyService fundApplyService;
	@Resource
	private DictionaryService dictionaryService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("status", dictionaryService.getListByType(DictionaryType.fundStatus));
		map.put("types",dictionaryService.getListByType(DictionaryType.fundType));
		map.put("companys",companyService.getAllList());
		return "/cms/fund/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Fund> pager,FundBo fundBo){
		if(!isPermission("canSeeCompany")){
			fundBo.setCompanyId(currentCompany());
		}
		pager=fundService.getList(pager,fundBo);
		return pager;
	}
	
	@RequestMapping("/getFundsByCompanyId")
	@ResponseBody
	public Object getFundsByCompanyId(Long companyId){
		if (!isPermission("canSeeCompany")) {
			companyId=currentCompany();
		}
		if(companyId==null) return "";
		List<Fund> funds=fundService.getFundsByCompanyId(companyId);
		String s="";
		for (Fund fund : funds) {
			s+="<option value='"+fund.getId()+"'>"+fund.getName()+"</option>";
		}
		return s;
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("status", FundStatus.values());
		modelMap.put("companys",companyService.getAllList());
		modelMap.put("types",FundType.values());
		modelMap.put("nextIndex", fundService.getMaxIndex()+1);
		return "/cms/fund/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(FundSaveBo fund){
		if(!isPermission("canSeeCompany")){
			fund.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		if(StringUtils.isBlank(fund.getNo())){
			map.put("error","产品代码必填");
			return map;
		}
		Fund fund2=fundService.getFunByNo(fund.getNo());
		if(fund2!=null){
			map.put("error","产品代码重复");
			return map;
		}
		if(CommonUtils.isNotEmpty(fund.getBeiNo())){
			Fund fund3=fundService.getFunByBei(fund.getBeiNo());
			if(fund3!=null){
				map.put("error","备案号重复");
				return map;
			}
		}
		fundService.saveFund(fund);
		map.put("error","00");
		addLog("添加基金", "添加了基金编号为:"+fund.getNo()+"的基金");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		FundEditVo fund=fundService.findDetailById(id);
		modelMap.put("fund",fund);
		modelMap.put("companys",companyService.getAllList());
		return "cms/fund/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(FundSaveBo fund){
		if(!isPermission("canSeeCompany")){
			fund.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		Fund persistent=fundService.get(fund.getId());
		Fund fund2=fundService.getFunByNo(persistent.getNo());
		if(fund2!=null&&!fund2.getId().equals(persistent.getId())){
			map.put("error","产品代码重复");
			return map;
		}
		if(CommonUtils.isNotEmpty(persistent.getBeiNo())){
			Fund fund3=fundService.getFunByBei(persistent.getBeiNo());
			if(fund3!=null&&!fund3.getId().equals(persistent.getId())){
				map.put("error","备案号重复");
				return map;
			}
		}
		fund.setCreateTime(persistent.getCreateTime());
		fundService.updateFund(fund);
		map.put("error","00");
		addLog("修改基金", "修改了基金编号为:"+fund.getNo()+"的基金");
		return map;
	}
	@RequestMapping("/editFundApply")
	public String editFundApply(Long id,ModelMap modelMap){
		FundApply fundApply=fundApplyService.get(id);
		if(fundApply==null){
			fundApply=new FundApply();
			fundApply.setFundId(id);
			fundApply.setUsed(false);
			fundApplyService.save(fundApply);
		}
		modelMap.put("fundApply", fundApply);
		return "cms/fund/editFundApply";
	}
	@RequestMapping("/updateFundApply")
	@ResponseBody
	public Map<String, Object> updateFundApply(FundApply fundApply,String applyMoneyString,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Long money=CommonUtils.money(applyMoneyString);
		if(money==null||money<=0){
			map.put("error","金额不正确,请填写两位小数");
			return map;
		}
		fundApply.setApplyMoney(money);
		fundApplyService.update(fundApply);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/openUploadFund")
	public String edit(ModelMap modelMap){
		return "cms/fund/uploadFund";
	}
	@RequestMapping("/uploadFund")
	@ResponseBody
	public Object fileUpload(MultipartFile file,HttpServletRequest request){
		Map<String, Object> map=new HashMap<>();
		List<Fund> temp=fundService.getAllList();
		List<String> nos=new ArrayList<>();
		List<String> beis=new ArrayList<>();
		if(temp!=null){
		for (Fund fund : temp) {
			nos.add(fund.getNo());
			if(fund.getBeiNo()!=null){
				beis.add(fund.getBeiNo());
			}
		}
		}
		try {
			Workbook workbook = WorkbookFactory.create(file.getInputStream());
			Sheet sheet=workbook.getSheetAt(0);
			if(sheet==null){
				map.put("status", "解析出错,请导入正确的excel");
				return map;
			}
			int allCount=0;
			List<Fund> funds=new ArrayList<>();
			Map<Object, String> errors=new LinkedHashMap<>();
			Date date=new Date();
			for (int i = 1; i < 1000000; i++) {
				Row row=sheet.getRow(i);
				if(row!=null){
					String companyNo=CommonUtils.cellValue(row, 0);
					String no=CommonUtils.cellValue(row, 1);
					String name=CommonUtils.cellValue(row, 2);
					String bei=CommonUtils.cellValue(row,3);
					String size=CommonUtils.cellValue(row, 4);
					String beginTime=CommonUtils.cellValue(row, 5);
					String type=CommonUtils.cellValue(row,6);
					String status=CommonUtils.cellValue(row, 7);
					String duration=CommonUtils.cellValue(row, 8);
//					String round=CommonUtils.cellValue(row, 9);
					if(CommonUtils.isEmpty(companyNo)&&CommonUtils.isEmpty(name)&&CommonUtils.isEmpty(no)){
						break;
					}
					allCount++;//记录总行数
					if(CommonUtils.isEmpty(companyNo)){
						errors.put("第"+(i+1)+"行", "公司编号不正确");
						continue;
					}
					Company company=companyService.getByCompanyNo(companyNo);
					if(company==null){
						errors.put("第"+(i+1)+"行", "系统根据公司编号找不到公司");
						continue;
					}
					if(status==null||FundStatus.cunxuqi.get(status)==null){
						errors.put("第"+(i+1)+"行", "产品状态错误");
						continue;
					}
					if(CommonUtils.isEmpty(name)){
						errors.put("第"+(i+1)+"行", "产品名称错误");
						continue;
					}
					if(CommonUtils.isEmpty(type)||FundType.chuangye.get(type)==null){
						errors.put("第"+(i+1)+"行", "产品类型不正确,请填写正确类型");
						continue;
					}
					if(CommonUtils.isEmpty(no)){
						errors.put("第"+(i+1)+"行", "产品代码错误");
						continue;
					}
					if(nos.contains(no)){
						errors.put("第"+(i+1)+"行", "产品代码重复错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(bei)&&beis.contains(bei)){
						errors.put("第"+(i+1)+"行", "备案号重复错误");
						continue;
					}
					nos.add(no);
					beis.add(bei);
					Fund fund=new Fund();
					fund.setCreateTime(date);
					fund.setUpdateTime(date);
					fund.setName(name);
					//fund.setBeginTime(CommonUtils.stringToDate(beginTime));
					fund.setCollectStartTime(beginTime);
					fund.setNo(no);
					fund.setBeiNo(bei);
					fund.setType(type);
					//fund.setStatus(status);
					fund.setSize(size);
					fund.setDuration(duration);
					fund.setCompanyId(company.getId());
					//fund.setRound(round);
					funds.add(fund);
				}else{
					break;
				}
			}
			map.put("allCount", "读取到:"+allCount+"行");
			map.put("successCount", "校验成功:"+funds.size()+"行");
			map.put("errorCount", "校验失败:"+errors.size()+"行");
			if(errors.isEmpty()&&CommonUtils.isNotEmpty(funds)){
				fundService.saveList(funds);
				for (Fund fund : funds) {
					addLog("excel导入基金", "导入基金编号为:"+fund.getNo()+"的基金");
				}
				map.put("saveCount", "保存成功:"+funds.size()+"行");
				map.put("status", "00");
				return map;
			}else{
				map.put("status", "11");
				map.put("saveCount", "保存成功:"+0+"行");
				map.put("errors", errors);
				return map;
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "解析出错,请导入正确的excel");
			return map;
		} 
	}
	
	@RequestMapping("/exportFund")
	@ResponseBody
	public Object exportFund(Pager<Fund> pager,FundBo fundBo) {
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = CommonUtils.newFileName() + ".xlsx";
		String path = getExportPath(null);
		File file = new File(path + File.separator + fileName);
		Workbook workbook = null;
		FileInputStream in = null;
		FileOutputStream ou = null;
		try {
			file.createNewFile();
			FileUtils.copyFile(new File(getExportPath("fund_upload.xlsx")), file);
			in = new FileInputStream(file);
			workbook = WorkbookFactory.create(in);
		} catch (Exception e) {
			map.put("status", "11");
			map.put("error", "模板复制错误");
			return map;
		}
		Sheet sheet = workbook.getSheetAt(0);
		int index = 1;
		pager.setUsePager(false);
		if(!isPermission("canSeeCompany")){
			fundBo.setCompanyId(currentCompany());
		}
		pager = fundService.getList(pager, fundBo);
		if (CommonUtils.isEmpty(pager.getRows())) {
			map.put("status", "11");
			map.put("error", "结果集为空");
			return map;
		}
		List<Fund> funds= pager.getRows();
//		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for (Fund fund : funds) {
			Row row=sheet.getRow(index);
			if(row==null){
				row=sheet.createRow(index);
			}
			Company company=companyService.get(fund.getCompanyId());
			CommonUtils.setCellValue(row, 0,company.getCompanyNo());			
			CommonUtils.setCellValue(row, 1,StringUtils.defaultString(company.getName()));
			CommonUtils.setCellValue(row, 2,StringUtils.defaultString(fund.getNo()));
			CommonUtils.setCellValue(row, 3,StringUtils.defaultString(fund.getName()));
			CommonUtils.setCellValue(row, 4,StringUtils.defaultString(fund.getBeiNo()));
			CommonUtils.setCellValue(row, 5,StringUtils.defaultString(fund.getSize()));
			CommonUtils.setCellValue(row, 6,fund.getCollectStartTime());
			CommonUtils.setCellValue(row, 7,fund.getType());
			CommonUtils.setCellValue(row, 8,String.valueOf(fund.getFundStatus()));
			CommonUtils.setCellValue(row, 9,StringUtils.defaultString(fund.getDuration()));
			//CommonUtils.setCellValue(row, 10,StringUtils.defaultString(fund.getRound()));
			CommonUtils.setCellValue(row, 11,StringUtils.defaultString(CommonUtils.DateToString(fund.getCreateTime())));
			index++;
		}
		try {
			ou = new FileOutputStream(file);
			workbook.write(ou);
			workbook.close();
			in.close();
			ou.close();
		} catch (IOException e) {
			map.put("status", "11");
			map.put("error", "导出错误,请重试");
			return map;
		}
		map.put("status", "00");
		map.put("error", fileName);
		return map;
	}
	
	
	@RequestMapping("/searchFundList")
	@ResponseBody
	public Object searchMemberList(String search){
		//查询用户，并通过姓名和账号做模糊匹配
		List<Fund> funds = fundService.searchFundList(search);
		List<Map<String, Object>> objects=new ArrayList<>();
		for (Fund fund : funds) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", fund.getId());
			map.put("text", fund.getName()+"_"+fund.getNo());
			objects.add(map);
		}
		return objects;
	}
}
