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
 * @date	2016年8月27日下午6:26:10
 * @desc	
 */
@Getter
@Setter
public class QuestionAddBo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long id;
	private String name;
	private Integer type;
    private Date startTime;
    private Date endTime;
    private Integer sort;//排行
    private Date createTime;
    private Long qtId;
    private List<QuestionAnswer> answers = new ArrayList<>();
}
