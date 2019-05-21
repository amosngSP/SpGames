package db;

public class Dbinfo {
	static String username = "root";
	static String password = "";
	static String database = "spgames";
	static String user_database = "hexgear_user_db";
	static String host = "localhost";
	static String port = "3306";

	public static String value(String item) {
		switch (item) {
		case "username":
			return username;

		case "password":
			if (password.length() == 0) {
				return null;
			} else {
				return password;
			}
		case "database":
			return database;
		case "user_database":
			return user_database;
		case "host":
			return host;
		case "port":
			return port;
		default:
			return "";
		}
	}
}
