package com.parinati.util;

import java.io.FileInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class ReadProperties {
	
	static Document doc;
	static {
		try {
			FileInputStream file = new FileInputStream("/props/DASHBOARD.xml");
			InputSource source = new InputSource(file);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder parser = dbf.newDocumentBuilder();
			doc = parser.parse(source);
		} catch (Exception e) {
			//Add logger

		}
	}
	
	public static String getValue(String strName) {
		String str = null;
		try {
			
		// Only one element will be returned.
		NodeList list = doc.getElementsByTagName(strName);
		Node node = list.item(0);

		// If Node not found in XML
		if (node == null)
			return null;

		NodeList children = node.getChildNodes();
		node = children.item(0);


			str = node.getNodeValue();
			str = str.trim();
		} catch (Exception e) {
			//Add logger
		} finally {
			//Add logger
		}
		return str;
	}
}
