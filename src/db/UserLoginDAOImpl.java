package db;

import java.sql.Connection;
import java.sql.ResultSet;

public class UserLoginDAOImpl implements UserLoginDAO {
	SqlDAO DBSQL;
	Connection con;

	public UserLoginDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public UserLoginDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public void CloseConnection() {
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	public boolean Login(String username, String password) {
		try {
			ResultSet rs;
			ValidationUtils Check = new ValidationUtils();
			if (Check.checkEmail(username)) {
				System.out.println("Wow is an email");
				ResultSet rsemail = DBSQL.SelectSQL("SELECT * from userdata WHERE email = ?", username);
				if (rsemail.next()) {
					rs = DBSQL.SelectSQL("SELECT * from user WHERE id = ?", rsemail.getObject("userid"));
				} else {
					return false;
				}
			} else {
				rs = DBSQL.SelectSQL("SELECT * from user WHERE username = ?", username);
			}
			if (rs.next()) {
				String encpassword = rs.getString("shadow");
				PassCrypt crypto = new PassCrypt(password, encpassword);
				if (crypto.get().contentEquals("true")) {
					return true;
				} else {
					throw new NullPointerException("Password not match");
					// return false;
				}
			} else {
				System.out.println("noting returned");
				throw new NullPointerException("User does not exist in database");
			}
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
			return false;
		}
	}

	public UserLogin GetUserDetails(int userid) {
		try {
			UserLogin temp = new UserLogin();
			ResultSet rs = DBSQL.SelectSQL("SELECT * FROM user WHERE id = ?", userid);
			if (rs.next()) {
				temp.SetID(rs.getInt("id"));
				temp.SetUsername(rs.getString("username"));
				// omit shadow(for security)
				temp.SetAdmin(rs.getInt("admin"));
				temp.SetStatus(rs.getInt("status"));
			}
			ResultSet rs1 = DBSQL.SelectSQL("SELECT * FROM userdata WHERE userid = ?", userid);

			if (rs1.next()) {

				temp.SetDisplayName(rs1.getString("displayname"));
				temp.SetAddress(rs1.getString("address"));
				temp.SetEmail(rs1.getString("email"));
				temp.SetContactNumber(rs1.getString("contactnumber"));
				return temp;
			} else {

				return null;
			}
		} catch (Exception e) {

			e.printStackTrace();
			return null;
		}
	}

	public UserLogin GetUserDetails(String username) {
		try {
			UserLogin temp = new UserLogin();
			ResultSet rs;
			ValidationUtils Check = new ValidationUtils();
			if (Check.checkEmail(username)) {
				System.out.println("Wow is an email");
				ResultSet rsemail = DBSQL.SelectSQL("SELECT * from userdata WHERE email = ?", username);
				if (rsemail.next()) {
					rs = DBSQL.SelectSQL("SELECT * from user WHERE id = ?", rsemail.getObject("userid"));
				} else {
					return null;
				}
			} else {
				rs = DBSQL.SelectSQL("SELECT * FROM user WHERE username = ?", username);
			}
			int userid = -1;
			if (rs.next()) {
				userid = rs.getInt("id");
				temp.SetID(rs.getInt("id"));
				temp.SetUsername(rs.getString("username"));
				// omit shadow(for security)
				temp.SetAdmin(rs.getInt("admin"));
				temp.SetStatus(rs.getInt("status"));
			} else {
				System.out.println("RETURNING NOTHING" + username);
			}
			ResultSet rs1 = DBSQL.SelectSQL("SELECT * FROM userdata WHERE userid = ?", userid);

			if (rs1.next()) {

				temp.SetDisplayName(rs1.getString("displayname"));
				temp.SetAddress(rs1.getString("address"));
				temp.SetEmail(rs1.getString("email"));
				temp.SetContactNumber(rs1.getString("contactnumber"));
				return temp;
			} else {
				System.out.println("NULL?? WHAT");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean CheckDuplicate(String Field, String Value) {
		try {
			String sql1 = "SELECT * FROM `user` WHERE `?` = ?";
			Object[] temp1 = { Field, Value };
			ResultSet rs1 = DBSQL.SelectSQL(sql1, temp1);
			if (rs1.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public int GetNextUserID() {
		return DBSQL.GetA_INumber("user");
	}

	public boolean AddUser(UserLogin RegistrationDetails) {
		try {
			UserLogin RD = RegistrationDetails;
			// Grab Auto_increment ID for the next row that will be put in via database

			RD.SetID(GetNextUserID());
			// run query to insert registration in
			Object[] temp1 = { RD.GetUsername(), RD.GetShadow(), RD.GetAdmin(), RD.GetStatus() };
			String sql1 = "INSERT INTO `user` (`id`, `username`, `shadow`, `admin`, `status`) VALUES (NULL, ?, ?, ?, ?)";
			boolean is1 = DBSQL.InsertSQL(sql1, temp1);
			if (is1) {
				// successfully inserted
				String sql2 = "INSERT INTO `userdata` (`userid`, `displayname`, `address`, `email`, `contactnumber`) VALUES (?, ?, ?, ?, ?)";
				Object[] temp2 = { RD.GetID(), RD.GetDisplayName(), RD.GetAddress(), RD.GetEmail(),
						RD.GetContactNumber() };
				return DBSQL.InsertSQL(sql2, temp2);

			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UpdateUserInfo(UserLogin UserDetails) {
		try {
			UserLogin UD = UserDetails;
			String sql1 = "UPDATE `userdata` SET `displayname` = ?, `address` = ?, `email` = ?, `contactnumber` = ? WHERE `userdata`.`userid` = ?";
			Object[] temp1 = { UD.GetDisplayName(), UD.GetAddress(), UD.GetEmail(), UD.GetContactNumber(), UD.GetID() };
			return DBSQL.InsertSQL(sql1, temp1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UpdateUsername(UserLogin UserDetails) {
		try {
			UserLogin UD = UserDetails;
			String sql1 = "UPDATE `user` SET `username` = ? WHERE `user`.`userid` = ?";
			Object[] temp1 = { UD.GetUsername(), UD.GetID() };
			return DBSQL.InsertSQL(sql1, temp1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UpdateAdminStatus(UserLogin UserDetails) {
		try {
			UserLogin UD = UserDetails;
			String sql1 = "UPDATE `user` SET `admin` = ? WHERE `user`.`userid` = ?";
			Object[] temp1 = { UD.GetAdmin(), UD.GetID() };
			return DBSQL.InsertSQL(sql1, temp1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UpdateUserStatus(UserLogin UserDetails) {
		try {
			UserLogin UD = UserDetails;
			String sql1 = "UPDATE `user` SET `status` = ? WHERE `user`.`userid` = ?";
			Object[] temp1 = { UD.GetStatus(), UD.GetID() };
			return DBSQL.InsertSQL(sql1, temp1);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
