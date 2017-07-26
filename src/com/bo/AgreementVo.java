/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.entity.AgreementFile;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月29日下午2:27:58
 * @desc	列表列
 */
@Getter
@Setter
public class AgreementVo implements Serializable {

	private static final long serialVersionUID = -8030865894068395583L;
	private Long id;
	private String managerName	;
	private String manager;
	private Long fundId;
	private String fundName;
	private String startTime;//产品成立日
	private String endTime;//产品到期日
	private String userSecondId;
	private String custName;
	private String custNo;//证件号
	private String ano;//合同编号
	private Integer astatus;//合同状态；正常；作废
	private String remark;
	
	private List<AgreementFile> files = new ArrayList<>();
}
