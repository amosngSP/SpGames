package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.UserLogin;
import db.UserLoginDAO;
import db.UserLoginDAOImpl;
import db.ValidationUtils;

/**
 * Servlet implementation class ServletRegister
 */
@WebServlet("/ServletRegister")
public class ServletRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletRegister() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		String email = request.getParameter("email").trim();
		String contact = request.getParameter("contact").trim();
		String displayname = request.getParameter("displayname").trim();
		String address = request.getParameter("address").trim();

		String emailregex = "^[\\w\\.]+@\\w+\\.[\\w\\.]+$";
		UserLoginDAO UserLogin_DAO = new UserLoginDAOImpl();
		ValidationUtils Check = new ValidationUtils();
		// Check if any data sent is null
		if (Check.isNull(username) | Check.isNull(password) | Check.isNull(email) | Check.isNull(contact)
				| Check.isNull(displayname) | Check.isNull(address)) {
			response.sendRedirect("register.jsp?fail=null");
		}
		// Data validation
		else if (!email.matches(emailregex) | contact.trim().length() != 8 | !(Check.isInt(contact))
				| Check.checkPassword(password) != 0) {
			response.sendRedirect("register.jsp?fail=condition");
		} else {

			UserLogin UserData = new UserLogin(username, password, displayname, address, email, contact);

			UserData.SetID(UserLogin_DAO.GetNextUserID());
			if (UserLogin_DAO.AddUser(UserData)) {
				request.setAttribute("userid", UserData.GetID());
				request.setAttribute("displayname", UserData.GetDisplayName());
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} else {
				response.sendRedirect("register.jsp?fail=1");
			}
		}
		UserLogin_DAO.CloseConnection();
	}

}
