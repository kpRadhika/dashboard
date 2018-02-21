package com.parinati.timesheet;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;

public class TimesSheetDomain {
	
	DBConnectionManager dbhelper = null;

	public TimesSheetDomain() {
		dbhelper = new DBConnectionManager();
	}

	public List<ArrayList> fetchEmployeeByProject(String projectId){
		List<ArrayList> rs = null;
		StringBuilder sql = new StringBuilder();
		try{
			sql.append("SELECT ER.EMPID,	");
			sql.append("ED.FNAME,			");
			sql.append("ED.LNAME			");
			sql.append("FROM EMPROLEDTLS ER, ");	
			sql.append("EMPLOYEEDTLS ED		");
			sql.append("WHERE				");
			sql.append("ED.EMPID = ER.EMPID	");
			
			rs = dbhelper.executeQuery(sql.toString(), null, null);
		}
		catch(Exception e){
			CustomLogger.exceptionJava(e, "Exception in fetchEmployeeByProject() while executing the query:"+sql.toString(), "TimesSheetDomain.java");
		}
		return rs;
	}
}
