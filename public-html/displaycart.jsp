
<%@ page import="db.*"%>
<%@ page import="htmlUtils.BootstrapAlerts" %>
<%@ page import="java.util.*"%>
<%
	Cart cartItemList = new Cart((Cart) session.getAttribute("cart_list"));
%>

<!DOCTYPE html>
<html lang="en">
<head>


<title>HEXGEAR - Buy Pre-owned and New Games</title>
<%@ include file="/etc/header-import.html"%>
<!-- <script type="text/javascript" src="js/inputvalidation.js"></script>-->
<style type="text/css">
.checked {
	color: orange;
}
</style>
</head>
<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<%@ include file="/etc/top-header.jsp"%>
		<!-- /TOP HEADER -->

		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<%@ include file="/etc/logo-import.html"%>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<%@ include file="/etc/searchbar-import.jsp"%>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Wishlist -->
							<!-- Cart -->
							<%@ include file="/etc/minicart.jsp"%>
							<!-- /Cart -->

							<!-- Menu Toogle -->
							<div class="menu-toggle">
								<a href="#"> <i class="fa fa-bars"></i> <span>Menu</span>
								</a>
							</div>
							<!-- /Menu Toogle -->
						</div>
					</div>
					<!-- /ACCOUNT -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<!-- container -->
		<div class="container">
			<!-- responsive-nav -->
			<div id="responsive-nav">
				<!-- NAV -->
				<ul class="main-nav nav navbar-nav">
					<li><a href="index.jsp">Home</a></li>
					<li><a href="search.jsp">Advanced Search</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<!-- BREADCRUMB -->
	<div id="breadcrumb" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<h3 class="breadcrumb-header">Cart</h3>
					<ul class="breadcrumb-tree">
						<li><a href="index.jsp">Home</a></li>
					</ul>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /BREADCRUMB -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<%
				
				String status = request.getParameter("status");
				if (status != null){
					BootstrapAlerts Bootstrap_Alerts = new BootstrapAlerts();
					if (status.equalsIgnoreCase("1")){
						out.print(Bootstrap_Alerts.SuccessAlert("The cart has been updated successfully."));
					}
				}
				%>
				<table class="table table-striped" style="width: 80%; margin: auto;">
					<tbody>
						<!-- First row to list out what the items mean-->
						<tr>
							<th>Game Image</th>
							<th>Game Title</th>
							<th>Pre-Owned</th>
							<th>Unit Price</th>
							<th style="width: 20%;">Quantity</th>
							<th>Total Price</th>
							<th></th>
						</tr>
						<!-- Individual product rows-->

						<%
							if (cartItemList.GetSize() != 0) {
								Iterator<Item> Item_Iterator = cartItemList.GetIterator();
								GameDAO Game_DAO = new GameDAOImpl();
								float CartTotal = 0;
								int i = 0;
								while (Item_Iterator.hasNext()) {
									Item temp = Item_Iterator.next();
									int gameid = temp.GetGameID();
									Game Game_Details = Game_DAO.GetGameInfo(gameid);
									String gametitle = Game_Details.GetGameTitle();
									String price = Game_Details.GetPrice();
									int preowned = Game_Details.GetPreOwned();
									int CartQty = temp.GetQty();

									if (CartQty > Game_Details.GetQty()) {
										temp.SetQty(1);
										CartQty = 1;
						%>
						<script>
							alert("Dear user, as the number of games you're attempting to buy for <%=gametitle%> is more than what we have, typically due to a decrease in the quantity for that game, we have reset the quantity to 1. We are sorry for any inconvenience caused.");
						</script>
						<%
							}
									float total = Float.parseFloat(price) * CartQty;
									CartTotal += total;
						%>
						<tr>
							<form action="ServletCart" method="POST">
								<td><a href="game.jsp?game_id=<%=gameid%>"> <img
										src="gameimage.jsp?game_id=<%=gameid%>" width="100"
										alt="Product Image">
								</a></td>
								<td><a href="game.jsp?game_id=<%=gameid%>"><%=gametitle%></a></td>
								<td>
									<%
										if (preowned == 0) {
													out.print("No");
												} else {
													out.print("Yes");
												}
									%>
								</td>
								<td><%=price%></td>
								<td class="i-qty"><input type="hidden" value="buy"
									name="action"> <input type="hidden" value="<%=gameid%>"
									name="gameid">
									<p>
									<div class="input-group">
										<span class="input-group-btn">
											<button type="button" class="btn btn-danger btn-number"
												data-type="minus" data-field="qty<%=i%>">
												<span class="glyphicon glyphicon-minus"></span>
											</button>
										</span> <input type="text" name="qty" id="qty<%=i%>"
											class="form-control input-number" value="<%=CartQty%>"
											min="1" max="<%=Game_Details.GetQty()%>"> <span
											class="input-group-btn">
											<button type="button" class="btn btn-success btn-number"
												data-type="plus" data-field="qty<%=i%>">
												<span class="glyphicon glyphicon-plus"></span>
											</button>
										</span>
									</div>
									</p>
									<button type="submit" class="btn btn-outline-secondary">
										<i class="fas fa-shopping-cart"></i>Update Qty
									</button></td>
								<td><%=total%></td>
								<td><button type="submit" name="RemoveFromCart"
										class="btn btn-outline-secondary">
										<i class="fas fa-shopping-cart"></i>Remove from Cart
									</button></td>
							</form>
						</tr>

						<%
							i++;
								}
								java.util.Formatter formatter = new java.util.Formatter();
								formatter.format("%.2f", CartTotal);
								String FormatTotal = formatter.toString();
								formatter.close();
						%>
						<tr>
							<td colspan="6"></td>
							<td style="float: right; text-align: left; width: 290px;">
								<dl>
									<dt>Sub Total:</dt>
									<dd>
										$<%=FormatTotal%></dd>
								</dl>
								<dl>
									<dt>Shipping:</dt>
									<dd>FREE</dd>
								</dl>
								<dl>
									<dt>
										<span class="h3">Total:</span>
									</dt>
									<dd>
										<span class="h3">$<%=FormatTotal%></span>
										<%%>
									</dd>
								</dl>
								<dl>
									<dt></dt>
									<dd>
										<a href="checkout.jsp" class="btn btn-primary">Checkout</a>
									</dd>
								</dl>
							</td>
						</tr>
						<%
							} else {
						%>
						<tr>
							<td colspan="7">There are no games added to the cart.</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>



			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->





	<%@include file="etc/footer.html"%>
	<script type="text/javascript">
//plugin bootstrap minus and plus
//http://jsfiddle.net/laelitenetwork/puJ6G/
$('.btn-number').click(function(e){
  e.preventDefault();
  
  fieldName = $(this).attr('data-field');
  type      = $(this).attr('data-type');
  var input = $("input#" + fieldName);
  var currentVal = parseInt(input.val());
  if (!isNaN(currentVal)) {
      if(type == 'minus') {
          
          if(currentVal > input.attr('min')) {
              input.val(currentVal - 1).change();
          } 
          if(parseInt(input.val()) == input.attr('min')) {
              $(this).attr('disabled', true);
          }

      } else if(type == 'plus') {

          if(currentVal < input.attr('max')) {
              input.val(currentVal + 1).change();
          }
          if(parseInt(input.val()) == input.attr('max')) {
              $(this).attr('disabled', true);
          }

      }
  } else {
      input.val(0);
  }
});
$('.input-number').focusin(function(){
 $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
   
  minValue =  parseInt($(this).attr('min'));
  maxValue =  parseInt($(this).attr('max'));
  valueCurrent = parseInt($(this).val());
  
  name = $(this).attr('name');
  if(valueCurrent >= minValue) {
      $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
  } else {
      alert('Sorry, the minimum value was reached');
      $(this).val($(this).data('oldValue'));
  }
  if(valueCurrent <= maxValue) {
      $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
  } else {
      alert('Sorry, the maximum value was reached');
      $(this).val($(this).data('oldValue'));
  }
  
  
});
$(".input-number").keydown(function (e) {
      // Allow: backspace, delete, tab, escape, enter and .
      if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
           // Allow: Ctrl+A
          (e.keyCode == 65 && e.ctrlKey === true) || 
           // Allow: home, end, left, right
          (e.keyCode >= 35 && e.keyCode <= 39)) {
               // let it happen, don't do anything
               return;
      }
      // Ensure that it is a number and stop the keypress
      if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
          e.preventDefault();
      }
  });
</script>
</body>
</html>
