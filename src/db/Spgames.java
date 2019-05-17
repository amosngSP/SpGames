package db;
import java.io.InputStream;
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
	//Database connection
	public Connection connection() {
		return con;
	}
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
			System.out.println("ohno");
			e.printStackTrace();
			return false;
		}
	}
	public boolean insert_sql(String sql, Object field) {
		try {
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setObject(1, field);
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
	public boolean create_game(game_entry game, InputStream image) {
		try {
			System.out.println("create_game");
		PreparedStatement ps = con.prepareStatement("INSERT INTO `games` (`game_id`, `game_title`, `company`, `release_date`, `description`, `price`, `preowned`, `image_file`, `del`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, '0')");
		ps.setObject(1, game.get_game_title());
		ps.setObject(2, game.get_company());
		ps.setObject(3, game.get_release_date());
		ps.setObject(4, game.get_description());
		ps.setObject(5, game.get_price());
		ps.setObject(6, game.get_preowned());
		if(image != null) {
			ps.setBlob(7, image);
		} else {
			ps.setObject(7, null);
		}
		ps.execute();
		ResultSet rs = select_sql("SELECT game_id FROM games WHERE game_title = ?", game.get_game_title());
		String game_id = null;
		if(rs.next()) {
		game_id = rs.getString(1);
		} else {
			System.out.println("Error");
		}
		for (genres s: game.genres) {
			System.out.println(s);
			Object[] fields = {game_id,s.get_genre_id()};
			boolean insert = insert_sql("INSERT INTO `game_genre` (`id`, `game_id`, `genre_id`) VALUES (NULL, ?, ?)",fields);
			if (insert) {
				System.out.println("success");
			} else {
				System.out.println("fail");
			}
		}
		return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean updateGame(game_entry GameRow, InputStream image) {
		try {
			System.out.println("test");
		PreparedStatement ps = con.prepareStatement("UPDATE `games` SET `game_title` = ?, `company` = ?, `release_date` = ?, `description` = ?, `price` = ?, `preowned` = ?, `image_file` = ? WHERE `games`.`game_id` = ?");
		ps.setObject(1, GameRow.get_game_title());
		ps.setObject(2, GameRow.get_company());
		ps.setObject(3, GameRow.get_release_date());
		ps.setObject(4, GameRow.get_description());
		ps.setObject(5, GameRow.get_price());
		ps.setObject(6, GameRow.get_preowned());
		ps.setObject(8, GameRow.get_game_id());
		if(image != null) {
			ps.setBlob(7, image);
		} else {
			ps.setObject(7, null);
		}
		ps.execute();
		
		boolean deletegenres = insert_sql("DELETE FROM `game_genre` WHERE `game_id` = ?",GameRow.get_game_id());
		if(deletegenres) {
			System.out.println("Delete genres successfully");
		} else {
			System.out.println("nothing");
		}
		for (genres s: GameRow.genres) {
			System.out.println(s);
			Object[] fields = {GameRow.get_game_id(),s.get_genre_id()};
			boolean insert = insert_sql("INSERT INTO `game_genre` (`id`, `game_id`, `genre_id`) VALUES (NULL, ?, ?)",fields);
			if (insert) {
				System.out.println("success");
			} else {
				System.out.println("fail");
			}
		}
		return true;
		} catch (Exception e) {
			System.out.println("crash");
			e.printStackTrace();
			return false;
		}
	}
	public boolean updateGame(game_entry GameRow) {
		try {
			System.out.println("test");
		PreparedStatement ps = con.prepareStatement("UPDATE `games` SET `game_title` = ?, `company` = ?, `release_date` = ?, `description` = ?, `price` = ?, `preowned` = ? WHERE `game_id` = ?");
		ps.setObject(1, GameRow.get_game_title());
		ps.setObject(2, GameRow.get_company());
		ps.setObject(3, GameRow.get_release_date());
		ps.setObject(4, GameRow.get_description());
		ps.setObject(5, GameRow.get_price());
		ps.setObject(6, GameRow.get_preowned());
		ps.setObject(7, GameRow.get_game_id());

		ps.execute();
		
		boolean deletegenres = insert_sql("DELETE FROM `game_genre` WHERE `id` = ?",GameRow.get_game_id());
		if(deletegenres) {
			System.out.println("Delete genres successfully");
		} else {
			System.out.println("nothing");
		}
		for (genres s: GameRow.genres) {
			System.out.println(s);
			Object[] fields = {GameRow.get_game_id(),s.get_genre_id()};
			boolean insert = insert_sql("INSERT INTO `game_genre` (`id`, `game_id`, `genre_id`) VALUES (NULL, ?, ?)",fields);
			if (insert) {
				System.out.println("success");
			} else {
				System.out.println("fail");
			}
		}
		return true;
		} catch (Exception e) {
			System.out.println("crash");
			e.printStackTrace();
			return false;
		}}
	public ArrayList<game_entry> return_all_gamesList() {
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
				row.preowned = Integer.parseInt(rs.getString("preowned"));
				ResultSet rs1 = select_sql("SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id ",rs.getString("game_id"));
				row.genres = new ArrayList<genres>();
				while(rs1.next()) {
					genres temp = new genres();
					temp.genre_id = Integer.parseInt(rs1.getString("genre_id"));
					temp.genre_name = rs1.getString("genre_name");
					row.genres.add(temp);
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
	public ArrayList<game_entry> gamesList() {
		try {
			ResultSet rs = select_sql("SELECT * from games WHERE del = 0");
	    ArrayList<game_entry> results = new ArrayList<game_entry>();
			while(rs.next()) {
				game_entry row = new game_entry();
				row.game_id = Integer.parseInt(rs.getString("game_id"));
				row.game_title = rs.getString("game_title"); 
				row.company = rs.getString("company");
				row.release_date = rs.getString("release_date");
				row.description = rs.getString("description");
				row.price = rs.getString("price");
				row.preowned = Integer.parseInt(rs.getString("preowned"));
				ResultSet rs1 = select_sql("SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id ",rs.getString("game_id"));
				row.genres = new ArrayList<genres>();
				while(rs1.next()) {
					genres temp = new genres();
					temp.genre_name = rs1.getString(2);
					row.genres.add(temp);
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
			ResultSet rs = select_sql("SELECT * from games WHERE game_id = ? AND del = 0", gameid);
			if (rs.next()) {
				game_entry row = new game_entry();
				row.game_id = Integer.parseInt(rs.getString("game_id"));
				row.game_title = rs.getString("game_title"); 
				row.company = rs.getString("company");
				row.release_date = rs.getString("release_date");
				row.description = rs.getString("description");
				row.price = rs.getString("price");
				row.preowned = Integer.parseInt(rs.getString("preowned"));
				ResultSet rs1 = select_sql("SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id ",rs.getString("game_id"));
				row.genres = new ArrayList<genres>();
				while(rs1.next()) {
					genres temp = new genres();
					temp.genre_name = rs1.getString(2);
					row.genres.add(temp);
				}
				return row;
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}
	public java.sql.Blob get_image(int gameid) {
		try {
		ResultSet image_blob = select_sql("SELECT image_file FROM games WHERE game_id = ?",gameid);
		if(image_blob.next()) {
		java.sql.Blob image = image_blob.getBlob(1);
		return image;
		} else {
			return null;
		}
		} catch (Exception e) {
			e.printStackTrace();
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
			row.genre_id = Integer.parseInt(genres.getString(1));
			row.genre_name = genres.getString(2);
			genre_list.add(row);
		}
		return genre_list;
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
	}
	public int insert_genre(String genrename) {
		try {
			boolean ins = insert_sql("INSERT INTO `genre` (`genre_id`, `genre_name`, `del`) VALUES (NULL, ?, '0')\r\n",genrename);
			if(ins) {
			return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	public int update_genre(int genreid, String genrename) {
		try {
			Object[] tempobj = {genrename,genreid};
			boolean upd = insert_sql("UPDATE `genre` SET `genre_name` = ? WHERE `genre`.`genre_id` = ?",tempobj);
			if (upd) {
				return 0;
			} else {
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	public int delete_genre(int genreid) {
		try {
			ResultSet rs = select_sql("SELECT * FROM game_genre WHERE genre_id = ?", genreid);
			if(rs.next()) {
				return 1;
			} else {
				boolean del = insert_sql("UPDATE `genre` SET `del` = '1' WHERE `genre`.`genre_id` = ?",genreid);
				if (del) {
				return 0;
				} else {
					return -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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