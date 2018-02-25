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
	
	public int createTask(List<String> inputList){
		String taskDes = inputList.get(0);
		String clientId = inputList.get(1);
		String projectId = inputList.get(2);
		String resources = inputList.get(3);
		String remarks = inputList.get(4);
		String user = inputList.get(5);
		String[] resourceList = resources.split(",");
		int res = -1;
		
		StringBuilder sql = new StringBuilder();
		List totalQueries = new ArrayList<>();
		List totalValues = new ArrayList<>();
		List totalValueTypes = new ArrayList<>();
		List valueTypes = null;
		List values = null;
		
		try{
		
		sql.append("SELECT TASKID_SEQ.NEXTVAL FROM DUAL");
		
		List result = dbhelper.executeQuery(sql.toString(), null, null);

		int taskId = Integer.parseInt(((ArrayList)result.get(0)).get(0).toString());
		
		sql = new StringBuilder();
		
		sql.append(" INSERT INTO TASKMASTER( ");
		sql.append(" TASKID,                 ");
		sql.append(" PROJECTID,              ");
		sql.append(" CLIENTTASKID,           ");
		sql.append(" TASKSTATUSIID,          ");
		sql.append(" REMARKS,                ");
		sql.append(" CREATEDBY,              ");
		sql.append(" CREATIONDATE,           ");
		sql.append(" TASKDESCRIPTION         ");
		sql.append(" )VALUES(                ");
		sql.append(" ?, 		             ");
		sql.append(" ?,			             ");
		sql.append(" ?,				         ");
		sql.append(" ?,				         ");
		sql.append(" ?,		                 ");
		sql.append(" ?,			             ");
		sql.append(" SYSDATE, 		         ");
		sql.append(" ?				         ");
		sql.append(" )                       ");

		values = new ArrayList();

		values.add(taskId);
		values.add(projectId);
		values.add(clientId);
		values.add(2);
		values.add(remarks);
		values.add(user);
		values.add(taskDes);
		
		valueTypes = new ArrayList<>();
		for(int i=0;i<values.size();i++){
			if(i==3||i==0)
				valueTypes.add(GenericConstDef.DB_INT);
			else
				valueTypes.add(GenericConstDef.DB_STRING);
		}
		
		totalQueries.add(sql.toString());
		totalValues.add(values);
		totalValueTypes.add(valueTypes);
		
		for(String resourceId: resourceList){
		sql = new StringBuilder();
		sql.append(" INSERT INTO EMPTASKMAPPINGDTLS(  ");
		sql.append(" TASKID,                          ");
		sql.append(" EMPID,                           ");
		sql.append(" CREATIONDATE,                    ");
		sql.append(" CREATEDBY)                       ");
		sql.append(" VALUES(                          ");
		sql.append(" ?,		                          ");
		sql.append(" ?,		                          ");
		sql.append(" SYSDATE,                         ");
		sql.append(" ?)			                      ");
		
		values = new ArrayList<>();
		values.add(taskId);
		values.add(Integer.parseInt(resourceId));
		values.add(user);
		
		valueTypes = new ArrayList<>();
		valueTypes.add(GenericConstDef.DB_INT);
		valueTypes.add(GenericConstDef.DB_INT);
		valueTypes.add(GenericConstDef.DB_STRING);
		
		totalQueries.add(sql.toString());
		totalValues.add(values);
		totalValueTypes.add(valueTypes);		
		}
		res = dbhelper.prepStmtExecuteMultiple(totalQueries, totalValues, totalValueTypes);
		if(res>0){
			res = taskId;
		}
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in createTask() while executing the query:"+totalQueries.toString()+" values:"+
					totalValues.toString(), "TimesSheetDomain.java");
		}
		return res;
	}
	public List<List<String>> getTaskList(String fromDate, String toDate){
		StringBuilder sql = new StringBuilder();
		List<String> values = null;
		List<String> valueTypes = null;
		List<List<String>> result = null;
		try{
			
		}
		catch (Exception e) {
	
		}
		return result;
		}
}
