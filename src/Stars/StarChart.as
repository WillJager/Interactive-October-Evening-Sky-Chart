package Stars {
	import flash.utils.ByteArray;
	
	import org.flixel.FlxGroup;
	
	public class StarChart extends FlxGroup {
		public function StarChart() {
			super();
			
			var loadedData:Array = [];
			
			var data:String = (new Embed.TestCSV as ByteArray).toString();
			loadedData = data.split(/\r\n|\n|\r/);
			
			for (var i:int = 0; i < loadedData.length; i++) {
				var rowData:Array = loadedData[i].split(',');
				var star:Star = new Star(rowData);
				add(star);
			}
		}
		
	}
}