package com.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.controller.AdminBaseController;
import com.util.CommonUtils;

@Controller("adminFileUploadController")
@RequestMapping("/admin")
public class FileUploadController extends AdminBaseController{
     
	
	@RequestMapping("/fileUpload")
	@ResponseBody
	public Object fileUpload(MultipartFile file,HttpServletRequest request){
		Map<String, Object> map=new HashMap<>();
		String pa=request.getServletContext().getRealPath("/upload");
		String dateString=CommonUtils.nowDateToString("yyyyMMdd");
		File directdory=new File(pa+File.separator+dateString);
		if(!directdory.exists()){
			directdory.mkdirs();
		}
		String rr=file.getOriginalFilename();
		String fileName=System.currentTimeMillis()+rr.substring(rr.lastIndexOf("."),rr.length());
		try {
			file.transferTo(new File(pa+File.separator+dateString+File.separator+fileName));
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "11");
			return map;
		}
		
		map.put("status", "00");
		map.put("url", "/upload"+"/"+dateString+"/"+fileName);
		return map;
		
	}
	
	@RequestMapping("/upload")
	public void upload(MultipartFile file,HttpServletRequest request,HttpServletResponse resp) throws IOException{
		
		MultipartHttpServletRequest req = (MultipartHttpServletRequest) request;
		if(req!=null){
			CommonsMultipartFile mf = (CommonsMultipartFile) req.getFile("wangEditorH5File");
			if(mf!=null){
				String pa=request.getServletContext().getRealPath("/upload");
				String dateString=CommonUtils.nowDateToString("yyyyMMdd");
				File directdory=new File(pa+File.separator+dateString);
				if(!directdory.exists()){
					directdory.mkdirs();
				}
		        String fileName = mf.getFileItem().getName();// 文件名称
		        /**上传文件处理内容**/
//		        DiskFileItemFactory factory = new DiskFileItemFactory();
//		        ServletFileUpload sfu = new ServletFileUpload(factory);
//		        sfu.setHeaderEncoding("UTF-8"); // 处理中文问题
//		        sfu.setSizeMax(1024 * 1024); // 限制文件大小
//		        try {
//		            List<FileItem> fileItems = sfu.parseRequest(request); // 解码请求
//		            for (FileItem fi : fileItems) {
//		                fi.write(new File(pa, pa+File.separator+dateString+File.separator+fileName));
//		            }
//		        } catch (Exception e) {
//		            e.printStackTrace();
//		        }
		        FileOutputStream fos = new FileOutputStream(new File(pa+File.separator+dateString+File.separator+fileName));
				IOUtils.write(mf.getFileItem().get(), fos);
				IOUtils.closeQuietly(fos);
				String path ="/zc/upload"+"/"+dateString+"/"+fileName;
				resp.setContentType("text/text;charset=utf-8");
		        PrintWriter out = resp.getWriter();
		        out.print(path);  //返回url地址
		        out.flush();
		        out.close();
			}
		}
	}
	
	public static void main(String[] args) {
		String s="中城投资首页(登录).jpg";
		System.out.println(s.lastIndexOf("."));
		System.out.println(s.substring(0,s.lastIndexOf("."))+UUID.randomUUID().toString()+s.substring(s.lastIndexOf("."),s.length()));
	}
}
