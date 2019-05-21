<%@ page import="db.*" %>
        <%@ page import ="java.util.ArrayList" %>
						<div class="col-md-6">
							<div class="header-search">
								<form action="search.jsp" method="POST">
									<select class="input-select" name="sfilter">
										<option value="0">Filter</option>
										 <optgroup label="By Genre"">
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
										</optgroup> 
										<optgroup label="Pre-Owned">
										<option value="p1">Yes</option>
										<option value="p2">No</option>
										</optgroup>
									</select>
									<input class="input" placeholder="Search here">
								
									<input type="submit" value="Search" name="submit" class="search-btn">
								</form>
								<div style="display: table; width: 100%;">
								<a href="search.jsp" style="color: white; margin:auto; display: table-cell; text-align: center;">Advanced Search</a>
							</div>
							</div>
						</div>