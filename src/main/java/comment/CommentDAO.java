package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() {
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
	
	public String getDate() {
		String SQL="select now()";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL="SELECT comment_no from COMMENT order by comment_no DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String comment_contents, String user_id, int board_no) {
		String SQL="insert into COMMENT(comment_no,board_no,comment_contents,comment_date,user_id) VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, board_no);
			pstmt.setString(3, comment_contents);
			pstmt.setString(4, getDate());
			pstmt.setString(5, user_id);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Comment> getList(int board_no){
		String SQL="SELECT * from comment where board_no = ? order by board_no desc limit 10";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, board_no);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setComment_no(rs.getInt(1));
				comment.setBoard_no(rs.getInt(2));
				comment.setComment_contents(rs.getString(3));
				comment.setComment_date(rs.getString(4));
				comment.setUser_id(rs.getString(5));					
				list.add(comment);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Comment getComment(int comment_no) {
		String SQL="SELECT * from comment where comment_no = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Comment comment = new Comment();
				comment.setComment_no(rs.getInt(1));
				comment.setBoard_no(rs.getInt(2));
				comment.setComment_contents(rs.getString(3));
				comment.setComment_date(rs.getString(4));
				comment.setUser_id(rs.getString(5));	
				return comment;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int comment_no) {
		String SQL = "delete from comment where comment_no = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_no);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}