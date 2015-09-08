package src.GLP
{
	import flash.display.MovieClip;

	public class GLPScene extends MovieClip implements Animable
	{
		private var m_scheduledForUpdate:Boolean = false;
		public function GLPScene()
		{

		}

		// Returns a GLPScene with the given MovieClip inside
		public static function sceneWithMovieClip(mv:MovieClip):GLPScene
		{
			var scene:GLPScene = new GLPScene();
			scene.addChild(mv);
			return scene;
		}
		
		// This method will be run on each loop
		public function update()
		{
			
		}
		
		public function updateTexts()
		{
			
		}

		// This method will be run when the director leaves a scene
		public function onExit()
		{

		}

		// This method will be run when the director enters a scene
		public function onEnter()
		{

		}

		// This method will be called each loop to paint this scene into the main frame
		public function paintScene()
		{
			var sharedCaller:MovieClip = GLPDirectorCaller.sharedDirectorCaller();
			if (! sharedCaller.contains(this))
			{
				GLPDirectorCaller.sharedDirectorCaller().removeChildren();
				GLPDirectorCaller.sharedDirectorCaller().addChild(MovieClip(this));
			}
		}
		
		public function pauseScene():void
		{
			//Call it to pause the scene. I.E: when showing an Ad
		}
		
		public function continueScene():void
		{
			//Call it to continue the scene. I.E: when showing an Ad
		}

		// Adds this scene to the update queue;
		public final function scheduleForUpdate()
		{
			if (! m_scheduledForUpdate)
			{
				GLPDirector.sharedDirector().scheduleUpdateForScene(this);
				m_scheduledForUpdate = true;
			}
		}

		// Removes this scene to the update queue
		public final function unscheduleForUpdate()
		{
			if (m_scheduledForUpdate)
			{
				GLPDirector.sharedDirector().unscheduleUpdateForScene(this);
				m_scheduledForUpdate = false;
			}
		}

		// Animable implementation
		private var m_movement:Array =
		[
		[],// x
		[],// y
		[],// scaleX
		[],// scaleY
		];
		private var m_counter:int = 0;

		public function animate():Boolean
		{
			var resp:Boolean = false;
			if (m_counter < m_movement[0].length ||
			m_counter < m_movement[1].length ||
			m_counter < m_movement[2].length ||
			m_counter < m_movement[3].length )
			{
				if (m_counter<m_movement[0].length)
				{
					this.x = m_movement[0][m_counter];
				}
				if (m_counter<m_movement[1].length)
				{
					this.y = m_movement[1][m_counter];
				}
				if (m_counter<m_movement[2].length)
				{
					this.scaleX = m_movement[2][m_counter];
				}
				if (m_counter<m_movement[3].length)
				{
					this.scaleY = m_movement[3][m_counter];
				}
				resp = true;
			}
			m_counter++;
			return resp;
		}
		
		public function setAnimation(animationArray:Array)
		{
			m_movement = animationArray;
			m_counter = 0;
		}
	}
}
