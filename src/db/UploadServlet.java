package db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@SuppressWarnings("serial")
@WebServlet("/admin/uploadServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB

public class UploadServlet extends HttpServlet {
	Spgames dbcon = new Spgames();
	boolean dummy = dbcon.setValues();
	Connection conn = dbcon.connection();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// gets values of text fields
		String game_title = request.getParameter("game_title");
		String company = request.getParameter("company");
		String release = request.getParameter("release_date");
		String price = request.getParameter("price");
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

				game_entry game = new game_entry();
				game.game_title = game_title;
				game.company = company;
				game.release_date = release;
				game.price = price;
				game.description = description;
				game.preowned = Integer.parseInt(preowned);
				game.genres = new ArrayList<genres>();
				for (String s : genres) {
					genres temp = new genres();
					temp.genre_id = Integer.parseInt(s);
					game.genres.add(temp);
				}

				if (inputStream != null) {
					dbcon.create_game(game, inputStream);
					dbcon.closeConnection();
				} else {
					dbcon.create_game(game, null);
					dbcon.closeConnection();
				}

				// closes the database connection

				// sets the message in request scope
				// forwards to the message page
				response.sendRedirect("editgames.jsp?success=3");
			}
		}
	}

}
