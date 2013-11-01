package view
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import view.game.engine.CongratulationScreen;
	import view.game.engine.Gallows;
	import view.game.engine.VirtualKeyboard;
	import view.game.engine.Word;
	
	public class GameEngine extends MovieClip
	{
		public var won_lost:TextField;
		public var congratulation_screen:CongratulationScreen;
		
		private var _word:Word;
		private var _virtual_keyboard:VirtualKeyboard;
		private var _gallows:Gallows;
		private var _won:int;
		private var _lost:int;
		private var _words:Array;
		
		private var _sound_lost:Sound;
		private var _sound_won:Sound;
		
		public function GameEngine()
		{
			super();
		}
		
		public function Init( words_list:Array ):void
		{
			if( contains( congratulation_screen ) )
			{
				removeChild( congratulation_screen );
			}
			
			_words = words_list;
			
			_sound_lost = new Lost_Sound();
			_sound_won = new Won_Sound();
			
			_gallows = new Gallows();
			addChild( _gallows );
			_gallows.x = 165;
			_gallows.y = 354;
			_gallows.ResetMe();
			
			_word = new Word();
			addChild( _word );
			_word.y = 0;
			_word.y = 56;
			_word.CreateWord( _words[ _won + _lost ] );
			
			_virtual_keyboard = new VirtualKeyboard();
			addChild( _virtual_keyboard );
			_virtual_keyboard.x = 96;
			_virtual_keyboard.y = 312;
			_virtual_keyboard.CreateMe();
			
			_won = 0;
			_lost = 0;
			won_lost.text = "Won: " + _won + " Lost: " + _lost;
			
			addEventListener( GameEvent.KEY_PRESSED, OnKeyPressed, false, 0, true );
			addEventListener( GameEvent.WORD_COMPLETED, WordCompleted, false, 0, true );
			addEventListener( GameEvent.WORD_LOST, WordLost, false, 0, true );
			addEventListener( Event.REMOVED_FROM_STAGE, OnRemoved, false, 0, true );
		}
		
		
		protected function ChangeScene(event:GameEvent):void
		{
			if( event.next_scene == "round" )
			{
				if( contains( congratulation_screen ) )
				{
					congratulation_screen.removeEventListener( GameEvent.CHANGE_SCENE, ChangeScene );
					removeChild( congratulation_screen );
				}
				
				if( ( _won + _lost ) == _words.length )
				{
					var ev:GameEvent = new GameEvent( GameEvent.CHANGE_SCENE, true );
					ev.next_scene = "start";
					dispatchEvent( ev );
				}
				else
				{
					_gallows.ResetMe();
					_word.CreateWord( _words[ _won + _lost ] );
					_virtual_keyboard.Refresh();
				}
			}
		}
		
		protected function WordLost(event:Event):void
		{
			_sound_lost.play();
			
			_lost++;
			won_lost.text = "Won: " + _won + " Lost: " + _lost;
			
			if( ( _won + _lost ) == _words.length )
			{
				congratulation_screen.label.text = "Game over";
				
			}
			else
			{
				congratulation_screen.label.text = "Fail";
			}
			congratulation_screen.addEventListener( GameEvent.CHANGE_SCENE, ChangeScene, false, 0, true );
			addChild( congratulation_screen );
		}
		
		protected function WordCompleted(event:GameEvent):void
		{
			_sound_won.play();
			
			_won++;
			won_lost.text = "Won: " + _won + " Lost: " + _lost;
			
			congratulation_screen.addEventListener( GameEvent.CHANGE_SCENE, ChangeScene, false, 0, true );
			addChild( congratulation_screen );
			
			if( ( _won + _lost ) == _words.length )
			{
				congratulation_screen.label.text = "Game over";
			}
			else
			{
				congratulation_screen.label.text = "Congratulations you guessed the word";
			}
			congratulation_screen.addEventListener( GameEvent.CHANGE_SCENE, ChangeScene, false, 0, true );
			addChild( congratulation_screen );
		}
		
		protected function OnKeyPressed(event:GameEvent):void
		{
			if( _word.CheckLetter( event.letter ) )
			{
				event.letter_button.Deactivate();
			}
			else
			{
				_gallows.BuildElement();
			}
		}
		
		protected function OnRemoved(event:Event):void
		{
			removeEventListener( GameEvent.KEY_PRESSED, OnKeyPressed );
			removeEventListener( GameEvent.WORD_COMPLETED, WordCompleted );
			removeEventListener( GameEvent.WORD_LOST, WordLost );
			removeEventListener( Event.REMOVED_FROM_STAGE, OnRemoved );
		}
	}
}