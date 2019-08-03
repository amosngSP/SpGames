<%@ page import="db.*"%>
<%@ page import="java.util.ArrayList"%>
<div class="col-md-6">
	<div class="header-search">
		<form action="search.jsp" method="POST">
			<select class="input-select" name="sfilter">
				<option value="0">Filter</option>
				<optgroup label="By Genre"">
					<%
						GenresDAO GD = new GenresDAOImpl();
						ArrayList<Genres> genre_list = new ArrayList<Genres>();
						genre_list = GD.GetGenresList(0);
						if(genre_list != null){
						for (Genres g : genre_list) {
					%>
					<option value="<%=g.GetGenreID()%>"><%=g.GetGenreName()%></option>
					<%
						}}
					%>
				</optgroup>
				<optgroup label="Pre-Owned">
					<option value="p1">Yes</option>
					<option value="p2">No</option>
				</optgroup>
			</select> <input class="input" placeholder="Search here"> <input
				type="submit" value="Search" name="submit" class="search-btn">
		</form>
		<div style="display: table; width: 100%;">
			<a href="search.jsp"
				style="color: white; margin: auto; display: table-cell; text-align: center;">Advanced
				Search</a>
		</div>
	</div>
</div>