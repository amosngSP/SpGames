package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import db.Game;
import db.GameDAO;
import db.GameDAOImpl;
import db.Genres;

@SuppressWarnings("serial")
@WebServlet("/admin/ServletUpload")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB

public class ServletGameUpload extends HttpServlet {
	GameDAO GameDAOinit = new GameDAOImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// gets values of text fields
		String game_title = request.getParameter("game_title");
		String company = request.getParameter("company");
		String release = request.getParameter("release_date");
		String price = request.getParameter("price");
		int qty = Integer.parseInt(request.getParameter("qty"));
		String description = request.getParameter("description");
		String preowned = request.getParameter("preowned");
		String[] genres = request.getParameterValues("genres");
		Part filePart = request.getPart("image_file");

		InputStream inputStream = null; // input stream of the upload file

		// obtains the upload file part in this multipart request

		if (filePart != null) {
			System.out.println("File size: " + filePart.getSize());
			if (filePart.getSize() > 1048576) {
				response.sendRedirect("editgames.jsp?fail=3");
			} else {
				inputStream = filePart.getInputStream();

				Game game = new Game();
				game.SetGameTitle(game_title);
				game.SetCompany(company);
				game.SetReleaseDate(release);
				game.SetPrice(price);
				game.SetQty(qty);
				game.SetDescription(description);
				game.SetPreOwned(Integer.parseInt(preowned));
				ArrayList<Genres> TempArrayList = new ArrayList<Genres>();
				for (String s : genres) {
					Genres temp = new Genres();
					temp.SetGenreID(Integer.parseInt(s));
					TempArrayList.add(temp);
				}
				game.SetGenresList(TempArrayList);
				if (inputStream != null) {
					GameDAOinit.CreateGame(game, inputStream);
					GameDAOinit.CloseConn();
				} else {
					GameDAOinit.CreateGame(game, null);
					GameDAOinit.CloseConn();
				}

				// closes the database connection

				// sets the message in request scope
				// forwards to the message page
				response.sendRedirect("editgames.jsp?success=3");
			}
		}
	}

}
