package view.game.engine
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	
	public class Gallows extends MovieClip
	{
		private var _element_id:int;
		
		public function Gallows()
		{
			super();
		}
		
		public function ResetMe():void
		{
			_element_id = 1;
			gotoAndStop( 1 );
		}
		
		public function BuildElement():void
		{
			_element_id++;
			gotoAndStop( _element_id );
			if( _element_id == 8)
			{
				var ev:GameEvent = new GameEvent( GameEvent.WORD_LOST, true );
				dispatchEvent( ev );
			}
		}
	}
}