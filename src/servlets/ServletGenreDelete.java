package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.GenresDAO;
import db.GenresDAOImpl;

/**
 * Servlet implementation class ServletGenreDelete
 */
@WebServlet("/ServletGenreDelete")
public class ServletGenreDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGenreDelete() {
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
		HttpSession session = request.getSession();
		try {
			if (session.getAttribute("name") != null && request.getParameter("submit") != null) {
				GenresDAO Genres_Class = new GenresDAOImpl();
				int genre_id = Integer.parseInt(request.getParameter("genre_id"));
				int del_genre = Genres_Class.DeleteGenre(genre_id);
				if (del_genre == 1) {
					response.sendRedirect("editgenres.jsp?fail=2");
				} else if (del_genre == 0) {
					response.sendRedirect("editgenres.jsp?success=2");
				}
			} else {
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			response.sendRedirect("index.jsp");
		}
	}

}
