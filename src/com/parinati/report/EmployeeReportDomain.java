package com.parinati.report;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.plaf.synth.Region;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;

public class EmployeeReportDomain {

	DBConnectionManager dbhelper = null;

	public EmployeeReportDomain() {
		dbhelper = new DBConnectionManager();
	}

	/**
	 * This method is used to fetch the Individual report data for employee
	 * @param monthYear
	 * @param projectName
	 */
	public List fetchLeaveReportData(String fromDate,String toDate, String projectId){


		List result= null;
		StringBuilder sql = new StringBuilder();
		List values = new ArrayList();
		try{
			sql.append("	SELECT															");
			sql.append("	    ld.empid,                                                   ");
			sql.append("	    ld.applicationid,                                           ");
			sql.append("	    ed.fname,                                                   ");
			sql.append("	    ed.lname,                                                   ");
			sql.append("	    TO_CHAR(ld.leavefrom,'DD-MM-YYYY'),                         ");
			sql.append("	    TO_CHAR(ld.leaveto,'DD-MM-YYYY'),                           ");
			sql.append("	    ltm.leavetype,                                              ");
			sql.append("	    ld.modifiedby                                               ");
			sql.append("	FROM                                                            ");
			sql.append("	    leavedetails ld,                                            ");
			sql.append("	    employeedtls ed,                                            ");
			sql.append("	    leavetypemaster ltm,                                        ");
			sql.append("	    emproledtls erd                                             ");
			sql.append("	WHERE                                                           ");
			sql.append("	        ld.empid = ed.empid                                     ");
			sql.append("	    AND                                                         ");
			sql.append("	        erd.empid = ed.empid                                    ");
			sql.append("	    AND                                                         ");
			sql.append("	        ld.leavetypeid = ltm.leavetypeid                        ");
			sql.append("	    AND                                                         ");
			sql.append("	        ld.approvalstatus = 'A'                                 ");
			sql.append("	    AND                                                         ");
			sql.append("	        erd.projectid =?                                        ");
			sql.append("	    AND                                                         ");
			sql.append("	        ld.leavefrom >= TO_DATE(?,'dd-MON-yy')    			");
			sql.append("	    AND                                                         ");
			sql.append("	        ld.leavefrom <= TO_DATE(?,'dd-MON-yy')    			");

			values.add(Integer.parseInt(projectId));
			values.add(fromDate);
			values.add(toDate);

			List queryValueTypes = new ArrayList();
				queryValueTypes.add(GenericConstDef.DB_INT);
				queryValueTypes.add(GenericConstDef.DB_STRING);
				queryValueTypes.add(GenericConstDef.DB_STRING);
			result = dbhelper.executeQuery(sql.toString(), values, queryValueTypes);

		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in getCandidateDetails() while executing the query:"+sql.toString()+" values:"+values.toString(), "CreateUserDomain.java");
		}
		return result;

	}

}
