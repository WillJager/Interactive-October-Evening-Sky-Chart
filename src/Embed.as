package {
	public class Embed {
		[Embed(source = '../assets/star.gif', mimeType = "image/gif")] public static var StarGIF:Class;		
		[Embed(source = '../assets/test.csv', mimeType = "application/octet-stream")] public static var TestCSV:Class;
	}
}