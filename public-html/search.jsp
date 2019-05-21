            <%@ page import ="db.*" %>
        <%@ page import ="java.*, javax.*, java.util.*, java.sql.*" %>
        <%
        
        %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>HEXGEAR - Buy Pre-owned and New Games</title>
 	<%@ include file="/etc/header-import.html" %>
    <style>
    td{
		vertical-align:top;    
    }
    </style>
    </head>
	<body>
		<!-- HEADER -->
		<header>
			<!-- TOP HEADER -->
			<div id="top-header">
				<div class="container">
					<ul class="header-links pull-right">
						<li><a href="admin"><i class="fas fa-sign-in-alt"></i>Admin Log-in</a></li>
					</ul>
				</div>
			</div>
			<!-- /TOP HEADER -->

			<!-- MAIN HEADER -->
			<div id="header">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<!-- LOGO -->
						<%@ include file="/etc/logo-import.html" %>
						<!-- /LOGO -->

						<!-- SEARCH BAR -->
						<%@ include file="/etc/searchbar-import.jsp" %>
						<!-- /SEARCH BAR -->

						<!-- ACCOUNT -->
						<div class="col-md-3 clearfix">
							<div class="header-ctn">
								<!-- Wishlist -->
								<!-- /Cart -->

								<!-- Menu Toogle -->
								<div class="menu-toggle">
									<a href="#">
										<i class="fa fa-bars"></i>
										<span>Menu</span>
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
						<li class="active"><a href="search.jsp">Advanced Search</a></li> 
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
						<h3 class="breadcrumb-header">Advanced Search</h3>
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
				<div style="width: 50%; margin: auto;">
				<form method="POST">
				  <div class="form-group">
    <label for="game_title">Game Title</label>
    <input type="text" name="game-title"class="form-control" aria-describedby="gameHelp" placeholder="Enter Game Title">
  </div>
  <div class="form-group">
    <label for="game_title">Genres</label>
		<select name="genres"  multiple="multiple" class="form-control selectpicker">
            <% 
            Spgames tempdb = new Spgames();  
    		tempdb.setValues();
    		ArrayList<genres> genrelist = new ArrayList<genres>();
            genrelist = tempdb.get_genres();
            		for (genres g: genrelist){
            %>
<option value="<%=g.get_genre_id() %>"><%=g.get_genre_name() %></option>
            <%
            		} 
            %> 
</select>
  </div>
<div class="form-group">
  <p><label for="pre-owned">Pre-Owned</label></p>
  <label class="radio-inline" style="font-weight: none;"><input type="radio" name="pre-owned" value="0" checked="checked">No</label>
  <label class="radio-inline"><input type="radio" name="pre-owned" value="1">Yes</label>
</div>
<div class="form-group">
<input type="submit" value="Submit" name="submit" class="form-control">
</div>
  </form>
				</div>
				
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->
<% if(request.getParameter("submit")!=null){ %>
		<div class="section">
		<div class="container">
			<%String preowned=null,gameTitle=null;
				String[]genres=null;
				if(request.getParameter("sfilter")!=null){
					String sfilter = request.getParameter("sfilter");
					if (sfilter.equals("p1")){
						preowned = "1";
					} else if(sfilter.equals("p2")){
						preowned ="2";
					} else {
						genres = request.getParameterValues("sfilter");
					}
				}
				else{
				gameTitle = request.getParameter("game-title");
				
				genres = request.getParameterValues("genres");
				preowned = request.getParameter("pre-owned");
				}
				if(gameTitle == null){gameTitle = "";}
				if(preowned == null){preowned = "";}
				Connection conn;
				Spgames tempcon = new Spgames();
				tempcon.setValues();
				conn = tempcon.connection(); 
				if(genres != null){
					//Filter by genre first...
					String basesql = "SELECT DISTINCT game_id FROM game_genre WHERE genre_id = ?";
					for (int i = 1; i < genres.length; i++){
						basesql = basesql+" OR genre_id = ?";
					}
					PreparedStatement ps = conn.prepareStatement(basesql);
					ps.setObject(1,genres[0]);
					for (int i = 1; i < genres.length; i++){
						ps.setObject(i+1, genres[i]);
					}
					ResultSet rs = ps.executeQuery();
					boolean got_record = false;
					
					while(rs.next()){
						ArrayList<String> temp_record = new ArrayList<String>();
						got_record = true;
						String basesql2 = "SELECT * FROM games WHERE game_id = ? AND del = '0'";
						if(gameTitle.trim().length() != 0){ basesql2 = basesql2 + " AND game_title LIKE ?"; temp_record.add("%"+gameTitle+"%");}
						if(preowned.trim().length() != 0){ basesql2 = basesql2 + " AND preowned = ?"; temp_record.add(preowned);}
						PreparedStatement ps1 = conn.prepareStatement(basesql2);
						ps1.setObject(1,rs.getString("game_id"));
						if(temp_record.size() != 0){
						for(int i=0;i<temp_record.size();i++){
						
							ps1.setObject(i+2,temp_record.get(i));
						}
						} 
							ResultSet rs1 = ps1.executeQuery();
							boolean got_record2 = false;
							if(rs1.next()){
								got_record2 = true;
			%>
			
			
			<div style="margin-top: 5px; margin:auto; border-style: solid; border-width: 1px; width: 80%;">
			<table style=" margin: 20px 20px;">
			<tr><td rowspan="2" style="width: 1%;">
			<img src="gameimage.jsp?game_id=<%=rs1.getString("game_id") %>"  style="padding-right: 10px;"width="200"></td>
			<td colspan="2">
			<h2><%=rs1.getString("game_title") %></h2>
			</td>
			</tr>
			
			<tr>
			<td style="width: 25%;"> 
			<p><label for="preowned">Pre-Owned:</label> <% if(rs1.getString("preowned").equals("0")){ out.print("No");} else {out.print("Yes");} %></p>
			<p><label for="company">Company:</label> <%=rs1.getString("company") %></p>
			<p><label for="releaseDate">Release Date:</label> <%=rs1.getString("release_date") %></p>
			</td><td style="width: 25%;">
			<p><label for="price">Price:</label> $<%=rs1.getString("price") %></p>
			
			<p><label for="genres">Genres:</label>					<%
					ResultSet genres_games = tempdb.select_sql("SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id", rs1.getString("game_id"));
			if(genres_games.next()){
				out.print(genres_games.getString("genre_name"));
			}
			while(genres_games.next()){
				out.print(", "+genres_games.getString("genre_name"));
			}
					%></p>
			
			</td>
			</tr>
			
			<tr>
			<td colspan="3">
			<p><%=rs1.getString("description") %></p></td>
			</tr>
			</table>
			</div>
			

			

			<% 
				} 
		}
		
		if(got_record){
			
		} else {
			out.print("There are no games with the genres you selected.");
		}
	} else {
		
		ArrayList<String> temp_record = new ArrayList<String>();
		//Skip genres
		String basesql2 = "SELECT * FROM games WHERE del = '0' ";
		if(gameTitle.trim().length() != 0){ basesql2 = basesql2 + " AND game_title LIKE ?"; temp_record.add("%"+gameTitle+"%");}
		if(preowned.trim().length() != 0){ basesql2 = basesql2 + " AND preowned = ?"; temp_record.add(preowned);}
		PreparedStatement ps1 = conn.prepareStatement(basesql2);
		if(temp_record.size() != 0){
		for(int i=0;i<temp_record.size();i++){
			ps1.setObject(i+1,temp_record.get(i));
		}
		}
			ResultSet rs1 = ps1.executeQuery();
			boolean got_record2 = false;
			while(rs1.next()){
				got_record2 = true;
				%>
							<div style="margin-top: 5px; margin:auto; border-style: solid; border-width: 1px; width: 80%;">
			<table style=" margin: 20px 20px;">
			<tr><td rowspan="2" style="width: 1%;">
			<img src="gameimage.jsp?game_id=<%=rs1.getString("game_id") %>"  style="padding-right: 10px;"width="200"></td>
			<td colspan="2">
			<h2><%=rs1.getString("game_title") %></h2>
			</td>
			</tr>
			
			<tr>
			<td style="width: 25%;">  
			<p><label for="preowned">Pre-Owned:</label> <% if(rs1.getString("preowned").equals("0")){ out.print("No");} else {out.print("Yes");} %></p>
			<p><label for="company">Company:</label> <%=rs1.getString("company") %></p>
			<p><label for="releaseDate">Release Date:</label> <%=rs1.getString("release_date") %></p>
			</td><td style="width: 25%;">
			<p><label for="price">Price:</label> $<%=rs1.getString("price") %></p>
			
			<p><label for="genres">Genres:</label>					<%
					ResultSet genres_games = tempdb.select_sql("SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id", rs1.getString("game_id"));
			if(genres_games.next()){
				out.print(genres_games.getString("genre_name"));
			}
			while(genres_games.next()){
				out.print(", "+genres_games.getString("genre_name"));
			}
					%></p>
			
			</td>
			</tr>
			
			<tr>
			<td colspan="3">
			<p><%=rs1.getString("description") %></p></td>
			</tr>
			</table>
			</div>
			

			
	
				
<%
			}  
	
	}
} 



 

%>
		</div>
		</div>
<%@include file="etc/footer.html" %>

	</body>
</html>
