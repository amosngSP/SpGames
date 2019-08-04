package db;

public interface GameVideoDAO {
	public GameVideo Get_Game_Video(int gameid);

	public boolean Add_Game_Video(GameVideo Game_Video);

	public boolean Update_Game_Video(GameVideo Game_Video);
}
