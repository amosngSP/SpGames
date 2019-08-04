package db;

import java.sql.Connection;
import java.sql.ResultSet;

public class GameVideoDAOImpl implements GameVideoDAO {
	private SqlDAO DBSQL;
	private Connection con;

	public GameVideoDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public GameVideoDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public GameVideo Get_Game_Video(int gameid) {
		try {
			String SQL_1 = "SELECT * FROM gamevideo WHERE gameid = ?";
			ResultSet rs_1 = DBSQL.SelectSQL(SQL_1, gameid);
			if (rs_1.next()) {
				GameVideo temp = new GameVideo(gameid, rs_1.getString("video"));
				return temp;
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean Add_Game_Video(GameVideo Game_Video) {
		try {
			String videourl = null;
			if (Game_Video.GetVideoURL() == null) {
				videourl = null;
			} else if (Game_Video.GetVideoURL().trim().length() != 0) {
				videourl = Game_Video.GetVideoURL();
			} else {
				videourl = null;
			}
			String SQL_1 = "INSERT INTO `gamevideo` (`gameid`, `video`) VALUES (?, ?)";
			Object[] Temp_1 = { Game_Video.GetGameID(), Game_Video.GetVideoURL() };
			return DBSQL.InsertSQL(SQL_1, Temp_1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean Update_Game_Video(GameVideo Game_Video) {
		try {
			String SQL_1 = "UPDATE `gamevideo` SET `video` = ? WHERE `gamevideo`.`gameid` = ?";
			Object[] Temp_1 = { Game_Video.GetVideoURL(), Game_Video.GetGameID() };
			return DBSQL.InsertSQL(SQL_1, Temp_1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
