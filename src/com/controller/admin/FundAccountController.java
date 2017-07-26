package com.controller.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
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

import com.bo.FundAccountBo;
import com.bo.FundAccountVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Fund;
import com.entity.FundAccount;
import com.service.CompanyService;
import com.service.FundAccountService;
import com.service.FundService;
import com.util.CommonUtils;

@Controller("adminFundAccountController")
@RequestMapping("/admin/fundAccount")
public class FundAccountController extends AdminBaseController{
	
	@Resource
	private FundService fundService;
	@Resource
	private FundAccountService fundAccountService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("funds", fundService.getAllList());
		map.put("companys", companyService.getAllList());
		return "/cms/fundAccount/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<FundAccountVo> pager,FundAccountBo fundAccountBo){
		fundAccountBo.setSm(CommonUtils.money(fundAccountBo.getStartMoney()));
		fundAccountBo.setEm(CommonUtils.money(fundAccountBo.getEndMoney()));
		if(!isPermission("canSeeCompany")){
			fundAccountBo.setCompanyId(currentCompany());
		}
		pager=fundAccountService.getList(pager,fundAccountBo);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		return "/cms/fundAccount/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(FundAccountBo fundAccountBo){
		Map<String, Object> map=new HashMap<>();
		Long money=CommonUtils.money4(fundAccountBo.getMoney());
		if(money==null||money<=0){
			map.put("error","金额不正确,请填写四位小数");
		}
		FundAccount fundAccount=new FundAccount();
		fundAccount.setFundId(fundAccountBo.getFundId());
		fundAccount.setMoney(money);
		fundAccount.setBeginTime(fundAccountBo.getBeginTime());
		fundAccount.setCreateTime(new Date());
		fundAccount.setUpdateTime(fundAccount.getCreateTime());
		fundAccountService.save(fundAccount);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		FundAccount fundAccount=fundAccountService.get(id);
		modelMap.put("fundAccount",fundAccount);
		return "cms/fundAccount/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(FundAccountBo fundAccountBo,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Long money=CommonUtils.money4(fundAccountBo.getMoney());
		if(money==null||money<=0){
			map.put("error","金额不正确,请填写四位小数");
		}
		FundAccount persistent=fundAccountService.get(fundAccountBo.getId());
		persistent.setUpdateTime(new Date());
		persistent.setMoney(money);
		persistent.setBeginTime(fundAccountBo.getBeginTime());
		fundAccountService.update(persistent);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		int i=fundAccountService.delete(id);
		if(i==1){
			map.put("error","00");
			return map;
		}
		map.put("error","删除出错,请重试");
		return map;
	}
	
	@RequestMapping("/openUploadFundAccount")
	public String edit(ModelMap modelMap){
		return "cms/fundAccount/uploadFundAccount";
	}
	@RequestMapping("/uploadFundAccount")
	@ResponseBody
	public Object fileUpload(MultipartFile file,HttpServletRequest request){
		Map<String, Object> map=new HashMap<>();
		try {
			Workbook workbook = WorkbookFactory.create(file.getInputStream());
			Sheet sheet=workbook.getSheetAt(0);
			if(sheet==null){
				map.put("status", "解析出错,请导入正确的excel");
				return map;
			}
			int allCount=0;
			List<FundAccount> funds=new ArrayList<>();
			Map<Object, String> errors=new LinkedHashMap<>();
			for (int i = 1; i < 1000000; i++) {
				Row row=sheet.getRow(i);
				if(row!=null){
					String no=CommonUtils.cellValue(row, 0);
					String beginTime=CommonUtils.cellValue(row, 1);
					String money=CommonUtils.cellValue(row, 2);
					
					if(CommonUtils.isEmpty(no)&&CommonUtils.isEmpty(beginTime)&&CommonUtils.isEmpty(money)){
						break;
					}
					allCount++;//记录总行数
					Fund fund=fundService.getFunByNo(no);
					if(CommonUtils.isEmpty(no)||fund==null){
						errors.put("第"+(i+1)+"行", "产品代码错误");
						continue;
					}
					if(CommonUtils.isEmpty(beginTime)||CommonUtils.stringToDate(beginTime)==null){
						errors.put("第"+(i+1)+"行", "发布日期错误");
						continue;
					}
					if(CommonUtils.isEmpty(money)||CommonUtils.money4(money)==null){
						errors.put("第"+(i+1)+"行", "净值错误");
						continue;
					}
					FundAccount fundAccount=new FundAccount();
					fundAccount.setFundId(fund.getId());
					fundAccount.setMoney(CommonUtils.money4(money));
					fundAccount.setBeginTime(CommonUtils.stringToDate(beginTime));
					fundAccount.setCreateTime(new Date());
					fundAccount.setUpdateTime(fundAccount.getCreateTime());
					fundAccount.setCompanyId(fund.getCompanyId());
					funds.add(fundAccount);
				}else{
					break;
				}
			}
			map.put("allCount", "读取到:"+allCount+"行");
			map.put("successCount", "校验成功:"+funds.size()+"行");
			map.put("errorCount", "校验失败:"+errors.size()+"行");
			if(errors.isEmpty()&&CommonUtils.isNotEmpty(funds)){
				fundAccountService.saveList(funds);
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
	@RequestMapping("/exportFundAccount")
	@ResponseBody
	public Object exportFundAccount(Pager<FundAccountVo> pager,FundAccountBo fundAccountBo) {
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = CommonUtils.newFileName() + ".xlsx";
		String path = getExportPath(null);
		File file = new File(path + File.separator + fileName);
		Workbook workbook = null;
		FileInputStream in = null;
		FileOutputStream ou = null;
		try {
			file.createNewFile();
			FileUtils.copyFile(new File(getExportPath("fund_nav.xlsx")), file);
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
		fundAccountBo.setSm(CommonUtils.money(fundAccountBo.getStartMoney()));
		fundAccountBo.setEm(CommonUtils.money(fundAccountBo.getEndMoney()));
		if(!isPermission("canSeeCompany")){
			fundAccountBo.setCompanyId(currentCompany());
		}
		pager=fundAccountService.getList(pager,fundAccountBo);
		if (CommonUtils.isEmpty(pager.getRows())) {
			map.put("status", "11");
			map.put("error", "结果集为空");
			return map;
		}
		List<FundAccountVo> fundAccountVos= pager.getRows();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for (FundAccountVo fundAccountVo : fundAccountVos) {
			Row row=sheet.getRow(index);
			if(row==null){
				row=sheet.createRow(index);
			}
			CommonUtils.setCellValue(row, 0,fundAccountVo.getNo());			
			CommonUtils.setCellValue(row, 1,StringUtils.defaultString(fundAccountVo.getFundName()));
			CommonUtils.setCellValue(row, 2,StringUtils.defaultString(simpleDateFormat.format(fundAccountVo.getBeginTime())));
			CommonUtils.setCellValue(row, 3,CommonUtils.money4(fundAccountVo.getMoney()));
			CommonUtils.setCellValue(row, 4,StringUtils.defaultString(CommonUtils.DateToString(fundAccountVo.getCreateTime())));

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
}
