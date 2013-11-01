package view.game.engine
{
	import com.greensock.easing.Quint;
	
	import events.GameEvent;
	
	import flash.display.MovieClip;
	
	public class Word extends MovieClip
	{
		private var _word:String;
		private var _margin:Number = 4;
		private var _letters:Array;
		private var _guessed_letters:int;
		
		public function Word()
		{
			super();
		}
		
		public function CreateWord( word:String ):void
		{
			var i:int;
			
			for( i = numChildren; i > 0; i-- )
			{
				removeChildAt( 0 );
			}
			
			_letters = new Array();
			_guessed_letters = 0;
			
			_word = word;
			var quantity:int = _word.length;
			var word_letter:WordLetter = new WordLetter();
			var base_x:Number = ( stage.stageWidth - quantity * word_letter.width - (quantity - 1) * _margin ) / 2;
			
			
			for( i = 0; i < quantity; i++ )
			{
				word_letter = new WordLetter();
				addChild( word_letter );
				word_letter.x = base_x + i * ( word_letter.width + _margin );
				_letters.push( word_letter );
			}
		}
		
		public function CheckLetter( letter:String ):Boolean
		{
			var correct:Boolean = false;
			var i:int;
			for( i = 0; i < _word.length; i++ )
			{
				if( letter == _word.charAt( i ) )
				{
					_guessed_letters++;
					correct = true;
					WordLetter( _letters[ i ] ).ShowLetter( letter );
				}
			}
			
			if( _guessed_letters == _word.length )
			{
				var ev:GameEvent = new GameEvent( GameEvent.WORD_COMPLETED, true );
				dispatchEvent( ev );
			}
			
			return correct;
		}
	}
}