package db;

public interface UserLoginDAO {
	public boolean Login(String username, String password);

	public boolean CheckDuplicate(String Field, String Value);

	public boolean AddUser(UserLogin RegistrationDetails);

	public boolean UpdateUserInfo(UserLogin UserDetails);

	public void CloseConnection();

	public UserLogin GetUserDetails(String username);

	public UserLogin GetUserDetails(int userid);

	public int GetNextUserID();
}
