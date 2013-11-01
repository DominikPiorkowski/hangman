package events
{
	import flash.events.Event;
	
	import view.game.engine.LetterButton;
	
	public class GameEvent extends Event
	{
		public static const KEY_PRESSED:String = "GameEvent::KeyPressed";
		public static const CHANGE_SCENE:String = "GameEvent::ChangeScene";
		public static const WORD_COMPLETED:String = "GameEvent::WordCompleted";
		public static const WORD_LOST:String = "GameEvent::WordLost";
		
		public var letter:String;
		public var next_scene:String;
		public var letter_button:LetterButton;
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}