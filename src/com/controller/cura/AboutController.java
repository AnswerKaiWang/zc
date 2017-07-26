/**
 * 
 */
package com.controller.cura;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.controller.WebBaseController;

/**
 * @author	tyb
 * @date	2016年8月28日下午10:16:39
 * @desc	
 */
@Controller("curaAboutController")
@RequestMapping("/cura/about")
public class AboutController extends WebBaseController {
	
	@RequestMapping
	public String about(ModelMap model){
		
		return "/cura/about_zc";
	}
	
	@RequestMapping("/cf")
	public String cf(ModelMap model){
		return "/cura/about_cf";
	}
}
