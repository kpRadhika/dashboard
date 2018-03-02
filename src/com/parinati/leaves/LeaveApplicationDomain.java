package com.parinati.leaves;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;

public class LeaveApplicationDomain {
	DBConnectionManager dbhelper = null;
	public LeaveApplicationDomain(){
		dbhelper = new DBConnectionManager();
	}
	
	public List<ArrayList> fetchLeaveTypes(){
		List<ArrayList> rs = null;
		StringBuilder sql = new StringBuilder();
		try{
			sql.append(" SELECT LEAVETYPEID,    ");
			sql.append(" LEAVETYPE              ");
			sql.append(" FROM LEAVETYPEMASTER   ");
			
			rs = dbhelper.executeQuery(sql.toString(), null, null);
		}
		catch (Exception e) {
			
		}
		return rs;
	}
	public int submitLeaveForApproval(List valueList){
		int retVal = 0;
		StringBuilder sql = null;
		List values = null;
		List valueTypes = null;
		try{
			sql = new StringBuilder();
			sql.append(" SELECT                              ");
			sql.append(" A.EMPID,                            ");
			sql.append(" B.PROJECTLEADID                     ");
			sql.append(" FROM                                ");
			sql.append(" USERLOGIN A,                        ");
			sql.append(" EMPROLEDTLS C,                      ");
			sql.append(" PROJECTMASTER B                     ");
			sql.append(" WHERE                               ");
			sql.append(" A.EMPID = C.EMPID                   ");
			sql.append(" AND   C.PROJECTID = B.PROJECTID     ");
			sql.append(" AND   A.LOGINID = ?                 ");
			
			values = new ArrayList<>();			
			values.add(valueList.get(0));
			
			valueTypes = new ArrayList<>();
			valueTypes.add(GenericConstDef.DB_INT);
			
			List rs = dbhelper.executeQuery(sql.toString(), values, valueTypes);
			
			((ArrayList)rs.get(0)).get(0);
			
		}
		catch (Exception e) {
			
		}
		return retVal;
	}
}
