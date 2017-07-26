package com.controller.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bo.UserCurrentBo;
import com.common.Principal;
import com.controller.WebBaseController;
import com.entity.Fund;
import com.entity.FundAccount;
import com.entity.FundFile;
import com.entity.UserShare;
import com.enums.FundFileType;
import com.github.pagehelper.PageInfo;
import com.service.FundAccountService;
import com.service.FundFileService;
import com.service.FundService;
import com.service.UserShareService;
import com.util.CommonUtils;

@Controller("WebFundController")
@RequestMapping("/user")
public class FundController extends WebBaseController{

	@Resource
	private FundService fundService;
	@Resource
	private FundFileService fundFileService;
	@Resource
	private FundAccountService fundAccountService;
	@Resource
	private UserShareService userShareService;
	
	@RequestMapping("/fund")
	public String fund(HttpServletRequest request,ModelMap modelMap,Integer page){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		UserCurrentBo userCurrentBo=new UserCurrentBo();
		userCurrentBo.setCompanyId(principal.getCompanyId());
		userCurrentBo.setUserId(principal.getId());
		PageInfo<Fund> info=fundService.getFunds(page,userCurrentBo);
		modelMap.put("info", info);
		return "web/user/fund";
	}
	
	@RequestMapping("/fundInfo")
	public String fundInfo(Long id,HttpServletRequest request,ModelMap modelMap){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Long companyId=currentCompany(request);
		Fund fund=fundService.get(id);
		if(companyId!=fund.getCompanyId()){
			return "web/user/fundInfo";
		}
		List<UserShare> userShares=userShareService.getByFundIdAndUserId(fund.getId(),principal.getId());
		if(CommonUtils.isEmpty(userShares)){
			return "web/user/fundInfo";
		}
		List<FundFile> fundFiles=fundFileService.getFrontList(fund.getId());
		List<FundAccount> fundAccounts=fundAccountService.getFrontList(fund.getId());
		modelMap.put("fund", fund);
		modelMap.put("fundFileTypes", FundFileType.values());
		modelMap.put("fundFiles", fundFiles);
		modelMap.put("fundAccounts", fundAccounts);
		return "web/user/fundInfo";
	}
}
