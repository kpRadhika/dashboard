package com.parinati.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
		String selProjectName = request.getParameter("projectDropDown")== null ? "": request.getParameter("projectDropDown");
		String monthYear = request.getParameter("monthYear")== null ? "": request.getParameter("monthYear");


		List<String> parsedDates = dateParse(monthYear);

		List<ArrayList<String>> reportData = emplDoamin.fetchLeaveReportData(parsedDates.get(0),parsedDates.get(1),selProjectName);
		String fileName = "LEAVE REPORT FOR THE MONTH OF "+monthYear;

		byte[] byteArray = null;
		ByteArrayOutputStream bos = null;
		FileOutputStream fileOut = null;


		if(reportData != null && !reportData.isEmpty())
		{
			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(fileName);

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
					cell.setCellValue("PROJECT NAME");
				}else{
					cell.setCellValue(selProjectName);
				}
			}

			row = sheet.createRow(1);
			cell = null;

			for(int i=0;i<18;i++)
			{
				cell = row.createCell(i);
				cell.setCellStyle(cellStyle1);
				if(i==0)
				{
					cell.setCellValue("MONTH");
				}else{
					cell.setCellValue(monthYear);
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
			cell.setCellValue(new XSSFRichTextString("EMP ID"));

			cell = row.createCell(1);
			cell.setCellStyle(headerCellStyle1);
			cell.setCellValue(new XSSFRichTextString("EMPLOYEE NAME"));

			cell = row.createCell(2);
			cell.setCellStyle(headerCellStyle1);
			cell.setCellValue(new XSSFRichTextString("LEVAE APPLICATION TYPE"));

			cell = row.createCell(3);
			cell.setCellStyle(headerCellStyle1);
			cell.setCellValue(new XSSFRichTextString("LEAVE FROM"));

			cell = row.createCell(4);
			cell.setCellStyle(headerCellStyle1);
			cell.setCellValue(new XSSFRichTextString("LEAVE TO"));

			cell = row.createCell(5);
			cell.setCellStyle(headerCellStyle1);
			cell.setCellValue(new XSSFRichTextString("APPRVED BY"));


			for(int k=0;k<reportData.size();k++) {
				row = sheet.createRow(k+1);
				ArrayList records = (ArrayList)reportData.get(k);

				cell = row.createCell(0);
				String empID=records.get(0)== null ? "":records.get(0).toString().trim();
				XSSFRichTextString slNoHSS = new XSSFRichTextString(String.valueOf(k+1));
				cell.setCellValue(slNoHSS);

				String empFirstName=records.get(2)== null ? "":records.get(2).toString().trim();
				String empLastName = records.get(3)== null ? "":records.get(3).toString().trim();
				cell = row.createCell(1);
				XSSFRichTextString gatewayNameHSS = new XSSFRichTextString(empFirstName +" "+empLastName);
				cell.setCellValue(gatewayNameHSS);

				String applId =records.get(1)== null ? "":records.get(1).toString().trim();
				cell = row.createCell(2);
				XSSFRichTextString applIdHSS = new XSSFRichTextString(applId);
				cell.setCellValue(applIdHSS);

				String leaveApplType =records.get(6)== null ? "":records.get(6).toString().trim();
				cell = row.createCell(3);
				XSSFRichTextString leaveApplTypeHSS = new XSSFRichTextString(leaveApplType);
				cell.setCellValue(leaveApplTypeHSS);

				String leaveForm = records.get(4)== null ? "":records.get(4).toString().trim();
				cell = row.createCell(4);
				XSSFRichTextString leaveFormHSS = new XSSFRichTextString(leaveForm);
				cell.setCellValue(leaveFormHSS);

				String leaveTo =records.get(5)== null ? "":records.get(5).toString().trim();
				cell = row.createCell(5);
				XSSFRichTextString leaveToHSS = new XSSFRichTextString(leaveTo);
				cell.setCellValue(leaveToHSS);

				String approvedBy =records.get(7)== null ? "":records.get(7).toString().trim();
				cell = row.createCell(6);
				XSSFRichTextString approvedByHSS = new XSSFRichTextString(approvedBy);
				cell.setCellValue(approvedByHSS);

			}

			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-Disposition", "attachment; filename="+fileName+".xlsx");
			bos = new ByteArrayOutputStream();
			wb.write(bos);
			byteArray=bos.toByteArray();

			ServletOutputStream print = response.getOutputStream();
			print.write(byteArray);
			print.flush();
			print.close();

		}else{
			response.sendRedirect("Report/employeeReport.jsp?msg=NODATA"+"&monthYear="+monthYear+"&projectDropDown="+selProjectName);
		}

	}

	public List<String> dateParse(String date){

		String fromDate    = null;
		String toDate	   = null;
		SimpleDateFormat mnthFormat = new SimpleDateFormat("MM/yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
		Date convertedDate=null;
		try {
			convertedDate = mnthFormat.parse(date);
			Calendar c = Calendar.getInstance();
			c.setTime(convertedDate);
			c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));
			fromDate = dateFormat.format(c.getTime());
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
			c.set(Calendar.HOUR_OF_DAY, 23);
			c.set(Calendar.MINUTE, 59);
			c.set(Calendar.SECOND, 59);
			toDate = dateFormat.format(c.getTime());
		} catch (Exception e) {

		}
		List<String> parsedDates = new ArrayList<>();
		parsedDates.add(fromDate);
		parsedDates.add(toDate);
		return parsedDates;
	}

}
