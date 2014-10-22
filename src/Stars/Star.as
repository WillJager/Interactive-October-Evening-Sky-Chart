package Stars {
	import flash.utils.Dictionary;
	
	import org.flixel.FlxSprite;
	
	public class Star extends FlxSprite {
		
		public var raDeg:Number;
		public var decDeg:Number;
		
		public var raHours:Number;
		public var ra:Number; //right ascension in radians
		public var dec:Number; //declination in radians
		public var mag:Number;
		public var commonName:String;
		public var name:String;
		public var catId:String;
		public var constellation:String;
		
		public var starInfo:String = "Did you know?\nSaturn is a planet?";
		
		public static var constellationMap:Dictionary;
		
		//original x, y, and z coords. updated after initial rotation.
		private var xOld:Number;
		private var yOld:Number;
		private var zOld:Number;
		
		public function Star(rowData:Array, X:Number=0, Y:Number=0) {
			
			super(X, Y, Embed.StarGIF);
			
			commonName = rowData[0];
			name = rowData[1];
			catId = rowData[2];
			constellation = rowData[3];
			raHours = rowData[4];
			raDeg = raHours * 15; //0 to 360
			decDeg = rowData[5]; //-90 to 90
			mag = rowData[6];
			
			ra = raDeg * Math.PI/180;
			dec = (decDeg) * Math.PI/180;
			
			xOld = Math.sin(dec + Math.PI / 2) * Math.cos(ra);
			yOld = Math.sin(dec + Math.PI / 2) * Math.sin(ra);
			zOld = Math.cos(dec + Math.PI / 2);
			
			adjust();
			
			if(constellationMap == null) {
				buildDict();
			}

			if(constellationMap[constellation] != null) {
				color=constellationMap[constellation];
			}
			
		}
		
		private var degrees:Number = 0;
		
		private var rotatedX:Boolean = false;
		private var rotatedY:Boolean = false;
		
		private var xRotationAmount:int = 40;
		private var yRotationAmount:int = 150;
		
		/**
		 * hacky function that gets called in update() method of PlayState.as
		 * responsible for the rotation animation that properly positions the star chart
		 */
		
		public function adjust() : void {
			
			if(rotatedY) {
				return;
			}
			
			var rad:Number = degrees * Math.PI/180;
			var x3D:Number;
			var y3D:Number;
			var z3D:Number;				
			
			//rotation around x axis or y axis - essentially applying rotation matrix
			if(!rotatedX) {
				x3D = xOld;
				y3D = yOld * Math.cos(rad) - zOld * Math.sin(rad);
				z3D = yOld * Math.sin(rad) + zOld * Math.cos(rad);				
			} else { //y axis
				x3D = xOld * Math.cos(rad) + zOld * -Math.sin(rad);
				y3D = yOld;
				z3D = xOld * Math.sin(rad) + zOld * Math.cos(rad);
			}
			
			if(!rotatedX && degrees > xRotationAmount) {
				rotatedX = true;
				xOld = x3D;
				yOld = y3D;
				zOld = z3D;
				degrees = 0;
			}
			
			if(rotatedX && !rotatedY && degrees > yRotationAmount) {
				rotatedY = true;
			}
			
			//plot points, using hacky magic numbers for correct positioning
			if (rotatedX && rotatedY) {
				//convert to "polar" with declination representing distance from center
				var theta:Number = Math.acos(z3D / Math.sqrt(x3D*x3D + y3D*y3D + z3D*z3D)) - Math.PI / 2;
				var phi:Number = Math.atan2(y3D,x3D);
				x = (90 - Math.abs(theta * 180 / Math.PI)) * Math.cos(phi) * ScienceHackDay.GAME_HEIGHT/200 + 320;
				y = (90 - Math.abs(theta * 180 / Math.PI)) * Math.sin(phi) * ScienceHackDay.GAME_HEIGHT/200 + 230;
			} else {
				x = x3D * ScienceHackDay.GAME_HEIGHT / 2.25 + 320;
				y = y3D * ScienceHackDay.GAME_HEIGHT / 2.25 + 230;				
			}
			
			degrees ++;

		}
		
		public function buildDict() : void{
			constellationMap = new Dictionary();
			
			constellationMap["Pegasus"]=0xffF0F8FF;
			constellationMap["Andromeda"]=0xff00FF00;
			constellationMap["Pisces Austrinus"]=0xff00FFFF;
			constellationMap["Perseus"]=0xff7FFFD4;
			constellationMap["Aries"]=0xffFF0000;
			constellationMap["Taurus"]=0xffF5F5DC;
			constellationMap["Auriga"]=0xffFFE4C4;
			constellationMap["Lynx"]=0xff000000;
			constellationMap["Triangulum"]=0xffFFEBCD;
			constellationMap["Cameloparidalis"]=0xff0000FF;
			constellationMap["Ursa Major"]=0xff8A2BE2;
			constellationMap["Ursa Minor"]=0xffA52A2A;
			constellationMap["Casseopeia"]=0xffDEB887;
			constellationMap["Cepheus"]=0xff5F9EA0;
			constellationMap["Cygnus"]=0xff7FFF00;
			constellationMap["Draco"]=0xffD2691E;
			constellationMap["Corona Borealis"]=0xffFF7F50;
			constellationMap["Bootes"]=0xff6495ED;
			constellationMap["Hercules"]=0xffFFF8DC;
			constellationMap["Lyra"]=0xffDC143C;
			constellationMap["Vulpecula"]=0xff00FFFF;
			constellationMap["Sagitta"]=0xff00008B;
			constellationMap["Delphinus"]=0xff008B8B;
			constellationMap["Equuleus"]=0xffB8860B;
			constellationMap["Aquila"]=0xffA9A9A9;
			constellationMap["Scutum"]=0xff006400;
			constellationMap["Serpens Cauda"]=0xffBDB76B;
			constellationMap["Aquarius"]=0xff8B008B;
			constellationMap["Capricornus"]=0xff556B2F;
			constellationMap["Sagittarius"]=0xffFF8C00;
			constellationMap["Microscopium"]=0xff9932CC;
			constellationMap["Piscis Austrinus"]=0xff8B0000;
			constellationMap["Sculptor"]=0xffE9967A;
			constellationMap["Cetus"]=0xff8FBC8F;
			constellationMap["Cetus"]=0xff483D8B;
			constellationMap["Lacerta"]=0xff2F4F4F;
			constellationMap["Ophiucus"]=0xff00CED1;
		}
		
		
	}
}