package com.parinati.timesheet;

import java.util.ArrayList;
import java.util.Iterator;
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
	public List<ArrayList> getTaskList(String fromDate, String toDate,int projectId){
		StringBuilder sql = null;
		List values = new ArrayList();
		List<String> valueTypes = new ArrayList();
		List<ArrayList> result = null;
		try{
			sql = new StringBuilder();
			sql.append(" SELECT TASKID,                                                     ");
			sql.append(" CLIENTTASKID,                                                      ");
			sql.append(" TASKSTATUSIID,                                                     ");
			sql.append(" CREATEDBY,                                                         ");
			sql.append(" TO_CHAR(CREATIONDATE,'DD-MM-YYYY'),                                ");
			sql.append(" GETEMPLOYEESBYTASK(TASKID),                                        ");
			sql.append(" TASKDESCRIPTION FROM TASKMASTER                                    ");
			sql.append(" WHERE PROJECTID = ?	                                            ");
			sql.append(" AND CREATIONDATE BETWEEN TO_DATE(?,'DD-MM-YYYY')            		");
			sql.append(" AND TO_DATE(?,'DD-MM-YYYY')                                     	");
			
			values.add(projectId);
			values.add(fromDate);
			values.add(toDate);
			
			valueTypes.add(GenericConstDef.DB_INT);
			valueTypes.add(GenericConstDef.DB_STRING);
			valueTypes.add(GenericConstDef.DB_STRING);
			
			result = dbhelper.executeQuery(sql.toString(), values, valueTypes);
			
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
	
	public List<List<String>> getTaskDetails(String statusId,String userLogin)
	{
		StringBuffer sql=null;
		List taskDetails=null;
		List queryValues = null;
		List queryTypes = null;
		List empIdList=null;
		String empId=null;
		try{
			sql = new StringBuffer();
			
			sql.append(" SELECT EMPID                                  ");
			sql.append(" FROM USERLOGIN                                ");
			sql.append(" WHERE LOGINID=?                                ");
			
			queryValues=new ArrayList<>();
			
			queryValues.add(userLogin);
			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);
			
			empIdList = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
			
			Iterator<List<String>> itr=empIdList.listIterator();
			while (itr.hasNext()) {
				empId=itr.next().get(0);
			}
			
			sql = new StringBuffer();
			
			sql.append(" SELECT A.TASKID,						");	
			sql.append(" A.TASKDESCRIPTION,						");	
			sql.append("B.STATUSDESCRIPTION,					");
			sql.append(" C.EMPID,								");
			sql.append(" B.TASKSTATUSIID						");
			sql.append(" FROM TASKMASTER A,						");		
			sql.append("TASKSTATUSMASTER B,						");
			sql.append("EMPTASKMAPPINGDTLS c					");
			sql.append(" WHERE A.TASKSTATUSIID=B.TASKSTATUSIID	");
			sql.append("AND A.TASKID=C.TASKID					");
			sql.append(" AND C.EMPID=?							");
			
			if(!statusId.isEmpty())
				sql.append("AND B.TASKSTATUSIID=?	");
			queryValues=new ArrayList<>();
			queryValues.add(empId);
			
			if(!statusId.isEmpty())
				queryValues.add(statusId);
			
			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);
			if(!statusId.isEmpty())
			queryTypes.add(GenericConstDef.DB_STRING);
			taskDetails = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch(Exception e)
		{
			CustomLogger.exceptionJava(e, "Exception in getTaskDetails() while executing the query:"+sql, "TimesSheetDomain.java");
		}
		
		return taskDetails;
	}
	public int insertTaskDetails(List<String> inpuList)
	{
		int result=0;
		List totalQueries = new ArrayList<>();
		List totalValues = new ArrayList<>();
		List totalValueTypes = new ArrayList<>();
		List queryValues = null;
		List queryTypes = null;
		String empId=inpuList.get(0)==null?"":inpuList.get(0).toString();
		String taskId=inpuList.get(1)==null?"":inpuList.get(1).toString();
		String fromDate=inpuList.get(2)==null?"":inpuList.get(2).toString();
		String toDate=inpuList.get(3)==null?"":inpuList.get(3).toString();
		String status=inpuList.get(4)==null?"":inpuList.get(4).toString();
		StringBuffer sql=new StringBuffer();
		List taskDetails=null;
		try{
			sql.append(" INSERT INTO TIMESHEETENTRY	(				");
			sql.append(" EMPID,TASKID,FROMTIME,TOTIME)				");
			sql.append("  VALUES(									");
			sql.append(" 		?	,								");
			sql.append(" 		?	,								");
			sql.append(" 		TO_TIMESTAMP(?,'dd-MM-yyyy HH24:mi'),  	");
			sql.append(" 		TO_TIMESTAMP(?,'dd-MM-yyyy HH24:mi')	)	");
			queryValues=new ArrayList<>();
			queryValues.add(empId);
			queryValues.add(taskId);
			queryValues.add(fromDate);
			queryValues.add(toDate);
			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);
			totalQueries.add(sql.toString());
			totalValues.add(queryValues);
			totalValueTypes.add(queryTypes);
			StringBuffer sql1=new StringBuffer();
			sql1.append(" UPDATE TASKMASTER SET TASKSTATUSIID = ? ");
			sql1.append(" WHERE TASKID = ? 								");
			queryValues=new ArrayList<>();
			queryValues.add(status);
			queryValues.add(taskId);
			queryTypes = new ArrayList<>();
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);
			totalQueries.add(sql1.toString());
			totalValues.add(queryValues);
			totalValueTypes.add(queryTypes);
			result = dbhelper.prepStmtExecuteMultiple(totalQueries, totalValues, totalValueTypes);
		}
		catch(Exception e)
		{
			CustomLogger.exceptionJava(e, "Exception in getTaskDetails() while executing the query:"+sql, "TimesSheetDomain.java");
		}
		return result;
	}
}
