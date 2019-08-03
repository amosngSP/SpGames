package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAOImpl implements CommentDAO {
	private SqlDAO DBSQL;
	private Connection con;

	public CommentDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public CommentDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public ArrayList<Comment> GetComments(int GameID) {
		try {
			ResultSet comments = DBSQL.SelectSQL("SELECT * from gamerating WHERE gameid = ?", GameID);
			ArrayList<Comment> comments_list = new ArrayList<Comment>();

			while (comments.next()) {
				Comment row = null;
				System.out.println("User ID:" + comments.getString("userid"));
				if (comments.getString("userid") == null)
					row = new Comment(Integer.parseInt(comments.getString("id")),
							Integer.parseInt(comments.getString("gameid")), 0, comments.getString("username"),
							comments.getString("comment"), Integer.parseInt(comments.getString("rating")),
							comments.getTimestamp("datetime"), Integer.parseInt(comments.getString("deleted")));
				else {

					UserLoginDAO UL = new UserLoginDAOImpl(DBSQL);
					UserLogin UserData = UL.GetUserDetails(Integer.parseInt(comments.getString("userid")));
					System.out.println("Grabbed Name:" + UserData.GetDisplayName());
					row = new Comment(Integer.parseInt(comments.getString("id")),
							Integer.parseInt(comments.getString("gameid")),
							Integer.parseInt(comments.getString("userid")), UserData.GetDisplayName(),
							comments.getString("comment"), Integer.parseInt(comments.getString("rating")),
							comments.getTimestamp("datetime"), Integer.parseInt(comments.getString("deleted")));
				}
				comments_list.add(row);
			}
			return comments_list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean AddComment(Comment Comment) {
		try {
			if (Comment.GetUsername() != null) {
				Object[] comm = { Comment.GetGameID(), Comment.GetUsername(), Comment.GetComment(),
						Comment.GetRating() };
				return DBSQL.InsertSQL(
						"INSERT INTO `gamerating` (`id`, `gameid`, `userid`,`username`, `comment`,`rating`) VALUES (NULL, ?, NULL, ?, ?, ?)",
						comm);
			} else {
				Object[] comm = { Comment.GetGameID(), Comment.GetUserID(), Comment.GetComment(), Comment.GetRating() };
				return DBSQL.InsertSQL(
						"INSERT INTO `gamerating` (`id`, `gameid`, `userid`,`username`, `comment`,`rating`) VALUES (NULL, ?, ?, NULL, ?, ?)",
						comm);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean DeleteComment(int CommentID) {
		try {
			return DBSQL.InsertSQL("UPDATE `gamerating` SET `deleted` = '1' WHERE `gamerating`.`id` = ?", CommentID);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean UndoDeleteComment(int CommentID) {
		try {
			return DBSQL.InsertSQL("UPDATE `gamerating` SET `deleted` = '0' WHERE `gamerating`.`id` = ?", CommentID);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean EditComment(Comment Comment) {
		try {
			Object[] comm = { Comment.GetUsername(), Comment.GetTimeStamp(), Comment.GetRating(), Comment.GetComment(),
					Comment.GetCommentID() };
			return DBSQL.InsertSQL(
					"UPDATE `gamerating` SET `userid` = ?, `username` = ? , `comment` = ?, `rating` = ?, `datetime` = ? WHERE `gamerating`.`id` = ?",
					comm);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
