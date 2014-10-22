package State {
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import KinectW.KinectWrapper;
	import KinectW.PlayerPoint;
	
	import Stars.Star;
	import Stars.StarChart;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	
	/**
	 * The main class, essentially. 
	 * 
	 * NOTES:
	 * When starting up, the stars should rotate to display the correct view
	 * Shortly after, the kinect should finish loading
	 * Once you see the video feed, you can press 1,2, or 3 for different masks. 
	 * Press T to toggle background on/off
	 * 
	 * In Flash Builder, had to do the following:
	 * Set the following in compiler argument: -frame appFrame ScienceHackDay
	 * Set Preloader.as as the default runnable application file
	 */
	public class PlayState extends FlxState {
		
		public static var text:FlxText;
		private var starChart:StarChart;
		
		private var kinect:KinectWrapper;
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
			start();
		}
		
		private function start() : void {

			kinect = new KinectWrapper()
			add(kinect);			
			
			starChart = new StarChart();
			add(starChart);
			
			//quick hack to enable pointing with mouse pointer
			cursor = new PlayerPoint(0,0,Embed.StarGIF);
			add(cursor);
			
			text = new FlxText(10, 10, 500, "");
			text.color = FlxG.GREEN;
			text.size = 16;
			add(text);
			
			//change to true to generate the star file.
			//results should be written to a file called starFile.txt on the Desktop directory (might have to create it first)
			//should then be put in test.csv in assets directory (wasn't able to write directly to this file)
			if(false) {
				doUrlLoadStuff();
			}
		}
		
		private var loader:URLLoader;
		private var starNames:Array;
		
		private function doUrlLoadStuff() : void {
			starNames = [
				"Delta Peg",
				"Beta Peg",
				"Gamma Peg",
				"Alpha Peg",
				"Zeta Peg",
				"Theta Peg",
				"Epsilon Peg",
				"Eta Peg",
				"Pi Peg",
				"Lambda Peg",
				"Iota Peg",
				"Kappa Peg",
				"Alpha And",
				"Beta And",
				"Mu And",
				"Nu And",
				"57 And",
				"Eta Psc",
				"Gamma Psc",
				"Omega Psc",
				"Iota Psc",
				"Omicron Psc",
				"Alpha Psc",
				"Epsilon Psc",
				"Theta Psc",
				"Delta Psc",
				"Nu Psc",
				"Beta Psc",
				"Mirfak",
				"Algol",
				"Eta Per",
				"Xi Per",
				"Omicron Per",
				"Pi Per",
				"Rho Per",
				"Omega Per",
				"Hamal",
				"Beta Ari ",
				"Gamma Ari ",
				"Alpha Ari",
				"Alpha Tau",
				"Beta Tau",
				"Gamma Tau",
				"Delta Tau",
				"Epsilon Tau",
				"Eta Tau",
				"Lambda Tau",
				"Zeta Tau",
				"Omnicron Tau",
				"16 Tau",
				"17 Tau",
				"19 Tau",
				"20 Tau",
				"21 Tau",
				"22 Tau",
				"23 Tau",
				"27 Tau",
				"68 Tau",
				"61 Tau",
				"Alpha Aur",
				"Beta Aur",
				"Theta Aur",
				"Zeta Aur",
				"Eta Aur",
				"Iota Aur",
				"2 Lyn",
				"15 Lyn",
				"21 Lyn",
				"Alpha Tri",
				"Beta Tri",
				"7 Tri",
				"CS Cam",
				"Alpha Cam",
				"Gamma Cam",
				"Eta UMa",
				"Zeta UMa",
				"Epsilon UMa",
				"Delta UMa",
				"Gamma UMa",
				"Chi UMa",
				"Psi UMa",
				"Lambda UMa",
				"Mu UMa",
				"Alpha UMa",
				"Omicron UMa",
				"HIP 48402 A",
				"Theta UMa",
				"Iota UMa",
				"Kappa UMa",
				"Polaris",
				"Delta UMi",
				"Epsilon UMi",
				"Zeta UMi",
				"Eta UMi",
				"Gamma UMi",
				"Beta UMi",
				"Beta Cas",
				"Alpha Cas",
				"Delta Cas",
				"Epsilon Cas",
				"Gamma Cas",
				"Alpha Cep",
				"Beta Cep",
				"Zeta Cep",
				"Gamma Cep",
				"Iota Cep",
				"Alpha Cyg",
				"Gamma Cyg",
				"Eta Cyg",
				"Beta1 Cyg",
				"Episilon Cyg",
				"Zeta Cyg",
				"78 Cyg",
				"Delta Cyg",
				"Iota Cyg",
				"Kappa Cyg",
				"Beta Dra",
				"Gamma Dra",
				"Xi Dra",
				"25 Dra",
				"Delta Dra",
				"Episilon Dra",
				"Tau Dra",
				"Chi Dra",
				"Zeta Dra",
				"Eta Dra",
				"Theta Dra",
				"Iota Dra",
				"Alpha Dra",
				"Kappa Dra",
				"Lambda Dra",
				"Delta CrB",
				"Beta CrB ",
				"Alpha Crb ",
				"Gamma CrB",
				"Theta CrB",
				"Epsilon CrB",
				"Iota CrB",
				"Gamma Boo",
				"Beta Boo ",
				"Delta Boo",
				"Episilon Boo",
				"Alpha Boo",
				"Zeta Boo",
				"Eta Boo",
				"Rho Boo",
				"Delta Herculis",
				"Lambda Herculis",
				"Mu Herculis",
				"Xi Herculis",
				"Episilon Herculis",
				"Pi Herculis",
				"Rho Herculis",
				"Theta Herculis",
				"Iota Herculis",
				"Eta Herculis",
				"Sigma Herculis",
				"Tau Herculis",
				"Phi Herculis",
				"Chi Herculis",
				"Vega ",
				"Zeta1 Lyrae",
				"Delta2 Lyrae",
				"Gamma Lyrae",
				"Beta Lyrae",
				"Alpha Vulpeculae",
				"15 Vulpeculae",
				"Beta Sagittae",
				"Alpha Sagittae",
				"Delta Sagittae",
				"Gamma Sagittae",
				"Nu Sagittae",
				"Epsilon Delphini",
				"Beta Delphini",
				"Delta Delphini",
				"Gamma Delphini",
				"Alpha Delphini",
				"Beta Equ",
				"Delta Equ",
				"6 Equ",
				"Alpha Equ",
				"Beta Aql",
				"Alpha Aql",
				"Gamma Aql",
				"Delta Aql",
				"Zeta Aql",
				"Episilon Aql",
				"Eta Aql",
				"Theta Aql",
				"Lambda Aql",
				"Alpha Sct",
				"Beta Sct",
				"Gamma Sct",
				"HIP 92814",
				"Theta1 Ser",
				"Eta Ser",
				"Omicron Ser",
				"Xi Ser",
				"Nu Ser",
				"98 Aqr",
				"Psi1 Aqr",
				"Lambda Aqr",
				"Eta Aqr",
				"Zeta Aqr",
				"Gamma Aqr",
				"Sadalmelik ",
				"Theta Aqr",
				"Sigma Aqr",
				"71 Aqr",
				"Delta Aqr",
				"88 Aqr",
				"38 Aqr",
				"Iota Aqr",
				"Beta Aqr",
				"Episilon Aqr",
				"Delta Cap",
				"Gamma Cap",
				"Iota Cap",
				"Zeta Cap",
				"Theta Cap",
				"Omega Cap",
				"Alpha Cap",
				"Beta Cap",
				"Psi Cap",
				"Rho1 Sgr",
				"Omricon Sgr",
				"Xi2 Sgr",
				"Sigma Sgr",
				"Tau Sgr",
				"52 Sgr",
				"62 Sgr",
				"Iota Sgr",
				"Alpha Sgr",
				"Beta Sgr",
				"Zeta Sgr",
				"Psi Sgr",
				"Lambda Sgr",
				"Mu Sgr",
				"Delta Sgr",
				"Episilon Sgr",
				"Gamma Sgr",
				"3 Sgr",
				"Eta Sgr",
				"Alpha Mic",
				"Gamma Mic",
				"Episilon Mic",
				"Fomalhaut ",
				"Epsilon PsA",
				"Eta PsA",
				"Theta PsA",
				"Tau PsA",
				"Beta PsA",
				"Delta PsA",
				"Alpha Scl",
				"Beta Scl",
				"Gamma Scl",
				"Xi1 Cet",
				"Xi2 Cet",
				"Mu Cet",
				"Lambda Cet",
				"Alpha Cet",
				"Gamma Cet",
				"Delta Cet",
				"Mira",
				"Episilon Cet",
				"Rho Cet",
				"Zeta Cet ",
				"Theta Cet",
				"Eta Cet",
				"Beta Cet",
				"Iota Cet",
				"Tau Ceta",
				"Sigma Ceta",
				"Pi Ceta",
				"Beta Lac",
				"Alpha Lac",
				"4 Lac",
				"5 Lac",
				"6 Lac",
				"1 Lac",
				"Alpha Oph",
				"Beta Oph",
				"Kappa Oph",
				"Episilon Oph",
				"Zeta Oph",
				"Eta Oph",
				"51 Oph"
			];
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadXML);
			loader.load(new URLRequest("http://server1.sky-map.org/search?star=" + starNames.splice(0, 1)));
		}
		
		private function loadXML(e:Event):void {
			var response:XML = new XML(e.target.data);
			
			if(response[0].status != "-1") {
			
				var infoString:String = response[0].request + "," + response.object[0].name + "," + response.object[0].catId + "," + response.object[0].constellation + "," + response.object[0].ra + "," + response.object[0].de + "," + response.object[0].mag + "\n";
				
				var file:File = File.desktopDirectory.resolvePath("starFile.txt");
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.APPEND);
				stream.writeUTFBytes(infoString);
				stream.close();
			}
			
			if(starNames.length > 0) {
				loader.load(new URLRequest("http://server1.sky-map.org/search?star=" + starNames.splice(0, 1)));
			}
		}
		
		public var cursor:PlayerPoint;
		
		override public function update():void {
			super.update();
			
			starChart.callAll("adjust"); //enables fancy rotation sequence
			
			cursor.x = FlxG.mouse.x;
			cursor.y = FlxG.mouse.y;		
			
			FlxG.overlap(kinect.players, starChart, playerTouchingStar);
			FlxG.overlap(cursor, starChart, playerTouchingStar);
			
			if(FlxG.keys.justPressed("ONE")) {
				kinect.enableNothing();
			} else if (FlxG.keys.justPressed("TWO")) {
				kinect.enableTint();
			} else if (FlxG.keys.justPressed("THREE")) {
				kinect.enableMask();
			} else if (FlxG.keys.justPressed("T")) {
				kinect.toggleBackGroundEnabled();
			}
		}

		private var starText:String;
		
		public function playerTouchingStar(pt:FlxSprite, s:Star) : void {
			if (pt is PlayerPoint) {
				starText = 
					"Common Name: " + s.commonName + "\n" +
					"Constellation: " + s.constellation + "\n" +
					"Name: " + s.name + "\n" +
					"CatId: " + s.catId + "\n" +
					"Right Ascension: " + s.raHours + "\n" +
					"Declination: " + s.decDeg + "\n" +
					"Magnitude: " + s.mag;
				
				text.text = starText;
			}
		}
		
	}
}