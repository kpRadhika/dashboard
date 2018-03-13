package com.parinati.admin;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.plaf.synth.Region;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.FileReadUtil;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;
import com.parinati.util.MailerUtil;

public class CreateUserDomain {

	DBConnectionManager dbhelper = null;

	public CreateUserDomain() {
		dbhelper = new DBConnectionManager();
	}

	public List getCandidateDetails(String fromDate, String toDate){
		List result= null;
		StringBuilder sql = new StringBuilder();
		List values = new ArrayList();
		try{
			sql.append(" SELECT CANDIDATEID, 	                ");
			sql.append(" FNAME,                                 ");
			sql.append(" EXPERIENCEINYRS,                       ");
			sql.append(" SKILLS,                                ");
			sql.append(" TO_CHAR(INTERVIEWDATE,'DD-MM-YYYY')    ");
			sql.append(" FROM CANDIDATEDTLS 	                ");
			sql.append(" WHERE ISSELECTED = ?                  	");
			sql.append(" AND TO_DATE(TO_CHAR(MODIFIEDDATE,'DD-MM-YYYY'),'DD-MM-YYYY') BETWEEN            ");
			sql.append(" TO_DATE(?,'DD-MM-YYYY') AND      		");
			sql.append(" TO_DATE(?,'DD-MM-YYYY')	              ");

		values.add("Y");
		values.add(fromDate);
		values.add(toDate);

		List queryValueTypes = new ArrayList();
		for (int i = 0; i < values.size(); i++) {
			queryValueTypes.add(GenericConstDef.DB_STRING);
		}
		result = dbhelper.executeQuery(sql.toString(), values, queryValueTypes);

	}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in getCandidateDetails() while executing the query:"+sql.toString()+" values:"+values.toString(), "CreateUserDomain.java");
		}
		return result;
	}
	public String insertCandidateDtls(List inputParam){

		StringBuilder sql = new StringBuilder();
		List queryValues  = null;
		List<String> queryTypes  = null;
		int result = 0;
		int updateCount = 0;
		String candId = null;
		try{
			sql.append("SELECT CANDID_SEQ.NEXTVAL FROM DUAL");

			List<ArrayList>rs = dbhelper.executeQuery(sql.toString(), null, null);

			if(rs != null && !rs.isEmpty()){
				candId = (String)((ArrayList)rs.get(0)).get(0);

			candId = "PARI"+candId;


			sql = new StringBuilder();

			sql.append("	INSERT INTO CANDIDATEDTLS (		");
			sql.append("	    CANDIDATEID,                ");
			sql.append("	    FNAME,                      ");
			sql.append("	    MNAME,                      ");
			sql.append("	    LNAME,                      ");
			sql.append("	    DOB,                        ");
			sql.append("	    PHONE,                      ");
			sql.append("	    PERSONALEMAIL,              ");
			sql.append("	    QUALIFICATION,              ");
			sql.append("	    EXPERIENCEINYRS,           	");
			sql.append("	    SKILLS,                     ");
			sql.append("	    PRESENTADD,                	");
			sql.append("	    CURRENTEMPLOYER,            ");
			sql.append("	    ACHIEVEMENTS,               ");
			sql.append("	    INTERVIEWDATE,              ");
			sql.append("	    RESUMEPATH,               	");
			sql.append("	    CREATIONDATE,              	");
			sql.append("	    SEX,              			");
			sql.append("	    CREATEDBY               	");
			sql.append("	) VALUES (                      ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("		TO_DATE(?,'DD-MM-YYYY'),    ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    ?,                          ");
			sql.append("	    TO_DATE(?,'DD-MM-YYYY'),    ");
			sql.append("	    ?,                          ");
			sql.append("	    SYSDATE,                    ");
			sql.append("	    ?,		                    ");
			sql.append("	    ?		                    ");
			sql.append("	)                               ");

			queryValues = new ArrayList<>();
			queryValues.add(candId);
			queryValues.add(GenericUtil.setValue((String)inputParam.get(0)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(1)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(2)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(3)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(4)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(5)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(6)));
			queryValues.add(inputParam.get(7));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(8)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(9)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(10)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(11)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(12)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(13)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(14)));
			queryValues.add(GenericUtil.setValue((String)inputParam.get(15)));

			queryTypes = new ArrayList<>();
			for(int i = 0; i<queryValues.size(); i++){
				if(i==8)
					queryTypes.add(GenericConstDef.DB_DOUBLE);
				else
					queryTypes.add(GenericConstDef.DB_STRING);
			}
			updateCount = dbhelper.executeInsertUpdate(sql.toString(), queryValues, queryTypes);
			}
		}
		catch(Exception e){
			updateCount = -1;
			CustomLogger.exceptionJava(e, "Exception in insertCandidateDtls() while executing the query:"+sql.toString()+" values:"+queryValues.toString(), "CreateUserDomain.java");
		}
		if(updateCount != -1){
			String mailTempPath = FileReadUtil.getValue("REFERENCEMAIL");
			String[] var = new String[2];
			var[0] = GenericUtil.setValue((String)((String)inputParam.get(0)));
			var[1] = candId;

			new MailerUtil().postMailWithTLSAuth(GenericUtil.setValue((String)inputParam.get(5)),(String)inputParam.get(15), "Resume submission status", mailTempPath, var);

			return candId;
		}
		else
			return "ERROR";

	}


	public List<ArrayList> fetchRecords(String searchValue,String radioButtonVal){
		StringBuffer sql = new StringBuffer();
		List rs = null;
		List queryValues = null;
		List queryTypes = null;
		try{
		sql.append("	SELECT										");
		sql.append("	    CANDIDATEID,       						");
		sql.append("	    FNAME,        							");
		sql.append("	    SKILLS,             					");
		sql.append("	    TO_CHAR(INTERVIEWDATE,'DD-MM-YYYY'),   	");//to_char ned to do
		sql.append(" 		ISSELECTED								");
		sql.append("	FROM                   						");
		sql.append("	    CANDIDATEDTLS       					");
		sql.append("	    WHERE       							");
		if("candidateId".equalsIgnoreCase(radioButtonVal))
			sql.append("	    UPPER(CANDIDATEID) = ?        ");
		else if("name".equalsIgnoreCase(radioButtonVal))
			sql.append("	    UPPER(FNAME)= ?    		");
		else if("skills".equalsIgnoreCase(radioButtonVal))
			sql.append("	    UPPER(SKILLS) like  ?     		");
		else if("InterviewDate".equalsIgnoreCase(radioButtonVal))
			sql.append("	    INTERVIEWDATE = TO_DATE(?,'DD-MM-YYYY')	");

		queryValues = new ArrayList<>();
		if("candidateId".equalsIgnoreCase(radioButtonVal))
			queryValues.add(searchValue.toUpperCase());
		else if("name".equalsIgnoreCase(radioButtonVal))
			queryValues.add(searchValue.toUpperCase());
		else if("skills".equalsIgnoreCase(radioButtonVal))
			queryValues.add("%"+searchValue.toUpperCase()+"%");
		else if("InterviewDate".equalsIgnoreCase(radioButtonVal))
			queryValues.add(searchValue);

		queryTypes = new ArrayList<>();
		queryTypes.add(GenericConstDef.DB_STRING);

		rs = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in fetchRecords() while executing the query:"+sql.toString()+" values:"+queryValues.toString(), "CreateUserDomain.java");
		}

		return rs;

	}

	public int modifyCandidate(List values){
		int updateCount=-1;

		StringBuilder sql = new StringBuilder();
		try{
		sql.append("UPDATE CANDIDATEDTLS    				 ");
		sql.append("SET SKILLS = ?,         				 ");
		sql.append("ISSELECTED = ?,         				 ");
		sql.append("INTERVIEWDATE = TO_DATE(?,'DD-MM-YYYY'), ");
		sql.append("MODIFIEDDATE = SYSDATE,  				 ");
		sql.append("MODIFIEDBY = ?			  				 ");
		sql.append("WHERE CANDIDATEID = ?   				 ");


		List queryValueTypes = new ArrayList<>();
		for (int i = 0; i < values.size(); i++) {
			queryValueTypes.add(GenericConstDef.DB_STRING);
		}

		updateCount = dbhelper.executeInsertUpdate(sql.toString(), values, queryValueTypes);
	}catch (Exception e) {
		CustomLogger.exceptionJava(e, "Exception in modifyCandidate() while executing the query:"+sql.toString()+" values:"+values.toString(), "CreateUserDomain.java");
	}
		return updateCount;
	}

}
