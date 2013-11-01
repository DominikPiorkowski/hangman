package view.game.engine
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class CongratulationScreen extends MovieClip
	{
		public var label:TextField;
		public var continue_btn:SimpleButton;
		
		public function CongratulationScreen()
		{
			super();
			continue_btn.addEventListener( MouseEvent.CLICK, OnClick, false, 0, true );
		}
		
		protected function OnClick(event:MouseEvent):void
		{
			var ev:GameEvent = new GameEvent( GameEvent.CHANGE_SCENE, true );
			ev.next_scene = "round";
			dispatchEvent( ev );
		}
	}
}