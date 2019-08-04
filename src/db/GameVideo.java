package db;

import java.io.Serializable;

public class GameVideo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9212288874068421854L;
	private int gameid;
	private String gamevideourl = null;

	public GameVideo() {

	}

	public GameVideo(int GameID, String Video_URL) {
		this.gameid = GameID;
		this.gamevideourl = Video_URL;
	}

	public void SetGameID(int GameID) {
		this.gameid = GameID;
	}

	public void SetVideoURL(String Video_URL) {
		this.gamevideourl = Video_URL;
	}

	public int GetGameID() {
		return this.gameid;
	}

	public String GetVideoURL() {
		if (this.gamevideourl == null) {
			return null;
		} else if (this.gamevideourl.length() == 0) {
			return null;
		} else {
			return this.gamevideourl;
		}
	}
}
