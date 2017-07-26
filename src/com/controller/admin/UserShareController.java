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

import com.bo.UserShareBo;
import com.bo.UserShareVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Fund;
import com.entity.User;
import com.entity.UserShare;
import com.enums.OrderType;
import com.service.CompanyService;
import com.service.FundService;
import com.service.UserService;
import com.service.UserShareService;
import com.util.CommonUtils;

@Controller("adminFundShareController")
@RequestMapping("/admin/userShare")
public class UserShareController extends AdminBaseController{

	@Resource
	private FundService fundService;
	@Resource
	private UserShareService userShareService;
	@Resource
	private CompanyService companyService;
	@Resource
	private UserService userService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("companys", companyService.getAllList());
		map.put("orderTypes",OrderType.values());
		map.put("funds",fundService.getAllList());
		return "/cms/userShare/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<UserShareVo> pager,UserShareBo userShareBo){
		if(!isPermission("canSeeCompany")){
			userShareBo.setCompanyId(currentCompany());
		}
		pager=userShareService.getList(pager,userShareBo);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		modelMap.put("orderTypes",OrderType.values());
		return "/cms/userShare/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(UserShareBo userShareBo){
		Map<String, Object> map=new HashMap<>();
		if(userShareBo.getShare()==null||userShareBo.getShare()<=0){
			map.put("error","份额不正确,请填写正整数");
			return map;
		}
		Long money=CommonUtils.money(userShareBo.getMoney());
		if(money==null||money<=0){
			map.put("error","金额不正确,请填写两位小数");
			return map;
		}
		Long fundAccountMoney=CommonUtils.money4(userShareBo.getFundAccountMoney());
		if(fundAccountMoney==null||fundAccountMoney<=0){
			map.put("error","净值不正确,请填写两位小数");
			return map;
		}
		Fund fund=fundService.get(userShareBo.getFundId());
		User user=null;
		if(CommonUtils.isNotEmpty(userShareBo.getUserNo())){
			user=userService.getByUserNo(userShareBo.getUserNo(), fund.getCompanyId());
			if(user==null){
				map.put("error","查无此基金账户");
				return map;
			}
		}
		if(user==null){
			if(CommonUtils.isEmpty(userShareBo.getCardNo())){
				map.put("error","当未填写基金账户时,证件号码必填");
				return map;
			}
			user=userService.getByCardNo(userShareBo.getCardNo(),fund.getCompanyId());
			if(user==null){
				map.put("error","查无此用户");
				return map;
			}
		}
		Date date=new Date();
		UserShare userShare=new UserShare();
		userShare.setCreateTime(date);
		userShare.setUpdateTime(date);
		userShare.setMoney(money);
		userShare.setFundAccountMoney(fundAccountMoney);
		userShare.setShare(userShareBo.getShare());
		userShare.setType(userShareBo.getType());
		userShare.setOkTime(userShareBo.getOkTime());
		userShare.setFundId(userShareBo.getFundId());
		userShare.setCompanyId(fund.getCompanyId());
		userShare.setUserId(user.getId());
		userShareService.save(userShare);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		UserShare userShare=userShareService.get(id);
		Fund fund=fundService.get(userShare.getFundId());
		User user=userService.get(userShare.getUserId());
		modelMap.put("fund", fund);
		modelMap.put("user", user);
		modelMap.put("userShare", userShare);
		modelMap.put("orderTypes",OrderType.values());
		return "cms/userShare/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(UserShareBo userShareBo,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Long money=CommonUtils.money(userShareBo.getMoney());
		if(money==null||money<=0){
			map.put("error","金额不正确,请填写两位小数");
			return map;
		}
		Long fundAccountMoney=CommonUtils.money4(userShareBo.getFundAccountMoney());
		if(fundAccountMoney==null||fundAccountMoney<=0){
			map.put("error","净值不正确,请填写两位小数");
			return map;
		}
		UserShare persistent=userShareService.get(userShareBo.getId());
		persistent.setUpdateTime(new Date());
		persistent.setMoney(money);
		persistent.setOkTime(userShareBo.getOkTime());
		persistent.setFundAccountMoney(fundAccountMoney);
		persistent.setShare(userShareBo.getShare());
		userShareService.update(persistent);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		int i=userShareService.delete(id);
		if(i==1){
			map.put("error","00");
			return map;
		}
		map.put("error","删除出错,请重试");
		return map;
	}
	
	@RequestMapping("/openUploadUserShare")
	public String edit(ModelMap modelMap){
		return "cms/userShare/uploadUserShare";
	}
	@RequestMapping("/uploadUserShare")
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
			List<UserShare> userShares=new ArrayList<>();
			Map<Object, String> errors=new LinkedHashMap<>();
			for (int i = 1; i < 1000000; i++) {
				Row row=sheet.getRow(i);
				if(row!=null){
					String no=CommonUtils.cellValue(row, 0);
					String cardNo=CommonUtils.cellValue(row, 1);
					String userNo=CommonUtils.cellValue(row, 2);
//					String name=CommonUtils.cellValue(row, 3);
					String type=CommonUtils.cellValue(row, 4);
					String okTime=CommonUtils.cellValue(row, 5);
					String fundAccountMoney=CommonUtils.cellValue(row, 6);
					String share=CommonUtils.cellValue(row, 7);
					String money=CommonUtils.cellValue(row, 8);
					if(CommonUtils.isEmpty(no)&&CommonUtils.isEmpty(userNo)&&CommonUtils.isEmpty(cardNo)&&CommonUtils.isEmpty(okTime)){
						break;
					}
					allCount++;//记录总行数
					Fund fund=fundService.getFunByNo(no);
					if(CommonUtils.isEmpty(no)||fund==null){
						errors.put("第"+(i+1)+"行", "产品代码错误");
						continue;
					}
					User user=null;
					if(CommonUtils.isNotEmpty(userNo)){
						user=userService.getByUserNo(userNo, fund.getCompanyId());
						if(user==null){
							errors.put("第"+(i+1)+"行", "基金账户不存在,请认真填写");
							continue;
						}
					}else{
						if(CommonUtils.isEmpty(cardNo)){
							errors.put("第"+(i+1)+"行", "客户证件号码不存在");
							continue;
						}
						user=userService.getByCardNo(cardNo,  fund.getCompanyId());
						if(user==null){
							errors.put("第"+(i+1)+"行", "客户证件号码不存在");
							continue;
						}
					}
					
					if(CommonUtils.isEmpty(type)||OrderType.add.get(type)==null){
						errors.put("第"+(i+1)+"行", "类型不正确,请填写认购或申购或赎回或其他");
						continue;
					}
					if(CommonUtils.isEmpty(okTime)||CommonUtils.stringToDate(okTime)==null){
						errors.put("第"+(i+1)+"行", "确认时间错误");
						continue;
					}
					if(CommonUtils.isEmpty(money)||CommonUtils.money(money)==null){
						errors.put("第"+(i+1)+"行", "认购金额错误");
						continue;
					}
					if(CommonUtils.isEmpty(fundAccountMoney)||CommonUtils.money4(fundAccountMoney)==null){
						errors.put("第"+(i+1)+"行", "单位净值错误");
						continue;
					}
					Long shareReal=null;
					try {
						shareReal=Long.parseLong(share);
					} catch (Exception e) {
						errors.put("第"+(i+1)+"行", "确认份额错误");
						continue;
					}
					if(shareReal==null||shareReal<=0){
						errors.put("第"+(i+1)+"行", "确认份额错误");
						continue;
					}
					UserShare userShare=new UserShare();
					userShare.setCompanyId(fund.getCompanyId());
					userShare.setCreateTime(new Date());
					userShare.setFundAccountMoney(CommonUtils.money4(fundAccountMoney));
					userShare.setFundId(fund.getId());
					userShare.setMoney(CommonUtils.money(money));
					userShare.setOkTime(CommonUtils.stringToDate(okTime));
					userShare.setShare(shareReal);
					userShare.setType(OrderType.ok.get(type));
					userShare.setUpdateTime(new Date());
					userShare.setUserId(user.getId());
					userShares.add(userShare);
				}else{
					break;
				}
			}
			map.put("allCount", "读取到:"+allCount+"行");
			map.put("successCount", "校验成功:"+userShares.size()+"行");
			map.put("errorCount", "校验失败:"+errors.size()+"行");
			if(errors.isEmpty()&&CommonUtils.isNotEmpty(userShares)){
				userShareService.saveList(userShares);
				map.put("saveCount", "保存成功:"+userShares.size()+"行");
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
	@RequestMapping("/exportUserShare")
	@ResponseBody
	public Object exportUserShare(Pager<UserShareVo> pager,UserShareBo userShareBo) {
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = CommonUtils.newFileName() + ".xlsx";
		String path = getExportPath(null);
		File file = new File(path + File.separator + fileName);
		Workbook workbook = null;
		FileInputStream in = null;
		FileOutputStream ou = null;
		try {
			file.createNewFile();
			FileUtils.copyFile(new File(getExportPath("user_share.xlsx")), file);
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
			userShareBo.setCompanyId(currentCompany());
		}
		pager=userShareService.getList(pager,userShareBo);
		if (CommonUtils.isEmpty(pager.getRows())) {
			map.put("status", "11");
			map.put("error", "结果集为空");
			return map;
		}
		List<UserShareVo> userShareVos= pager.getRows();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for (UserShareVo shareVo: userShareVos) {
			Row row=sheet.getRow(index);
			if(row==null){
				row=sheet.createRow(index);
			}
			CommonUtils.setCellValue(row, 0,shareVo.getNo());	
			CommonUtils.setCellValue(row, 1,StringUtils.defaultString(shareVo.getFundName()));
			CommonUtils.setCellValue(row, 2,StringUtils.defaultString(shareVo.getCardNo()));
			CommonUtils.setCellValue(row, 3,StringUtils.defaultString(shareVo.getUserNo()));
			CommonUtils.setCellValue(row, 4,StringUtils.defaultString(shareVo.getName()));
			CommonUtils.setCellValue(row, 5,StringUtils.defaultString(shareVo.getType().getDescription()));
			CommonUtils.setCellValue(row, 6,StringUtils.defaultString(simpleDateFormat.format(shareVo.getOkTime())));
			CommonUtils.setCellValue(row, 7,CommonUtils.money4(shareVo.getFundAccountMoney()));
			CommonUtils.setCellValue(row, 8,shareVo.getShare().toString());
			CommonUtils.setCellValue(row, 9,CommonUtils.money(shareVo.getMoney()));
			CommonUtils.setCellValue(row, 10,StringUtils.defaultString(CommonUtils.DateToString(shareVo.getCreateTime())));
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
