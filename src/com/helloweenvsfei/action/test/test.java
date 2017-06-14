package com.helloweenvsfei.action.test;

import java.sql.*;
import java.util.Date;

public class test {
	public static void main(String[] args){
		Date date=new Date();
		Timestamp timestart = new Timestamp(date.getTime());
		System.out.println(timestart);
		Timestamp timeend= new Timestamp(date.getTime());
		timeend.setTime(timestart.getTime() - 1000 * 60 * 60 * 24 * 40);
		System.out.println(timeend);
	}
}
