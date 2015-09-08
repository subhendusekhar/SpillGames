package
{
	import GLP.GLPApplication;
	import GLP.GLPDirector;
	
	import flash.display.MovieClip;
	
	import scenes.LoadGame;
	
	import test.AppDelegate;

	public class GLPTemplate extends MovieClip
	{
		public function GLPTemplate()
		{
			GLPApplication.sharedApplication().run();
			GLPApplication.sharedApplication().addApplicationToFrame(this);
			GLPDirector.sharedDirector().pushScene(new LoadGame());
		}
	}
}