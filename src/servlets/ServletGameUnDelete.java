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
 * Servlet implementation class ServletUnDeleteGame
 */
@WebServlet("/admin/ServletGameUnDelete")
public class ServletGameUnDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGameUnDelete() {
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
			GameDAO Game_DAO = new GameDAOImpl();
			if (Game_DAO.UndoDeleteGame(Integer.parseInt(request.getParameter("game_id")))) {
				response.sendRedirect("editgames.jsp?del=1&success=4");
			} else {
				response.sendRedirect("editgames.jsp?del=1&fail=4");
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
