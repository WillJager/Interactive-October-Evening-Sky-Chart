package Stars {
	import State.PlayState;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * Was going to be used to display pics/info about stars, but never implemented
	 */
	public class StarInfoBox extends FlxGroup {
		
		public static const BOX_WIDTH:uint = 100;
		public static const BOX_HEIGHT:uint = 50;
		
		public var star:Star;
		
		public var box:FlxSprite;
		public var txt:FlxText;
		
		public function StarInfoBox(star:Star) {
			super();
			this.star = star;
			box = new FlxSprite(star.x, star.y).makeGraphic(BOX_WIDTH, BOX_HEIGHT, FlxG.PINK);
			txt = new FlxText(star.x, star.y, BOX_WIDTH, star.starInfo);
			txt.color = FlxG.BLUE;
			txt.size = 8;
			
			add(box);
			add(txt);
		}
		
		override public function update():void {
			super.update();
			PlayState.text.text = star.x.toString();
			
			for (var i:uint = 0; i < length; i++) {
				var basic:FlxObject = members[i] as FlxObject;
				basic.x = star.x;
				basic.y = star.y;
			}

		}
	}
}