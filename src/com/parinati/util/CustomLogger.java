package com.parinati.util;

import java.text.SimpleDateFormat;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class CustomLogger {
	private static final Logger logDebug = LogManager.getLogger("Debug");
	private static final Logger logError = LogManager.getLogger("Error");

	/****************************************************************************************************
	 * Following Method Simply Writes the text sent to it by the program
	 * invoking this method to the file
	 * LOG prints logging as DEBUG
	 ***************************************************************************************************/

	public static void printDebug(String text, String filename) {

		if (logDebug.isDebugEnabled()) {
			logDebug.debug(new SimpleDateFormat("E MMM d H:mm:ss.SSSS z yyyy").format(new java.util.Date()) + text + " - " + filename);
		}

	}

	/****************************************************************************************************
	 * Following Method Simply Writes the text ,along with Date (Time of
	 * occurence of exception ) sent to it by the JSP invoking this method to
	 * the file
	 ***************************************************************************************************/

	public static void exceptionJsp(Exception e, String text, String filename) {
		if (logError.isErrorEnabled()) {
			logError.error(new SimpleDateFormat("E MMM d H:mm:ss.SSSS z yyyy").format(new java.util.Date()) + text + "\t The Exception\t" + e + " Occured on jsp -\t"+ filename);
		}

	}

	/****************************************************************************************************
	 * Following Method Simply Writes the text ,along with Date (Time of
	 * occurence of exception ) sent to it by the Java programe invoking this
	 * method to the file
	 ***************************************************************************************************/

	public static void exceptionJava(Exception e, String text, String fname) {
		if (logError.isErrorEnabled()) {
			logError.error(new SimpleDateFormat("E MMM d H:mm:ss.SSSS z yyyy").format(new java.util.Date())+ text +"\tThe Exception\t" + e + " Occured inside Java File\t - " +fname );
		}

	}

}