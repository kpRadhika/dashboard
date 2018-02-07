/*
 * @(#)TemplateFormatterException.java	09/09/2002
 *
 * Copyright 2013 State Bank of India. All Rights Reserved.
 * 
 * This software is the proprietary information of State Bank of India.
 * Use is subject to license terms.
 * 
 */
package com.parinati.util;

/**
 *
 * 
 * @version 1.00, 09/09/2002
 */

public class TemplateFormatterException extends Exception {

	/**
	 * Creates new <code>TemplateFormatterException</code> without detail
	 * message.
	 */
	public TemplateFormatterException() {
	}

	/**
	 * Constructs an <code>TemplateFormatterException</code> with the specified
	 * detail message.
	 * 
	 * @param msg
	 *            the detail message.
	 */
	public TemplateFormatterException(String msg) {
		super(msg);
	}
}
