package com.controller.web;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.controller.WebBaseController;
import com.entity.CompanyAttr;
import com.entity.Help;
import com.entity.User;
import com.service.CompanyAttrService;
import com.service.HelpService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.util.CommonUtils;

@Controller("webIndexController")
public class IndexController extends WebBaseController{

	@Resource
	private CompanyAttrService companyAttrService;
	@Resource
	private HelpService helpService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,ModelMap modelMap,String needLogin){
		Long companyId=currentCompany(request);
		if(companyId==14){//进入二期网站
			return curaIndex(request, modelMap, needLogin);
		}
		List<CompanyAttr> firstPicHrefs=companyAttrService.getLikeName(companyId, "firstPicHref");
		modelMap.put("firstPicHrefs", firstPicHrefs);
		if(!CommonUtils.isEmpty(needLogin)&&request.getSession().getAttribute(User.SESSION_USER)==null){
			modelMap.put("needLogin", "true");
		}
		return "web/index";
	}
	
	private String curaIndex(HttpServletRequest request,ModelMap modelMap,String needLogin){
		
		return "cura/index";
	}
	
	
	@RequestMapping("/common/error")
	public String error(HttpServletRequest request,ModelMap modelMap){
		return "web/error";
	}
	@RequestMapping("/security")
	public String security(HttpServletRequest request,ModelMap modelMap){
		return "web/security";
	}
	@RequestMapping("/about")
	public String about(HttpServletRequest request,ModelMap modelMap){
		return "web/about";
	}
	@RequestMapping("/help")
	public String help(ModelMap modelMap,String type,HttpServletRequest request){
		if(CommonUtils.isNotEmpty(type)){
			try {
				type=new String(type.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
			}
		}
		List<String> types=helpService.getTypeByGroup();
		modelMap.put("types",types );
		if(CommonUtils.isEmpty(type)&&CommonUtils.isNotEmpty(types)){
			List<Help> helps=helpService.getFrontList(types.get(0),currentCompany(request));
			modelMap.put("helps", helps);
			modelMap.put("type", types.get(0));
		}
		if(CommonUtils.isNotEmpty(type)&&CommonUtils.isNotEmpty(types)){
			List<Help> helps=helpService.getFrontList(type,currentCompany(request));
			modelMap.put("helps", helps);
			modelMap.put("type", type);
		}
		return "web/help";
	}
	
	@RequestMapping("/loginImage")
	public String loginImage(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
		response.setContentType("image/jepg");
		BufferedImage image = new BufferedImage(40, 15,
				BufferedImage.TYPE_INT_RGB);
		Graphics graphics = image.getGraphics();
		Random random = new Random();
		graphics.setColor(new Color(218, 184, 102));

		graphics.fillRect(0, 0, 40, 15);
		graphics.setColor(new Color(255, 255, 255));
		graphics.drawLine(random.nextInt(60), random.nextInt(20),
				random.nextInt(60), random.nextInt(20));
		graphics.drawLine(random.nextInt(60), random.nextInt(20),
				random.nextInt(60), random.nextInt(20));
		String number = String.valueOf(random.nextInt(99999));
		HttpSession session = request.getSession();
		session.setAttribute("loginImage", number);
		graphics.setColor(new Color(255, 255, 255));
		graphics.drawString(number, 2, 12);
		graphics.drawString(number, 3, 12);
		JPEGImageEncoder encoder;
		try {
			encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
			encoder.encode(image);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return null;
	}
}
