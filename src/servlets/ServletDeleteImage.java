package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.GameImage;
import db.GameImageDAO;
import db.GameImageDAOImpl;

/**
 * Servlet implementation class ServletDeleteImage
 */
@WebServlet("/admin/ServletDeleteImage")
public class ServletDeleteImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletDeleteImage() {
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
		if (request.getParameter("submit") != null) {
			int gameid = Integer.parseInt(request.getParameter("gameid"));
			GameImage Game_Image = new GameImage();
			Game_Image.SetGameID(gameid);
			GameImageDAO GameImage_DAO = new GameImageDAOImpl();
			GameImage_DAO.RemoveGameImage(Game_Image);
			response.sendRedirect("editgames.jsp?success=yay");
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
