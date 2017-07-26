package com.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.CustFileBo;
import com.bo.CustFileVo;
import com.bo.SelectResultVo;
import com.bo.UserSecondComBo;
import com.bo.UserSecondComVo;
import com.bo.UserSecondPerBo;
import com.bo.UserSecondPerVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Member;
import com.entity.UserSecond;
import com.entity.UserSecondAttr;
import com.entity.UserSecondCom;
import com.entity.UserSecondContant;
import com.entity.UserSecondPer;
import com.entity.UserSecondPic;
import com.enums.MemberType;
import com.enums.Status;
import com.enums.UserType;
import com.service.DictionaryService;
import com.service.MemberService;
import com.service.UserSecondAttrService;
import com.service.UserSecondComService;
import com.service.UserSecondContantService;
import com.service.UserSecondPerService;
import com.service.UserSecondPicService;
import com.service.UserSecondService;
import com.util.CommonUtils;
import com.util.JsonUtils;

@Controller("adminUserSecondController")
@RequestMapping("/admin/userSecond")
public class UserSecondController extends AdminBaseController{

	@Resource
	private MemberService memberService;
	@Resource
	private DictionaryService dictionaryService;
	@Resource
	private UserSecondService userSecondService;
	@Resource
	private UserSecondPerService userSecondPerService;
	@Resource
	private UserSecondComService userSecondComService;
	@Resource
	private UserSecondContantService userSecondContantService;
	@Resource
	private UserSecondAttrService userSecondAttrService;
	@Resource
	private UserSecondPicService userSecondPicService;
	
	@RequestMapping("/per/toList")
	public String toPerList(ModelMap map){
		map.put("status", Status.values());
		
		List<Member> members = memberService.getByMemberType(MemberType.caifuguwen, null);
		Member m = getCurrentMember();
		if(m != null && m.getType() != null){
			if(m.getType().toString().equals(MemberType.caifuguwen.toString())){
				if(members != null){
					members.clear();
					members.add(m);
				}
			}
		}
		map.put("members",members);
		return "/cms/userSecond/perList";
	}
	@RequestMapping("/per/list")
	@ResponseBody
	public Object list(Pager<UserSecondPerVo> pager,UserSecondPerBo secondPerBo){
		secondPerBo.setUserType(UserType.geren);
		Member m = getCurrentMember();
		if(m != null && m.getType() != null){
			if(m.getType().toString().equals(MemberType.caifuguwen.toString())){
				secondPerBo.setMemberId(m.getId());
			}
		}
		pager=userSecondService.getPerList(pager,secondPerBo);
		return pager;
	}
	@RequestMapping("/per/add")
	public String add(ModelMap modelMap){
		return "/cms/userSecond/perAdd";
	}
	
	@RequestMapping("/per/card")
	public String card(ModelMap modelMap,Long id){
		modelMap.put("userSecondPic", userSecondPicService.get(id));
		return "/cms/userSecond/perCard";
	}
	
	@RequestMapping("/per/openUploadPer")
	public String edit(ModelMap modelMap){
		return "cms/userSecond/uploadPer";
	}
	
	@RequestMapping("/per/save")
	@ResponseBody
	public Object save(UserSecond userSecond,UserSecondPer userSecondPer,UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr,UserSecondPic userSecondPic,Boolean useContant){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(userSecondPer.getPerCardNo())){
			map.put("error","证件号码必填");
			return map;
		}
		if(CommonUtils.isEmpty(userSecondPer.getPerName())){
			map.put("error","姓名必填");
			return map;
		}
		if(CommonUtils.isNotEmpty(userSecond.getUserNo())){
			UserSecond uu=userSecondService.getByUserNo(userSecond.getUserNo());
			if(uu!=null){
				map.put("error","客户编号重复");
				return map;	
			}
		}
		
		UserSecondPer te=userSecondPerService.getByCardNo(userSecondPer.getPerCardNo());
		if(te!=null){
			map.put("error","证件号码存在");
			return map;
		}
		te=userSecondPerService.getByPhone(userSecondPer.getPerPhone());
		if(te!=null){
			map.put("error","电话号码存在");
			return map;
		}
		if(CommonUtils.isNotEmpty(userSecondPer.getPerEmail())){
		te=userSecondPerService.getByEmail(userSecondPer.getPerEmail());
		if(te!=null){
			map.put("error","email存在");
			return map;
		}
		}
		if(CommonUtils.isEmpty(userSecond.getUserNo())){
			userSecond.setUserNo(System.currentTimeMillis()+"");
		}
		userSecond.setUserNo(userSecondService.genNextNo("geren"));
		userSecond.setUserType(UserType.geren);
		userSecond.setName(userSecondPer.getPerName());
		userSecond.setCreateTime(new Date());
		userSecond.setUpdateTime(new Date());
			//userSecondContant=null;
		userSecondService.save(userSecond,userSecondPer,userSecondContant,userSecondAttr,userSecondPic);
		map.put("error","00");
		return map;
	}
	
	/**
	 * 个人客户文件附件
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/per/file/toList")
	public String fileList(ModelMap modelMap){
		return "/cms/userSecond/custFileList";
	}
	
	/**
	 * 添加附件
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/per/file/add")
	public String fileAdd(ModelMap modelMap,Long custId){
		modelMap.put("custId", custId);
		return "/cms/userSecond/custFileAdd";
	}
	/**
	 * 编辑
	 * @param modelMap
	 * @param id 图片类型ID
	 * @return
	 */
	@RequestMapping("/per/file/edit")
	public String fileEdit(ModelMap modelMap,Long id){
		modelMap.put("userSecondPic", userSecondPicService.findById(id));
		return "/cms/userSecond/custFileEdit";
	}
	
	@RequestMapping("/per/file/update")
	@ResponseBody
	public Map<String, Object> fileUpdate(ModelMap modelMap, UserSecondPic pic){
		Map<String, Object> map=new HashMap<>();
		userSecondService.update(pic);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/per/file/save")
	@ResponseBody
	public Map<String, Object> fileSave(ModelMap modelMap, UserSecondPic pic){
		Map<String, Object> map=new HashMap<>();
		userSecondService.save(pic);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/per/file/list")
	@ResponseBody
	public Object list(Pager<CustFileVo> pager,CustFileBo bo){
		pager=userSecondPerService.getList(pager,bo);
		return pager;
	}
	
	
	
	
	@RequestMapping("/per/edit")
	public String perEdit(ModelMap modelMap,Long id){
		UserSecond userSecond= userSecondService.get(id);
		modelMap.put("userSecond",userSecond);
		modelMap.put("userSecondPer", userSecondPerService.get(id));
		modelMap.put("userSecondContant", userSecondContantService.get(id));
		modelMap.put("userSecondAttr", userSecondAttrService.get(id));
		modelMap.put("userSecondPic", userSecondPicService.get(id));
		modelMap.put("userSecondPics", userSecondPicService.findByCustId(id));
		modelMap.put("member", memberService.get(userSecond.getMemberId()));
		return "/cms/userSecond/perEdit";
	}
	@RequestMapping("/per/update")
	@ResponseBody
	public Object perUpdate(UserSecond userSecond,UserSecondPer userSecondPer,UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr,Boolean useContant,UserSecondPic userSecondPic){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(userSecondPer.getPerCardNo())){
			map.put("error","证件号码必填");
			return map;
		}
		if(CommonUtils.isEmpty(userSecondPer.getPerName())){
			map.put("error","姓名必填");
			return map;
		}
		if(CommonUtils.isNotEmpty(userSecond.getUserNo())){
			UserSecond uu=userSecondService.getByUserNo(userSecond.getUserNo());
			if(uu!=null&&!uu.getId().equals(userSecond.getId())){
				map.put("error","客户编号重复");
				return map;	
			}
		}
		UserSecondPer te=userSecondPerService.getByCardNo(userSecondPer.getPerCardNo());
		if(te!=null&&!te.getId().equals(userSecond.getId())){
			map.put("error","证件号码存在");
			return map;
		}
		te=userSecondPerService.getByPhone(userSecondPer.getPerPhone());
		if(te!=null&&!te.getId().equals(userSecond.getId())){
			map.put("error","电话号码存在");
			return map;
		}
		if(CommonUtils.isNotEmpty(userSecondPer.getPerEmail())){
			te=userSecondPerService.getByEmail(userSecondPer.getPerEmail());
			if(te!=null&&!te.getId().equals(userSecond.getId())){
				map.put("error","email存在");
				return map;
			}
		}
		UserSecond persistent=userSecondService.get(userSecond.getId());
		if(CommonUtils.isEmpty(userSecond.getUserNo())){
			userSecond.setUserNo(System.currentTimeMillis()+"");
		}
		userSecond.setUserType(UserType.geren);
		userSecond.setName(userSecondPer.getPerName());
		userSecond.setUpdateTime(new Date());
		BeanUtils.copyProperties(userSecond, persistent, new String[]{"memberId","createTime","password"});
		userSecondService.update(persistent,userSecondPer,userSecondContant,userSecondAttr,userSecondPic);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/com/toList")
	public String toComList(ModelMap map){
		map.put("status", Status.values());
		return "/cms/userSecond/comList";
	}
	@RequestMapping("/com/list")
	@ResponseBody
	public Object comList(Pager<UserSecondComVo> pager,UserSecondComBo secondComBo){
		secondComBo.setUserType(UserType.qiye);
		Member m = getCurrentMember();
		if(m != null && m.getType() != null){
			if(m.getType().toString().equals(MemberType.caifuguwen.toString())){
				secondComBo.setMemberId(m.getId());
			}
		}
		pager=userSecondService.getComList(pager,secondComBo);
		return pager;
	}
	@RequestMapping("/com/add")
	public String comAdd(ModelMap modelMap){
		return "/cms/userSecond/comAdd";
	}
	@RequestMapping("/com/save")
	@ResponseBody
	public Object comSave(UserSecond userSecond,UserSecondCom userSecondCom,UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr,UserSecondPic userSecondPic,boolean useContant){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(userSecondCom.getZhizhao())){
			map.put("error","营业执照必填");
			return map;
		}
		if(CommonUtils.isEmpty(userSecondCom.getFaCardNo())){
			//map.put("error","法人证件号");
			//return map;
		}
		if(CommonUtils.isEmpty(userSecondCom.getFaName())){
			//map.put("error","法人姓名必填");
			//return map;
		}
		if(CommonUtils.isNotEmpty(userSecond.getUserNo())){
			UserSecond uu=userSecondService.getByUserNo(userSecond.getUserNo());
			if(uu!=null){
				map.put("error","客户编号重复");
				return map;	
			}
		}
		UserSecondCom te=userSecondComService.getByZhizhao(userSecondCom.getZhizhao());
		if(te!=null){
			map.put("error","营业执照存在");
			return map;
		}
		if(CommonUtils.isEmpty(userSecond.getUserNo())){
			userSecond.setUserNo(System.currentTimeMillis()+"");
		}
		userSecond.setUserNo(userSecondService.genNextNo("qiye"));
		userSecond.setUserType(UserType.qiye);
		userSecond.setCreateTime(new Date());
		userSecond.setUpdateTime(new Date());
		if(!useContant){
			userSecondContant=null;
		}
		userSecondService.save(userSecond,userSecondCom,userSecondContant,userSecondAttr,userSecondPic);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/com/edit")
	public String comEdit(ModelMap modelMap,Long id){
		UserSecond userSecond= userSecondService.get(id);
		modelMap.put("userSecond", userSecondService.get(id));
		modelMap.put("userSecondCom", userSecondComService.get(id));
		modelMap.put("userSecondContant", userSecondContantService.get(id));
		modelMap.put("userSecondAttr", userSecondAttrService.get(id));
		//modelMap.put("userSecondPic", userSecondPicService.get(id));
		modelMap.put("userSecondPics", userSecondPicService.findByCustId(id));
		modelMap.put("member", memberService.get(userSecond.getMemberId()));
		return "/cms/userSecond/comEdit";
	}
	@RequestMapping("/com/update")
	@ResponseBody
	public Object comUpdate(UserSecond userSecond,UserSecondCom userSecondCom,UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr,UserSecondPic userSecondPic,boolean useContant){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(userSecondCom.getZhizhao())){
			map.put("error","营业执照必填");
			return map;
		}
		if(CommonUtils.isEmpty(userSecondCom.getFaCardNo())){
			//map.put("error","法人证件号");
			//return map;
		}
		if(CommonUtils.isEmpty(userSecondCom.getFaName())){
			//map.put("error","法人姓名必填");
			//return map;
		}
		if(CommonUtils.isNotEmpty(userSecond.getUserNo())){
			UserSecond uu=userSecondService.getByUserNo(userSecond.getUserNo());
			if(uu!=null&&!uu.getId().equals(userSecond.getId())){
				map.put("error","客户编号重复");
				return map;	
			}
		}
		UserSecondCom te=userSecondComService.getByZhizhao(userSecondCom.getZhizhao());
		if(te!=null&&!te.getId().equals(userSecond.getId())){
			map.put("error","营业执照存在");
			return map;
		}
		UserSecond persistent=userSecondService.get(userSecond.getId());
		if(CommonUtils.isEmpty(userSecond.getUserNo())){
			userSecond.setUserNo(System.currentTimeMillis()+"");
		}
		userSecond.setUserType(UserType.qiye);
		userSecond.setUpdateTime(new Date());
		BeanUtils.copyProperties(userSecond, persistent, new String[]{"memberId","createTime","password"});
		if(!useContant){
			userSecondContant=null;
		}
		userSecondService.update(persistent,userSecondCom,userSecondContant,userSecondAttr,userSecondPic);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/editMember")
	public String editMember(ModelMap modelMap,Long[] ids,String type){
		modelMap.put("ids", JsonUtils.toJson(ids));
		modelMap.put("type", type);
		return "/cms/userSecond/editMember";
	}
	@RequestMapping("/updateUserMember")
	@ResponseBody
	public Map<String, Object> updateUserMember(Long[] ids,Long memberId,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		userSecondService.updateUserMember(ids,memberId);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStatus(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		UserSecond user=userSecondService.get(id);
		if(Status.finish.equals(user.getStatus())){
			user.setStatus(Status.use);
		}else{
			user.setStatus(Status.finish);
		}
		user.setUpdateTime(new Date());
		userSecondService.update(user);
		map.put("error","00");
		return map;
	}
	@RequestMapping("/updatePassword")
	@ResponseBody
	public Map<String, Object> updatePassword(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		UserSecond user=userSecondService.get(id);
		String password=CommonUtils.createRandomForSms(8);
		user.setPassword(DigestUtils.md5Hex(password));
		user.setUpdateTime(new Date());
		userSecondService.update(user);
		map.put("error","00");
		map.put("msg",password);
		return map;
	}
	/**
	 * 客户查询
	 * @param search
	 * @return
	 */
	@RequestMapping("/searchCustList")
	@ResponseBody
	public Object searchMemberList(String search){
		//查询用户，并通过姓名和账号做模糊匹配
		List<SelectResultVo> rts = userSecondService.searchCustList(search);
		List<Map<String, Object>> objects=new ArrayList<>();
		for (SelectResultVo fund : rts) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", fund.getId());
			map.put("text", fund.getName());
			objects.add(map);
		}
		return objects;
	}
}
