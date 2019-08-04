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
 * Servlet implementation class ServletGenreAdd
 */
@WebServlet("/admin/ServletGenreAdd")
public class ServletGenreAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGenreAdd() {
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
				String genre_name = request.getParameter("genre_name");
				GenresDAO Genre_Class = new GenresDAOImpl();

				int insert = Genre_Class.InsertGenre(genre_name);
				if (insert == 1) {
					response.sendRedirect("editgenres.jsp?success=3");
				} else if (insert == 0) {
					response.sendRedirect("editgenres.jsp?fail=3");
				} else {
					response.sendRedirect("editgenres.jsp?fail=3");
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
