package KinectW {
	import flash.geom.ColorTransform;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PlayerMask extends FlxSprite {
		public function PlayerMask(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) {
			super(X, Y, SimpleGraphic);
		}
		
		public function setColor(color:uint) : void {
			_colorTransform = new ColorTransform();
			if (color != FlxG.TRANSPARENT) {
				_colorTransform.color = color;
			}
		}
	}
}