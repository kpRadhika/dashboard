package com.parinati.admin;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;

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
		
		/*sql= new StringBuilder();
		sql.append(" UPDATE EMPONBOARDINGTRACKER    ");
		sql.append(" SET STEPID = 2,                ");
		sql.append(" MODIFIEDDATE = SYSDATE         ");
		sql.append(" WHERE CANDIDATEID = ?          ");
		
		totalQueryList.add(sql.toString());	
		
		values = new ArrayList();
		values.add(candidateId);
		totalValues.add(values);
		
		valueTypes = new ArrayList();
		valueTypes.add(GenericConstDef.DB_STRING);
		
		totalTypes.add(valueTypes);*/
		
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
		
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in generateEmployeeLogin() while executing the query:"+sql.toString()+" values:"+
					values.toString()+"total:"+totalQueryList+" totalValues:"+totalValues, "CreateEmployeeDomain.java");
		}
		return returnList;		
		
	}
}
