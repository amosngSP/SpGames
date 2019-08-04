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
 * Servlet implementation class ServletGenreUpdate
 */
@WebServlet("/admin/ServletGenreUpdate")
public class ServletGenreUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGenreUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// TODO Auto-generated method stub
		try {
			if (session.getAttribute("name") != null && request.getParameter("submit") != null) {
				GenresDAO Genres_DAO = new GenresDAOImpl();
				int genre_id = Integer.parseInt(request.getParameter("genre_id"));
				String genre_name = request.getParameter("genre_name");
				boolean update = Genres_DAO.UpdateGenre(genre_id, genre_name);
				if (update) {
					response.sendRedirect("editgenres.jsp?success=1");
				} else {
					response.sendRedirect("editgenres.jsp?fail=1");
				}
			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("index.jsp");
		}
	}

}
