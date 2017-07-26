/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.entity.QuestionAnswer;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日下午7:03:11
 * @desc	
 */
@Getter
@Setter
public class QuestionEditVo implements Serializable {
	private static final long serialVersionUID = -4133589099225495977L;
	private Long id;
	private String name;
    private Date startTime;
    private Date endTime;
    private Integer sort;//排行
    private Date createTime;
    private List<QuestionAnswer> answers = new ArrayList<>();
}
