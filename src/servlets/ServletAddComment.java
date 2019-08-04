package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Comment;
import db.CommentDAO;
import db.CommentDAOImpl;

/**
 * Servlet implementation class ServletAddComment
 */
@WebServlet("/ServletAddComment")
public class ServletAddComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletAddComment() {
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
		try {
			if (request.getParameter("submit") != null) {
				String userid = request.getParameter("userid");
				String username = request.getParameter("username");
				String review = request.getParameter("review");
				int rating = Integer.parseInt(request.getParameter("rating"));
				int game_id = Integer.parseInt(request.getParameter("game_id"));
				Comment cmt = new Comment();
				cmt.SetGameID(game_id);
				cmt.SetRating(rating);
				cmt.SetComment(review);
				if (userid != null) {
					cmt.SetUserID(Integer.parseInt(userid));
				} else {
					cmt.SetUsername(username);
				}
				CommentDAO Comment_DAO = new CommentDAOImpl();
				if (Comment_DAO.AddComment(cmt)) {
					response.sendRedirect("game.jsp?game_id=" + game_id + "&status=1");
				} else {
					response.sendRedirect("game.jsp?game_id=" + game_id + "&status=1");
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
