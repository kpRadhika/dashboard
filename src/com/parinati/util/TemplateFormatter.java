/*
 * @(#)TemplateFormatter.java	09/09/2002
 *
 * Copyright 2013 State Bank of India. All Rights Reserved.
 * 
 * This software is the proprietary information of State Bank of India.
 * Use is subject to license terms.
 * 
 */
package com.parinati.util;

import java.io.*;

/**
 *
 * 
 * @version 1.00, 09/09/2002
 */

public class TemplateFormatter extends Object {

	/** Creates new TemplateFormatter */
	public TemplateFormatter() {
	}
	public static String format(File fin, Object[] mailData) throws TemplateFormatterException {
		StringBuffer inBuf = new StringBuffer();
		String outStr = "";
		String inLine = null;

		try {
			FileReader fr = new FileReader(fin);
			BufferedReader bin = new BufferedReader(fr);

			while ((inLine = bin.readLine()) != null) {

				inBuf.append(inLine);
				inBuf.append("\n");

			}

			outStr = format(inBuf.toString(), mailData);

		} catch (Exception t) {
			CustomLogger.exceptionJava(t, "TemplateFormatter.java in format()", "TemplateFormatter.java");
		}

		return outStr;
	}

	public static String format(String inStr, Object[] mailData) throws TemplateFormatterException {
		StringBuffer sb = new StringBuffer(inStr);
		// StringBuffer outBuf = new StringBuffer();

		int startLoc = 0;
		String varStr = "";

		for (int i = 0; i < mailData.length; i++) {
			int loc = 0;
			// get the next variable to be searched
			while (loc != -1) {
				varStr = "{" + i + "}";
				loc = inStr.indexOf(varStr);
				if (loc != -1) {
					sb.delete(loc, loc + varStr.length());
					sb.insert(loc, (String) mailData[i]);
				}
				inStr = sb.toString();
			}

		}

		return sb.toString();
	}
	
}