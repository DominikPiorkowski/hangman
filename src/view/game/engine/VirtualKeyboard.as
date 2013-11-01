package view.game.engine
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import view.GameEngine;
	
	public class VirtualKeyboard extends MovieClip
	{
		private var _alphabet:Array = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
		private var _margin:Number = 1;
		private var _btns:Array;
		
		public function VirtualKeyboard()
		{
			super();
		}
		
		public function CreateMe():void
		{
			_btns = new Array();
			
			var letter_button:LetterButton = new LetterButton();
			var column_max:int = 7;
			
			var iks:int = 0;
			var igrek:int = 0;
			var i:int;
			
			for( i = 0; i < _alphabet.length; i++ )
			{
				if( iks > column_max )
				{
					iks = 0;
					igrek++;
				}
					
				letter_button = new LetterButton();
				addChild( letter_button );
				letter_button.CreateMe( _alphabet[ i ] );
				letter_button.x = iks * ( letter_button.width + _margin );
				letter_button.y = igrek * ( letter_button.height + _margin );
				
				_btns.push( letter_button );
				
				iks++;
			}
		}
		
		public function Refresh():void
		{
			var i:int;
			
			for( i = 0; i < _btns.length; i++ )
			{
				LetterButton( _btns[ i ] ).Activate();
			}
		}
	}
}