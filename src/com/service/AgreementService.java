/**
 * 
 */
package com.service;

import com.bo.AgreementAddBo;
import com.bo.AgreementBo;
import com.bo.AgreementVo;
import com.common.Pager;

/**
 * @author	tyb
 * @date	2016年8月29日下午3:01:23
 * @desc	
 */
public interface AgreementService {
	
	
	Pager<AgreementVo> getList(Pager<AgreementVo> pager, AgreementBo bo);
	
	void saveAgreement(AgreementAddBo bo);
	
	AgreementVo findDetailById(Long id);
	
	void updateAgreement(AgreementAddBo bo);
}
