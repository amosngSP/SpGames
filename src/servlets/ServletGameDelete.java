package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.GameDAO;
import db.GameDAOImpl;

/**
 * Servlet implementation class ServletGameDelete
 */
@WebServlet("/admin/ServletGameDelete")
public class ServletGameDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGameDelete() {
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
		if (request.getParameter("game_id") != null) {
			GameDAO Game_Class = new GameDAOImpl();
			if (Game_Class.DeleteGame(Integer.parseInt(request.getParameter("game_id")))) {
				response.sendRedirect("editgames.jsp?success=2");
			} else {
				response.sendRedirect("editgames.jsp?fail=2");
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
