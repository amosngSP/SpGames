package db;

import java.io.Serializable;

public class Sql implements Serializable {
	/**
	 * 
	 */

	private static final long serialVersionUID = 7617398029371141085L;
	private String Username = "root";
	private String Password = "rootroot";
	private String MainDatabase = "hexgear_store_db";
	private String Host = "aazwjnou032jg9.cb2sukrq6nwg.ap-southeast-1.rds.amazonaws.com";
	private String Port = "3306";

	public Sql() {

	}

	public String GetDBUsername() {
		return this.Username;
	}

	public String GetPassword() {
		return this.Password;
	}

	public String GetMainDatabase() {
		return this.MainDatabase;
	}

	public String GetHost() {
		return this.Host;
	}

	public String GetPort() {
		return this.Port;
	}
}
