package com.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.entity.User;

public class LoginFilter  extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		if(request.getSession().getAttribute(User.SESSION_USER)==null){
			response.sendRedirect(request.getContextPath()+"/index.htm?needLogin=true");
		}else{
			filterChain.doFilter(request, response);;
		}
	}

}
