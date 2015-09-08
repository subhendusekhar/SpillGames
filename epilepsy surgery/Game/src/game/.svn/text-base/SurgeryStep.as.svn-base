package src.game {
	import src.GLP.GLPScene;
	import flash.errors.EOFError;
	import flash.utils.getQualifiedClassName;
	import src.GLP.GMGDebugger;
	import flash.utils.getDefinitionByName;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class SurgeryStep extends GLPScene{
		
		private var m_properties:SurgeryStepProperties;
		
		public function SurgeryStep() {
			for(var i:uint = 0; i < numChildren; i++)
			{
				if(getChildAt(i) is SurgeryStepProperties)
				{
					m_properties = SurgeryStepProperties(getChildAt(i));
				}
			}
		}
		
		public function getProperties():SurgeryStepProperties
		{
			if(m_properties == null)
			{
				GMGDebugger.traceString("No properties defined at scene " + getQualifiedClassName(this) + 
					  ". Add a SurgeryStepProperties element to the SurgeryStep object.");
				m_properties = new SurgeryStepProperties();
			}
			return m_properties;
		}
		
		public function stepIsNamed(name:String):Boolean
		{
			return (getQualifiedClassName(this).indexOf(name) >= 0);
		}
		
		public function updateSounds():void
		{
			if(getProperties().soundList != null)
			{
				for(var soundIndex:int = 0; soundIndex < getProperties().soundList.length; soundIndex++)
				{
					var movieClipName:String = getProperties().soundList[soundIndex].toString().split(",")[0];
					var movieClip:MovieClip = (movieClipName == "this" ? this : this.getChildByName(movieClipName)) as MovieClip;
					if(movieClip != null)
					{
						var frame:Number = Number(getProperties().soundList[soundIndex].toString().split(",")[1]);
						var sound:String = getProperties().soundList[soundIndex].toString().split(",")[2];
						var loop:Number = Number(getProperties().soundList[soundIndex].toString().split(",")[3]);
						var particularEvent:String = getProperties().soundList[soundIndex].toString().split(",")[4];
						
						try
						{
							if(movieClip.currentFrame == frame)
							{
								var gmgSound:Class = getDefinitionByName(sound) as Class;
							
								if(particularEvent == "over")
								{
									movieClip.addEventListener(MouseEvent.MOUSE_OVER, mcOver);
									movieClip.overSound = new gmgSound();
									movieClip.overLoop = loop;
								}
								else if(particularEvent == "click")
								{
									movieClip.addEventListener(MouseEvent.CLICK, mcClick);
									movieClip.clickSound = new gmgSound();
									movieClip.clickLoop = loop;
								}
								else if(particularEvent == "out")
								{
									movieClip.addEventListener(MouseEvent.MOUSE_OUT, mcOut);
									movieClip.outSound = new gmgSound();
									movieClip.outLoop = loop;
								}
								else
								{
									SoundManager.sharedManager().playSound(new gmgSound(), loop);
								}
								getProperties().soundList.splice(soundIndex, 1);
								soundIndex--;
							}
						}
						catch (err:Error)
						{
							GMGDebugger.traceString("Sound of name " + sound + " called at " + getQualifiedClassName(this) + " does not exist.");
							return;
						}
					}
					else
					{
						GMGDebugger.traceString("Movieclip of name " + movieClipName + " called at " + getQualifiedClassName(this) + " does not exist.");
					}
				}
			}
		}
		
		public function mcOver(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(ev.currentTarget.overSound as GMGSound, ev.currentTarget.overLoop as Number);
		}
		
		public function mcOut(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(ev.currentTarget.outSound as GMGSound, ev.currentTarget.outLoop as Number);
		}
		
		public function mcClick(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(ev.currentTarget.clickSound as GMGSound, ev.currentTarget.clickLoop as Number);
		}
	}
}
