package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3308/bbs";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "select user_pw from user where user_id=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else
					return 0;
			}
			return -1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	public int join (User user) {
		String SQL = "INSERT INTO USER(user_id,user_pw,user_name,user_email) VALUES(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUser_id());
			pstmt.setString(2, user.getUser_pw());
			pstmt.setString(3, user.getUser_name());
			pstmt.setString(4, user.getUser_email());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
