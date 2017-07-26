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

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bo.UserBo;
import com.bo.UserVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Company;
import com.entity.User;
import com.enums.CardType;
import com.enums.Status;
import com.enums.UserType;
import com.service.CompanyService;
import com.service.UserService;
import com.util.CommonUtils;

@Controller("adminUserController")
@RequestMapping("/admin/user")
public class UserController extends AdminBaseController{
	
	@Resource
	private UserService userService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("status", Status.values());
		map.put("cardTypes", CardType.values());
		map.put("userTypes", UserType.values());
		map.put("companys", companyService.getAllList());
		return "/cms/user/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<UserVo> pager,UserBo userBo){
		if(!isPermission("canSeeCompany")){
			userBo.setCompanyId(currentCompany());
		}
		pager=userService.getList(pager,userBo);
		return pager;
	}
	
	@RequestMapping("/getUsersByCompanyId")
	@ResponseBody
	public Object getUsersByCompanyId(Long companyId){
		if (!isPermission("canSeeCompany")) {
			companyId=currentCompany();
		}
		if(companyId==null) return "";
		List<User> funds=userService.getFundsByCompanyId(companyId);
		String s="";
		for (User fund : funds) {
			s+="<option value='"+fund.getId()+"'>"+fund.getName()+"</option>";
		}
		return s;
	}
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("status", Status.values());
		modelMap.put("companys", companyService.getAllList());
		modelMap.put("cardTypes", CardType.values());
		modelMap.put("userTypes", UserType.values());
		return "/cms/user/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(User user){
		if(!isPermission("canSeeCompany")){
			user.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isNotEmpty(user.getTradePassword())){
			user.setTradePassword(DigestUtils.md5Hex(user.getTradePassword()));
		}
		User u=userService.getByCardNo(user.getCardNo(), user.getCompanyId());
		if(u!=null){
			map.put("error","证件号码重复");
			return map;
		}
		if(CommonUtils.isNotEmpty(user.getUserNo())){
			u=userService.getByUserNo(user.getUserNo(), user.getCompanyId());
			if(u!=null){
				map.put("error","基金号码重复");
				return map;
			}
		}
		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		user.setCreateTime(new Date());
		user.setUpdateTime(user.getCreateTime());
		userService.save(user);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap) {
		modelMap.put("status", Status.values());
		modelMap.put("companys", companyService.getAllList());
		User user = userService.get(id);
		modelMap.put("user", user);
		modelMap.put("cardTypes", CardType.values());
		modelMap.put("userTypes", UserType.values());
		return "cms/user/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(User user,ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			user.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		User persistent=userService.get(user.getId());
		if(!CommonUtils.isEmpty(user.getPassword())){//修改密码
			persistent.setPassword(DigestUtils.md5Hex(user.getPassword()));
		}
		if(!CommonUtils.isEmpty(user.getTradePassword())){//修改密码
			persistent.setTradePassword(DigestUtils.md5Hex(user.getTradePassword()));
		}
		User u=userService.getByCardNo(user.getCardNo(), user.getCompanyId());
		if(u!=null&&!u.getId().equals(user.getId())){
			map.put("error","证件号码重复");
			return map;
		}
		if(CommonUtils.isNotEmpty(user.getUserNo())&&!StringUtils.equals(user.getUserNo(), persistent.getUserNo())){
			u=userService.getByUserNo(user.getUserNo(), user.getCompanyId());
			if(u!=null){
				map.put("error","基金号码重复");
				return map;
			}
		}
		user.setUpdateTime(new Date());
		BeanUtils.copyProperties(user, persistent, new String[]{"createTime","password","tradePassword","lastLoginTime"});
		userService.update(persistent);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStatus(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		User user=userService.get(id);
		if(Status.finish.equals(user.getStatus())){
			user.setStatus(Status.use);
		}else{
			user.setStatus(Status.finish);
		}
		user.setUpdateTime(new Date());
		userService.update(user);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/updatePassword")
	@ResponseBody
	public Map<String, Object> updatePassword(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		User user=userService.get(id);
		String password=CommonUtils.createRandomForSms(8);
		user.setPassword(DigestUtils.md5Hex(password));
		user.setUpdateTime(new Date());
		userService.update(user);
		map.put("error","00");
		map.put("msg",password);
		return map;
	}
	
	@RequestMapping("/openUploadUser")
	public String edit(ModelMap modelMap){
		return "cms/user/uploadUser";
	}
	@RequestMapping("/uploadUser")
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
			List<User> users=new ArrayList<>();
			Map<Object, String> errors=new LinkedHashMap<>();
			List<String> phones =new ArrayList<>();
			List<String> emails =new ArrayList<>();
			List<String> userNos =new ArrayList<>();
			List<String> cardNosss =new ArrayList<>();
			Date date=new Date();
			for (int i = 1; i < 1000000; i++) {
				Row row=sheet.getRow(i);
				if(row!=null){
					String companyNo=CommonUtils.cellValue(row, 0);
					String type=CommonUtils.cellValue(row, 1);
					String userNo=CommonUtils.cellValue(row, 2);
					String name=CommonUtils.cellValue(row, 3);
					String sex=CommonUtils.cellValue(row, 4);
					String cardType=CommonUtils.cellValue(row, 5);
					String cardNo=CommonUtils.cellValue(row, 6);
					String zip=CommonUtils.cellValue(row, 7);
					String address=CommonUtils.cellValue(row, 8);
					String phone=CommonUtils.cellValue(row, 9);
					String tel=CommonUtils.cellValue(row, 10);
					String email=CommonUtils.cellValue(row, 11);
					String password=CommonUtils.cellValue(row, 12);
					if(CommonUtils.isEmpty(companyNo)&&CommonUtils.isEmpty(cardNo)&&CommonUtils.isEmpty(name)&&CommonUtils.isEmpty(password)){
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
					if(CommonUtils.isNotEmpty(userNo)&&(userNos.contains(userNo)||userService.getByUserNo(userNo, company.getId())!=null)){
						errors.put("第"+(i+1)+"行", "基金账户重复错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(phone)&&(phones.contains(phone)||userService.getByPhone(phone, company.getId())!=null)){
						errors.put("第"+(i+1)+"行", "电话重复错误");
						continue;
					}
					if(CommonUtils.isNotEmpty(email)&&(emails.contains(email)||userService.getByEmail(email, company.getId())!=null)){
						errors.put("第"+(i+1)+"行", "邮箱重复错误");
						continue;
					}
					if(CommonUtils.isEmpty(name)){
						errors.put("第"+(i+1)+"行", "姓名必填");
						continue;
					}
					if(CommonUtils.isEmpty(type)||UserType.geren.get(type)==null){
						errors.put("第"+(i+1)+"行", "账户类型必填,请填写 企业或个人");
						continue;
					}
					if(CommonUtils.isEmpty(cardType)||CardType.huzhao.get(cardType)==null){
						errors.put("第"+(i+1)+"行", "证件类型必填,请填写身份证或护照或营业执照");
						continue;
					}
					if(CommonUtils.isEmpty(cardNo)){
						errors.put("第"+(i+1)+"行", "证件号码必填");
						continue;
					}
					if(cardNosss.contains(cardNo)){
						errors.put("第"+(i+1)+"行", "证件号码重复");
						continue;
					}
					User te=userService.getByCardNo(cardNo, company.getId());
					if(te!=null){
						errors.put("第"+(i+1)+"行", "证件号码已存在");
						continue;
					}
					if(CommonUtils.isNotEmpty(sex)&&!"F".equalsIgnoreCase(sex)&&!"M".equalsIgnoreCase(sex)){
						errors.put("第"+(i+1)+"行", "性别错误,请填写M或F或为空");
						continue;
					}
					if(CommonUtils.isEmpty(password)||password.length()<6){
						errors.put("第"+(i+1)+"行", "密码为空或长度小于6");
						continue;
					}
					if(CommonUtils.isNotEmpty(phone)){
						phones.add(phone);
					}
					if(CommonUtils.isNotEmpty(email)){
						emails.add(email);
					}
					cardNosss.add(cardNo);
					User user=new User();
					user.setAddress(address);
					user.setCardNo(cardNo);
					user.setCardType(CardType.huzhao.get(cardType));
					user.setCompanyId(company.getId());
					user.setCreateTime(date);
					user.setUpdateTime(date);
					user.setEmail(email);
					user.setName(name);
					user.setPassword(DigestUtils.md5Hex(password));
					user.setPhone(phone);
					if(CommonUtils.isNotEmpty(sex)){
					user.setSex("F".equalsIgnoreCase(sex));
					}
					user.setStatus(Status.use);
					user.setTel(tel);
					user.setType(UserType.geren.get(type));
					user.setUserNo(userNo);
					user.setZip(zip);
					users.add(user);
				}else{
					break;
				}
			}
			map.put("allCount", "读取到:"+allCount+"行");
			map.put("successCount", "校验成功:"+users.size()+"行");
			map.put("errorCount", "校验失败:"+errors.size()+"行");
			if(errors.isEmpty()&&CommonUtils.isNotEmpty(users)){
				userService.saveList(users);
				map.put("saveCount", "保存成功:"+users.size()+"行");
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
	
	
	@RequestMapping("/exportUser")
	@ResponseBody
	public Object exportUser(Pager<UserVo> pager,UserBo userBo) {
		Map<String, Object> map = new HashMap<String, Object>();
		String fileName = CommonUtils.newFileName() + ".xlsx";
		String path = getExportPath(null);
		File file = new File(path + File.separator + fileName);
		Workbook workbook = null;
		FileInputStream in = null;
		FileOutputStream ou = null;
		try {
			file.createNewFile();
			FileUtils.copyFile(new File(getExportPath("user.xlsx")), file);
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
			userBo.setCompanyId(currentCompany());
		}
		pager=userService.getList(pager,userBo);
		if (CommonUtils.isEmpty(pager.getRows())) {
			map.put("status", "11");
			map.put("error", "结果集为空");
			return map;
		}
		List<UserVo> userVos= pager.getRows();
		for (UserVo userVo: userVos) {
			Row row=sheet.getRow(index);
			if(row==null){
				row=sheet.createRow(index);
			}
			Company company=companyService.get(userVo.getCompanyId());
			CommonUtils.setCellValue(row, 0,company.getCompanyNo());	
			CommonUtils.setCellValue(row, 1,StringUtils.defaultString(company.getName()));
			CommonUtils.setCellValue(row, 2,userVo.getType().getDescription());
			CommonUtils.setCellValue(row, 3,StringUtils.defaultString(userVo.getUserNo()));
			CommonUtils.setCellValue(row, 4,userVo.getName());
			CommonUtils.setCellValue(row, 5,userVo.getSex()==null?"":(userVo.getSex()?"女":"男"));
			CommonUtils.setCellValue(row, 6,userVo.getCardType().getDescription());
			CommonUtils.setCellValue(row, 7,StringUtils.defaultString(userVo.getCardNo()));
			CommonUtils.setCellValue(row, 8,StringUtils.defaultString(userVo.getZip()));
			CommonUtils.setCellValue(row, 9,StringUtils.defaultString(userVo.getAddress()));
			CommonUtils.setCellValue(row, 10,StringUtils.defaultString(userVo.getPhone()));
			CommonUtils.setCellValue(row, 11,StringUtils.defaultString(userVo.getTel()));
			CommonUtils.setCellValue(row, 12,StringUtils.defaultString(userVo.getEmail()));
			CommonUtils.setCellValue(row, 13,StringUtils.defaultString(CommonUtils.DateToString(userVo.getCreateTime())));
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
