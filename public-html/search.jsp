<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@ page import ="db.*" %>
        <%@ page import ="java.*, javax.*, java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Searchbar
<form action="search.jsp" method="POST">
Game Title:<input type="text" name="game_title">
Company Name:<input type="text" name="company">
Release Date:<input type="date" name="release_date">
Price:<input type="number" step="0.01" min="0.01" name="price">
Pre-owned:<select name="preowned">
				<option value="">All</option>
            	<option value="0">No</option>
            	<option value="1">Yes</option>
            </select>
Genres:<select name="genres"  multiple="multiple">
            <% 
            Spgames dbcon = new Spgames();
            dbcon.setValues();
            ArrayList<genres> genre_list = new ArrayList<genres>();
            genre_list = dbcon.get_genres();
            		for (genres g: genre_list){
            %>
<option value="<%=g.get_genre_id() %>"><%=g.get_genre_name() %></option>
            <%
            		} 
            %> 
</select>
<input type="submit" value="Submit" name="submit">
</form>


<table>
<tr><th>Game Title</th><th>Company</th><th>Release Date</th><th>Description</th><th>Price</th><th>Image Location</th><th>Genres</th><th>Pre-Owned</th></tr>
<%
if(request.getParameter("submit") != null){
	String game_title = request.getParameter("game_title");
	String company = request.getParameter("company");
	String release_date = request.getParameter("release_date");
	String price =  request.getParameter("price");
	String preowned = request.getParameter("preowned");
	String[] genres = request.getParameterValues("genres");
	
	Spgames con = new Spgames();
	con.setValues();
	Connection conn;
	conn = con.connection(); 
	
	if(genres != null){
		//Filter by genre first...
		String basesql = "SELECT game_id FROM game_genre WHERE genre_id = ?";
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
			if(game_title.trim().length() != 0){ basesql2 = basesql2 + " AND game_title LIKE ?"; temp_record.add("%"+game_title+"%");}
			if(company.trim().length() != 0){ basesql2 = basesql2 + " AND company LIKE ?"; temp_record.add("%"+company+"%");}
			if(release_date.trim().length() != 0){ basesql2 = basesql2 + " AND release_date = ?"; temp_record.add(release_date);}
			if(price.trim().length() != 0){ basesql2 = basesql2 + " AND price = ?"; temp_record.add(price); System.out.println("Price: "+price+"");}
			if(preowned.trim().length() != 0){ basesql2 = basesql2 + " AND preowned = ?"; temp_record.add(preowned);}
			PreparedStatement ps1 = conn.prepareStatement(basesql2);
			ps1.setObject(1,rs.getString("game_id"));
			System.out.println(basesql2+"Size of Array:"+temp_record.size());
			if(temp_record.size() != 0){
			for(int i=0;i<temp_record.size();i++){
				System.out.print(temp_record.get(i));
				ps1.setObject(i+2,temp_record.get(i));
			}
			} 
				ResultSet rs1 = ps1.executeQuery();
				boolean got_record2 = false;
				if(rs1.next()){
					got_record2 = true;
					%>
					<tr>
					<td><%=rs1.getString("game_title") %></td>
					<td><%=rs1.getString("company") %></td>
					<td><%=rs1.getString("release_date") %></td>
					<td><%=rs1.getString("description") %></td>
					<td><%=rs1.getString("price") %></td>
					<td><img src="gameimage.jsp?game_id=<%=rs1.getString("game_id") %>" width="200"></td>
					<td>
					<%
					ResultSet genres_games = con.select_sql("SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id", rs1.getString("game_id"));
					while(genres_games.next()){
						out.print(genres_games.getString("genre_name"));
					}
					%>
					</td>
					<td><% if(rs1.getString("preowned").equals("0")){ out.print("No");} else {out.print("Yes");} %></td>
					
					</tr>
					<% 
				} 
		}
		
		if(got_record){
			
		} else {
			out.print("There are no games with the genres you selected.");
		}
	} else {
		System.out.println("Detected no genres selected");
		ArrayList<String> temp_record = new ArrayList<String>();
		//Skip genres
		String basesql2 = "SELECT * FROM games WHERE del = '0' ";
		if(game_title.trim().length() != 0){ basesql2 = basesql2 + " AND game_title LIKE ?"; temp_record.add("%"+game_title+"%");}
		if(company.trim().length() != 0){ basesql2 = basesql2 + " AND company LIKE ?"; temp_record.add("%"+company+"%");}
		if(release_date.trim().length() != 0){ basesql2 = basesql2 + " AND release_date = ?"; temp_record.add(release_date);}
		if(price.trim().length() != 0){ basesql2 = basesql2 + " AND price = ?"; temp_record.add(price); System.out.println("Price: "+price+"");}
		if(preowned.trim().length() != 0){ basesql2 = basesql2 + " AND preowned = ?"; temp_record.add(preowned);}
		PreparedStatement ps1 = conn.prepareStatement(basesql2);
		if(temp_record.size() != 0){
		for(int i=0;i<temp_record.size();i++){
			ps1.setObject(i+1,temp_record.get(i));
		}
			System.out.println(basesql2);
			System.out.println("'"+preowned+"'");
			ResultSet rs1 = ps1.executeQuery();
			boolean got_record2 = false;
			while(rs1.next()){
				got_record2 = true;
				%>
				<tr>
				<td><%=rs1.getString("game_title") %></td>
				<td><%=rs1.getString("company") %></td>
				<td><%=rs1.getString("release_date") %></td>
				<td><%=rs1.getString("description") %></td>
				<td><%=rs1.getString("price") %></td>
				<td><img src="gameimage.jsp?game_id=<%=rs1.getString("game_id") %>" width="200"></td>
				<td>
				<%
				ResultSet genres_games = con.select_sql("SELECT gg.game_id, G.genre_id, G.genre_name FROM game_genre gg, genre G WHERE gg.game_id = ? AND gg.genre_id = G.genre_id", rs1.getString("game_id"));
				while(genres_games.next()){
					out.print(genres_games.getString("genre_name"));
				}
				%>
				</td>
				<td><% if(rs1.getString("preowned").equals("0")){ out.print("No");} else {out.print("Yes");} %></td>
				
				</tr>
				<%
			}  
	}
	}
}

%>




</table>
</body>
</html>