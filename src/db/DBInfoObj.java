package db;

public class DBInfoObj {
	String Username = "root";
	String Password = "";
	String MainDatabase = "spgames";
	String UserDatabase = "hexgear_user_db";
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

	public String GetUserDatabase() {
		return this.UserDatabase;
	}

	public String GetHost() {
		return this.Host;
	}

	public String GetPort() {
		return this.Port;
	}
}
