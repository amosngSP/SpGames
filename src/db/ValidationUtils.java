package db;

public class ValidationUtils {
	public ValidationUtils() {

	}

	public boolean checkEmail(String email) {
		String emailregex = "^\\w+@\\w+\\.\\w+$";
		return email.matches(emailregex);
	}

	public boolean isNull(Object o1) {
		// checks if value is null or has no input
		return (o1 == null || o1.toString().trim().length() == 0);
	} // end of method

	public boolean isInt(Object o1) {
		try {
			int testint = Integer.parseInt((String) o1);
			// Can be parsed as integer
			return true;
		} catch (Exception e) {
			// Not integer
			return false;
		}
	}

	public int checkPassword(String password) {
		// Requirements:
		// Length 8 to 16
		// Both lowercase and uppercase characters
		// Contain numbers

		// Return 0 ->Password is OK
		// Return 1 ->Password too short
		// Return 2 ->Password too long
		// Return 3 ->Password does not meet regex
		String passwordregex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";

		if (password.length() < 8) {
			return 1;
		} else if (password.length() > 16) {
			return 2;
		} else if (!(password.matches(passwordregex))) {
			return 3;
		} else {
			return 0;
		}
	}
}
