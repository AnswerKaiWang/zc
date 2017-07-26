package com.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.ExpireVo;
import com.bo.SelectResultVo;
import com.bo.UserSecondComBo;
import com.bo.UserSecondComVo;
import com.bo.UserSecondPerBo;
import com.bo.UserSecondPerVo;
import com.bo.UserSecondPicPathVo;
import com.bo.UserSecondPicVO;
import com.bo.cura.LoginBo;
import com.bo.cura.LoginVo;
import com.common.Constant;
import com.common.Pager;
import com.entity.Dictionary;
import com.entity.Member;
import com.entity.UserSecond;
import com.entity.UserSecondAttr;
import com.entity.UserSecondCom;
import com.entity.UserSecondContant;
import com.entity.UserSecondPer;
import com.entity.UserSecondPic;
import com.entity.UserSecondPics;
import com.enums.UserType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.MemberMapper;
import com.mapper.UserSecondAttrMapper;
import com.mapper.UserSecondComMapper;
import com.mapper.UserSecondContantMapper;
import com.mapper.UserSecondMapper;
import com.mapper.UserSecondPerMapper;
import com.mapper.UserSecondPicMapper;
import com.mapper.UserSecondPicsMapper;
import com.service.UserSecondService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("userSecondServiceImpl")
public class UserSecondServiceImpl extends BaseServiceImpl<UserSecond> implements UserSecondService {

	@Autowired
	private UserSecondMapper userSecondMapper;
	@Autowired
	private UserSecondPerMapper userSecondPerMapper;
	@Autowired
	private UserSecondComMapper userSecondComMapper;
	@Autowired
	private UserSecondContantMapper userSecondContantMapper;
	@Autowired
	private UserSecondAttrMapper userSecondAttrMapper;
	@Autowired
	private UserSecondPicMapper userSecondPicMapper;
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private UserSecondPicsMapper userSecondPicsMapper;

	@Override
	public UserSecond getByUserNo(String userNo) {
		Example example = new Example(UserSecond.class);
		example.createCriteria().andEqualTo("userNo", userNo);
		List<UserSecond> dictionaries = userSecondMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries) ? null : dictionaries.get(0);
	}

	@Override
	@Transactional
	public void save(UserSecond userSecond, UserSecondPer userSecondPer, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic) {
		userSecondMapper.insert(userSecond);
		userSecondPer.setId(userSecond.getId());
		userSecondPerMapper.insert(userSecondPer);
		if (userSecondContant != null) {
			userSecondContant.setId(userSecond.getId());
			userSecondContantMapper.insert(userSecondContant);
		}
		if (userSecondAttr != null) {
			userSecondAttr.setId(userSecond.getId());
			userSecondAttrMapper.insert(userSecondAttr);
		}
//		if (userSecondPic != null) {
//			userSecondPic.setPicCreateTime(new Date());
//			userSecondPic.setCustId(userSecond.getId());
//			userSecondPicMapper.insert(userSecondPic);
//			if (StringUtils.isNotBlank(userSecondPic.getPicPath())) {
//				String[] pics = userSecondPic.getPicPath().split(",");
//				if (pics != null && pics.length > 0) {
//					for (String picPath : pics) {
//						if (StringUtils.isNotBlank(picPath)) {
//							UserSecondPics p = new UserSecondPics();
//							p.setPicId(userSecondPic.getId());
//							p.setPicPath(picPath);
//							p.setCreateTime(new Date());
//							p.setCreateTime(new Date());
//							p.setUpdateTime(new Date());
//							userSecondPicsMapper.insert(p);
//						}
//					}
//				}
//			}
//		}
	}

	@Override
	public Pager<UserSecondPerVo> getPerList(Pager<UserSecondPerVo> pager, UserSecondPerBo secondPerBo) {
		if (pager.getUsePager()) {
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserSecondPerVo> members = userSecondMapper.getPerList(pager, secondPerBo);
		for (UserSecondPerVo userSecondPerVo : members) {
			if (userSecondPerVo.getMemberId() != null) {
				Member member = memberMapper.selectByPrimaryKey(userSecondPerVo.getMemberId());
				if (member != null) {
					userSecondPerVo.setPerMemberName(member.getRealName());
				}
			}
		}
		pager.setRows(members);
		PageInfo<UserSecondPerVo> pageInfo = new PageInfo<UserSecondPerVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void update(UserSecond persistent, UserSecondPer userSecondPer, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic) {
		userSecondMapper.updateByPrimaryKey(persistent);
		userSecondPer.setId(persistent.getId());
		userSecondPerMapper.updateByPrimaryKey(userSecondPer);
		UserSecondContant contant = userSecondContantMapper.selectByPrimaryKey(persistent.getId());
		if (userSecondContant != null) {// 新增或更新
			userSecondContant.setId(persistent.getId());
			if (contant == null) {// 原来木有新增一个
				userSecondContantMapper.insert(userSecondContant);
			} else {// 原来有更新
				userSecondContantMapper.updateByPrimaryKey(userSecondContant);
			}
		} else {// 删除
			userSecondContantMapper.deleteByPrimaryKey(persistent.getId());
		}
		UserSecondAttr attr = userSecondAttrMapper.selectByPrimaryKey(persistent.getId());
		if (userSecondAttr != null) {// 新增或更新
			userSecondAttr.setId(persistent.getId());
			if (attr == null) {// 原来木有新增一个
				userSecondAttrMapper.insert(userSecondAttr);
			} else {// 原来有更新
				userSecondAttrMapper.updateByPrimaryKey(userSecondAttr);
			}
		} else {// 删除
			userSecondAttrMapper.deleteByPrimaryKey(persistent.getId());
		}
//		UserSecondPic secondPic = userSecondPicMapper.selectByPrimaryKey(persistent.getId());
//		if (userSecondPic != null) {// 新增或更新
//			userSecondPic.setId(persistent.getId());
//			if (secondPic == null) {// 原来木有新增一个
//				userSecondPic.setPicCreateTime(new Date());
//				userSecondPicMapper.insert(userSecondPic);
//			} else {// 原来有更新
//				userSecondPicMapper.updateByPrimaryKey(userSecondPic);
//			}
//		} else {// 删除
//			userSecondPicMapper.deleteByPrimaryKey(persistent.getId());
//		}
	}

	@Override
	@Transactional
	public void updateUserMember(Long[] ids, Long memberId) {
		for (Long long1 : ids) {
			UserSecond userSecond = userSecondMapper.selectByPrimaryKey(long1);
			if (userSecond != null) {
				userSecond.setMemberId(memberId);
				userSecondMapper.updateByPrimaryKey(userSecond);
			}
		}
	}

	@Override
	public Pager<UserSecondComVo> getComList(Pager<UserSecondComVo> pager, UserSecondComBo secondComBo) {
		if (pager.getUsePager()) {
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserSecondComVo> members = userSecondMapper.getComList(pager, secondComBo);
		for (UserSecondComVo userSecondPerVo : members) {
			if (userSecondPerVo.getMemberId() != null) {
				Member member = memberMapper.selectByPrimaryKey(userSecondPerVo.getMemberId());
				if (member != null) {
					userSecondPerVo.setPerMemberName(member.getRealName());
				}
			}
			if (userSecondPerVo.getFaCardTypeId() != null) {
				Dictionary dictionary = Constant.DICTIONARY_MAP.get(userSecondPerVo.getFaCardTypeId());
				if (dictionary != null) {
					userSecondPerVo.setFaCardTypeName(dictionary.getName());
				}
			}
		}
		pager.setRows(members);
		PageInfo<UserSecondComVo> pageInfo = new PageInfo<UserSecondComVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void save(UserSecond userSecond, UserSecondCom userSecondCom, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic) {
		userSecondMapper.insert(userSecond);
		userSecondCom.setId(userSecond.getId());
		userSecondComMapper.insert(userSecondCom);
		if (userSecondContant != null) {
			userSecondContant.setId(userSecond.getId());
			userSecondContantMapper.insert(userSecondContant);
		}
		if (userSecondAttr != null) {
			userSecondAttr.setId(userSecond.getId());
			userSecondAttrMapper.insert(userSecondAttr);
		}
//		if (userSecondPic != null) {
//			userSecondPic.setPicCreateTime(new Date());
//			userSecondPic.setCustId(userSecond.getId());
//			userSecondPic.setCreateTime(new Date());
//			userSecondPic.setUpdateTime(new Date());
//			userSecondPicMapper.insert(userSecondPic);
//			if (StringUtils.isNotBlank(userSecondPic.getPicPath())) {
//				String[] pics = userSecondPic.getPicPath().split(",");
//				if (pics != null && pics.length > 0) {
//					for (String picPath : pics) {
//						if (StringUtils.isNotBlank(picPath)) {
//							UserSecondPics p = new UserSecondPics();
//							p.setPicId(userSecondPic.getId());
//							p.setPicPath(picPath);
//							p.setCreateTime(new Date());
//							p.setCreateTime(new Date());
//							p.setUpdateTime(new Date());
//							userSecondPicsMapper.insert(p);
//						}
//					}
//				}
//			}
//		}

	}

	@Override
	@Transactional
	public void update(UserSecond persistent, UserSecondCom userSecondCom, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic) {
		userSecondMapper.updateByPrimaryKey(persistent);
		userSecondCom.setId(persistent.getId());
		userSecondComMapper.updateByPrimaryKey(userSecondCom);
		UserSecondContant contant = userSecondContantMapper.selectByPrimaryKey(persistent.getId());
		if (userSecondContant != null) {// 新增或更新
			userSecondContant.setId(persistent.getId());
			if (contant == null) {// 原来木有新增一个
				userSecondContantMapper.insert(userSecondContant);
			} else {// 原来有更新
				userSecondContantMapper.updateByPrimaryKey(userSecondContant);
			}
		} else {// 删除
			userSecondContantMapper.deleteByPrimaryKey(persistent.getId());
		}
		UserSecondAttr attr = userSecondAttrMapper.selectByPrimaryKey(persistent.getId());
		if (userSecondAttr != null) {// 新增或更新
			userSecondAttr.setId(persistent.getId());
			if (attr == null) {// 原来木有新增一个
				userSecondAttrMapper.insert(userSecondAttr);
			} else {// 原来有更新
				userSecondAttrMapper.updateByPrimaryKey(userSecondAttr);
			}
		} else {// 删除
			userSecondAttrMapper.deleteByPrimaryKey(persistent.getId());
		}
//		UserSecondPic secondPic = userSecondPicMapper.selectByPrimaryKey(persistent.getId());
//		if (userSecondPic != null) {// 新增或更新
//			userSecondPic.setId(persistent.getId());
//			if (secondPic == null) {// 原来木有新增一个
//				userSecondPic.setPicCreateTime(new Date());
//				userSecondPicMapper.insert(userSecondPic);
//			} else {// 原来有更新
//				userSecondPicMapper.updateByPrimaryKey(userSecondPic);
//			}
//		} else {// 删除
//			userSecondPicMapper.deleteByPrimaryKey(persistent.getId());
//		}
	}

	@Override
	public void save(UserSecondPic userSecondPic) {
		if (userSecondPic != null) {
			userSecondPic.setPicCreateTime(new Date());
			userSecondPic.setCustId(userSecondPic.getCustId());
			userSecondPic.setCreateTime(new Date());
			userSecondPic.setUpdateTime(new Date());
			userSecondPicMapper.insert(userSecondPic);
			if (StringUtils.isNotBlank(userSecondPic.getPicPath())) {
				String[] pics = userSecondPic.getPicPath().split(",");
				if (pics != null && pics.length > 0) {
					for (String picPath : pics) {
						if (StringUtils.isNotBlank(picPath)) {
							UserSecondPics p = new UserSecondPics();
							p.setPicId(userSecondPic.getId());
							p.setPicPath(picPath);
							p.setCreateTime(new Date());
							p.setCreateTime(new Date());
							p.setUpdateTime(new Date());
							userSecondPicsMapper.insert(p);
						}
					}
				}
			}
		}
	}

	@Override
	public void update(UserSecondPic userSecondPic) {
		UserSecondPicVO old = userSecondPicMapper.findById(userSecondPic.getId());
		if(old != null){//更新
			if (userSecondPic != null) {
				userSecondPicMapper.updatePic(userSecondPic);
				userSecondPicMapper.delPicsByPid(userSecondPic.getId());
				if (StringUtils.isNotBlank(userSecondPic.getPicPath())) {
					String[] pics = userSecondPic.getPicPath().split(",");
					if (pics != null && pics.length > 0) {
						for (String picPath : pics) {
							if (StringUtils.isNotBlank(picPath)) {
								UserSecondPics p = new UserSecondPics();
								p.setPicId(userSecondPic.getId());
								p.setPicPath(picPath);
								p.setCreateTime(new Date());
								p.setCreateTime(new Date());
								p.setUpdateTime(new Date());
								userSecondPicsMapper.insert(p);
							}
						}
					}
				}
			}
			List<UserSecondPicPathVo> files = old.getFiles();
			if(files != null && files.size()>0){
				for(UserSecondPicPathVo f: files){
					//物理删除？
					
				}
			}
		}
		
	}

	/**
	 * 规则：P/E00000 5位数
	 */
	@Override
	public String genNextNo(String type) {
		String rt = "";
		String maxNo = userSecondMapper.getLastestMaxNo(type);
		if (StringUtils.isBlank(maxNo)) {// 第一个
			if ("geren".equals(type)) {
				rt = "P00001";
			} else {
				rt = "E00001";
			}
		} else {
			String pre = maxNo.substring(0, 1);
			int num = Integer.valueOf(maxNo.substring(1));
			num = num + 1;
			String nums = String.valueOf(num);
			int len = nums.length();
			for (int i = 0; i < (5 - len); i++) {
				nums = "0" + nums;
			}
			rt = pre.toUpperCase() + nums;
		}
		return rt;
	}

	@Override
	public List<SelectResultVo> searchCustList(String keyword) {
		return userSecondMapper.searchCustList(keyword);
	}

	@Override
	public LoginVo findUserSecondByPhoneOrCardNo(LoginBo bo) {
		LoginVo rt = new LoginVo();
		List<LoginVo> users = new ArrayList<>();
		if(UserType.geren.toString().equals(bo.getType())){//个人
			users = userSecondMapper.findUserSecondPer(bo);
		}else{
			users = userSecondMapper.findUserSecondCom(bo);
		}
		if(CommonUtils.isEmpty(users)){
			rt.setMessage("用户不存在!");
		}else if(users.size()>1){
			rt.setMessage("存在多个用户");
		}else{
			rt = users.get(0);
		}
		if(rt.getEvaluationTime() != null){
			Date toDate = moveDate(rt.getEvaluationTime(), 3, Calendar.YEAR);
			Date now = new Date();
			if(now.after(toDate)){
				//过期
				rt.setExpired(1);//过期
			}
			rt.setEvaluationTime(toDate);//3年有效期
		}
		//客户等级
		if("geren".equals(rt.getUserType())){
			rt.setType(UserType.geren.getDescription()+"投资者");
		}else{
			rt.setType(UserType.qiye.getDescription()+"投资者");
		}
		//风险评价
		if(StringUtils.isNotBlank(rt.getRiskLevel())){
			rt.setRiskLevelName(userSecondMapper.getRiskBear(rt.getRiskLevel()));
		}
		return rt;
	}
	private Date moveDate(Date date, int offset, int unit){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(unit, offset);
		return c.getTime();
	}
	@Override
	public String getRiskBear(String riskLevel) {
		return userSecondMapper.getRiskBear(riskLevel);
	}

	@Override
	public boolean isRepeat(String cardNo) {
		List<Integer> nums = userSecondMapper.getCardNoCount(cardNo);
		if(nums != null && nums.size()>0){
			int count = 0;
			for(Integer n: nums){
				count += n;
			}
			if(count >0){
				return true;//已存在
			}
		}
		return false;
	}

	@Override
	public boolean isRepeat(String cardNo, Long userSecondId) {
		List<Integer> nums = userSecondMapper.getCardNoCountExclude(cardNo,userSecondId);
		if(nums != null && nums.size()>0){
			int count = 0;
			for(Integer n: nums){
				count += n;
			}
			if(count >0){
				return true;//已存在
			}
		}
		return false;
	}

	@Override
	public void resetPwd(Long id, String password) {
		userSecondMapper.resetPwd(id, password);
	}

	@Override
	public void resetPhone(Long id, String phone) {
		userSecondMapper.resetPerPhone(id, phone);
		userSecondMapper.resetComPhone(id, phone);
	}

	@Override
	public void resetEmail(Long id, String email) {
		userSecondMapper.resetPerEmail(id, email);
		userSecondMapper.resetComEmail(id, email);
	}

	@Override
	public boolean hadExist(Long id, String phone) {
		int p = userSecondMapper.getExistPerPhone(id, phone);
		int c = userSecondMapper.getExistComPhone(id, phone);
		if(p >0 || c >0){
			return true;
		}
		return false;
	}

	@Override
	public Pager<ExpireVo> getExpriedList(Pager<ExpireVo> pager, int expireDays) {
		if (pager.getUsePager()) {
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<ExpireVo> members = userSecondMapper.getExpriedList(expireDays);
		pager.setRows(members);
		PageInfo<ExpireVo> pageInfo = new PageInfo<ExpireVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public Pager<ExpireVo> getRiskExpriedList(Pager<ExpireVo> pager, int expireDays) {
		if (pager.getUsePager()) {
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<ExpireVo> members = userSecondMapper.getRiskExpriedList(expireDays);
		pager.setRows(members);
		PageInfo<ExpireVo> pageInfo = new PageInfo<ExpireVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public Pager<ExpireVo> getFundRecordExpriedList(Pager<ExpireVo> pager, int expireDays) {
		if (pager.getUsePager()) {
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<ExpireVo> members = userSecondMapper.getFundRecordExpriedList(expireDays);
		pager.setRows(members);
		PageInfo<ExpireVo> pageInfo = new PageInfo<ExpireVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	
	
}
