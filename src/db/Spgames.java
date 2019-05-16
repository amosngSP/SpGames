package db;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.Dbinfo;
import db.game_entry;
public class Spgames {
	
	String dbuser = Dbinfo.value("username");
	String dbpassword = Dbinfo.value("password");
	String dbdatabase = Dbinfo.value("database");
	String dbhost = Dbinfo.value("host");
	String dbport = Dbinfo.value("port");
	
	String url;
	Connection con;
	public boolean setValues(){
		//To return true if connection is valid, else to return false.
		try {
		url = "jdbc:mysql://"+dbhost+":"+dbport+"/"+dbdatabase;
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		con = DriverManager.getConnection(url,dbuser,dbpassword);
		return true;
		}
		catch (Exception e) {
			
			e.printStackTrace();
			return false;
		}
	}
	public ResultSet select_sql(String sql) {
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			return ps.executeQuery();
		} catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	public ResultSet select_sql(String sql, Object field) {
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setObject(1, field);
			return ps.executeQuery();
		} catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	public ResultSet select_sql(String sql, Object[] fields) {
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			for(int i = 1; i <= fields.length; i++) {
				ps.setObject(i, fields[i-1]);
			}
			return ps.executeQuery();
		} catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	public boolean insert_sql(String sql, Object[] fields) {
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			for(int i = 1; i <= fields.length; i++) {
				ps.setObject(i, fields[i-1]);
			}
			ps.execute();
			return true;
		} catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	public boolean login(String username, String password) {
		try {
			ResultSet rs = select_sql("SELECT * from users WHERE username = ?", username);
	   if(rs.next()) {
		   String salt = rs.getString("salt");
		   String passwordsalt = rs.getString("password");
		   String salted = passwordhash(password, salt); 
		   if(passwordsalt.equalsIgnoreCase(salted)) {
			   return true;
		   } else {
			   return false;
		   }
	   } else {
		   return false;
	   }
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public String passwordhash(String password, String salt) {
		String passwordsalt = password + salt;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(passwordsalt.getBytes(StandardCharsets.UTF_8));
			StringBuilder hashed = new StringBuilder();
			for (byte b : hash) {
				hashed.append(String.format("%02x", b));
			}
			return hashed.toString().toUpperCase();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "-1";
		}

	}
	public ArrayList<game_entry> gamesList() {
		try {
			ResultSet rs = select_sql("SELECT * from games");
	    ArrayList<game_entry> results = new ArrayList<game_entry>();
			while(rs.next()) {
				game_entry row = new game_entry();
				row.game_id = Integer.parseInt(rs.getString("game_id"));
				row.game_title = rs.getString("game_title"); 
				row.company = rs.getString("company");
				row.release_date = rs.getString("release_date");
				row.description = rs.getString("description");
				row.price = rs.getString("price");
				row.image_location = rs.getString("image_location");
				row.preowned = Integer.parseInt(rs.getString("preowned"));
				ResultSet rs1 = select_sql("SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id ",rs.getString("game_id"));
				row.genres = new ArrayList<String>();
				while(rs1.next()) {
					row.genres.add(rs1.getString(2));
				}
				results.add(row);
			}
			return results;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}
	public game_entry get_game_info(int gameid) {
		try {
			ResultSet rs = select_sql("SELECT * from games WHERE game_id = ?", gameid);
			if (rs.next()) {
				game_entry row = new game_entry();
				row.game_id = Integer.parseInt(rs.getString("game_id"));
				row.game_title = rs.getString("game_title"); 
				row.company = rs.getString("company");
				row.release_date = rs.getString("release_date");
				row.description = rs.getString("description");
				row.price = rs.getString("price");
				row.image_location = rs.getString("image_location");
				row.preowned = Integer.parseInt(rs.getString("preowned"));
				ResultSet rs1 = select_sql("SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id ",rs.getString("game_id"));
				row.genres = new ArrayList<String>();
				while(rs1.next()) {
					row.genres.add(rs1.getString(2));
				}
				return row;
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}
	public void closeConnection() {
		try {
		con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public ArrayList<genres> get_genres() {
		try {
		ResultSet genres = select_sql("SELECT * FROM genre");
		ArrayList<genres> genre_list = new ArrayList<genres>(); 

		while(genres.next()) {
			genres row = new genres();
			row.genre_id = Integer.parseInt(genres.getString(0));
			row.genre_name = genres.getString(1);
			genre_list.add(row);
		}
		return genre_list;
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
	}
	public boolean update_genre(int genreid, String genrename) {
		try {
			Object[] tempobj = {genrename,genreid};
			return insert_sql("UPDATE `genre` SET `genre_name` = ? WHERE `genre`.`genre_id` = ?",tempobj);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public ArrayList<comment> get_comments(int gameid){
		try {
			ResultSet comments = select_sql("SELECT * from game_comments WHERE game_id = ?",gameid);
			ArrayList<comment> comments_list = new ArrayList<comment>();
			
			while(comments.next()) {
				comment row = new comment();
				row.comment_id = Integer.parseInt(comments.getString("comment_id"));
				row.game_id = Integer.parseInt(comments.getString("game_id"));
				row.username = comments.getString("username");
				row.rating = Integer.parseInt(comments.getString("rating"));
				row.review = comments.getString("review");
				comments_list.add(row);
			}
			return comments_list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	public boolean add_comment(comment commentObj) {
		try {
			Object[] comm = {commentObj.get_game_id(),commentObj.get_username(),commentObj.get_rating(),commentObj.get_review()};
			return insert_sql("INSERT INTO `game_comments` (`comment_id`, `game_id`, `username`, `rating`, `review`) VALUES (NULL, ?, ?, ?, ?)",comm);
		
		} catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
