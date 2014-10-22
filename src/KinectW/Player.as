package KinectW {
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxGroup {
		public var user:User;
		public var leftHand:FlxSprite;
		
		public var mask:PlayerMask;
		public var littleMask:PlayerMask;
		
		private var littleMaskScale:Number = 0.95;
		
		private var previousMode:int = -1;
		private var playerMode:int = 0; 
		
		private var maskPixels:BitmapData;
		
		public function Player() {
			leftHand = new PlayerPoint(0,0,Embed.StarGIF);
			mask = new PlayerMask();
			littleMask = new PlayerMask();
			littleMask.scale.x = littleMaskScale;
			littleMask.scale.y = littleMaskScale;
			
			add(mask);
			add(littleMask);

			add(leftHand);
		}
		
		internal function setUser(user:User) : void {
			this.user = user;
		}
		
		override public function update():void {
			super.update();
			
			if(user != null) {
				if(user.hasSkeleton) {
					var p : Point = user.getJointByName("left_hand").position.rgb;
					leftHand.x = p.x;
					leftHand.y = p.y;
				}
				
				if (maskPixels != null) {
					mask.pixels = maskPixels;
				}
				
				switch(playerMode) {
					case 2: { //mask
						if (maskPixels != null) {
							littleMask.pixels = mask.pixels;
						}
						break;
					}
				}
				
				if(previousMode != playerMode) {
					previousMode = playerMode;
					
					switch(playerMode) {
						case 0: { //normal
							mask.color = FlxG.TRANSPARENT;
							mask.setColor(FlxG.TRANSPARENT);
							0x00ffffff
							littleMask.kill();
							break;
						}
						case 1: { //tint
							mask.setColor(FlxG.TRANSPARENT);
							mask.color = FlxG.BLUE;
							littleMask.kill();
							break;
						}
						case 2: { //mask
							mask.color = FlxG.TRANSPARENT;
							mask.setColor(FlxG.WHITE);
							littleMask.setColor(FlxG.BLACK);
							littleMask.revive();
							break;
						}
					}
				}
			}
		}
		
		public function enableMask() : void {
			playerMode = 2;
		}
		
		public function enableTint() : void {
			playerMode = 1;
		}
		
		public function enableNothing() : void {
			playerMode = 0;
		}
		
		override public function revive():void {
			super.revive();
			callAll("revive");
			previousMode = -1;
			playerMode = 0;
		}
		
		internal function updateMaskPixels(newPixels:BitmapData) : void {
			maskPixels = newPixels;
		}
		
	}
}