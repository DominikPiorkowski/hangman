package view.game.engine
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class WordLetter extends MovieClip
	{
		public var label:TextField;
		
		public function WordLetter()
		{
			super();
			label.text = "";
		}
		
		public function ShowLetter( letter:String ):void
		{
			label.text = letter;
		}
	}
}