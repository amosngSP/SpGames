package db;

import java.io.InputStream;
import java.io.Serializable;

public class GameImage implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4743223256407176707L;
	int GameID;
	InputStream ImageBlob;

	public GameImage() {

	}

	public GameImage(int GameID, InputStream image) {
		this.GameID = GameID;
		this.ImageBlob = image;
	}

	public void SetImage(InputStream image) {
		this.ImageBlob = image;
	}

	public void SetGameID(int GameID) {
		this.GameID = GameID;
	}

	public InputStream GetImage() {
		return this.ImageBlob;
	}

	public int GetGameID() {
		return this.GameID;
	}
}
