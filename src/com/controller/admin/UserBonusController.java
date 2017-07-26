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

import com.bo.UserBonusBo;
import com.bo.UserBonusVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Fund;
import com.entity.User;
import com.entity.UserBonus;
import com.service.CompanyService;
import com.service.FundService;
import com.service.UserBonusService;
import com.service.UserService;
import com.util.CommonUtils;

@Controller("adminUserBonusController")
@RequestMapping("/admin/userBonus")
public class UserBonusController extends AdminBaseController{

	@Resource
	private FundService fundService;
	@Resource
	private UserBonusService userBonusService;
	@Resource
	private CompanyService companyService;
	@Resource
	private UserService userService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("companys", companyService.getAllList());
		map.put("funds",fundService.getAllList());
		return "/cms/userBonus/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<UserBonusVo> pager,UserBonusBo userBonusBo){
		if(!isPermission("canSeeCompany")){
			userBonusBo.setCompanyId(currentCompany());
		}
		pager=userBonusService.getList(pager,userBonusBo);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		return "/cms/userBonus/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(UserBonusBo userBonusBo){
		Map<String, Object> map=new HashMap<>();
		if(userBonusBo.getShare()==null||userBonusBo.getShare()<=0){
			map.put("error","份额不正确,请填写正整数");
			return map;
		}
		Long oneMoney=CommonUtils.money(userBonusBo.getOneMoney());
		if(oneMoney==null||oneMoney<=0){
			map.put("error","每单位分红金额不正确,请填写两位小数");
			return map;
		}
		Long totalMoney=CommonUtils.money(userBonusBo.getTotalMoney());
		if(totalMoney==null||totalMoney<=0){
			map.put("error","总额不正确,请填写两位小数");
			return map;
		}
		Long realMoney=null;
		if(CommonUtils.isNotEmpty(userBonusBo.getRealMoney())){
			realMoney=CommonUtils.money(userBonusBo.getRealMoney());
			if(realMoney==null||realMoney<=0){
				map.put("error","实发金额不正确,请填写两位小数");
				return map;
			}
		}
		Fund fund=fundService.get(userBonusBo.getFundId());
		User user=null;
		if(CommonUtils.isNotEmpty(userBonusBo.getUserNo())){
			user=userService.getByUserNo(userBonusBo.getUserNo(), fund.getCompanyId());
			if(user==null){
				map.put("error","查无此基金账户");
				return map;
			}
		}
		if(user==null){
			if(CommonUtils.isEmpty(userBonusBo.getCardNo())){
				map.put("error","当未填写基金账户时,证件号码必填");
				return map;
			}
			user=userService.getByCardNo(userBonusBo.getCardNo(),fund.getCompanyId());
			if(user==null){
				map.put("error","查无此用户");
				return map;
			}
		}
		Date date=new Date();
		UserBonus userBonus = new UserBonus();
		userBonus.setCreateTime(date);
		userBonus.setUpdateTime(date);
		userBonus.setCompanyId(fund.getCompanyId());
		userBonus.setDengjiTime(userBonusBo.getDengjiTime());
		userBonus.setFundId(userBonusBo.getFundId());
		userBonus.setOkTime(userBonusBo.getOkTime());
		userBonus.setOneMoney(oneMoney);
		userBonus.setRealMoney(realMoney);
		userBonus.setSendTime(userBonusBo.getSendTime());
		userBonus.setShare(userBonusBo.getShare());
		userBonus.setTotalMoney(totalMoney);
		userBonus.setType(userBonusBo.getType());
		userBonus.setUserId(user.getId());
		userBonusService.save(userBonus);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		UserBonus userBonus=userBonusService.get(id);
		Fund fund=fundService.get(userBonus.getFundId());
		User user=userService.get(userBonus.getUserId());
		modelMap.put("fund", fund);
		modelMap.put("user", user);
		modelMap.put("userBonus", userBonus);
		return "cms/userBonus/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(UserBonusBo userBonusBo,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		if(userBonusBo.getShare()==null||userBonusBo.getShare()<=0){
			map.put("error","份额不正确,请填写正整数");
			return map;
		}
		Long oneMoney=CommonUtils.money(userBonusBo.getOneMoney());
		if(oneMoney==null||oneMoney<=0){
			map.put("error","每单位分红金额不正确,请填写两位小数");
			return map;
		}
		Long totalMoney=CommonUtils.money(userBonusBo.getTotalMoney());
		if(totalMoney==null||totalMoney<=0){
			map.put("error","总额不正确,请填写两位小数");
			return map;
		}
		Long realMoney=null;
		if(CommonUtils.isNotEmpty(userBonusBo.getRealMoney())){
			realMoney=CommonUtils.money(userBonusBo.getRealMoney());
			if(realMoney==null||realMoney<=0){
				map.put("error","实发金额不正确,请填写两位小数");
				return map;
			}
		}
		UserBonus  persistent=userBonusService.get(userBonusBo.getId());
		persistent.setUpdateTime(new Date());
		persistent.setDengjiTime(userBonusBo.getDengjiTime());
		persistent.setOkTime(userBonusBo.getOkTime());
		persistent.setOneMoney(oneMoney);
		persistent.setRealMoney(realMoney);
		persistent.setSendTime(userBonusBo.getSendTime());
		persistent.setShare(userBonusBo.getShare());
		persistent.setTotalMoney(totalMoney);
		persistent.setType(userBonusBo.getType());
		userBonusService.update(persistent);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		int i=userBonusService.delete(id);
		if(i==1){
			map.put("error","00");
			return map;
		}
		map.put("error","删除出错,请重试");
		return map;
	}
	
	@RequestMapping("/openUploadUserBonus")
	public String edit(ModelMap modelMap){
		return "cms/userBonus/uploadUserBonus";
	}
	@RequestMapping("/uploadUserBonus")
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
			List<UserBonus> userBonuss=new ArrayList<>();
			Map<Object, String> errors=new LinkedHashMap<>();
			for (int i = 1; i < 1000000; i++) {
				Row row=sheet.getRow(i);
				if(row!=null){
					String no=CommonUtils.cellValue(row, 0);
					String cardNo=CommonUtils.cellValue(row, 1);
					String userNo=CommonUtils.cellValue(row, 2);
					String name=CommonUtils.cellValue(row, 3);
					String type=CommonUtils.cellValue(row, 4);
					String dengjiTime=CommonUtils.cellValue(row, 5);
					String sendTime=CommonUtils.cellValue(row, 6);
					String share=CommonUtils.cellValue(row, 7);
					String oneMoney=CommonUtils.cellValue(row, 8);
					String totalMoney=CommonUtils.cellValue(row, 9);
					String sendMoney=CommonUtils.cellValue(row, 10);
					String okTime=dengjiTime;
					if(CommonUtils.isEmpty(no)&&CommonUtils.isEmpty(userNo)&&CommonUtils.isEmpty(cardNo)&&CommonUtils.isEmpty(name)&&CommonUtils.isEmpty(type)){
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
						user=userService.getByCardNo(cardNo, fund.getCompanyId());
						if(user==null){
							errors.put("第"+(i+1)+"行", "客户证件号码不存在");
							continue;
						}
					}
					if(CommonUtils.isEmpty(okTime)||CommonUtils.stringToDate(okTime)==null){
						errors.put("第"+(i+1)+"行", "分红日期错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(dengjiTime)&&CommonUtils.stringToDate(dengjiTime)==null){
						errors.put("第"+(i+1)+"行", "登记日期格式错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(sendTime)&&CommonUtils.stringToDate(sendTime)==null){
						errors.put("第"+(i+1)+"行", "发放日期格式错误");
						continue;
					}
					Long shareReal=null;
					try {
						shareReal=Long.parseLong(share);
					} catch (Exception e) {
						errors.put("第"+(i+1)+"行", "分红基数份额错误");
						continue;
					}
					if(CommonUtils.isEmpty(oneMoney)||CommonUtils.money(oneMoney)==null){
						errors.put("第"+(i+1)+"行", "每单位分红额错误");
						continue;
					}
					if(CommonUtils.isEmpty(totalMoney)||CommonUtils.money(totalMoney)==null){
						errors.put("第"+(i+1)+"行", "应发红利错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(sendMoney)&&CommonUtils.money(sendMoney)==null){
						errors.put("第"+(i+1)+"行", "实发红利错误");
						continue;
					}
					UserBonus userBonus=new UserBonus();
					userBonus.setCompanyId(fund.getCompanyId());
					userBonus.setCreateTime(new Date());
					userBonus.setDengjiTime(CommonUtils.stringToDate(dengjiTime));
					userBonus.setFundId(fund.getId());
					userBonus.setOkTime(CommonUtils.stringToDate(okTime));
					userBonus.setOneMoney(CommonUtils.money(oneMoney));
					userBonus.setRealMoney(CommonUtils.money(sendMoney));
					userBonus.setSendTime(CommonUtils.stringToDate(sendTime));
					userBonus.setShare(shareReal);
					userBonus.setTotalMoney(CommonUtils.money(totalMoney));
					userBonus.setType(type);
					userBonus.setUpdateTime(new Date());
					userBonus.setUserId(user.getId());
					userBonuss.add(userBonus);
				}else{
					break;
				}
			}
			map.put("allCount", "读取到:"+allCount+"行");
			map.put("successCount", "校验成功:"+userBonuss.size()+"行");
			map.put("errorCount", "校验失败:"+errors.size()+"行");
			if(errors.isEmpty()&&CommonUtils.isNotEmpty(userBonuss)){
				userBonusService.saveList(userBonuss);
				map.put("saveCount", "保存成功:"+userBonuss.size()+"行");
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
	
	
	@RequestMapping("/exportUserBonus")
	@ResponseBody
	public Object exportUserBonus(Pager<UserBonusVo> pager,UserBonusBo userBonusBo) {
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = CommonUtils.newFileName() + ".xlsx";
		String path = getExportPath(null);
		File file = new File(path + File.separator + fileName);
		Workbook workbook = null;
		FileInputStream in = null;
		FileOutputStream ou = null;
		try {
			file.createNewFile();
			FileUtils.copyFile(new File(getExportPath("user_bonus.xlsx")), file);
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
			userBonusBo.setCompanyId(currentCompany());
		}
		pager=userBonusService.getList(pager,userBonusBo);
		if (CommonUtils.isEmpty(pager.getRows())) {
			map.put("status", "11");
			map.put("error", "结果集为空");
			return map;
		}
		List<UserBonusVo> userBonusVos= pager.getRows();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for (UserBonusVo bonusVo: userBonusVos) {
			Row row=sheet.getRow(index);
			if(row==null){
				row=sheet.createRow(index);
			}
			CommonUtils.setCellValue(row, 0,bonusVo.getNo());
			CommonUtils.setCellValue(row, 1,StringUtils.defaultString(bonusVo.getFundName()));	
			CommonUtils.setCellValue(row, 2,StringUtils.defaultString(bonusVo.getCardNo()));
			CommonUtils.setCellValue(row, 3,StringUtils.defaultString(bonusVo.getUserNo()));
			CommonUtils.setCellValue(row, 4,StringUtils.defaultString(bonusVo.getName()));
			CommonUtils.setCellValue(row, 5,StringUtils.defaultString(bonusVo.getType()));
			if(bonusVo.getDengjiTime()!=null){
			CommonUtils.setCellValue(row, 6,StringUtils.defaultString(simpleDateFormat.format(bonusVo.getDengjiTime())));
			}
			if(bonusVo.getSendTime()!=null){
			CommonUtils.setCellValue(row, 7,StringUtils.defaultString(simpleDateFormat.format(bonusVo.getSendTime())));
			}
			CommonUtils.setCellValue(row, 8,bonusVo.getShare().toString());
			CommonUtils.setCellValue(row, 9,CommonUtils.money(bonusVo.getOneMoney()));
			CommonUtils.setCellValue(row, 10,CommonUtils.money(bonusVo.getTotalMoney()));
			CommonUtils.setCellValue(row, 11,CommonUtils.money(bonusVo.getRealMoney()));
			CommonUtils.setCellValue(row, 12,StringUtils.defaultString(CommonUtils.DateToString(bonusVo.getCreateTime())));

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
