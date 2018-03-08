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
/*	*//**
	 * This method is used to fetch the Individual report data for employee
	 * @param monthYear
	 * @param projectName
	 *//*
	public void fetchIndividualReportData(String monthYear, String projectName){




	}*/

	/**
	 * This method is used to fetch the Individual report data for employee
	 * @param monthYear
	 * @param projectName
	 */
	public void fetchConsolidatedReportData(String monthYear, String projectName){




	}

}
