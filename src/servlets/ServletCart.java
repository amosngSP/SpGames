package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.CartItem;

/**
 * Servlet implementation class ServletCart
 */
@WebServlet("/ServletCart")
public class ServletCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletCart() {
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
		int GameID = Integer.parseInt(request.getParameter("gameid"));
		int Qty = Integer.parseInt(request.getParameter("qty"));
		CartItem cart_item = new CartItem(GameID, Qty);
		HttpSession session = request.getSession();
		List<CartItem> cartItemList;
		if (session.getAttribute("cart_list") != null) {
			cartItemList = (List<CartItem>) session.getAttribute("cart_list");
		}

	}

}
