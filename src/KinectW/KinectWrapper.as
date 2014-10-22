package KinectW {
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;
	
	import flash.utils.Dictionary;
	
	import State.PlayState;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	/**
	 * custom wrapper to make AirKinect play (somewhat) nicely with Flixel
	 */
	public class KinectWrapper extends FlxGroup {
		
		private var device:Kinect;
		private var rgbCanvas:FlxSprite;
		
		private var playerMap:Dictionary;
		public var players:FlxGroup;
		
		public function KinectWrapper() {
			if (Kinect.isSupported()) {
				rgbCanvas = new FlxSprite(0,0);
				add(rgbCanvas);
				
				players = new FlxGroup();
				add(players);
				
				playerMap = new Dictionary();
				
				device = Kinect.getDevice();
				device.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, rgbImageUpdateHandler);
				device.addEventListener(UserEvent.USERS_ADDED, usersAddedHandler, false, 0, true);
				device.addEventListener(UserEvent.USERS_REMOVED, usersRemovedHandler, false, 0, true);
				device.addEventListener(UserEvent.USERS_MASK_IMAGE_UPDATE, usersMaskImageUpdateHandler, false, 0, true);
				
				var settings:KinectSettings = new KinectSettings();
				settings.rgbResolution = CameraResolution.RESOLUTION_640_480;
				settings.rgbEnabled = true;
				settings.userMaskEnabled = true;
				settings.userMaskResolution = settings.rgbResolution;
				settings.skeletonEnabled = true;
				device.start(settings);
			}
		}
		
		//todo: should be looking for changed values in update... 
		
		private function rgbImageUpdateHandler(event:CameraImageEvent):void {
			rgbCanvas.pixels = event.imageData;
		}
		
		private function usersAddedHandler(event:UserEvent):void {
			
			PlayState.text.text = "USER DETECTED";
			
			for each(var user:User in event.users) {
				var player:Player = players.recycle(Player) as Player;
				player.revive();
				player.setUser(user);
				playerMap[user.userID] = player;
			}
		}
		
		private function usersRemovedHandler(event:UserEvent):void {
			
			PlayState.text.text = "USER REMOVED";
			
			for each(var user:User in event.users) {
				var player:Player = playerMap[user.userID];
				
				if (player != null) {
					player.kill();
				}

			}
		}
		
		private function usersMaskImageUpdateHandler(event:UserEvent):void {
			for each (var user:User in event.users) {
				var player:Player = playerMap[user.userID];
				if (player != null && player.active) {
					player.updateMaskPixels(user.userMaskData);
				}
			}
			
		}
		
		public function enableMask() : void {
			players.callAll("enableMask", false);
		}
		
		public function enableTint() : void {
			players.callAll("enableTint", false);
		}
		
		public function enableNothing() : void {
			players.callAll("enableNothing", false);
		}
		
		private var showRGB:Boolean = true;
		
		public function toggleBackGroundEnabled() : void {
			showRGB = !showRGB;
			
			if(showRGB) {
				rgbCanvas.revive();
			} else {
				rgbCanvas.kill();
			}
			
		}
		
	}
}