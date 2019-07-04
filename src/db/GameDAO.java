package db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GameDAO {
	SqlDAO DBSQL = new SqlDAO();
	Connection con = DBSQL.GetConnectionObj();

	public void CloseConnection() {
		DBSQL.closeConnection();
	}

	public boolean CreateGame(GameEntryObj Game, InputStream Image) {
		try {
			System.out.println("create_game");
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO `games` (`game_id`, `game_title`, `company`, `release_date`, `description`, `price`, `preowned`, `image_file`, `del`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, '0')");
			ps.setObject(1, Game.GetGameTitle());
			ps.setObject(2, Game.GetCompany());
			ps.setObject(3, Game.GetReleaseDate());
			ps.setObject(4, Game.GetDescription());
			ps.setObject(5, Game.GetPrice());
			ps.setObject(6, Game.GetPreOwned());
			if (Image != null) {
				ps.setBlob(7, Image);
			} else {
				ps.setObject(7, null);
			}
			ps.execute();
			ResultSet rs = DBSQL.SelectSQL("SELECT game_id FROM games WHERE game_title = ?", Game.GetGameTitle());
			String game_id = null;
			if (rs.next()) {
				game_id = rs.getString(1);
			} else {
				System.out.println("Error");
			}
			for (GenresObj s : Game.GetGenres()) {
				System.out.println(s);
				Object[] fields = { game_id, s.GetGenreID() };
				boolean insert = DBSQL.InsertSQL(
						"INSERT INTO `game_genre` (`id`, `game_id`, `genre_id`) VALUES (NULL, ?, ?)", fields);
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

	public boolean UpdateGame(GameEntryObj GameRow, InputStream image) {
		try {
			System.out.println("test");
			PreparedStatement ps = con.prepareStatement(
					"UPDATE `games` SET `game_title` = ?, `company` = ?, `release_date` = ?, `description` = ?, `price` = ?, `preowned` = ?, `image_file` = ? WHERE `games`.`game_id` = ?");
			ps.setObject(1, GameRow.GetGameTitle());
			ps.setObject(2, GameRow.GetCompany());
			ps.setObject(3, GameRow.GetReleaseDate());
			ps.setObject(4, GameRow.GetDescription());
			ps.setObject(5, GameRow.GetPrice());
			ps.setObject(6, GameRow.GetPreOwned());
			ps.setObject(8, GameRow.GetGameID());
			if (image != null) {
				ps.setBlob(7, image);
			} else {
				ps.setObject(7, null);
			}
			ps.execute();

			DBSQL.InsertSQL("DELETE FROM `game_genre` WHERE `game_id` = ?", GameRow.GetGameID());

			for (GenresObj s : GameRow.GetGenres()) {
				System.out.println(s);
				Object[] fields = { GameRow.GetGameID(), s.GetGenreID() };
				boolean insert = DBSQL.InsertSQL(
						"INSERT INTO `game_genre` (`id`, `game_id`, `genre_id`) VALUES (NULL, ?, ?)", fields);
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

	public boolean delete_game(int game_id) {
		try {
			return DBSQL.InsertSQL("UPDATE `games` SET `del` = 1 WHERE `game_id` = ?", game_id);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean undelete_game(int game_id) {
		try {
			// Check if game has a deleted genre

			return DBSQL.InsertSQL("UPDATE `games` SET `del` = 0 WHERE `game_id` = ?", game_id);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ArrayList<GameEntryObj> return_all_gamesList(int del) {
		try {
			ResultSet rs;
			if (del == 0) {
				rs = DBSQL.SelectSQL("SELECT * from games WHERE del = 0");
			} else if (del == 1) {
				rs = DBSQL.SelectSQL("SELECT * from games");
			} else {
				rs = DBSQL.SelectSQL("SELECT * from games WHERE del = 0");
			}
			ArrayList<GameEntryObj> results = new ArrayList<GameEntryObj>();
			while (rs.next()) {
				GameEntryObj row = new GameEntryObj(Integer.parseInt(rs.getString("game_id")),
						rs.getString("game_title"), rs.getString("company"), rs.getString("release_date"),
						rs.getString("description"), rs.getString("price"), Integer.parseInt(rs.getString("preowned")),
						Integer.parseInt(rs.getString("del")));
				ResultSet rs1 = DBSQL.SelectSQL(
						"SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G, genre GE WHERE gg.game_id = ? AND gg.genre_id = G.genre_id AND gg.genre_id = GE.genre_id AND GE.del = 0",
						rs.getString("game_id"));
				ArrayList<GenresObj> temp1 = new ArrayList<GenresObj>();
				while (rs1.next()) {
					GenresObj temp = new GenresObj();
					temp.SetGenreID(Integer.parseInt(rs1.getString("genre_id")));
					temp.SetGenreName(rs1.getString("genre_name"));
					temp1.add(temp);
				}
				row.SetGenresList(temp1);
				results.add(row);
			}
			return results;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

	/*
	 * public ArrayList<GameEntryObj> return_all_gamesList() { try { ResultSet rs;
	 * rs = DBSQL.SelectSQL("SELECT * from games WHERE del = 0");
	 * 
	 * ArrayList<GameEntryObj> results = new ArrayList<GameEntryObj>(); while
	 * (rs.next()) { GameEntryObj row = new GameEntryObj(); row.game_id =
	 * Integer.parseInt(rs.getString("game_id")); row.game_title =
	 * rs.getString("game_title"); row.company = rs.getString("company");
	 * row.release_date = rs.getString("release_date"); row.description =
	 * rs.getString("description"); row.price = rs.getString("price"); row.preowned
	 * = Integer.parseInt(rs.getString("preowned")); row.deleted =
	 * Integer.parseInt(rs.getString("del")); ResultSet rs1 = DBSQL.SelectSQL(
	 * "SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G, genre GE WHERE gg.game_id = ? AND gg.genre_id = G.genre_id AND gg.genre_id = GE.genre_id AND GE.del = 0"
	 * , rs.getString("game_id")); row.genres = new ArrayList<genres>(); while
	 * (rs1.next()) { genres temp = new genres(); temp.genre_id =
	 * Integer.parseInt(rs1.getString("genre_id")); temp.genre_name =
	 * rs1.getString("genre_name"); row.genres.add(temp); } results.add(row); }
	 * return results; } catch (SQLException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); return null; }
	 * 
	 * }
	 */

	/*
	 * public ArrayList<GameEntryObj> gamesList() { try { ResultSet rs =
	 * DBSQL.SelectSQL("SELECT * from games WHERE del = 0"); ArrayList<GameEntryObj>
	 * results = new ArrayList<GameEntryObj>(); while (rs.next()) { GameEntryObj row
	 * = new GameEntryObj(); row.game_id =
	 * Integer.parseInt(rs.getString("game_id")); row.game_title =
	 * rs.getString("game_title"); row.company = rs.getString("company");
	 * row.release_date = rs.getString("release_date"); row.description =
	 * rs.getString("description"); row.price = rs.getString("price"); row.preowned
	 * = Integer.parseInt(rs.getString("preowned")); ResultSet rs1 =
	 * DBSQL.SelectSQL(
	 * "SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id AND G.del = 0"
	 * , rs.getString("game_id")); row.genres = new ArrayList<genres>(); while
	 * (rs1.next()) { genres temp = new genres(); temp.genre_name =
	 * rs1.getString(2); row.genres.add(temp); } results.add(row); } return results;
	 * } catch (SQLException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); return null; }
	 * 
	 * }
	 */

	public ArrayList<GameEntryObj> preownedGamesList(int PreOwned) {
		try {
			ResultSet rs = DBSQL.SelectSQL("SELECT * from games WHERE del = 0 AND preowned = ?", PreOwned);
			ArrayList<GameEntryObj> results = new ArrayList<GameEntryObj>();
			while (rs.next()) {
				GameEntryObj row = new GameEntryObj(Integer.parseInt(rs.getString("game_id")),
						rs.getString("game_title"), rs.getString("company"), rs.getString("release_date"),
						rs.getString("description"), rs.getString("price"), Integer.parseInt(rs.getString("preowned")),
						Integer.parseInt(rs.getString("del")));
				ResultSet rs1 = DBSQL.SelectSQL(
						"SELECT gg.game_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id AND G.del = 0 ",
						rs.getString("game_id"));
				ArrayList<GenresObj> temp1 = new ArrayList<GenresObj>();
				while (rs1.next()) {
					GenresObj temp = new GenresObj();
					temp.SetGenreID(Integer.parseInt(rs1.getString("genre_id")));
					temp.SetGenreName(rs1.getString("genre_name"));
					temp1.add(temp);
				}
				row.SetGenresList(temp1);
				results.add(row);
			}
			return results;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

	public java.sql.Blob get_image(int gameid) {
		try {
			ResultSet image_blob = DBSQL.SelectSQL("SELECT image_file FROM games WHERE game_id = ?", gameid);
			if (image_blob.next()) {
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
}
