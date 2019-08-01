package htmlUtils;

import java.io.Serializable;

public class BootstrapAlerts implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2992227521011140152L;

	public BootstrapAlerts() {

	}

	public String CritAlert(String message) {
		String WarningBox = "<div class=\"alert alert-danger\">\r\n" + "  <strong>Error!</strong> " + message + " \r\n"
				+ "</div>";
		return WarningBox;
	}

	public String SuccessAlert(String message) {
		String SuccessBox = "<div class=\"alert alert-success\">\r\n" + "  <strong>Success!</strong> " + message
				+ "\r\n" + "</div>	";
		return SuccessBox;
	}
}
