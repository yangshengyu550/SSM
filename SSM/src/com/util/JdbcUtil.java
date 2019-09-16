package com.util;

import java.sql.*;
import java.util.*;

public class JdbcUtil {
	private static String driver,url,user,password;
	private static Properties pr=new Properties();
	private JdbcUtil() {}
	static {
		try {
			pr.load(JdbcUtil.class.getClassLoader().getResourceAsStream("jdbc.properties"));
			driver=pr.getProperty("driverClassName");
			url=pr.getProperty("url");
			user=pr.getProperty("username");
			password=pr.getProperty("password");
			Class.forName(driver);
		}catch(Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}
	public static Connection getConnection() throws SQLException{
		return DriverManager.getConnection(url,user,password);
	}
	public static void free(ResultSet rs,PreparedStatement ps,Connection conn) {
		try {
			if(rs!=null) {rs.close();}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			if(conn!=null) {
				try{
					conn.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
