/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.entity.LectureVedio;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日上午8:58:59
 * @desc	
 */
@Getter
@Setter
public class LectureSaveBo implements Serializable {

	private static final long serialVersionUID = -5192776461340348816L;
	
	private Long id;
	private String title;
	private String brief;
	private String lastestTime;//最后更新时间
	private String cover;//封面
	private Integer recStatus;//推荐状态，1：推荐；0：不推荐
	private List<LectureVedio> vedios = new ArrayList<>();
}
