<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="db.Spgames" %>
    <% if(session.getAttribute("name")!= null){response.sendRedirect("admin.jsp");} %>
         <% 
     if(request.getParameter("btnSubmit") != null){
    	Spgames dbcon = new Spgames();
    	 dbcon.setValues();
    	 String name = request.getParameter("loginid");
    	 String password = request.getParameter("password");
    	 boolean check = dbcon.login(name, password);
     	if (check == true){
        	session.setAttribute("name", name);     	 
        	response.sendRedirect("admin.jsp");
     	} else {
     		String redirectURL = "index.jsp?login=fail";
            response.sendRedirect(redirectURL);
     	}
     dbcon.closeConnection();
     }
     %>
    <%-- Admin login for administration --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- jQuery library import -->
<script type="text/javascript" src="js/jquery.js"></script>
<!-- Popper library import -->
<script type="text/javascript" src="js/popper.js"></script>
<!-- Bootstrap import -->
<script type="text/javascript" src="bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
<link href="bootstrap-4.3.1-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">
</head>
<body>
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <p style="padding-top:20px;">Login Administration</p>
    </div>

    <!-- Login Form -->
<form action="index.jsp" method="POST">
<%
String error = request.getParameter("login");
if(error != null){
	if(error.equals("fail")){
		out.print("You have entered an invalid ID/Password<br>");
	}
}
%>

      <input type="text" id="login" class="fadeIn second" name="loginid" placeholder="login">
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="password">
      <input type="submit" class="fadeIn fourth" name="btnSubmit" value="Log In">
</form>
    <!-- Remind Password -->
    <div id="formFooter">
      <a class="underlineHover" href="#">Forgot Password?</a>
    </div>

  </div>
</div>
<script type="text/javascript">

</script>
</body>
</html>