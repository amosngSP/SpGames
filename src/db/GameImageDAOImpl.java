package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GameImageDAOImpl implements GameImageDAO {
	private SqlDAO DBSQL;
	private Connection con;

	public GameImageDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public GameImageDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public boolean AddGameImage(GameImage GameImageObj) {
		try {
			String sqlstatement = "INSERT INTO `gameimage` (`gameid`,`image`) VALUES (?,?)";
			PreparedStatement ps = con.prepareStatement(sqlstatement);
			ps.setObject(1, GameImageObj.GetGameID());
			if (GameImageObj.GetImage() != null) {
				System.out.println("Adding image..");
				ps.setBlob(2, GameImageObj.GetImage());
			} else {
				System.out.println("No image..");
				ps.setObject(2, null);
			}
			return ps.execute();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UpdateGameImage(GameImage GameImageObj) {
		try {
			String sqlstatement = "UPDATE `gameimage` SET `image` = ? WHERE `gameimage`.`gameid` = ?";
			PreparedStatement ps = con.prepareStatement(sqlstatement);
			ps.setBlob(1, GameImageObj.GetImage());
			ps.setObject(2, GameImageObj.GetGameID());
			boolean temp = ps.execute();
			System.out.println("Game image update: " + temp);
			return temp;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean RemoveGameImage(GameImage GameImageObj) {
		try {
			String sqlstatement = "UPDATE `gameimage` SET `image` = ? WHERE `gameimage`.`gameid` = ?";
			PreparedStatement ps = con.prepareStatement(sqlstatement);
			ps.setObject(1, null);
			ps.setObject(2, GameImageObj.GetGameID());
			return ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public java.sql.Blob GetGameImage(int GameID) {
		try {
			String sqlstatement = "SELECT `image` FROM `gameimage` WHERE `gameid` = ?";
			ResultSet rs = DBSQL.SelectSQL(sqlstatement, GameID);
			if (rs.next()) {
				java.sql.Blob image = rs.getBlob(1);
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
