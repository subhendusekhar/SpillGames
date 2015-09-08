package src.elements {
	
	import flash.display.MovieClip;
	import src.GLP.GLPScene;
	import fl.controls.Label;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import src.game.GameLogic;
	import src.game.SoundManager;
	import src.game.SpilAPIManager;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	
	[Inspectable(name="text", variable="text", type="String", defaultValue="")]
	[Inspectable(name="targetScene", variable="targetScene", type="String", defaultValue="")]
	public class NormalButton extends GLPScene {
		
		public var targetScene:String = "";
		private var m_textString:String;
		public var m_text:TextField;
		
		public function NormalButton() 
		{
			if(m_text != null)
			{
				m_text.mouseEnabled = false;
			}
			
			addEventListener(MouseEvent.CLICK, gotoTarget);
			addEventListener(MouseEvent.MOUSE_OVER, overButton);
		}
		
		public function set text(value:Object):void
		{
			m_textString = value as String;
			updateTexts();
		}
		
		public function get text():Object
		{
			return m_textString;
		}
		
		private function gotoTarget(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(new SND_ClickButton());
			if(targetScene != "")
			{
				GameLogic.sharedGameLogic().showSceneByName(targetScene);
				removeEventListener(MouseEvent.CLICK, gotoTarget);
			}
		}
		
		private function overButton(ev:MouseEvent)
		{
			SoundManager.sharedManager().playSound(new SND_OverButton());
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			updateTexts();
		}
		
		override public function updateTexts(ev:Event = null)
		{
			if(SpilAPIManager.sharedSpilAPI().isApiReady())
			{
				if(m_text != null)
				{
					m_text.text = m_textString;
					SpilAPIManager.sharedSpilAPI().localizeTextField(m_text);
				}
			}
			else
			{
				if(m_text != null)
				{
					m_text.text = m_textString;
				}
			}
		}
	}
}
