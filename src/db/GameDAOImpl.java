package db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GameDAOImpl implements GameDAO {
	private SqlDAO DBSQL;
	private Connection con;

	public GameDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public GameDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public void CloseConn() {
		DBSQL.CloseConnection();
	}

	public boolean CreateGame(Game Game, InputStream Image) {
		try {
			System.out.println("create_game");
			Game.SetGameID(DBSQL.GetA_INumber("game"));
			System.out.println("Game ID Generated:" + Game.GetGameID());
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO `game` (`id`, `preowned`,`gametitle`, `company`, `releasedate`, `description`, `price`, `quantity`, `deleted`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, '0')");
			ps.setObject(1, Game.GetPreOwned());
			ps.setObject(2, Game.GetGameTitle());
			ps.setObject(3, Game.GetCompany());
			ps.setObject(4, Game.GetReleaseDate());
			ps.setObject(5, Game.GetDescription());
			ps.setObject(6, Game.GetPrice());
			ps.setObject(7, Game.GetQty());
			ps.execute();

			GameImageDAO GameImage_DAO = new GameImageDAOImpl(DBSQL);
			GameImage temp = new GameImage();
			temp.SetGameID(Game.GetGameID());
			temp.SetImage(Image);
			GameImage_DAO.AddGameImage(temp);

			for (Genres s : Game.GetGenres()) {
				System.out.println(s);
				Object[] fields = { Game.GetGameID(), s.GetGenreID() };
				boolean insert = DBSQL.InsertSQL("INSERT INTO `gamegenre` (`gameid`, `genreid`) VALUES ( ?, ?)",
						fields);
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

	public boolean UpdateGame(Game GameRow, InputStream Image) {
		try {
			System.out.println("test");
			PreparedStatement ps = con.prepareStatement(
					"UPDATE `game` SET `gametitle` = ?, `company` = ?, `releasedate` = ?, `description` = ?, `price` = ?, `preowned` = ?, `quantity` = ? WHERE `game`.`id` = ?");
			ps.setObject(1, GameRow.GetGameTitle());
			ps.setObject(2, GameRow.GetCompany());
			ps.setObject(3, GameRow.GetReleaseDate());
			ps.setObject(4, GameRow.GetDescription());
			ps.setObject(5, GameRow.GetPrice());
			ps.setObject(6, GameRow.GetPreOwned());
			ps.setObject(7, GameRow.GetQty());
			ps.setObject(8, GameRow.GetGameID());
			ps.execute();
			GameImage GameData = new GameImage();
			GameData.SetGameID(GameRow.GetGameID());
			GameData.SetImage(Image);
			GameImageDAO GameImage_DAO = new GameImageDAOImpl();
			boolean UpdatedGame = GameImage_DAO.UpdateGameImage(GameData);
			if (UpdatedGame) {
				System.out.println("True, Image was updated.");
			} else {
				System.out.println("Well, something went wrong.");
			}
			DBSQL.InsertSQL("DELETE FROM `gamegenre` WHERE `gameid` = ?", GameRow.GetGameID());

			for (Genres s : GameRow.GetGenres()) {
				System.out.println(s);
				Object[] fields = { GameRow.GetGameID(), s.GetGenreID() };
				boolean insert = DBSQL.InsertSQL("INSERT INTO `gamegenre` (`gameid`, `genreid`) VALUES (?, ?)", fields);
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

	public boolean UpdateGame(Game GameRow) {
		try {
			System.out.println("test");
			PreparedStatement ps = con.prepareStatement(
					"UPDATE `game` SET `gametitle` = ?, `company` = ?, `releasedate` = ?, `description` = ?, `price` = ?, `preowned` = ?, `quantity` = ? WHERE `game`.`id` = ?");
			ps.setObject(1, GameRow.GetGameTitle());
			ps.setObject(2, GameRow.GetCompany());
			ps.setObject(3, GameRow.GetReleaseDate());
			ps.setObject(4, GameRow.GetDescription());
			ps.setObject(5, GameRow.GetPrice());
			ps.setObject(6, GameRow.GetPreOwned());
			ps.setObject(7, GameRow.GetQty());
			ps.setObject(8, GameRow.GetGameID());
			ps.execute();

			DBSQL.InsertSQL("DELETE FROM `gamegenre` WHERE `gameid` = ?", GameRow.GetGameID());

			for (Genres s : GameRow.GetGenres()) {
				System.out.println(s);
				Object[] fields = { GameRow.GetGameID(), s.GetGenreID() };
				boolean insert = DBSQL.InsertSQL("INSERT INTO `gamegenre` (`gameid`, `genreid`) VALUES (?, ?)", fields);
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

	public boolean DeleteGame(int GameID) {
		try {
			return DBSQL.InsertSQL("UPDATE `game` SET `deleted` = 1 WHERE `id` = ?", GameID);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UndoDeleteGame(int GameID) {
		try {
			// Check if game has a deleted genre

			return DBSQL.InsertSQL("UPDATE `game` SET `deleted` = 0 WHERE `id` = ?", GameID);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public Game GetGameInfo(int gameid) {
		try {
			ResultSet rs = DBSQL.SelectSQL("SELECT * from game WHERE id = ?", gameid);
			if (rs.next()) {
				Game row = new Game(Integer.parseInt(rs.getString("id")), Integer.parseInt(rs.getString("preowned")),
						rs.getString("gametitle"), rs.getString("company"), rs.getString("releasedate"),
						rs.getString("description"), rs.getString("price"), Integer.parseInt(rs.getString("quantity")));
				ResultSet rs1 = DBSQL.SelectSQL(
						"SELECT gg.gameid, G.name FROM gamegenre gg, genre G WHERE gg.gameid = ? AND gg.genreid = G.id",
						rs.getString("id"));
				ArrayList<Genres> temparray = new ArrayList<Genres>();
				while (rs1.next()) {
					Genres temp = new Genres();
					temp.SetGenreName(rs1.getString(2));
					temparray.add(temp);
				}
				row.SetGenresList(temparray);
				return row;
			} else {
				System.out.println("Function returning null");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Crashed!");
			return null;
		}
	}

	public boolean DeductQty(int gameid, int qtytodeduct) {
		try {
			String SQL_1 = "SELECT quantity FROM game WHERE id = ?";
			ResultSet rs = DBSQL.SelectSQL(SQL_1, gameid);
			if (rs.next()) {
				int qty = rs.getInt("quantity");
				int updatedqty = qty - qtytodeduct;
				String SQL_Update = "UPDATE `game` SET `quantity` = ? WHERE `game`.`id` = ?";
				Object[] tempobj = { updatedqty, gameid };
				if (DBSQL.InsertSQL(SQL_Update, tempobj)) {
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

	public ArrayList<Game> GetGamesList(int Del) {
		try {
			// 0 -> not deleted games 1 -> deleted games -1 or any other integer -> all
			// whether deleted or not
			ResultSet rs;
			if (Del == 0) {
				rs = DBSQL.SelectSQL("SELECT * from game WHERE deleted = 0");
			} else if (Del == 1) {
				rs = DBSQL.SelectSQL("SELECT * from game WHERE deleted = 1");
			} else {
				rs = DBSQL.SelectSQL("SELECT * from game");
			}
			ArrayList<Game> results = new ArrayList<Game>();
			if (rs != null) {
				while (rs.next()) {
					Game row = new Game(Integer.parseInt(rs.getString("id")),
							Integer.parseInt(rs.getString("preowned")), rs.getString("gametitle"),
							rs.getString("company"), rs.getString("releasedate"), rs.getString("description"),
							rs.getString("price"), rs.getInt("quantity"), rs.getInt("deleted"));
					ResultSet rs1 = DBSQL.SelectSQL(
							"SELECT gg.gameid, G.id, G.name FROM gamegenre gg, genre G, genre GE WHERE gg.gameid = ? AND gg.genreid = G.id AND gg.genreid = GE.id AND GE.deleted = 0",
							rs.getString("id"));
					ArrayList<Genres> temp1 = new ArrayList<Genres>();
					while (rs1.next()) {
						Genres temp = new Genres();
						temp.SetGenreID(Integer.parseInt(rs1.getString("id")));
						temp.SetGenreName(rs1.getString("name"));
						temp1.add(temp);
					}
					row.SetGenresList(temp1);
					results.add(row);
				}
			} else {
				return null;
			}
			return results;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

	public ArrayList<Game> GetGamesReport(int qty) {
		try {
			// 0 -> not deleted games 1 -> deleted games -1 or any other integer -> all
			// whether deleted or not
			ResultSet rs = DBSQL.SelectSQL("SELECT * from game WHERE quantity < ?", qty);

			ArrayList<Game> results = new ArrayList<Game>();
			while (rs.next()) {
				Game row = new Game(Integer.parseInt(rs.getString("id")), Integer.parseInt(rs.getString("preowned")),
						rs.getString("gametitle"), rs.getString("company"), rs.getString("releasedate"),
						rs.getString("description"), rs.getString("price"), rs.getInt("quantity"),
						rs.getInt("deleted"));
				ResultSet rs1 = DBSQL.SelectSQL(
						"SELECT gg.gameid, G.id, G.name FROM gamegenre gg, genre G, genre GE WHERE gg.gameid = ? AND gg.genreid = G.id AND gg.genreid = GE.id AND GE.deleted = 0",
						rs.getString("id"));
				ArrayList<Genres> temp1 = new ArrayList<Genres>();
				while (rs1.next()) {
					Genres temp = new Genres();
					temp.SetGenreID(Integer.parseInt(rs1.getString("id")));
					temp.SetGenreName(rs1.getString("name"));
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

	public ArrayList<Game> GetPreownedGamesList(int PreOwned) {
		try {
			ResultSet rs;
			rs = DBSQL.SelectSQL("SELECT * from game WHERE deleted = 0 AND preowned = ?", PreOwned);
			ArrayList<Game> results = new ArrayList<Game>();
			if (rs != null) {
				while (rs.next()) {
					Game row = new Game(Integer.parseInt(rs.getString("id")),
							Integer.parseInt(rs.getString("preowned")), rs.getString("gametitle"),
							rs.getString("company"), rs.getString("releasedate"), rs.getString("description"),
							rs.getString("price"), rs.getInt("quantity"), rs.getInt("deleted"));
					ResultSet rs1 = DBSQL.SelectSQL(
							"SELECT gg.gameid, G.name FROM gamegenre gg, genre G WHERE gg.gameid = ? AND gg.genreid = G.id AND G.deleted = 0 ",
							rs.getString("id"));
					ArrayList<Genres> temp1 = new ArrayList<Genres>();
					while (rs1.next()) {
						Genres temp = new Genres();
						temp.SetGenreName(rs1.getString("name"));
						temp1.add(temp);
					}
					row.SetGenresList(temp1);
					results.add(row);
				}
			} else {
				return null;
			}
			return results;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

	}

}
