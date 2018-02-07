package com.parinati.util;

import java.io.*;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter {

	private ArrayList<String> urlList;

	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String url = request.getServletPath();

		if (!urlList.contains(url)) {
			HttpSession session = request.getSession(false);
			String user = null;

			if (session != null) {
					user = (String) session.getAttribute("userID");
			}

			if (session == null || user == null) {
					RequestDispatcher view = request.getRequestDispatcher("Logout.jsp");
					view.forward(request, response);
					return;
			}
		}

		chain.doFilter(req, res);
	}

	public void init(FilterConfig config) throws ServletException {

		String urls = config.getInitParameter("avoid-urls");
		StringTokenizer token = new StringTokenizer(urls, ",");
		urlList = new ArrayList<String>();

		while (token.hasMoreTokens()) {
			urlList.add(token.nextToken());

		}
	}
}
