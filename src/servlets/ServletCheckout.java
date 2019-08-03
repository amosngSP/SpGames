package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.Cart;
import db.Game;
import db.GameDAO;
import db.GameDAOImpl;
import db.Item;
import db.Transaction;
import db.TransactionDAO;
import db.TransactionDAOImpl;
import db.TransactionData;

/**
 * Servlet implementation class ServletCheckout
 */
@WebServlet("/ServletCheckout")
public class ServletCheckout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletCheckout() {
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
		Cart cartItemList = new Cart((Cart) session.getAttribute("cart_list"));
		if (session.getAttribute("cart_list") != null) {
			int userid = (int) session.getAttribute("userid");
			Transaction TransData = new Transaction();
			TransData.SetUserID(userid);
			TransactionDAO Trans_DAO = new TransactionDAOImpl();
			GameDAO Game_DAO = new GameDAOImpl();

			for (Item s : cartItemList.GetCartList()) {
				int gameid = s.GetGameID();
				int qty = s.GetQty();
				Game Game_Details = Game_DAO.GetGameInfo(gameid);
				int preowned = Game_Details.GetPreOwned();
				String costprice = Game_Details.GetPrice();
				TransactionData temp = new TransactionData(gameid, preowned, qty, costprice);
				TransData.AddNewTransactionData(temp);
			}
			if (Trans_DAO.UploadPurchase(TransData)) {
				session.setAttribute("cart_list", null);
				response.sendRedirect("thankyoupage.jsp?success=true");
			} else {
				response.sendRedirect("thankyoupage.jsp?error=true");
			}

		} else {
			response.sendRedirect("index.jsp");
		}
	}
}
