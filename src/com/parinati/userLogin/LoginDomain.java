package com.parinati.userLogin;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;

public class LoginDomain {
	DBConnectionManager dbhelper = null;

	public LoginDomain() {
		dbhelper = new DBConnectionManager();
	}

	@SuppressWarnings("unchecked")
	public List<List<String>> validateUser(String userId, String pass){

		List rs = null;
		StringBuilder query = new StringBuilder();
		List prepValues = new ArrayList();
		try{
		query.append("SELECT UL.LOGINID,UL.PASSWORD,ERD.ROLEID ");
		query.append("FROM USERLOGIN UL, EMPROLEDTLS ERD ");
		query.append("WHERE UL.EMPID = ERD.EMPID ");
		query.append("AND LOGINID= ? ");
		query.append("AND PASSWORD= ?");


		prepValues.add(userId);
		prepValues.add(pass);

		List<String> prepTypes = new ArrayList();
		prepTypes.add(GenericConstDef.DB_STRING);
		prepTypes.add(GenericConstDef.DB_STRING);

		rs = dbhelper.executeQuery(query.toString(), prepValues, prepTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception occured in findToolsByRole():: query:"+query.toString()+" values:"+prepValues.toString(), "LoginDomain.java");
		}
		return rs;

	}

	public List<ArrayList> findToolsByRole(int roleId, String Category)  {

		List queryValues = new ArrayList<>();
		List<String> queryTypes = new ArrayList();
		List<ArrayList> result = null;
		StringBuilder sql = new StringBuilder();
		try{
		sql.append("SELECT FUNCTIONNAME, 	");
		sql.append("FUNCTIONURL 	 		");
		sql.append("FROM FUNCTIONMAPTBL 	");
		sql.append("WHERE ROLEID=?			");//Change query here
		sql.append("AND CATEGORY=?			");
		sql.append("AND ISACTIVE=?			");


		queryValues.add(roleId);
		queryValues.add(Category);
		queryValues.add("Y");

		queryTypes.add(GenericConstDef.DB_INT);
		queryTypes.add(GenericConstDef.DB_STRING);
		queryTypes.add(GenericConstDef.DB_STRING);

		result = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception occured in findToolsByRole():: query:"+sql.toString()+" values:"+queryValues.toString(), "LoginDomain.java");
		}

		return result;
	}

	public List findCategories(int roleId){
		List queryValues = new ArrayList<>();
		List<String> queryTypes = new ArrayList();
		List<ArrayList> result = null;
		StringBuilder sql = new StringBuilder();
		try{
		sql.append("SELECT CATEGORY		 	");
		sql.append("FROM TOOLCATEGORYMAP 	");
		sql.append("WHERE ROLEID=?			");//Change query here


		queryValues.add(roleId);

		queryTypes.add(GenericConstDef.DB_INT);

		result = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception occured in findToolsByRole():: query:"+sql.toString()+" values:"+queryValues.toString(), "LoginDomain.java");
		}

		return result;
	}

	/**
	 *
	 * @param inputParam
	 * @return
	 */
	public int updatePasswordDetails(List inputParam){

		StringBuilder sql = new StringBuilder();
		int rs=0;
		List queryValues = null;
		List queryTypes = null;
		try{
			sql.append("	UPDATE USERLOGIN						");
			sql.append("	SET                                     ");
			sql.append("	    PASSWORD =?,                        ");
			sql.append("	    MODIFIEDDATE = sysdate,             ");
			sql.append("	    MODIFIEDBY = 'Forgot Password Tool' ");
			sql.append("	WHERE                                   ");
			sql.append("	LOGINID =?                              ");

			queryValues=new ArrayList();
			queryValues.add(inputParam.get(1));
			queryValues.add(inputParam.get(0));

			queryTypes=new ArrayList();
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);

			rs = dbhelper.executeInsertUpdate(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in updateEmployeeDetails() while executing the query:"+sql.toString(), "CreateUserDomain.java");
		}

		return rs;
	}

}
