package src.game {
	
	import flash.display.MovieClip;
	
	[Inspectable(name="nextSceneName", variable="nextSceneName", type="String", defaultValue="")]
	[Inspectable(name="hasTransition", variable="hasTransition", type="Boolean", defaultValue=false)]
	[Inspectable(name="backGroundMusic", variable="backGroundMusic", type="String", defaultValue="")]
	[Inspectable(name="hasOptions", variable="hasOptions", type="Boolean", defaultValue=false)]
	[Inspectable(name="correctAnswer", variable="correctAnswer", type="String", defaultValue="")]
	[Inspectable(name="hasText", variable="hasText", type="Boolean", defaultValue=false)]
	[Inspectable(name="text", variable="text", type="String", defaultValue="")]
	[Inspectable(name="startHRM", variable="startHRM", type="Boolean", defaultValue=false)]
	[Inspectable(name="elementToDrag", variable="elementToDrag", type="String", defaultValue="")]
	[Inspectable(name="elementToMantain", variable="elementToMantain", type="String", defaultValue="")]
	[Inspectable(name="gotoNextOnLastFrame", variable="gotoNextOnLastFrame", type="Boolean", defaultValue=false)]
	[Inspectable(name="forceMessageOnTop", variable="forceMessageOnTop", type="Boolean", defaultValue=false)]
	[Inspectable(name="forceContinueButtonVisible", variable="forceContinueButtonVisible", type="Boolean", defaultValue=false)]
	[Inspectable(name="skipOnNoBlood", variable="skipOnNoBlood", type="Boolean", defaultValue=false)]
	[Inspectable(name="skipOnHardMode", variable="skipOnHardMode", type="Boolean", defaultValue=false)]
	[Inspectable(name="forceMessageOnHard", variable="forceMessageOnHard", type="Boolean", defaultValue=false)]
	[Inspectable(name="hideOnNoBlood", variable="hideOnNoBlood", type="Array")]
	[Inspectable(name="soundList", variable="soundList", type="Array")]
	
	public class SurgeryStepProperties extends MovieClip {
		
		// General
		public var nextSceneName:String = null;
		public var hasTransition:Boolean = false;
		
		// Music and sound
		public var backGroundMusic:String = null;
		
		// Option Set
		public var correctAnswer:String = null;
		public var hasOptions:Boolean = false;
		
		// Message box
		public var hasText:Boolean = false;
		public var text:String = null;
		
		public var startHRM:Boolean = false;
		
		public var elementToDrag:String = "";
		public var elementToMantain:String = "";
		
		public var gotoNextOnLastFrame:Boolean = false;
		
		public var forceMessageOnTop:Boolean = false;
		
		public var forceContinueButtonVisible:Boolean = false;
		
		public var skipOnNoBlood:Boolean;
		public var skipOnHardMode:Boolean;
		public var forceMessageOnHard:Boolean;
		public var hideOnNoBlood:Array;
		
		public var soundList:Array;
		
		public function SurgeryStepProperties() {
			this.visible = false;
		}
	}
}
