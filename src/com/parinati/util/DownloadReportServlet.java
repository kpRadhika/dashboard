package com.parinati.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.parinati.report.EmployeeReportDomain;

/**
 * Servlet implementation class DownloadReport
 */
public class DownloadReportServlet extends HttpServlet {

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		EmployeeReportDomain emplDoamin = new EmployeeReportDomain();
		String radioVal = request.getParameter("reportRadio")== null ? "": request.getParameter("reportRadio");
		String selProjectName = request.getParameter("projectDropDown")== null ? "": request.getParameter("projectDropDown");
		String monthYear = request.getParameter("monthYear")== null ? "": request.getParameter("monthYear");

		/*if("individual".equalsIgnoreCase(radioVal)){

			List<String> reportData = null;//emplDoamin.fetchIndividualReportData(monthYear,projectName);


			if(reportData != null && !reportData.isEmpty())
			{
				XSSFWorkbook wb = new XSSFWorkbook();
				XSSFSheet sheet = wb.createSheet("Employee Report");


				sheet.setColumnWidth(0, 5000);
				sheet.setColumnWidth(1, 5000);
				sheet.setColumnWidth(2, 4000);
				sheet.setColumnWidth(3, 4000);
				sheet.setColumnWidth(4, 7000);
				sheet.setColumnWidth(5, 4000);
				sheet.setColumnWidth(6, 7000);
				sheet.setColumnWidth(7, 5000);
				sheet.setColumnWidth(8, 3000);
				sheet.setColumnWidth(9, 3000);
				sheet.setColumnWidth(10, 3000);
				sheet.setColumnWidth(11, 3000);
				sheet.setColumnWidth(12, 3000);
				sheet.setColumnWidth(13,4000);
				sheet.setColumnWidth(14, 7000);
				sheet.setColumnWidth(15, 5000);
				sheet.setColumnWidth(16, 3000);
				sheet.setColumnWidth(17, 3000);
				sheet.setColumnWidth(18, 3000);
				sheet.setColumnWidth(19, 3000);
				sheet.setColumnWidth(20, 3000);
				sheet.setColumnWidth(21,4000);

				 XSSFCellStyle headerCellStyle = wb.createCellStyle();
			        XSSFColor color = new XSSFColor(new java.awt.Color(148, 197, 246));
			        headerCellStyle.setFillForegroundColor(color);
			        headerCellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			        XSSFFont boldFont = wb.createFont();
			        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
			        headerCellStyle.setWrapText(true);
			        headerCellStyle.setFont(boldFont);

			        XSSFRow row = sheet.createRow(0);

					CellStyle cellStyle1 = wb.createCellStyle();
					cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);

					Font font1 = wb.createFont();
					font1.setFontHeightInPoints((short) 18);
					cellStyle1.setFont(font1);

				  	row = sheet.createRow(0);
					XSSFCell cell = null;

					for(int i=0;i<18;i++)
					{
						cell = row.createCell(i);
					    cell.setCellStyle(cellStyle1);
					    if(i==0)
					    {
					    	cell.setCellValue("Module");
					    }else{
					    	cell.setCellValue(projectName);
					    }
					}

					row = sheet.createRow(1);

					CellStyle cellStyle2 = wb.createCellStyle();
					cellStyle2.setAlignment(CellStyle.ALIGN_CENTER);
					Font font2 = wb.createFont();
					font2.setFontHeightInPoints((short) 12);
					cellStyle2.setFont(font2);
					for(int i=0;i<18;i++)
					{
						cell = row.createCell(i);
						cell.setCellStyle(cellStyle2);
						if(i==0)
					    {
							cell.setCellValue("Employee NO");
					    }else{
					    	cell.setCellValue("");//form DB
					    }
					}

					row = sheet.createRow(3);

					CellStyle cellStyle3 = wb.createCellStyle();
					cellStyle3.setAlignment(CellStyle.ALIGN_CENTER);
					Font font3 = wb.createFont();
					font3.setFontHeightInPoints((short) 12);
					cellStyle3.setFont(font3);
					for(int i=0;i<18;i++)
					{
						cell = row.createCell(i);
						cell.setCellStyle(cellStyle3);
						if(i==0)
					    {
							cell.setCellValue("Resource Name");
					    }else{
					    	cell.setCellValue("");//form DB
					    }
					}


				XSSFCellStyle headerCellStyle1 = wb.createCellStyle();
				XSSFFont boldFont1 = wb.createFont();
				boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				headerCellStyle1.setFont(boldFont1);

				XSSFCellStyle alignCellStyle = wb.createCellStyle();
				alignCellStyle.setAlignment(XSSFCellStyle.ALIGN_RIGHT);

				row = sheet.createRow(4);

				row = sheet.createRow(5);

				cell = row.createCell(0);
				cell = row.createCell(0);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("ATRN"));

				cell = row.createCell(6);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("Gateway Name"));


				double sumGatewayFeeABS = 0;
				double sumServiceTaxPayable = 0;
				for(int k=0;k<reportData.size();k++) {
					row = sheet.createRow(k+1);
					ArrayList records = (ArrayList)reportData.get(k);

					String atrn=records.get(0)== null ? "":records.get(0).toString().trim();
					cell = row.createCell(0);
					XSSFRichTextString atrnHSS = new XSSFRichTextString(atrn);
					cell.setCellValue(atrnHSS);

					String gatewayName=records.get(1)== null ? "":records.get(1).toString().trim();
					cell = row.createCell(1);
					XSSFRichTextString gatewayNameHSS = new XSSFRichTextString(gatewayName);
					cell.setCellValue(gatewayNameHSS);

				}

			}

		}else if("consolidated".equalsIgnoreCase(radioVal)){*/

			List<ArrayList<String>> reportData = null;//emplDoamin.fetchConsolidatedReportData(monthYear,projectName);

			if(reportData != null && !reportData.isEmpty())
			{
				XSSFWorkbook wb = new XSSFWorkbook();
				XSSFSheet sheet = wb.createSheet("Cosolidated Time Sheet");

				sheet.setColumnWidth(0, 5000);
				sheet.setColumnWidth(1, 5000);
				sheet.setColumnWidth(2, 4000);
				sheet.setColumnWidth(3, 4000);
				sheet.setColumnWidth(4, 7000);
				sheet.setColumnWidth(5, 4000);
				sheet.setColumnWidth(6, 7000);
				sheet.setColumnWidth(7, 5000);
				sheet.setColumnWidth(8, 3000);
				sheet.setColumnWidth(9, 3000);
				sheet.setColumnWidth(10, 3000);
				sheet.setColumnWidth(11, 3000);
				sheet.setColumnWidth(12, 3000);
				sheet.setColumnWidth(13,4000);
				sheet.setColumnWidth(14, 7000);
				sheet.setColumnWidth(15, 5000);
				sheet.setColumnWidth(16, 3000);
				sheet.setColumnWidth(17, 3000);
				sheet.setColumnWidth(18, 3000);
				sheet.setColumnWidth(19, 3000);
				sheet.setColumnWidth(20, 3000);
				sheet.setColumnWidth(21,4000);

				 XSSFCellStyle headerCellStyle = wb.createCellStyle();
			        XSSFColor color = new XSSFColor(new java.awt.Color(148, 197, 246));
			        headerCellStyle.setFillForegroundColor(color);
			        headerCellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			        XSSFFont boldFont = wb.createFont();
			        boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
			        headerCellStyle.setWrapText(true);
			        headerCellStyle.setFont(boldFont);

			        XSSFRow row = sheet.createRow(0);

					CellStyle cellStyle1 = wb.createCellStyle();
					cellStyle1.setAlignment(CellStyle.ALIGN_CENTER);

					Font font1 = wb.createFont();
					font1.setFontHeightInPoints((short) 18);
					cellStyle1.setFont(font1);

				  	row = sheet.createRow(0);
					XSSFCell cell = null;

					for(int i=0;i<18;i++)
					{
						cell = row.createCell(i);
					    cell.setCellStyle(cellStyle1);
					    if(i==0)
					    {
					    	cell.setCellValue("CONSOLIDATED  EFFORTS FOR MONTH OF "+monthYear);
					    }
					}


				XSSFCellStyle headerCellStyle1 = wb.createCellStyle();
				XSSFFont boldFont1 = wb.createFont();
				boldFont.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
				headerCellStyle1.setFont(boldFont1);

				XSSFCellStyle alignCellStyle = wb.createCellStyle();
				alignCellStyle.setAlignment(XSSFCellStyle.ALIGN_RIGHT);

				row = sheet.createRow(2);

				row = sheet.createRow(3);

				cell = row.createCell(0);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("SL NO."));

				cell = row.createCell(1);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("EMPLOYEE NAME"));

				cell = row.createCell(2);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("EMPLOYEE NAME"));

				cell = row.createCell(3);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("APPLICATION"));

				cell = row.createCell(4);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("WEEK-1"));

				cell = row.createCell(5);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("WEEK-2"));

				cell = row.createCell(6);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("WEEK-3"));

				cell = row.createCell(7);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("WEEK-4"));

				cell = row.createCell(8);
				cell.setCellStyle(headerCellStyle1);
				cell.setCellValue(new XSSFRichTextString("WEEK-5"));



				double totalOfFirstWeek = 0;
				double totalOfSecondWeek = 0;
				double totalOfThirdWeek = 0;
				double totalOfFourthWeek = 0;
				double totalOfFifthWeek = 0;
				for(int k=0;k<reportData.size();k++) {
					row = sheet.createRow(k+1);
					ArrayList records = (ArrayList)reportData.get(k);

					cell = row.createCell(0);
					XSSFRichTextString slNoHSS = new XSSFRichTextString(String.valueOf(k+1));
					cell.setCellValue(slNoHSS);

					String empName=records.get(0)== null ? "":records.get(0).toString().trim();
					cell = row.createCell(1);
					XSSFRichTextString gatewayNameHSS = new XSSFRichTextString(empName);
					cell.setCellValue(gatewayNameHSS);

					String projectName =records.get(1)== null ? "":records.get(1).toString().trim();
					cell = row.createCell(2);
					XSSFRichTextString projectNameHSS = new XSSFRichTextString(projectName);
					cell.setCellValue(projectNameHSS);


					String firstWeek = records.get(1)== null ? "":records.get(1).toString().trim();
					totalOfFirstWeek = totalOfFirstWeek + Double.valueOf(firstWeek);
					cell = row.createCell(3);
					XSSFRichTextString firstWeekHSS = new XSSFRichTextString(firstWeek);
					cell.setCellValue(firstWeekHSS);

					String secondWeek=records.get(2)== null ? "":records.get(2).toString().trim();
					totalOfSecondWeek = totalOfSecondWeek + Double.valueOf(secondWeek);
					cell = row.createCell(4);
					XSSFRichTextString secondWeekHSS = new XSSFRichTextString(secondWeek);
					cell.setCellValue(secondWeekHSS);

					String thirdWeek=records.get(3)== null ? "":records.get(3).toString().trim();
					totalOfThirdWeek = totalOfThirdWeek + Double.valueOf(thirdWeek);
					cell = row.createCell(5);
					XSSFRichTextString thirdWeekHSS = new XSSFRichTextString(thirdWeek);
					cell.setCellValue(thirdWeekHSS);

					String fourthWeek=records.get(4)== null ? "":records.get(4).toString().trim();
					totalOfFourthWeek = totalOfFourthWeek + Double.valueOf(fourthWeek);
					cell = row.createCell(6);
					XSSFRichTextString fourthWeekHSS = new XSSFRichTextString(fourthWeek);
					cell.setCellValue(fourthWeekHSS);

					String fifthWeek=records.get(5)== null ? "":records.get(5).toString().trim();
					totalOfFifthWeek = totalOfFifthWeek + Double.valueOf(fifthWeek);
					cell = row.createCell(7);
					XSSFRichTextString fifthWeekHSS = new XSSFRichTextString(fifthWeek);
					cell.setCellValue(fifthWeekHSS);

				}
				cell = row.createCell(0);

				cell = row.createCell(1);
				XSSFRichTextString totalHSS = new XSSFRichTextString("Total");
				cell.setCellValue(totalHSS);

				cell = row.createCell(2);
				XSSFRichTextString appHSS = new XSSFRichTextString("");
				cell.setCellValue(appHSS);

				cell = row.createCell(3);
				XSSFRichTextString totalOfFirstWeekHSS = new XSSFRichTextString(String.valueOf(totalOfFirstWeek));
				cell.setCellValue(totalOfFirstWeekHSS);

				cell = row.createCell(4);
				XSSFRichTextString totalOfSecondWeekHSS = new XSSFRichTextString(String.valueOf(totalOfSecondWeek));
				cell.setCellValue(totalOfSecondWeekHSS);

				cell = row.createCell(5);
				XSSFRichTextString totalOfThirdWeekHSS = new XSSFRichTextString(String.valueOf(totalOfThirdWeek));
				cell.setCellValue(totalOfThirdWeek);

				cell = row.createCell(6);
				XSSFRichTextString totalOfFourthWeekHSS = new XSSFRichTextString(String.valueOf(totalOfFourthWeek));
				cell.setCellValue(totalOfFourthWeekHSS);

				cell = row.createCell(7);
				XSSFRichTextString totalOfFifthWeekHSS = new XSSFRichTextString(String.valueOf(totalOfFifthWeek));
				cell.setCellValue(totalOfFifthWeek);

				XSSFCellStyle cellStyle3 = wb.createCellStyle();

		 		Font font3 = wb.createFont();
		 		font3.setFontHeightInPoints((short) 12);
		 		cellStyle3.setFont(font3);

		 		cellStyle3.setFillForegroundColor(color);
		 		cellStyle3.setFillPattern(CellStyle.SOLID_FOREGROUND);

		 		 row = sheet.createRow(reportData.size()+7);
		 		for(int i=0;i<18;i++)
		 		{
		 			cell = row.createCell(i);
		 		    cell.setCellStyle(cellStyle3);
		 		    if(i==0)
		 		    {
		 		    	//cell.setCellValue("The report is printed on  " + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date()));
		 		    }
		 		}


			}
		//}

	}

}
