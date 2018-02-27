package com.parinati.admin;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;

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
			queryValues.add("A");
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


}
