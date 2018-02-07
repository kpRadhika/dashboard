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
			List result = new LoginDomain().validateUser(request.getParameter("userId").trim(), request.getParameter("userPassword").trim());

			if (result!=null && !result.isEmpty()) {

				request.getSession().setAttribute("userID", ((ArrayList)result.get(0)).get(0));
				request.getSession().setAttribute("password", ((ArrayList)result.get(0)).get(1));
				request.getSession().setAttribute("role", ((ArrayList)result.get(0)).get(2));
				request.getRequestDispatcher("/login/LoginHome.jsp").forward(request,
						response);

			} else {
				request.getRequestDispatcher("/Login.jsp?result='failure'")
						.forward(request, response);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
