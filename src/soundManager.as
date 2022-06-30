package 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.utils.Timer;
	
	public class  soundManager extends Sprite
	{
		var fadeClock:Timer;
	
		var bMute:Boolean = false;
		var bMus:Boolean = false;
		
		var bgMusic:Sound;
	
		var explode1:Sound;
		var explode2:Sound;
		var shot1:Sound;
		var wallH:Sound;
		var collect:Sound;
		
		
		
		
		var game:Game;
		
		var hs:SoundChannel;
		var ds:SoundChannel;
		var ms:SoundChannel;
		
		public function soundManager(gm)
		{
			bgMusic = new bgm1();
			
			game = gm;
			fadeClock = new Timer(20, 0);
			fadeClock.addEventListener(TimerEvent.TIMER, fadeout, false, 0, true);
		
			SoundMixer.soundTransform = new SoundTransform(1.0);
			
			
			
			explode1 = new explosion_1();
			explode2 = new missileLaunchS();
			shot1 = new nShot1();
			wallH = new hitWall();
			collect = new coinS();
		
			
			//bgNoise = new NoiseBG()
		}
		
		public function mute():void
		{
			if (bMute)
			{
				bMute = false;
				SoundMixer.soundTransform = new SoundTransform(1.0);
				var sf = new SoundTransform(.6);
				if (ds != null)
				{
					ds.soundTransform = sf;
					
				}
				if (ms != null)
				{
					ms.soundTransform = sf;
					
				}
			}
			else {
				bMute = true;
				SoundMixer.soundTransform = new SoundTransform(0);
				var sf = new SoundTransform(0);
				if (ds != null)
				{
					ds.soundTransform = sf;
					
				}
				if (ms != null)
				{
					ms.soundTransform = sf;
					
				}
			}
		}
		
		
		public function playShot(snd:String):void
		{
			if (!bMute)
			{
				switch(snd)
				{
					case "shot1":
						shot1.play();
						break;
					case "explode":
						explode1.play();
						break;
					
					case "explode2":
						explode2.play();
						break;
					case "wall":
						wallH.play();
						break;
					case "coin":
						collect.play();
						break;
					case "beep":
						collect.play();
						break;
					
				
				}
			}
		}
		
		public function fadeout(evt:TimerEvent):void
		{
			if (ms.soundTransform.volume > .02)
			{
				var sf = new SoundTransform(ms.soundTransform.volume - .03);
				ms.soundTransform = sf;
			}
			else {
				ms.stop();
				bMus = false;
				fadeClock.stop();
				
			}
			
		}
		
		public function playbgm():void
		{
			if (!bMute)
			{	if (!bMus)
				{
					bMus = true;
					var sf = new SoundTransform(.9);
					ms = bgMusic.play(0, 100,sf);
				}
			}
		}
		public function stopbgm():void
		{
			if (ms.soundTransform != null)
			{
				fadeClock.start();
			}
			
		}
		public function playNoise():void
		{
			if (!bMute)
			{		var sf = new SoundTransform(.6);
				//	ds = bgNoise.play(0, 100,sf);
					
				
			}
		}
		public function stopNoise():void
		{
			if (ds != null)
			{
				var sf = new SoundTransform(0);
				//ds.soundTransform = sf;
				//ds.stop();
			}
			
		}
	
		public function Win():void
		{
			if (!bMute)
			{
				//win.play();
			}
		}
	
		
	}
	
}