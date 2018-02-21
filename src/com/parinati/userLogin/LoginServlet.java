package com.parinati.userLogin;

import java.io.IOException;
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

		/*DBConnectionManager dbhelper = null;
		ResultSet rs = null;

		try {

			dbhelper = new DBConnectionManager();
			String qry = "SELECT LOGINID,password FROM USERLOGIN WHERE LOGINID= ? and password= ?";

			PreparedStatement psmt = dbhelper.dbConnection.prepareStatement(qry);

			psmt.setString(1, request.getParameter("userId"));
			psmt.setString(2, request.getParameter("userPassword"));

			rs = psmt.executeQuery();*/
		try {
			request.getSession().invalidate();
			HttpSession session = request.getSession(true);
			response.setHeader( "Set-Cookie", "JSESSIONID="+session.getId());

	         response.addHeader("Pragma", "No-cache");
	         response.setHeader("Cache-Control", "no-cache");
		  response.setHeader("Cache-Control", "no-store");
	         response.setDateHeader("Expires",0);
			List result = new LoginDomain().validateUser(request.getParameter("userId").trim(), request.getParameter("userPassword").trim());

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
