package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SqlDAOImpl implements SqlDAO {
	private Sql DBInfo = new Sql();
	private String dbuser = DBInfo.GetDBUsername();
	private String dbpassword = DBInfo.GetPassword();
	private String dbdatabase = DBInfo.GetMainDatabase();
	private String dbhost = DBInfo.GetHost();
	private String dbport = DBInfo.GetPort();
	private String url;
	private Connection con;

	public SqlDAOImpl() {
		// Establish Database Connection
		try {
			url = "jdbc:mysql://" + dbhost + ":" + dbport + "/" + dbdatabase;
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, dbuser, dbpassword);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	public Connection GetConnectionObj() {
		return con;
	}

	public void CloseConnection() {
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet SelectSQL(String sql) {
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			return ps.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ResultSet SelectSQL(String sql, Object field) {
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setObject(1, field);
			return ps.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ResultSet SelectSQL(String sql, Object[] fields) {
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			for (int i = 1; i <= fields.length; i++) {
				ps.setObject(i, fields[i - 1]);
			}
			return ps.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean InsertSQL(String sql, Object field) {
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setObject(1, field);
			ps.execute();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean InsertSQL(String sql, Object[] fields) {
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			for (int i = 1; i <= fields.length; i++) {
				ps.setObject(i, fields[i - 1]);
			}
			ps.execute();
			return true;

		} catch (Exception e) {
			System.out.println("ohno");
			e.printStackTrace();
			return false;
		}
	}

	public int GetA_INumber(String table) {
		try {
			// Information Schema
			String sqlID = "SELECT id FROM " + table + " ORDER BY id DESC";
			ResultSet rs = SelectSQL(sqlID);
			if (rs.next()) {
				return Integer.parseInt(rs.getString(1)) + 1;
			} else {
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}
