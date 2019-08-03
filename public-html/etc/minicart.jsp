<%@ page import="db.*"%>
<%@ page import="java.util.*"%>
<%
	Cart MiniCartItemList = new Cart((Cart) session.getAttribute("cart_list"));
	float MiniCartTotal = 0;
	int ij = 0;
%>
<div class="dropdown">

	<a class="dropdown-toggle" id="cartbutton">
		<i class="fa fa-shopping-cart"></i> <span>Your Cart</span> <%
 	if (MiniCartItemList.GetSize() != 0) {
 %>
		<div class="qty"><%=MiniCartItemList.GetSize()%></div> <%
 	}
 %>
	</a>

	<div class="cart-dropdown">

		<div class="cart-list">
			<%
				if (MiniCartItemList.GetSize() != 0) {
			%>

			<%
				Iterator<Item> Item_Iterator = MiniCartItemList.GetIterator();
					GameDAO MiniGame_DAO = new GameDAOImpl();

					while (Item_Iterator.hasNext()) {
						Item temp = Item_Iterator.next();
						int MiniGameID = temp.GetGameID();
						Game Game_Details = MiniGame_DAO.GetGameInfo(MiniGameID);
						String gametitle = Game_Details.GetGameTitle();
						String price = Game_Details.GetPrice();
						int MiniCartQty = temp.GetQty();
						float total = Float.parseFloat(price) * MiniCartQty;
						MiniCartTotal += total;
			%>
			<div class="product-widget">
				<div class="product-img">
					<img src="gameimage.jsp?game_id=<%=MiniGameID%>" alt="">
				</div>
				<div class="product-body">
					<h3 class="product-name">
						<a href="game.jsp?game_ud<%=MiniGameID%>"><%=gametitle%></a>
					</h3>
					<h4 class="product-price">
						<span class="qty"><%=MiniCartQty%>x</span><%=price%>
					</h4>
				</div>
				<button class="delete">
					<i class="fa fa-close"></i>
				</button>
			</div>
			<%
			ij++;
				}
				} else {
			%>
	<div class="product-widget">
	There are no products in the cart.
	</div>
<%} %>
		</div>
		<div class="cart-summary">
			<small><%=ij%> Item(s) selected</small>
			<h5>
				SUBTOTAL: $<%=MiniCartTotal%></h5>
		</div>
		<%
			
		%>
		<div class="cart-btns">
			<a href="displaycart.jsp">View Cart</a> <a href="checkout.jsp">Checkout <i
				class="fa fa-arrow-circle-right"></i></a>
		</div>

	</div>
</div>
