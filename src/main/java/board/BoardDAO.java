package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() {
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
		String SQL = "Select Now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public int getNext() {
		String SQL = "Select board_no from board order by board_no desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String board_title, String user_id , String board_contents , String board_index, String board_type,int board_count,String file_name) {
		String SQL = "Insert Into board(board_no,user_id,board_index,board_title,board_contents,board_date,board_type,board_count,file_name) VALUES(?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, user_id);
			pstmt.setString(3, board_index);
			pstmt.setString(4, board_title);
			pstmt.setString(5, board_contents);
			pstmt.setString(6, getDate());
			pstmt.setString(7, board_type);
			pstmt.setInt(8, board_count);
			pstmt.setString(9,file_name);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Board> getList(int pageNumber, String boardType){
		String SQL = "Select * from board where board_type like '%" + boardType + "%' order by board_no desc limit ?, 10";
		
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				
				board.setBoard_no(rs.getInt(1));
				board.setUser_id(rs.getString(2));
				board.setBoard_index(rs.getString(3));
				board.setBoard_title(rs.getString(4));
				board.setBoard_contents(rs.getString(5));
				board.setBoard_date(rs.getString(6));
				board.setBoard_type(rs.getString(7));
				board.setBoard_count(rs.getInt(8));
				board.setFile_name(rs.getString(9));
				
				list.add(board);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Board getBoard(int board_no) {
		String SQL = "Select * from board where board_no = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {			
				Board board = new Board();
				board.setBoard_no(rs.getInt(1));
				board.setUser_id(rs.getString(2));
				board.setBoard_index(rs.getString(3));
				board.setBoard_title(rs.getString(4));
				board.setBoard_contents(rs.getString(5));
				board.setBoard_date(rs.getString(6));
				board.setBoard_type(rs.getString(7));
				int board_count=rs.getInt(8);
				board.setBoard_count(board_count);
				board_count++;
				countUpdate(board_count,board_no);
				board.setFile_name(rs.getString(9));
				
				return board;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int countUpdate(int board_count, int board_no) {
		String SQL = "UPDATE board set board_count = ? where board_no=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_count);
			pstmt.setInt(2, board_no);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int update(int board_no, String board_index, String board_title, String board_contents, String board_type, String file_name) {
		String SQL = "UPDATE board SET board_index = ?, board_title = ?, board_contents = ?, board_type = ?, file_name = ? where board_no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, board_index);
			pstmt.setString(2, board_title);
			pstmt.setString(3, board_contents);
			pstmt.setString(4, board_type);
			pstmt.setString(5, file_name);
			pstmt.setInt(6, board_no);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int board_no) {
		String SQL = "delete from board where board_no =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_no);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Board> getSearch(String searchField, String searchText){
		ArrayList<Board> list = new ArrayList<Board>();
		String SQL = "Select * from board where "+searchField.trim();
		try { 
				SQL += " LIKE N'%"+searchText.trim()+"%'";
				
			PreparedStatement pstmt = conn.prepareStatement(SQL);	
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setBoard_no(rs.getInt(1));
				board.setUser_id(rs.getString(2));
				board.setBoard_index(rs.getString(3));
				board.setBoard_title(rs.getString(4));
				board.setBoard_contents(rs.getString(5));
				board.setBoard_date(rs.getString(6));
				board.setBoard_type(rs.getString(7));
				board.setBoard_count(rs.getInt(8));
				board.setFile_name(rs.getString(9));
				list.add(board);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCount(String boardType) {
		String SQL = "Select count(board_no) from board where board_type like '%" + boardType + "%' order by board_no desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

