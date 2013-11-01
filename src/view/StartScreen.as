package view
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class StartScreen extends MovieClip
	{
		public var play_btn:SimpleButton;
		
		public function StartScreen()
		{
			super();
		}
		
		public function CreateMe():void
		{
			play_btn.addEventListener( MouseEvent.CLICK, OnClick, false, 0, true );
		}
		
		protected function OnClick(event:MouseEvent):void
		{
			var ev:GameEvent = new GameEvent( GameEvent.CHANGE_SCENE, true );
			ev.next_scene = "game";
			dispatchEvent( ev );
		}
	}
}