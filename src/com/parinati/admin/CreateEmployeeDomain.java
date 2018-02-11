package com.parinati.admin;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.FileReadUtil;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;
import com.parinati.util.MailerUtil;

public class CreateEmployeeDomain {
	DBConnectionManager dbhelper = null;

	public CreateEmployeeDomain() {
		dbhelper = new DBConnectionManager();
	}

	public List generateEmployeeLogin(String candidateId, String doj, String roleId){

		StringBuilder sql = new StringBuilder();
		List values = new ArrayList();
		List valueTypes = new ArrayList();
		List totalQueryList =null;
		List totalValues = null;
		List totalTypes = null;
		List returnList = new ArrayList();

		try{
		sql.append("SELECT EMPID_SEQ.NEXTVAL FROM DUAL");

		List result = dbhelper.executeQuery(sql.toString(), null, null);

		int empId = Integer.parseInt(((ArrayList)result.get(0)).get(0).toString());

		sql = new StringBuilder();
		sql.append(" SELECT 			                    ");
		sql.append(" FNAME,                                 ");
		sql.append(" MNAME,                                 ");
		sql.append(" LNAME,                                 ");
		sql.append(" TO_CHAR(DOB,'DD-MM-YYYY'),             ");
		sql.append(" PHONE,                                 ");
		sql.append(" PERSONALEMAIL,                         ");
		sql.append(" QUALIFICATION,                         ");
		sql.append(" EXPERIENCEINYRS,                       ");
		sql.append(" SKILLS,                                ");
		sql.append(" PRESENTADD,                            ");
		sql.append(" ACHIEVEMENTS                           ");
		sql.append(" FROM CANDIDATEDTLS                     ");
		sql.append(" WHERE                                  ");
		sql.append(" CANDIDATEID = ?						");

		values = new ArrayList();
		values.add(candidateId);

		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_STRING);

		List candDetails = dbhelper.executeQuery(sql.toString(), values, valueTypes);

		String fName=(String)((ArrayList)candDetails.get(0)).get(0);
		String lName=GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(2));

		String proposedLogin = fName+"."+lName.charAt(0);
		proposedLogin=proposedLogin.toLowerCase();

		sql = new StringBuilder();
		sql.append(" SELECT COUNT(OFFICIALEMAIL) ");
		sql.append(" FROM EMPLOYEEDTLS           ");
		sql.append(" WHERE OFFICIALEMAIL LIKE(?) ");
		sql.append(" AND ISACTIVE = 'Y'			 ");

		values = new ArrayList();

		values.add(proposedLogin);

		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_STRING);

		result = dbhelper.executeQuery(sql.toString(), values, valueTypes);

		int count = Integer.parseInt(((ArrayList)result.get(0)).get(0).toString());
		String actualLogin;

		if(count>0)
			actualLogin = proposedLogin+(count+1)+"@parinati.in";
		else
			actualLogin = proposedLogin+"@parinati.in";

		totalQueryList = new ArrayList();

		sql = new StringBuilder();
		sql.append(" INSERT INTO EMPLOYEEDTLS( ");
		sql.append("    EMPID,                 ");
		sql.append("    FNAME,                 ");
		sql.append("    MNAME,                 ");
		sql.append("    LNAME,                 ");
		sql.append("    DOB,                   ");
		sql.append("    PHONE,                 ");
		sql.append("    OFFICIALEMAIL,         ");
		sql.append("    PERSONALEMAIL,         ");
		sql.append("    QUALIFICATION,         ");
		sql.append("    DOJ,                   ");
		sql.append("    EXPERIENCEINYRS,       ");
		sql.append("    SKILLS,                ");
		sql.append("    PRESENTADD,            ");
		sql.append("    ACHIEVEMENTS,          ");
		sql.append("    CANDIDATEID,           ");
		sql.append("    ISACTIVE )             ");
		sql.append("	VALUES (               ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   TO_DATE(?,'DD-MM-YYYY'),");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   TO_DATE(?,'DD-MM-YYYY'),");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?,                      ");
		sql.append("   ?	)                  ");

		totalQueryList.add(sql.toString());

		totalValues = new ArrayList();
		values = new ArrayList();
		values.add(empId);
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(0)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(1)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(2)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(3)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(4)));
		values.add(actualLogin);
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(5)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(6)));
		values.add(doj);
		values.add(Double.parseDouble((String)((ArrayList)candDetails.get(0)).get(7)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(8)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(9)));
		values.add(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(10)));
		values.add(candidateId);
		values.add("Y");

		totalValues.add(values);

		totalTypes = new ArrayList();

		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_INT);

		for (int i = 0; i < values.size()-1; i++) {
			if(i == 9)
				valueTypes.add(GenericConstDef.DB_DOUBLE);
			else
			 valueTypes.add(GenericConstDef.DB_STRING);
		}
		totalTypes.add(valueTypes);



		sql= new StringBuilder();
		sql.append(" INSERT INTO EMPROLEDTLS(    ");
		sql.append(" EMPID,                      ");
		sql.append(" ROLEID,                     ");
		sql.append(" CREATIONDATE,               ");
		sql.append(" CREATEDBY                   ");
		sql.append(" )                           ");
		sql.append(" VALUES(                     ");
		sql.append(" ?,                          ");
		sql.append(" ?,                          ");
		sql.append(" SYSDATE,                    ");
		sql.append(" 'ADMIN'                     ");
		sql.append(" )                           ");

		totalQueryList.add(sql.toString());

		values = new ArrayList();
		values.add(empId);
		values.add(Integer.parseInt(roleId));

		totalValues.add(values);

		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_INT);
		valueTypes.add(GenericConstDef.DB_INT);

		totalTypes.add(valueTypes);

		sql= new StringBuilder();
		sql.append(" INSERT INTO USERLOGIN     ");
		sql.append(" (EMPID,                   ");
		sql.append(" LOGINID,                  ");
		sql.append(" PASSWORD,                 ");
		sql.append(" CREATIONDATE,             ");
		sql.append(" CREATEDBY)                ");
		sql.append(" VALUES(                   ");
		sql.append(" ?,                        ");
		sql.append(" ?,                        ");
		sql.append(" ?,                        ");
		sql.append(" SYSDATE,                  ");
		sql.append(" 'ADMIN' )                 ");

		totalQueryList.add(sql.toString());

		values = new ArrayList();
		values.add(empId);
		values.add(actualLogin);
		values.add((GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(4))).replaceAll("/", ""));

		totalValues.add(values);

		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_INT);
		valueTypes.add(GenericConstDef.DB_STRING);
		valueTypes.add(GenericConstDef.DB_STRING);
		totalTypes.add(valueTypes);

		int res = dbhelper.prepStmtExecuteMultiple(totalQueryList, totalValues, totalTypes);
		//if success, welcome mail to be sent
		returnList.add(empId);
		returnList.add(actualLogin);


		//sending onboarding mail
		String mailTempPath = FileReadUtil.getValue("ONBOARDINGMAIL");
		String[] var = new String[3];
		var[0] = GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(0));
		var[1] = Integer.toString(empId);
		var[2] = actualLogin;

		new MailerUtil().postMailWithTLSAuth(GenericUtil.setValue((String)((ArrayList)candDetails.get(0)).get(5)), "Welcome to Parinati", mailTempPath, var);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in generateEmployeeLogin() while executing the query:"+sql.toString()+" values:"+
					values.toString()+"total:"+totalQueryList+" totalValues:"+totalValues, "CreateEmployeeDomain.java");
		}
		return returnList;

	}
	/**
	 * This method will fetch all the projects available
	 * @return
	 */
	public List<ArrayList> fetchProjectDetails(){

		StringBuffer sql = new StringBuffer();
		List rs = null;
		List queryValues = null;
		List queryTypes = null;
		try{
			sql.append("	SELECT					");
			sql.append("	    projectid,          ");
			sql.append("	    projectname         ");
			sql.append("	FROM                    ");
			sql.append("	    projectmaster       ");
			sql.append("	WHERE                   ");
			sql.append("	    isactive = 'Y'      ");

			rs = dbhelper.executeQuery(sql.toString(), null, null);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in fetchRecords() while executing the query:"+sql.toString(), "CreateUserDomain.java");
		}

		return rs;
	}

	/**
	 * This method fetch All the employees record
	 * @param inputParam
	 * @return
	 */
	public List<ArrayList> fetchEmployeeRecords(ArrayList inputParam){
		StringBuffer sql = new StringBuffer();
		List rs = null;
		List queryValues = null;
		List queryTypes = null;
		try{

			sql.append("	SELECT												");
			sql.append("	    ed.empid,                                       ");
			sql.append("	    ed.fname,                                       ");
			sql.append("	    ed.lname,                                       ");
			sql.append("	    ed.phone,                                       ");
			sql.append("	    ed.PANNO,                                       ");
			sql.append("	    ed.AADHARNO,                                    ");
			sql.append("	    ed.PASSPORTNO,                                  ");
			sql.append("	    ed.SKILLS,                                      ");
			sql.append("	    ed.ISACTIVE                                     ");
			sql.append("	FROM                                                ");
			sql.append("	    employeedtls ed                                 ");
			sql.append("	    JOIN emproledtls erd ON ed.empid = erd.empid    ");
			sql.append("	WHERE                                               ");

			if(!"".equalsIgnoreCase(inputParam.get(0).toString()) && "projectName".equalsIgnoreCase(inputParam.get(1).toString()))
				sql.append("	    erd.projectid = ?        ");
			else if(!"".equalsIgnoreCase(inputParam.get(0).toString()) && "name".equalsIgnoreCase(inputParam.get(1).toString()))
				sql.append("	    UPPER(FNAME)like ?    		");

			queryValues = new ArrayList<>();
			if(!"".equalsIgnoreCase(inputParam.get(0).toString()) && "projectName".equalsIgnoreCase(inputParam.get(1).toString()))
				queryValues.add(inputParam.get(0).toString());
			else if(!"".equalsIgnoreCase(inputParam.get(0).toString()) && "name".equalsIgnoreCase(inputParam.get(1).toString()))
				queryValues.add("%"+inputParam.get(0).toString().toUpperCase()+"%");

			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);

			rs = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in fetchRecords() while executing the query:"+sql.toString()+" values:"+queryValues.toString(), "CreateUserDomain.java");
		}

		return rs;

	}

	public int updateEmployeeDetails(List inputParam){

		StringBuilder sql = new StringBuilder();
		int rs=0;
		List queryValues = null;
		List queryTypes = null;
		try{
			sql.append("	UPDATE EMPLOYEEDTLS		");
			sql.append("	SET                     ");
			sql.append("	    PHONE =?,           ");
			sql.append("	    PANNO =?,           ");
			sql.append("	    AADHARNO =?,        ");
			sql.append("	    PASSPORTNO =?,      ");
			sql.append("	    SKILLS =?,          ");
			sql.append("	    ISACTIVE =?         ");
			sql.append("	WHERE                   ");
			sql.append("	EMPID =?                ");

			queryValues = new ArrayList<>();
			queryValues.add(inputParam.get(0));//phone
			queryValues.add(inputParam.get(1));//panno
			queryValues.add(inputParam.get(2));//aadharNo
			queryValues.add(inputParam.get(3));//passportNo
			queryValues.add(inputParam.get(4));//skills
			queryValues.add(inputParam.get(5));//isActive
			queryValues.add(inputParam.get(6));//empid


			queryTypes = new ArrayList<>();
			for(int i = 0; i<queryValues.size()-1;i++)
				queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_INT);


			rs = dbhelper.executeInsertUpdate(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in fetchRecords() while executing the query:"+sql.toString(), "CreateUserDomain.java");
		}

		return rs;
	}
}
