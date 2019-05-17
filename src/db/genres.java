package db;

public class genres {
	int genre_id;
	String genre_name;

	public void set_genre_id(int genreID) {
		this.genre_id = genreID;
	}

	public void set_genre_name(String genreName) {
		this.genre_name = genreName;
	}

	public int get_genre_id() {
		return this.genre_id;
	}

	public String get_genre_name() {
		return this.genre_name;
	}
}
