<div id="top-header">
			<div class="container">
				<ul class="header-links pull-right">
										<% if (session.getAttribute("name")==null){ %>
					<li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i>Log - in</a></li>
					<li><a href="register.jsp"><i class="fas fa-sign-in-alt"></i>Register</a></li>
					<% } else {%>
					<li> <span>Hello, <%= session.getAttribute("name") %> </span></li>
					<% 
					int admin = (int) session.getAttribute("admin");
					if(admin == 1){
					%>
					<li><a href="admin/index.jsp"><i class="fas fa-sign-in-alt"></i>Admin Portal</a></li>
					<% }%>
					<li><a href="myaccount.jsp"><i class="fas fa-sign-in-alt"></i>My Account</a></li>
					<li><a href="logout.jsp"><i class="fas fa-sign-in-alt"></i>Log Out</a></li>
					<% } %>
				</ul>
			</div>
		</div> 