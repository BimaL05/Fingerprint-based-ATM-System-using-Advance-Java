package com.atm;
import java.sql.*;

public class ConnectionManager {
	public static Connection jdbcConnection() throws Exception
	{
		String url="jdbc:mysql://localhost:3306/ATM_using_Fingerprint";
		String uname="root";
		String pass="admin";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection(url,uname,pass);
		return con;
	}
}