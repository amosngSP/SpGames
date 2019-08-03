package db;

import java.sql.ResultSet;
import java.util.ArrayList;

public class GenresDAOImpl implements GenresDAO {
	private SqlDAO DBSQL;
	// private Connection con;

	public GenresDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		// con = DBSQL.GetConnectionObj();
	}

	public GenresDAOImpl() {
		DBSQL = new SqlDAOImpl();
		// con = DBSQL.GetConnectionObj();
	}

	public ArrayList<Genres> GetGenresList(int Del) {
		try {
			// 0 - not deleted, 1 - deleted, -1 - return all
			ResultSet genres;
			if (Del == -1) {
				genres = DBSQL.SelectSQL("SELECT * FROM genre");
			} else {
				genres = DBSQL.SelectSQL("SELECT * FROM genre WHERE deleted = ?", Del);
			}
			ArrayList<Genres> genre_list = new ArrayList<Genres>();

			while (genres.next()) {
				Genres row = new Genres(Integer.parseInt(genres.getString("id")), genres.getString("name"),
						Integer.parseInt(genres.getString("deleted")));
				genre_list.add(row);
			}
			return genre_list;
		} catch (Exception e) {

			e.printStackTrace();
			return null;
		}
	}

	public int InsertGenre(String GenreName) {
		try {
			boolean ins = DBSQL.InsertSQL("INSERT INTO `genre` (`id`, `name`, `deleted`) VALUES (NULL, ?, '0')\r\n",
					GenreName);
			if (ins) {
				return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public boolean UpdateGenre(int GenreID, String GenreName) {
		try {
			Object[] tempobj = { GenreName, GenreID };
			boolean upd = DBSQL.InsertSQL("UPDATE `genre` SET `name` = ? WHERE `genre`.`id` = ?", tempobj);
			if (upd) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public int DeleteGenre(int GenreID) {
		try {
			ResultSet rs = DBSQL.SelectSQL("SELECT * FROM gamegenre WHERE genreid = ?", GenreID);
			if (rs.next()) {
				return 1;
			} else {
				boolean del = DBSQL.InsertSQL("UPDATE `genre` SET `deleted` = '1' WHERE `genre`.`id` = ?", GenreID);
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

	public int UndoDeleteGenre(int GenreID) {
		try {

			boolean del = DBSQL.InsertSQL("UPDATE `genre` SET `deleted` = '0' WHERE `genre`.`id` = ?", GenreID);
			if (del) {
				return 0;
			} else {
				return -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
}