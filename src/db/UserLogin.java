package db;

import java.sql.ResultSet;

public class UserLogin {
	public boolean login(String username, String password) {
		try {
			SqlDAO UserDB = new SqlDAO("User");
			ResultSet rs = UserDB.SelectSQL("SELECT * from users WHERE username = ?", username);
			if (rs.next()) {
				String encpassword = rs.getString("password");
				PassCrypt crypto = new PassCrypt(password, encpassword);
				if (crypto.get().contentEquals("true")) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
