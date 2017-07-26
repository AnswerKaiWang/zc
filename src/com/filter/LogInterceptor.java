package com.filter;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.common.LogConfig;
import com.common.Principal;
import com.entity.SysLog;
import com.service.MemberService;
import com.service.SysLogService;
import com.util.IpUtil;


public class LogInterceptor extends HandlerInterceptorAdapter {

	private static final String[] DEFAULT_IGNORE_PARAMETERS = new String[] { "password", "rePassword", "currentPassword" };

	private static AntPathMatcher antPathMatcher = new AntPathMatcher();

	private String[] ignoreParameters = DEFAULT_IGNORE_PARAMETERS;

	@Resource(name = "sysLogServiceImpl")
	private SysLogService sysLogService;
	@Resource
	private MemberService memberService;

	
	@SuppressWarnings("unchecked")
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		List<LogConfig> logConfigs = sysLogService.getAll();
		if (logConfigs != null) {
			String path = request.getServletPath();
			for (LogConfig logConfig : logConfigs) {
				if (antPathMatcher.match(logConfig.getUrlPattern(), path)) {
					Principal principal= memberService.getPrincipal();
					String ip = IpUtil.getIpAddr(request);
					String name = logConfig.getName();
					StringBuffer parameter = new StringBuffer();
					Map<String, String[]> parameterMap = request.getParameterMap();
					if (parameterMap != null) {
						for (Entry<String, String[]> entry : parameterMap.entrySet()) {
							String parameterName = entry.getKey();
							if (!ArrayUtils.contains(ignoreParameters, parameterName)) {
								String[] parameterValues = entry.getValue();
								if (parameterValues != null) {
									for (String parameterValue : parameterValues) {
										parameter.append(parameterName + " = " + parameterValue + "\n");
									}
								}
							}
						}
					}
					SysLog log = new SysLog();
					log.setMemberId(principal==null?null:principal.getId());
					log.setCompanyId(principal==null?null:principal.getCompanyId());
					log.setMemberName(principal==null?"":principal.getUsername());
					log.setCompanyName(principal==null?"":principal.getCompanyName());
					log.setName(name);
					log.setContant(parameter.toString());
					log.setIp(ip);
					log.setCreateTime(new Date());
					log.setUpdateTime(log.getCreateTime());
					sysLogService.save(log);
					break;
				}
			}
		}
		Object o=request.getAttribute(SysLog.SYS_LOGS);
		if(o!=null){
			Principal principal= memberService.getPrincipal();
			String ip = IpUtil.getIpAddr(request);
			if(o instanceof SysLog){
				SysLog sysLog=(SysLog)o;
				sysLog.setMemberId(principal==null?null:principal.getId());
				sysLog.setCompanyId(principal==null?null:principal.getCompanyId());
				sysLog.setIp(ip);
				sysLog.setCreateTime(new Date());
				sysLog.setCompanyId(principal.getCompanyId());
				sysLog.setMemberName(principal==null?"":principal.getUsername());
				sysLog.setCompanyName(principal==null?"":principal.getCompanyName());
				sysLog.setUpdateTime(sysLog.getCreateTime());
				sysLogService.save(sysLog);
			}else{
				List<SysLog> list=(List<SysLog>) o;
				for (SysLog sysLog : list) {
					sysLog.setMemberId(principal==null?null:principal.getId());
					sysLog.setCompanyId(principal==null?null:principal.getCompanyId());
					sysLog.setMemberName(principal==null?"":principal.getUsername());
					sysLog.setCompanyName(principal==null?"":principal.getCompanyName());
					sysLog.setIp(ip);
					sysLog.setCreateTime(new Date());
					sysLog.setUpdateTime(sysLog.getCreateTime());
					sysLogService.save(sysLog);
				}
			}
		}
	}

	public String[] getIgnoreParameters() {
		return ignoreParameters;
	}

	public void setIgnoreParameters(String[] ignoreParameters) {
		this.ignoreParameters = ignoreParameters;
	}

}