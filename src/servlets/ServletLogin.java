package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.UserLogin;
import db.UserLoginDAO;
import db.UserLoginDAOImpl;

/**
 * Servlet implementation class ServletLogin
 */
@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("submit") != null) {
			// If received a request (We used submit to check)
			UserLoginDAO UserLogin_DAO = new UserLoginDAOImpl();
			String name = request.getParameter("username");
			String password = request.getParameter("password");
			boolean check = UserLogin_DAO.Login(name, password);
			HttpSession session = request.getSession();
			if (check == true) {
				// if login valid
				// grab user data...
				UserLogin UserInfo = UserLogin_DAO.GetUserDetails(name);
				session.setAttribute("userid", UserInfo.GetID());
				session.setAttribute("name", UserInfo.GetDisplayName());
				session.setAttribute("username", UserInfo.GetUsername());
				session.setAttribute("admin", UserInfo.GetAdmin());
				System.out.println(UserInfo.GetAdmin());
				response.sendRedirect("index.jsp");
				System.out.println("success");
			} else {
				// invalid login
				response.sendRedirect("login.jsp?fail=1");
				System.out.println("fail");
			}

			// close database connection
			UserLogin_DAO.CloseConnection();
		}

	}

}
