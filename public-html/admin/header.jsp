<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
        <%@ page import ="db.*" %>
        <%@ page import ="java.util.ArrayList" %>
         <% if(session.getAttribute("name")== null){response.sendRedirect("../index.jsp");} %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>HEXGEAR - Admin Dashboard</title>

  <!-- Bootstrap core CSS -->

 
  <!-- Custom styles for this template -->
  <link href="css/simple-sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
<style>

body{
width: 100%;
margin:auto;
}
.addgame{
    text-align: -webkit-center;

}
.alert {
	width: 60%; 
	margin:auto;
}
.d-flex{ 
	width: 100%;
}
</style>
</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-light border-right" id="sidebar-wrapper">
     <div class="sidebar-heading" style="background-color:black;"> <a href="../index.jsp">  <img src="img/logo.png" width="200px"></a></div>
      <div class="list-group list-group-flush">
        <a href="index.jsp" class="list-group-item list-group-item-action bg-light">Dashboard</a>
        <a href="editgames.jsp" class="list-group-item list-group-item-action bg-light">Edit Games</a>
        <a href="stockreport.jsp" class="list-group-item list-group-item-action bg-light">Games Report</a>
        <a href="editgenres.jsp" class="list-group-item list-group-item-action bg-light">Edit Genres</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <button class="btn btn-primary" id="menu-toggle">Toggle Menu</button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item active">
             
              <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
          </ul>
        </div>
      </nav>