/**
 * 
 */
package com.controller.cura;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.FundEditVo;
import com.bo.cura.CuraFundFileVo;
import com.bo.cura.LoginVo;
import com.bo.cura.ProductBo;
import com.bo.cura.ProductDetailVo;
import com.bo.cura.ProductVo;
import com.bo.cura.RespBean;
import com.bo.cura.RespListBean;
import com.bo.cura.RiskEvaluationBo;
import com.controller.CuraBaseController;
import com.controller.GlobalConstant;
import com.entity.Company;
import com.entity.Dictionary;
import com.entity.FundAccount;
import com.entity.FundFile;
import com.entity.UserApply;
import com.enums.DictionaryType;
import com.service.CompanyService;
import com.service.DictionaryService;
import com.service.FundAccountService;
import com.service.FundFileService;
import com.service.FundService;
import com.service.MessageService;
import com.service.QuestionService;
import com.service.UserApplyService;
import com.util.CommonUtils;

/**
 * @author	tyb
 * @date	2016年8月28日下午2:44:18
 * @desc	基金产品
 */
@Controller("curaFundController")
@RequestMapping("/cura/fund")
public class FundController extends CuraBaseController  {
	
	@Autowired
	private FundService fundService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private DictionaryService dictionaryService;
	
	@Autowired
	private FundFileService fundFileService;
	
	@Autowired
	private QuestionService questionService;
	@Autowired
	private FundAccountService fundAccountService;
	@Autowired
	private UserApplyService userApplyService;
	
	@Autowired
	private MessageService messageService;
	
	
	
	@RequestMapping("/product")
	public String product(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo lvo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		lvo.setUnread(messageService.getUnreadCount(lvo.getUserSecondId()));
		//banner
		List<ProductVo> list = fundService.curaBannerList();
		List<Dictionary> fundS = dictionaryService.getByType(DictionaryType.fundStatus);
		if(list!=null && list.size()>0){
			for(ProductVo vo: list){
				//vo.setDeadline(CommonUtils.transDeadline(vo.getDeadline()));
				vo.setStatusName(getDictionaryName(fundS, Long.valueOf(vo.getFundStatus())));
				//是否购买过产品
				int has = fundService.hasBuyFund(lvo.getUserSecondId(), vo.getFundId());
				if(has >0){
					vo.setDisabled(0);
				}else{
					vo.setDisabled(1);
				}
			}
		}
		model.put("banners", list);
		//下拉列表
//		model.put("series", fundService.getSeriesList());
		
		return "/cura/product";
	}
	
	@RequestMapping("/projects")
	@ResponseBody
	public RespListBean productJson(ProductBo bo,HttpServletRequest req){
		if(!isLogined(req)){
			return success(0,0, new ArrayList<ProductVo>());
		}
		LoginVo lvo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		lvo.setUnread(messageService.getUnreadCount(lvo.getUserSecondId()));
		bo.setUserSecondId(lvo.getUserSecondId());
		if(StringUtils.isNotBlank(bo.getProductName())){
			try {
				bo.setProductName( URLDecoder.decode(bo.getProductName(), "UTF-8"));;
			} catch (UnsupportedEncodingException e) {
			}
		}
		List<ProductVo> list = fundService.cruaList(bo);
		List<Dictionary> fundS = dictionaryService.getByType(DictionaryType.fundStatus);
		if(list!=null && list.size()>0){
			for(ProductVo vo: list){
				//vo.setDeadline(CommonUtils.transDeadline(vo.getDeadline()));
				vo.setStatusName(getDictionaryName(fundS, Long.valueOf(vo.getFundStatus())));
			}
		}
		int count = fundService.curaCount(bo);
		return success(count,count/bo.getPageSize() +1, list);
	}
	
	@RequestMapping("/detail")
	public String detail(Long id,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo lvo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		lvo.setUnread(messageService.getUnreadCount(lvo.getUserSecondId()));
		if(StringUtils.isBlank(lvo.getCardNo())){
			return "/cura/product";
		}
		//产品详情
		FundEditVo vo = fundService.findDetailById(id);
		ProductDetailVo detail = new ProductDetailVo();
		if(vo != null){
			BeanUtils.copyProperties(vo, detail);
			Company com = companyService.get(vo.getCompanyId());
			if(com != null){
				detail.setCompanyName(com.getCompanyAbbr());
			}
			//detail.setDeadline(CommonUtils.transDeadline(detail.getDeadline())+"+1+1年");
			List<Dictionary> fundS = dictionaryService.getByType(DictionaryType.fundStatus);
			detail.setStatusName(getDictionaryName(fundS, Long.valueOf(detail.getFundStatus())));
			//万元为单位
			Long incrM = 0L;
			if(detail.getIncrMoney() != null){
				incrM = detail.getIncrMoney()/10000;
			}
			Long startPM = 0L;
			if(detail.getStartPerMoney() != null){
				startPM = detail.getStartPerMoney()/10000;
			}
			Long startCM = 0L;
			if(detail.getStartComMoney() != null){
				startCM = detail.getStartComMoney()/10000;
			}
			detail.setIncrMoneyStr(CommonUtils.fmtMoney(incrM));
			detail.setStartPerMoneyStr(CommonUtils.fmtMoney(startPM));
			detail.setStartComMoneyStr(CommonUtils.fmtMoney(startCM));
			
			fundS = dictionaryService.getByType(DictionaryType.fundRiskLevel);
			detail.setRiskName(getDictionaryName(fundS, Long.valueOf(detail.getRiskLevel())));
			fundS = dictionaryService.getByType(DictionaryType.fundType);
			if(StringUtils.isNotBlank(detail.getType())){
				detail.setType(getDictionaryName(fundS, Long.valueOf(detail.getType())));
			}
		}
		model.put("fund", detail);
		model.put("titles", questionService.findRiskTitleById(lvo.getUserType()));
		//附件
		List<FundFile> files = fundFileService.getFrontList(id);
		List<CuraFundFileVo> fs = new ArrayList<>();
		if(files != null){
			for(FundFile file: files){
				CuraFundFileVo f = new CuraFundFileVo();
				f.setName(file.getName());
				f.setSuffix(getSuffix(file.getUrl()));
				f.setPath(file.getUrl());
				fs.add(f);
			}
		}
		model.put("files", fs);
		List<FundAccount> fundAccounts=fundAccountService.getFrontList(id);
		model.put("fundAccounts", fundAccounts);
		return "/cura/product_details";
	}
	
	private String getSuffix(String url){
		if(StringUtils.isBlank(url) && url.lastIndexOf(".") ==-1){
			return "";
		}
		return url.substring(url.lastIndexOf(".")+1).toUpperCase();
	}
	
	/**
	 * 风险测评提交
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/risk/evaluation")
	@ResponseBody
	public RespBean evaluation(RiskEvaluationBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请先登录!");
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		bo.setUserSecondId(vo.getUserSecondId());
		Map<String,String> rt = new HashMap<>();
		questionService.addRiskEvaluation(bo,vo,rt);
		//更新
		vo.setRiskLevel(rt.get("riskLevelId"));
		vo.setRiskLevelName(rt.get("riskBear"));
		return success(rt);
	}
	
	@RequestMapping("/appointment")
	@ResponseBody
	public RespBean appointment(Long fundId,Long amount,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请先登录!");
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		UserApply apply = new UserApply();
		apply.setUserSecondId(vo.getUserSecondId());
		apply.setApplyMoney(amount);
		apply.setApplyStatus(""+67);//未确认
		Date now = new Date();
		apply.setCreateTime(now);
		apply.setUpdateTime(now);
		apply.setFundId(fundId);
		apply.setApplyWay(65);
		userApplyService.save(apply);
		//预约状态，客户等级->预约状态
		userApplyService.upgradeCustLevel(vo.getUserSecondId(), 2L);//预约客户
		return success();
	}
	
	
	
}
