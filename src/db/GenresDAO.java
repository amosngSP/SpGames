package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GenresDAO {
	SqlDAO DBSQL = new SqlDAO();
	Connection con = DBSQL.GetConnectionObj();

	public ArrayList<GenresObj> get_genres(int del) {
		try {
			ResultSet genres = DBSQL.SelectSQL("SELECT * FROM genre WHERE del = ?", del);
			ArrayList<GenresObj> genre_list = new ArrayList<GenresObj>();

			while (genres.next()) {
				GenresObj row = new GenresObj(Integer.parseInt(genres.getString("genre_id")),
						genres.getString("genre_name"), Integer.parseInt(genres.getString("del")));
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
			boolean ins = DBSQL.InsertSQL(
					"INSERT INTO `genre` (`genre_id`, `genre_name`, `del`) VALUES (NULL, ?, '0')\r\n", genrename);
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

	public boolean update_genre(int genreid, String genrename) {
		try {
			Object[] tempobj = { genrename, genreid };
			boolean upd = DBSQL.InsertSQL("UPDATE `genre` SET `genre_name` = ? WHERE `genre`.`genre_id` = ?", tempobj);
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

	public int delete_genre(int genreid) {
		try {
			ResultSet rs = DBSQL.SelectSQL("SELECT * FROM game_genre WHERE genre_id = ?", genreid);
			if (rs.next()) {
				return 1;
			} else {
				boolean del = DBSQL.InsertSQL("UPDATE `genre` SET `del` = '1' WHERE `genre`.`genre_id` = ?", genreid);
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

	public int undelete_genre(int genreid) {
		try {

			boolean del = DBSQL.InsertSQL("UPDATE `genre` SET `del` = '0' WHERE `genre`.`genre_id` = ?", genreid);
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
