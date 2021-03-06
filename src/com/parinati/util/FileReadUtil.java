package com.parinati.util;

import java.io.File;
import java.io.FileInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class FileReadUtil {
	static Document doc;

	static {
		try {
			/*File dummyFile = new File("");
			String path = dummyFile.getPath();*/
			ClassLoader classLoader = FileReadUtil.class.getClassLoader();
			File file = new File(classLoader.getResource("config/dashboard.xml").getFile());
			FileInputStream fis = new FileInputStream(file);
			InputSource source = new InputSource(fis);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder parser = dbf.newDocumentBuilder();
			doc = parser.parse(source);
		} catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception Occured :: File not found ", "FetchProperties");

		}
	}
	
	public static String getValue(String strName) {
		String str = "";
		try {
			
		// Only one element will be returned.
		NodeList list = doc.getElementsByTagName(strName);
		Node node = list.item(0);

		// If Node not found in XML
		if (node == null)
			return null;

		NodeList children = node.getChildNodes();
		node = children.item(0);

		// If Node Value is not specified
		if (node == null)
			return null;

			str = node.getNodeValue();
			str = str.trim();
		} catch (Exception e) {
			CustomLogger.exceptionJava(e, "Exception Occured :: getValue()", "FileReadUtil");
		} 
		return str;
	}
}
