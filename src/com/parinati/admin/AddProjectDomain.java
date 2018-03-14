package com.parinati.admin;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;

public class AddProjectDomain
{

	DBConnectionManager dbhelper = null;

	public AddProjectDomain() {
		dbhelper = new DBConnectionManager();
	}

	public int insertProjectDtls(List inputParam){

		StringBuilder sql = new StringBuilder();
		List queryValues  = null;
		List<String> queryTypes  = null;
		int result = 0;
		String projectId = null;
		try{
			sql.append("SELECT PROJECT_SEQ.NEXTVAL FROM DUAL");

			List<ArrayList>rs = dbhelper.executeQuery(sql.toString(), null, null);

			if(rs != null && !rs.isEmpty()){
				projectId = (String)((ArrayList)rs.get(0)).get(0);

			sql = new StringBuilder();

			sql.append("	INSERT INTO PROJECTMASTER (		");
			sql.append("				    PROJECTID,      ");
			sql.append("				    PROJECTNAME,    ");
			sql.append("				    PROJECTLOC,     ");
			sql.append("				    ISACTIVE,       ");
			sql.append("				    TECHNOLOGY,     ");
		    sql.append("	                CREATIONDATE,   ");
		    sql.append("	                CREATEDBY       ");
			sql.append("				) VALUES (          ");
			sql.append("				    ?,              ");
			sql.append("				    ?,              ");
			sql.append("				    ?,              ");
			sql.append("				    ?,              ");
			sql.append("				    ?,              ");
		    sql.append("	                SYSDATE,        ");
		    sql.append("	                'ADMIN'         ");
			sql.append("				)                   ");

			queryValues = new ArrayList<>();
			queryValues.add(projectId);
			queryValues.add(inputParam.get(0).toString());
			queryValues.add(inputParam.get(2).toString());
			queryValues.add("Y");
			queryValues.add(inputParam.get(1).toString());

			queryTypes = new ArrayList<>();
			for(int i = 0; i<queryValues.size(); i++){
				queryTypes.add(GenericConstDef.DB_STRING);
			}
			result = dbhelper.executeInsertUpdate(sql.toString(), queryValues, queryTypes);
			}
		}
		catch(Exception e){
			result = -1;
			CustomLogger.exceptionJava(e, "Exception in insertProjectDtls() while executing the query:"+sql.toString()+" values:"+queryValues.toString(), "AddProjectDomain.java");
		}
			return result;

	}

	public List<List<ArrayList>> fetchProjectDetails(String projectId){
		List<List<ArrayList>> rs = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		try{
			sql.append(" SELECT PROJECTLOC,				");
			sql.append(" TECHNOLOGY  FROM      			");
			sql.append(" PROJECTMASTER     				");
			sql.append(" WHERE PROJECTID=?      		");

			List values = new ArrayList();
			values.add(Integer.parseInt(projectId));

			List valueTypes = new ArrayList();
			valueTypes.add(GenericConstDef.DB_INT);

			List result1 = dbhelper.executeQuery(sql.toString(), values, valueTypes);
			
			sql = new StringBuilder();
			sql.append(" SELECT                         ");
			sql.append("     ED.EMPID,                 ");
			sql.append("     ED.FNAME                   ");
			sql.append("     || ' '                     ");
			sql.append("     || ED.LNAME                ");
			sql.append(" FROM                           ");
			sql.append("     EMPLOYEEDTLS ED,            ");
			sql.append(" 	PROJECTMASTER   PM  				");
			sql.append("     WHERE ED.EMPID = PM.PROJECTLEADID       ");
			sql.append("     AND   PM.PROJECTID = ?    ");
			
			List result2 = dbhelper.executeQuery(sql.toString(), values, valueTypes);
			
			String leadId = null;
			if(result2!=null && !result2.isEmpty()){
				leadId = GenericUtil.setValue((String)result1.get(2));
			}
			sql = new StringBuilder();

			sql.append(" SELECT                         ");
			sql.append("     ERD.EMPID,                 ");
			sql.append("     ED.FNAME                   ");
			sql.append("     || ' '                     ");
			sql.append("     || ED.LNAME                ");
			sql.append(" FROM                           ");
			sql.append("     EMPROLEDTLS ERD,           ");
			sql.append("     EMPLOYEEDTLS ED            ");
			sql.append(" WHERE                          ");
			sql.append("     ERD.EMPID = ED.EMPID       ");
			sql.append("     AND   ERD.ROLEID = 3       ");
			sql.append("     AND   ERD.PROJECTID = ?    ");
			if(leadId != null && !leadId.isEmpty()){
			sql.append("     AND   EMPID NOT IN(?)    	");
			
			
				values.add(Integer.parseInt(leadId));
				valueTypes.add(GenericConstDef.DB_INT);
			}
			List result3 = dbhelper.executeQuery(sql.toString(), values, valueTypes);

			rs.add(result1);
			rs.add(result2);
			rs.add(result3);
		}
		catch(Exception e){
			CustomLogger.exceptionJava(e, "Exception in fetchEmployeeByProject() while executing the query:"+sql.toString(), "AddProjectDomain.java");
		}
		return rs;
	}
public int updateProjectDtls(List input){
	StringBuilder sql = new StringBuilder();
	int result = -1;
	try{	
	sql.append(" UPDATE PROJECTMASTER	");
	sql.append(" SET 					");
	sql.append(" PROJECTLOC = ?,        ");
	sql.append(" TECHNOLOGY = ?,        ");
	sql.append(" PROJECTLEADID = ?      ");
	sql.append(" WHERE PROJECTID = ?    ");
	
	List<String> queryTypes = new ArrayList<>();
	
		queryTypes.add(GenericConstDef.DB_STRING);
		queryTypes.add(GenericConstDef.DB_STRING);
		queryTypes.add(GenericConstDef.DB_INT);
		queryTypes.add(GenericConstDef.DB_INT);
	
	result = dbhelper.executeInsertUpdate(sql.toString(), input, queryTypes);
	
}catch (Exception e) {
	CustomLogger.exceptionJava(e, "Exception in updateProjectDtls() while executing the query:"+sql.toString(), "AddProjectDomain.java");
}
	return result;
}
}
