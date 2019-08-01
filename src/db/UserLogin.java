package db;

import java.io.Serializable;

public class UserLogin implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1460336266503793878L;
	int id;
	String username;
	String shadow;
	String password;
	int admin;
	int status;
	String displayname;
	String address;
	String email;
	String contactnumber;

	public UserLogin() {

	}

	public UserLogin(int id, String username, String shadow, int admin, int status, String displayname, String address,
			String email, String contactnumber) {
		// use for grabbing info from database
		this.id = id;
		this.username = username;
		this.shadow = shadow;
		this.admin = admin;
		this.status = status;
		this.displayname = displayname;
		this.address = address;
		this.email = email;
		this.contactnumber = contactnumber;
	}

	public UserLogin(String username, String password, String displayname, String address, String email,
			String contactnumber) {
		// new registration
		this.username = username;
		this.password = password;
		this.displayname = displayname;
		this.address = address;
		this.email = email;
		this.contactnumber = contactnumber;
	}

	public void SetID(int ID) {
		this.id = ID;
	}

	public void SetUsername(String Username) {
		this.username = Username;
	}

	public void SetShadow(String Shadow) {
		this.shadow = Shadow;
	}

	public void SetPassword(String Password) {
		this.password = Password;
	}

	public void SetAdmin(int Admin) {
		this.admin = Admin;
	}

	public void SetStatus(int Status) {
		this.status = Status;
	}

	public void SetDisplayName(String DisplayName) {
		this.displayname = DisplayName;
	}

	public void SetAddress(String Address) {
		this.address = Address;
	}

	public void SetEmail(String Email) {
		this.email = Email;
	}

	public void SetContactNumber(String ContactNumber) {
		this.contactnumber = ContactNumber;
	}

	public int GetID() {
		return this.id;
	}

	public String GetUsername() {
		return this.username;
	}

	public String GetShadow() {
		if (this.shadow != null) {

			return this.shadow;
		} else {
			this.GenerateShadow();
			return this.shadow;
		}
	}

	public String GetPassword() {
		return this.password;
	}

	public int GetAdmin() {
		return this.admin;
	}

	public int GetStatus() {
		if (this.status != 0) {
			return this.status;
		} else {
			// default is 0 if not set
			return this.status;
		}

	}

	public String GetDisplayName() {
		return this.displayname;
	}

	public String GetAddress() {
		return this.address;
	}

	public String GetEmail() {
		return this.email;
	}

	public String GetContactNumber() {
		return this.contactnumber;
	}

	public void GenerateShadow() {
		PassCrypt PassShadow = new PassCrypt(GetPassword());
		SetShadow(PassShadow.get());
	}
}
