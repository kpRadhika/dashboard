package com.parinati.util;

/**
 * Purpose : Used to perform ternary opration. 
 */
public class GenericUtil
{
	public static String setValue(String val){
		return (val == null) ? GenericConstDef.PATTERN_EMPTY : val.trim();
	}
}
