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
	public List<List<String>> getTaskList(String fromDate, String toDate,String projectId){
		StringBuilder sql = new StringBuilder();
		List<String> values = new ArrayList();
		List<String> valueTypes = new ArrayList();
		List<List<String>> result = null;
		try{
			sql.append(" SELECT A.TASKID,                                                     ");
			sql.append(" A.CLIENTTASKID,                                                      ");
			sql.append(" A.TASKSTATUSIID,                                                     ");
			sql.append(" A.CREATEDBY,                                                         ");
			sql.append(" A.CREATIONDATE,                                                      ");
			sql.append(" (SELECT B.EMPID FROM EMPTASKMAPPINGDTLS B WHERE B.TASKID=A.TASKID)AS EMPLIST,  ");
			sql.append(" A.TASKDESCRIPTION FROM TASKMASTER A                                  ");
			sql.append(" WHERE PROJECTID = ?	                                              ");
			sql.append(" AND A.CREATIONDATE BETWEEN TO_DATE(?,'DD-MM-YYYY')            ");
			sql.append(" AND TO_DATE(?,'DD-MM-YYYY')                                     ");
			
			values.add(projectId);
			values.add(fromDate);
			values.add(toDate);
			
			valueTypes.add(GenericConstDef.DB_INT);
			valueTypes.add(GenericConstDef.DB_STRING);
			valueTypes.add(GenericConstDef.DB_STRING);
			
			
		}
		catch (Exception e) {
	
		}
		return result;
		}
	
	public List<List<String>> getTaskStatus(){

		String sql=null;
		List statusList=null;
		try{

		sql = "select TASKSTATUSIID,STATUSDESCRIPTION from TASKSTATUSMASTER";

		statusList = dbhelper.executeQuery(sql, null, null);

		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in generateEmployeeLogin() while executing the query:"+sql, "TimesSheetDomain.java");
		}
		return statusList;

	}
	
	public List<List<String>> getTaskDetails(String statusId)
	{
		StringBuffer sql=new StringBuffer();
		List taskDetails=null;
		List queryValues = null;
		List queryTypes = null;
		try{
			sql.append(" SELECT A.TASKID,						");
			sql.append(" A.TASKDESCRIPTION,						");
			sql.append(" B.STATUSDESCRIPTION					");
			sql.append(" FROM TASKMASTER A,						");
			sql.append(" TASKSTATUSMASTER B						");
			sql.append(" WHERE A.TASKSTATUSIID=B.TASKSTATUSIID	");
			
			if(!statusId.isEmpty())
			{
				sql.append("AND B.TASKSTATUSIID=?	");
			}
			queryValues=new ArrayList<>();
			if(!statusId.isEmpty())
			{
				queryValues.add(statusId);
			}
			
			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);
			taskDetails = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch(Exception e)
		{
			CustomLogger.exceptionJava(e, "Exception in getTaskDetails() while executing the query:"+sql, "TimesSheetDomain.java");
		}
		
		return taskDetails;
	}
}
