package db;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@SuppressWarnings("serial")
@WebServlet("/admin/updateServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB

public class UpdateServlet extends HttpServlet {
	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		GameDAO GameDAOinit = new GameDAO();
		Map<String, String[]> parameters = request.getParameterMap();
		for (String parameter : parameters.keySet()) {
			System.out.print(parameter);
			System.out.print(parameters.get(parameter));
		}

		System.out.println("Received Request");
		System.out.println(request.getParameter("submit"));
		System.out.println(request.getParameter("game_id"));
		if (request.getParameter("game_id") != null) {
			int game_id = Integer.parseInt(request.getParameter("game_id"));
			String game_title = request.getParameter("game_title");
			String company = request.getParameter("company");
			String release_date = request.getParameter("release_date");
			String[] genres_form = request.getParameterValues("genres");
			String price = request.getParameter("price");
			int preowned = Integer.parseInt(request.getParameter("preowned"));
			String description = request.getParameter("description");
			Part filePart = request.getPart("image_file");
			InputStream inputStream = null;
			if (filePart.getSize() != 0) {
				inputStream = filePart.getInputStream();
				System.out.println("File size: " + filePart.getSize());

				if (filePart.getSize() > 1048576) {
					response.sendRedirect("edit.jsp?fail=3");
				}
			} else {
				System.out.println("File is null!");
			}
			GameEntryObj temp = new GameEntryObj();
			temp.SetGameID(game_id);
			temp.SetGameTitle(game_title);
			temp.SetCompany(company);
			temp.SetReleaseDate(release_date);
			ArrayList<GenresObj> temp2 = new ArrayList<GenresObj>();
			for (String s : genres_form) {
				GenresObj temp3 = new GenresObj();
				temp3.SetGenreID(Integer.parseInt(s));
				temp2.add(temp3);
			}
			temp.SetGenresList(temp2);
			temp.SetPrice(price);
			temp.SetPreOwned(preowned);
			temp.SetDescription(description);
			if (inputStream == null) {
				GameDAOinit.UpdateGame(temp, null);
			} else {
				GameDAOinit.UpdateGame(temp, inputStream);
			}
			System.out.println("Success");
			GameDAOinit.CloseConnection();
			response.sendRedirect("editgames.jsp?success=1");

		} else {
			System.out.println("Wait what");
			response.sendRedirect("index.jsp");
		}
	}
}
