package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.Cart;
import db.CartDAO;
import db.CartDAOImpl;
import db.Item;

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action != null) {
			action = action.trim();
			if (action.equalsIgnoreCase("buy")) {
				String removefromcartbtn = request.getParameter("RemoveFromCart");
				if (removefromcartbtn != null) {
					doPost_RemoveFromCart(request, response);
				} else {
					doPost_AddToCart(request, response);
				}
			} else if (action.equalsIgnoreCase("remove")) {
				doPost_RemoveFromCart(request, response);
			}
		} else {
			response.sendRedirect("displaycart.jsp");
		}

	}

	protected void doPost_RemoveFromCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int GameID = Integer.parseInt(request.getParameter("gameid"));
		Cart cartItemList = new Cart((Cart) session.getAttribute("cart_list"));
		CartDAO Cart_DAO = new CartDAOImpl();
		Cart_DAO.RemoveFromCart(cartItemList, GameID);

		session.setAttribute("cart_list", cartItemList);
		RedirectUser(request, response);
	}

	protected void doPost_AddToCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// If not in cart, add to cart. Else updates current entry
		HttpSession session = request.getSession();
		int GameID = Integer.parseInt(request.getParameter("gameid"));
		int Qty = Integer.parseInt(request.getParameter("qty"));
		Item cart_item = new Item(GameID, Qty);

		Cart cartItemList = new Cart((Cart) session.getAttribute("cart_list"));
		CartDAO Cart_DAO = new CartDAOImpl();
		Cart_DAO.AddToCart(cartItemList, cart_item);

		session.setAttribute("cart_list", cartItemList);
		RedirectUser(request, response);
	}

	protected void RedirectUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String origin = request.getParameter("origin");
		String GameID = request.getParameter("gameid");
		if (origin != null && GameID != null) {
			if (origin.trim().equalsIgnoreCase("gamepages")) {
				response.sendRedirect("game.jsp?game_id=" + GameID);
			} else {
				response.sendRedirect("displaycart.jsp?status=1");
			}
		} else {
			response.sendRedirect("displaycart.jsp?status=1");
		}
	}

}
