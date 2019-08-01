package db;

import java.io.Serializable;

public class Sql implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7617398029371141085L;
	String Username = "root";
	String Password = "";
	String MainDatabase = "hexgear_store_db";
	String Host = "localhost";
	String Port = "3306";

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
