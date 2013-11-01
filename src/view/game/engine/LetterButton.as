package view.game.engine
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	
	public class LetterButton extends MovieClip
	{
		public var label:TextField;
		public var hit:MovieClip;
		
		private var _sound:Sound;
		
		public function LetterButton()
		{
			super();
		}
		
		public function CreateMe( letter:String ):void
		{
			stop();
			
			_sound = new Click_Sound();
			
			label.text = letter;
			buttonMode = true;
			hit.addEventListener( MouseEvent.MOUSE_OVER, OnOver, false, 0, true );
			hit.addEventListener( MouseEvent.MOUSE_OUT, OnOut, false, 0, true );
			hit.addEventListener( MouseEvent.CLICK, OnClick, false, 0, true );
		}
		
		protected function OnOut(event:MouseEvent):void
		{
			gotoAndStop( 1 );
		}
		
		protected function OnOver(event:MouseEvent):void
		{
			gotoAndStop( 2 );
		}
		
		protected function OnClick(event:MouseEvent):void
		{
			_sound.play();
			
			var ev:GameEvent = new GameEvent( GameEvent.KEY_PRESSED, true );
			ev.letter = label.text;
			ev.letter_button = this;
			dispatchEvent( ev );
		}
		
		public function Deactivate():void
		{
			hit.removeEventListener( MouseEvent.MOUSE_OVER, OnOver );
			hit.removeEventListener( MouseEvent.MOUSE_OUT, OnOut );
			hit.removeEventListener( MouseEvent.CLICK, OnClick );
			alpha = 0.5;
			buttonMode = false;
		}
		
		public function Activate():void
		{
			gotoAndStop( 1 );
			alpha = 1;
			buttonMode = true;
			hit.addEventListener( MouseEvent.MOUSE_OVER, OnOver, false, 0, true );
			hit.addEventListener( MouseEvent.MOUSE_OUT, OnOut, false, 0, true );
			hit.addEventListener( MouseEvent.CLICK, OnClick, false, 0, true );
		}
	}
}