package com.parinati.userLogin;

import java.io.IOException;
import java.security.KeyPair;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.parinati.util.DBConnectionManager;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			//request.getSession().invalidate(); //need to check
			HttpSession session = request.getSession(true);
			response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId());

	         response.addHeader("Pragma", "No-cache");
	         response.setHeader("Cache-Control", "no-cache");
		  response.setHeader("Cache-Control", "no-store");
	         response.setDateHeader("Expires",0);
	         KeyPair keys = (KeyPair) request.getSession(true).getAttribute("keys");
	         
	         String userId=JCryptionUtil.decrypt(request.getParameter("userId").trim(), keys);
	         String password=JCryptionUtil.decrypt(request.getParameter("userPassword").trim(), keys);
			List result = new LoginDomain().validateUser(userId.trim(), password.trim());

			if (result!=null && !result.isEmpty()) {

				session.setAttribute("userID", ((ArrayList)result.get(0)).get(0));
				session.setAttribute("password", ((ArrayList)result.get(0)).get(1));
				session.setAttribute("role", ((ArrayList)result.get(0)).get(2));
				request.getRequestDispatcher("/login/LoginHome.jsp").forward(request,
						response);

			} else {
				request.getRequestDispatcher("/index.jsp?result='failure'")
						.forward(request, response);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
