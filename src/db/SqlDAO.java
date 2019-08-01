package db;

import java.sql.Connection;
import java.sql.ResultSet;

public interface SqlDAO {
	public Connection GetConnectionObj();

	public void CloseConnection();

	public ResultSet SelectSQL(String sql);

	public ResultSet SelectSQL(String sql, Object field);

	public ResultSet SelectSQL(String sql, Object[] fields);

	public boolean InsertSQL(String sql, Object field);

	public boolean InsertSQL(String sql, Object[] fields);

	public int GetA_INumber(String table);
}
