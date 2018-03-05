package com.parinati.leaves;

import java.util.ArrayList;
import java.util.List;

import com.parinati.util.CustomLogger;
import com.parinati.util.DBConnectionManager;
import com.parinati.util.FileReadUtil;
import com.parinati.util.GenericConstDef;
import com.parinati.util.GenericUtil;
import com.parinati.util.MailerUtil;

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
			sql.append(" C.REPORTINGMANAGERID,               ");
			sql.append(" A.FNAME||' '||A.LNAME               ");
			sql.append(" FROM                                ");
			sql.append(" EMPLOYEEDTLS A,                     ");
			sql.append(" EMPROLEDTLS C                       ");
			sql.append(" WHERE                               ");
			sql.append(" A.EMPID = C.EMPID                   ");
			sql.append(" AND   A.OFFICIALEMAIL = ?           ");

			values = new ArrayList<>();
			values.add(valueList.get(0));

			valueTypes = new ArrayList<>();
			valueTypes.add(GenericConstDef.DB_STRING);

			List rs = dbhelper.executeQuery(sql.toString(), values, valueTypes);

			if(rs!=null && !rs.isEmpty()){
				sql = new StringBuilder();
				sql.append(" INSERT                     ");
				sql.append("    INTO LEAVEDETAILS (     ");
				sql.append("        EMPID,              ");
				sql.append("        LEAVETYPEID,        ");
				sql.append("        LEAVEFROM,          ");
				sql.append("        LEAVETO,            ");
				sql.append("        APPROVALSTATUS,     ");
				sql.append("        CREATIONDATE,       ");
				sql.append("        CREATEDBY,          ");
				sql.append("        MANAGERID           ");
				sql.append("    )                       ");
				sql.append("VALUES (                    ");
				sql.append("?,                          ");
				sql.append("?,                          ");
				sql.append("TO_DATE(?,'DD-MM-YYYY'),    ");
				sql.append("TO_DATE(?,'DD-MM-YYYY'),    ");
				sql.append("?,                          ");
				sql.append("SYSDATE,                    ");
				sql.append("?,                          ");
				sql.append("?                           ");
				sql.append(")                           ");

				values = new ArrayList<>();
				values.add(Integer.parseInt((String)((ArrayList)rs.get(0)).get(0)));
				values.add(valueList.get(3));
				values.add(valueList.get(1));
				values.add(valueList.get(2));
				values.add("P");
				values.add(valueList.get(0));
				values.add(Integer.parseInt((String)((ArrayList)rs.get(0)).get(1)));

				valueTypes = new ArrayList<>();
				valueTypes.add(GenericConstDef.DB_INT);
				valueTypes.add(GenericConstDef.DB_INT);
				valueTypes.add(GenericConstDef.DB_STRING);
				valueTypes.add(GenericConstDef.DB_STRING);
				valueTypes.add(GenericConstDef.DB_STRING);
				valueTypes.add(GenericConstDef.DB_STRING);
				valueTypes.add(GenericConstDef.DB_INT);

				int result = dbhelper.executeInsertUpdate(sql.toString(), values, valueTypes);
				if(result>0){
					sql = new StringBuilder();
					sql.append(" SELECT FNAME, OFFICIALEMAIL FROM EMPLOYEEDTLS WHERE EMPID = ? ");

					values = new ArrayList<>();
					values.add(Integer.parseInt((String)((ArrayList)rs.get(0)).get(1)));

					valueTypes = new ArrayList<>();
					valueTypes.add(GenericConstDef.DB_INT);

					List managerDetails = dbhelper.executeQuery(sql.toString(), values, valueTypes);

					if(managerDetails!=null && !managerDetails.isEmpty()){

					String mailTempPath = FileReadUtil.getValue("LEAVEAPPMAIL");
					String[] var = new String[2];
					var[0] = (String)((ArrayList)managerDetails.get(0)).get(0);
					var[1] = valueList.get(0).toString();

					new MailerUtil().postMailWithTLSAuth((String)((ArrayList)managerDetails.get(0)).get(1),(String)valueList.get(0), "Leave Application Pending for action", mailTempPath, var);
					}
				}

			}
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in submitLeaveForApproval() while executing the query:"+sql.toString()+" values:"+
					values.toString(), "LeaveApplicationDomain.java");
		}
		return retVal;
	}
		/**
	 *
	 * @param loginId
	 * @return
	 */
	public List<ArrayList> fetchEmployeeLeave(String loginId){
		List<ArrayList> rs = null;
		StringBuilder sql = new StringBuilder();
		List values = null;
		List valueTypes = null;

		try{
			/*sql.append(" SELECT APPLICATIONID,
			sql.append("  EMPID,
			sql.append("  LEAVETYPEID,
			sql.append("  LEAVEFROM,
			sql.append("  LEAVETO
			sql.append(" FROM LEAVEDETAILS
			sql.append(" WHERE APPROVALSTATUS = 'P'
			AND MANAGERID        =
			  (SELECT EMPID FROM EMPLOYEEDTLS WHERE officialemail=?
			  )*/

			sql.append("	SELECT									");
			sql.append("	    UL.EMPID,                           ");
			sql.append("	    ED.FNAME,                           ");
			sql.append("	    ED.LNAME,                           ");
			sql.append("		TO_CHAR(LD.LEAVEFROM,'DD/MM/YYYY'), ");
			sql.append("		TO_CHAR(LD.LEAVETO,'DD/MM/YYYY'),   ");
			sql.append("	    LTM.LEAVETYPE,                      ");
			sql.append("	    LD.APPLICATIONID                    ");
			sql.append("	FROM                                    ");
			sql.append("	    LEAVEDETAILS LD,                    ");
			sql.append("	    USERLOGIN UL,                       ");
			sql.append("	    EMPLOYEEDTLS ED,                    ");
			sql.append("	    LEAVETYPEMASTER LTM                 ");
			sql.append("	WHERE LD.EMPID = UL.EMPID               ");
			sql.append("	AND LD.EMPID = ED.EMPID                 ");
			sql.append("	AND LD.LEAVETYPEID = LTM.LEAVETYPEID    ");
			sql.append("	    AND LD.APPROVALSTATUS = 'P'         ");
			sql.append("	    AND UL.LOGINID = ?                  ");

			values = new ArrayList();
			values.add(loginId);

			valueTypes = new ArrayList();
			valueTypes.add(GenericConstDef.DB_STRING);

			rs = dbhelper.executeQuery(sql.toString(), values, valueTypes);
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in fetchEmployeeLeave() while executing the query:"+sql.toString(), "LeaveApplicationDomain.java");
		}
		return rs;
	}

	/**
	 *
	 * @param inputParam
	 * @return
	 */
	public int updateEmpLeaveDetail(List inputParam){

		StringBuilder sql = new StringBuilder();
		int rs=0;
		List queryValues = null;
		List queryTypes = null;
		try{
			sql.append("	UPDATE LEAVEDETAILS				");
			sql.append("	SET                             ");
			sql.append("	    APPROVALSTATUS =?,          ");
			sql.append("	    MODIFIEDDATE = SYSDATE,     ");
			sql.append("	    MODIFIEDBY =?               ");
			sql.append("	WHERE                           ");
			sql.append("	APPLICATIONID =?                ");

			queryValues = new ArrayList();
			queryValues.add(inputParam.get(1));
			queryValues.add(inputParam.get(2));
			queryValues.add(Integer.parseInt(inputParam.get(0).toString()));

			queryTypes = new ArrayList();
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_STRING);
			queryTypes.add(GenericConstDef.DB_INT);

			rs = dbhelper.executeInsertUpdate(sql.toString(), queryValues, queryTypes);
			if(rs > 0){
				sql = new StringBuilder();
				sql.append(" SELECT FNAME, OFFICIALEMAIL FROM EMPLOYEEDTLS,				");
				sql.append(" LEAVEDETAILS WHERE LEAVEDETAILS.EMPID =EMPLOYEEDTLS.EMPID	");
				sql.append(" AND APPLICATIONID = ?										");
				/*sql.append(" SELECT FNAME, OFFICIALEMAIL FROM EMPLOYEEDTLS WHERE EMPID = ? ");*/
				queryValues = new ArrayList<>();
				queryValues.add(Integer.parseInt(inputParam.get(0).toString()));
				queryTypes = new ArrayList<>();
				queryTypes.add(GenericConstDef.DB_INT);
				List empDetails = dbhelper.executeQuery(sql.toString(), queryValues, queryTypes);
				if(empDetails!=null && !empDetails.isEmpty()){
				String mailTempPath = FileReadUtil.getValue("LEAVEAPPROVEMAIL");
				String[] var = new String[2];
				var[0] = (String)((ArrayList)empDetails.get(0)).get(0);
				var[1] = (String)((ArrayList)empDetails.get(0)).get(0);
				new MailerUtil().postMailWithTLSAuth((String)((ArrayList)empDetails.get(0)).get(1),(String)inputParam.get(2), "Leave Application action", mailTempPath, var);
				}
			}
		}
		catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception in updateEmpLeaveDetail() while executing the query:"+sql.toString(), "LeaveApplicationDomain.java");
		}

		return rs;
	}
}
