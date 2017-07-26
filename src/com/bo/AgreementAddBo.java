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
 * @date	2016年8月29日下午2:53:53
 * @desc	
 */
@Getter
@Setter
public class AgreementAddBo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long id;
	private Long fundId;
	private Long userSecondId;
	private String ano;
	private Integer astatus;
	private String remark;
	
	private List<AgreementFile> files = new ArrayList<>();
}
