package com.parinati.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class DBConnectionManager {
	private static final String DB_DRIVER;
	private static final String DB_CONNECTION;
	private static final String DB_USER;
	private static final String DB_PASSWORD;

	Connection dbConnection;
	public Statement smt;
	public String ip;

	static {
		Properties props = new Properties();

		try {
			props.load(DBConnectionManager.class.getClassLoader().getResourceAsStream("db.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		DB_DRIVER = props.getProperty("driver");
		DB_USER = props.getProperty("db_user");
		DB_PASSWORD = props.getProperty("db_pass");
		DB_CONNECTION = props.getProperty("jdbcURL");

	}

	public DBConnectionManager() {
		//getDBConnection();
	}

	private void getDBConnection() {
		try {
			Class.forName(DB_DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		}
		try {
			dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void closeConnection(Connection conn) {
		if (conn == null)
			return;
		try {
			conn.close();
			conn = null;
		} catch (Exception e) {
			//Add logger here
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				//Add logger here
			}
		}
	}
	
	private void closePStmt(PreparedStatement pstmt) {
		if (pstmt == null)
			return;
		try {
			pstmt.close();
			pstmt = null;
		} catch (Exception e) {
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				CustomLogger.exceptionJava(e, "Exception in closePStmt()", "DBConnectionManager.java");
			}
		}
	}
	
	private void setAutoCommitFalse() {
		getDBConnection();
		try {
			dbConnection.setAutoCommit(false);
		} catch (java.sql.SQLException e) {
			CustomLogger.exceptionJava(e, "Exception in setAutoCommitFalse()", "DBConnectionManager.java");
		}
	}
	
	private PreparedStatement setValues(PreparedStatement pstmt,List prepValues, List prepDataType) {
		try{
		for (int i = 0; i < prepValues.size(); i++) {
			String dataType = (String) prepDataType.get(i);
		
			if (dataType.equals("DB_STRING")) {
				pstmt.setString(i + 1, (String) prepValues.get(i));
			} else if (dataType.equals("DB_DOUBLE")) {
				pstmt.setDouble(i + 1, (double)prepValues.get(i));
			} else if (dataType.equals("DB_INT")) {
				pstmt.setInt(i + 1, (int) prepValues.get(i));
			}
			else if (dataType.equals("DB_LONG")) {
				pstmt.setLong(i + 1, (long)prepValues.get(i));
			} else if (dataType.equals("DB_DATE")) {
				Timestamp timestamp = null;
				Date parsedDate = null;
				SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss a z");
				parsedDate = dateFormat.parse(prepValues.get(i).toString());
				timestamp = new java.sql.Timestamp(parsedDate.getTime());
				pstmt.setTimestamp(i + 1, timestamp);
			}
		}
		}catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in setValues()", "DBConnectionManager.java");
		}
		return pstmt;
	}
	public List<ArrayList> executeQuery(String sql, List prepValues, List<String> prepDataType){
		ResultSet rs = null;
		List<ArrayList> result =null;
		PreparedStatement pstmt = null;
		getDBConnection();
		try{
		pstmt = dbConnection.prepareStatement(sql);
		if(prepValues != null && prepDataType != null)
		pstmt = setValues(pstmt,prepValues,prepDataType);
		
		rs = pstmt.executeQuery();
		result = getResultList(rs);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in executeQuery()", "DBConnectionManager.java");
		}
		finally{
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			closePStmt(pstmt);
			pstmt = null;
			closeConnection(dbConnection);
			dbConnection = null;
		}
		return result;
	}

	public List getResultList(ResultSet rs){
		List result = new ArrayList();
		try{
		while (rs.next()) {
			ResultSetMetaData rsmd = rs.getMetaData();

			int columnCount = rsmd.getColumnCount();
			List list = new ArrayList(columnCount);

			for (int i = 1; i <= columnCount; i++) {
				if(rsmd.getColumnTypeName(i).equalsIgnoreCase("DASHBOARD.EMPLIST"))
					list.add(rs.getArray(i));
				else
				list.add(rs.getString(i));
			}
			result.add(list);
		}
		}catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in getResultList()", "DBConnectionManager.java");
		}
		return result;
	}
	
	public int executeInsertUpdate(String sql, List queryValues, List queryTypes){
		int updateCount = 0;
		PreparedStatement pstmt = null;
		try{
			getDBConnection();
			pstmt = dbConnection.prepareStatement(sql);
			pstmt = setValues(pstmt,queryValues,queryTypes);
			
			updateCount = pstmt.executeUpdate();

			if (updateCount == 0) {

				updateCount = -1;
			}
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in executeInsertUpdate()", "DBConnectionManager.java");
		}
		 finally {
			closePStmt(pstmt);
			pstmt = null;
			closeConnection(dbConnection);
			dbConnection = null;
		}
		return updateCount;
	}

	public int prepStmtExecuteMultiple(List sqlList, List prepValues, List prepDataType) throws Exception {

		PreparedStatement pstmt = null;
		int listsize = sqlList.size();
		String sqlQuery = null;
		String variableValue = null;
		String dataType = null;
		int updateCount = 0;
		try {
			setAutoCommitFalse();

			for (int d = 0; d < listsize; d++) {

				sqlQuery = sqlList.get(d).toString();
				pstmt = dbConnection.prepareStatement(sqlQuery);

				ArrayList queryValues = (ArrayList) prepValues.get(d);
				ArrayList prepData = (ArrayList) prepDataType.get(d);

				pstmt = setValues(pstmt, queryValues, prepData);
				
				updateCount = pstmt.executeUpdate();
				pstmt.close();

				if (updateCount == 0) {
					updateCount = -1;
					dbConnection.rollback();
					break;
				} else {
					updateCount = 1;
				}
			}
			dbConnection.commit();
		} catch (SQLException e) {
			CustomLogger.exceptionJava(e, "Exception in prepStmtExecuteMultiple()", "DBConnectionManager.java");
			dbConnection.rollback();
			updateCount = -1;
			throw new SQLException(e.getMessage());
		} finally {
			closePStmt(pstmt);
			pstmt = null;
			closeConnection(dbConnection);
			dbConnection = null;
		}
		return updateCount;
	}
}
