package db;

public class genres {
	int genre_id;
	String genre_name;
	int deleted;

	public void set_genre_id(int genreID) {
		this.genre_id = genreID;
	}

	public void set_deleted(int deleted) {
		this.deleted = deleted;
	}

	public void set_genre_name(String genreName) {
		this.genre_name = genreName;
	}

	public int get_genre_id() {
		return this.genre_id;
	}

	public int get_deleted() {
		return this.deleted;
	}

	public String get_genre_name() {
		return this.genre_name;
	}
}
