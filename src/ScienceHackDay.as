package {
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import State.PlayState;
	
	import org.flixel.FlxGame;
	
	public class ScienceHackDay extends FlxGame {
		
		public static const GAME_WIDTH:uint = 640;
		public static const GAME_HEIGHT:uint = 480;
		private static const F:uint = 1; //scale factor. setting this to 2 will get a larger window (and slow the app down significantly)
		
		public function ScienceHackDay() {
			super(GAME_WIDTH, GAME_HEIGHT, PlayState, F, 60, 60);
			forceDebugger = true;
		}
		
		override protected function create(FlashEvent:Event) : void {
			super.create(FlashEvent);
			stage.nativeWindow.bounds = new Rectangle(240, 0, GAME_WIDTH*F, GAME_HEIGHT*F);
		}
		

	}
}