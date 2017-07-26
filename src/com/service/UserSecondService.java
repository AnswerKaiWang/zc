package com.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.ExpireVo;
import com.bo.SelectResultVo;
import com.bo.UserSecondComBo;
import com.bo.UserSecondComVo;
import com.bo.UserSecondPerBo;
import com.bo.UserSecondPerVo;
import com.bo.cura.LoginBo;
import com.bo.cura.LoginVo;
import com.common.Pager;
import com.entity.UserSecond;
import com.entity.UserSecondAttr;
import com.entity.UserSecondCom;
import com.entity.UserSecondContant;
import com.entity.UserSecondPer;
import com.entity.UserSecondPic;

public interface UserSecondService extends BaseService<UserSecond>{

	UserSecond getByUserNo(String userNo);

	void save(UserSecond userSecond, UserSecondPer userSecondPer, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic);

	Pager<UserSecondPerVo> getPerList(Pager<UserSecondPerVo> pager, UserSecondPerBo secondPerBo);

	void update(UserSecond persistent, UserSecondPer userSecondPer, UserSecondContant userSecondContant,UserSecondAttr userSecondAttr, UserSecondPic userSecondPic);

	void updateUserMember(Long[] ids, Long memberId);

	void save(UserSecond userSecond, UserSecondCom userSecondCom, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic);

	Pager<UserSecondComVo> getComList(Pager<UserSecondComVo> pager, UserSecondComBo secondComBo);

	void update(UserSecond persistent, UserSecondCom userSecondCom, UserSecondContant userSecondContant,
			UserSecondAttr userSecondAttr, UserSecondPic userSecondPic);
	
	/**
	 * 获得下一个编号
	 * @param type
	 * @return
	 */
	String genNextNo(String type);
	
	/**
	 * 添加图片
	 * @param pic
	 */
	void save(UserSecondPic pic);
	/**
	 * 修改
	 * @param pic
	 */
	void update(UserSecondPic pic);
	/**
	 * 搜索记过
	 * @param keyword
	 * @return
	 */
	List<SelectResultVo> searchCustList(String keyword);
	
	
	LoginVo findUserSecondByPhoneOrCardNo(LoginBo bo);
	
	String getRiskBear(@Param("riskLevel")String riskLevel);
	/**
	 * 判断机构证件是否重复
	 * @param cardNo
	 * @return true:已存在；false:不存在
	 */
	boolean isRepeat(String cardNo);
	/**
	 * 是否重复：其他人是否已有
	 * @param cardNo
	 * @param userSecondId
	 * @return
	 */
	boolean isRepeat(String cardNo, Long userSecondId);
	
	void resetPwd(Long id, String password);
	
	void resetPhone(Long id, String phone);
	
	void resetEmail(Long id, String email);
	
	boolean hadExist(Long id, String phone);
	
	/**
	 * 到期提醒 客户证件到期
	 * @param pager
	 * @param expireDays 距离到期还有多少天
	 * @return
	 */
	Pager<ExpireVo> getExpriedList(Pager<ExpireVo> pager, int expireDays);
	/**
	 * 风险测评到期提醒
	 * @param pager
	 * @param expireDays
	 * @return
	 */
	Pager<ExpireVo> getRiskExpriedList(Pager<ExpireVo> pager, int expireDays);
	/**
	 * 产品纪要到期提醒
	 * @param pager
	 * @param expireDays
	 * @return
	 */
	Pager<ExpireVo> getFundRecordExpriedList(Pager<ExpireVo> pager, int expireDays);
}
