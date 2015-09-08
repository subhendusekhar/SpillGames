package src.elements {
	
	import src.GLP.GLPScene;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import src.game.GMGSound;
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import src.game.GameLogic;
	import flash.utils.getQualifiedClassName;
	import src.GLP.GMGDebugger;
	import src.game.SoundManager;
	import flash.media.SoundChannel;
	
	[Inspectable(name="horizontal", variable="horizontalSlide", type="Boolean", defaultValue=false)]
	[Inspectable(name="vertical", variable="verticalSlide", type="Boolean", defaultValue=false)]
	[Inspectable(name="slidingSound", variable="m_slidingSound", type="String", defaultValue="")]
	[Inspectable(name="slidingElement", variable="slidingElement", type="String", defaultValue="")]
	[Inspectable(name="backgroundAnimation", variable="backgroundAnimation", type="String", defaultValue="")]
	[Inspectable(name="canGoBack", variable="canGoBack", type="Boolean", defaultValue=false)]
	
	public class Slider extends GLPScene {
		
		public var m_horizontalSlide:Boolean;
		public var m_verticalSlide:Boolean;
		public var m_slidingSound:String;
		public var m_slidingElement:String;
		
		public var currentXPortion:int = 0;
		public var currentYPortion:int = 0;

		public var draggable:MovieClip;

		public var reachedXPortion:int = 0;
		public var reachedYPortion:int = 0;
		public var reachedX:Number = 0;
		public var reachedY:Number = 0;

		public var bgAnimation:MovieClip = null;

		private var horizontalFactor:int = 0;
		private var verticalFactor:int = 0;

		private var rect:Rectangle = null;

		public var canGoBack:Boolean = true;

		private var shouldDrag:Boolean = false;
		private var mDown:Boolean = false;
		private var mUp:Boolean = false;
		private var dragging:Boolean = false;
		private var sound:GMGSound = null;
		
		private var m_soundChannel:SoundChannel = null;
		
		public function Slider() 
		{
			getChildByName("m_background").visible = false;
		}
		
		public function set backgroundAnimation(value:Object)
		{
			if(value != null && value != "")
			{
				if(value == "this")
				{
					bgAnimation = MovieClip(this.parent);
				}
				else
				{
					bgAnimation = MovieClip(this.parent.getChildByName(String(value)));
					if(bgAnimation == null)
					{
						GMGDebugger.traceString("Selected background animation called at " + getQualifiedClassName(GameLogic.sharedGameLogic().getCurrentScene()) + " does not exist.");
					}
				}
			}
			else
			{
				GMGDebugger.traceString("Selected background animation called at " + getQualifiedClassName(GameLogic.sharedGameLogic().getCurrentScene()) + " is invalid.");
			}
		}
		public function set horizontalSlide(value:Object)
		{
			m_horizontalSlide = Boolean(value);
			if(draggable != null)
			{
				initSlider(m_horizontalSlide, m_verticalSlide, draggable);
			}
		}
		
		public function get horizontalSlide()
		{
			m_horizontalSlide;
		}
		
		public function set verticalSlide(value:Object)
		{
			m_verticalSlide = Boolean(value);
			if(draggable != null)
			{
				initSlider(m_horizontalSlide, m_verticalSlide, draggable);
			}
		}
		
		public function get verticalSlide()
		{
			return m_verticalSlide;
		}
		
		public function set slidingElement(value:Object)
		{
			var Definition:Class = getDefinitionByName(String(value)) as Class;
			var slidingElement = MovieClip(new Definition());
			if(slidingElement != null)
			{
				initSlider(m_horizontalSlide, m_verticalSlide, slidingElement);
			}
		}
		
		public function get slidingElement()
		{
			return "";
		}

		public function initSlider(hor:Boolean, ver:Boolean, draggableClip:MovieClip, snd:GMGSound = null)
		{
			scheduleForUpdate();
			
			sound = snd;

			horizontalFactor = hor ? 1:0;
			verticalFactor = ver ? 1:0;

			if (hor)
			{
				draggableClip.y = 25;
			}
			else if (ver)
			{
				draggableClip.x = 25;
			}

			if (ver && hor)
			{
				draggableClip.x = 0;
				draggableClip.y = 0;
			}

			if (draggable == null)
			{
				draggable = draggableClip;
				
				var rot:Number = this.rotation;
				this.rotation = 0;
				
				draggable.width /= this.width/50;
				draggable.height /= this.height/50;
				
				this.rotation = rot;
				this.addChild(draggable);
				
				// EVENTS
				draggable.addEventListener(MouseEvent.MOUSE_OVER, startDragging);
				draggable.addEventListener(MouseEvent.MOUSE_OUT, stopDragging);
				//MovieClip(this.parent).addEventListener(MouseEvent.MOUSE_MOVE, dragged);
				MovieClip(this.parent).addEventListener(MouseEvent.MOUSE_DOWN, moDown);
				MovieClip(this.parent).addEventListener(MouseEvent.MOUSE_UP, moUp);
			}

			//draggable.width /=  scaleX;
			//draggable.height /=  scaleY;

			rect = new Rectangle(25 * (1-horizontalFactor), 25 * (1-verticalFactor), (50 * horizontalFactor), (50 * verticalFactor));

			this.mouseEnabled = false;
		}
		
		// Events
		function moDown(ev:MouseEvent):void
		{
			mDown = true;
			mUp = false;
			
			if(m_slidingSound != null)
			{
				if(m_soundChannel != null)
				{
					SoundManager.sharedManager().stopSound(m_soundChannel);
					m_soundChannel = null;
				}
				try
				{
					var ClassDef = getDefinitionByName(m_slidingSound);
					if(ClassDef != null)
					{
						m_soundChannel = SoundManager.sharedManager().playSound(new ClassDef(), 9999);
					}
				}
				catch(e:*)
				{
					GMGDebugger.traceString("Selected sound does not exist.");
				}
				
			}
			//draggable.startDrag(false, rect);
		}

		function moUp(ev:MouseEvent):void
		{
			mUp = true;
			mDown = false;
			
			if(m_slidingSound != null)
			{
				if(m_soundChannel != null)
				{
					SoundManager.sharedManager().stopSound(m_soundChannel);
					m_soundChannel = null;
				}
			}
			//draggable.stopDrag();
		}
		
		function startDragging(ev:MouseEvent):void
		{
			shouldDrag = true;
		}
		
		function stopDragging(ev:MouseEvent):void
		{
			if(m_soundChannel)
			{
				m_soundChannel.stop();
			}
			shouldDrag = false;
		}

		//function dragged(ev:MouseEvent):void
		//{
		//}

		public function destroy()
		{
			draggable.removeEventListener(MouseEvent.MOUSE_OVER, startDragging);
			draggable.removeEventListener(MouseEvent.MOUSE_OUT, stopDragging);
			//MovieClip(this.parent).removeEventListener(MouseEvent.MOUSE_MOVE, dragged);
			MovieClip(this.parent).removeEventListener(MouseEvent.MOUSE_DOWN, moDown);
			MovieClip(this.parent).removeEventListener(MouseEvent.MOUSE_UP, moUp);
			
			if(m_slidingSound != null)
			{
				if(m_soundChannel != null)
				{
					SoundManager.sharedManager().stopSound(m_soundChannel);
					m_soundChannel = null;
				}
			}
			
			unscheduleForUpdate();
		}

		override public function update()
		{
			var portions:uint = 1;
			if(bgAnimation != null)
			{
				portions = bgAnimation.totalFrames;
				
				if(canGoBack)
				{
					if(m_verticalSlide && !m_horizontalSlide)
					{
						bgAnimation.gotoAndStop(currentYPortion);
					}
					else if(!m_verticalSlide && m_horizontalSlide)
					{
						bgAnimation.gotoAndStop(currentXPortion);
					}
				}
				else
				{
					if(m_verticalSlide && !m_horizontalSlide)
					{
						bgAnimation.gotoAndStop(reachedYPortion);
					}
					else if(!m_verticalSlide && m_horizontalSlide)
					{
						bgAnimation.gotoAndStop(reachedXPortion);
					}
				}
			}
			
			if (mDown && !mUp && shouldDrag)
			{
				if (! dragging)
				{
					draggable.startDrag(false, rect);
					dragging = true;
					if(sound)
					{
						m_soundChannel = sound.play(9999999);
					}
				}
				else
				{
					currentXPortion = draggable.x / (50 / portions);
					currentYPortion = draggable.y / (50 / portions);
					if (currentXPortion > reachedXPortion)
					{
						reachedXPortion = currentXPortion;
					}
					if (currentYPortion > reachedYPortion)
					{
						reachedYPortion = currentYPortion;
					}
					reachedX = canGoBack ? draggable.x : (draggable.x > reachedX ? draggable.x : reachedX);
					reachedY = canGoBack ? draggable.y : (draggable.y > reachedY ? draggable.y : reachedY);
				}
			}
			else
			{
				if (dragging)
				{
					draggable.stopDrag();
					dragging = false;
					
					if(m_soundChannel)
					{
						m_soundChannel.stop();
					}
				}
			}

			if (horizontalFactor == 1)
			{
				draggable.x = reachedX;
			}
			
			if (verticalFactor == 1)
			{
				draggable.y = reachedY;
			}
		}
	}
	
}
