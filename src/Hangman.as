package
{
	import events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import view.Car;
	import view.GameEngine;
	import view.StartScreen;
	
	public class Hangman extends Sprite
	{
		public var start_screen:StartScreen;
		public var hangman:MovieClip;
		public var loader:MovieClip;
		
		private var _xml:XML;
		private var _words:Array;
		
		private var game_engine:GameEngine;
		
		public function Hangman()
		{
			start_screen.CreateMe();
			addEventListener( GameEvent.CHANGE_SCENE, ChangeScene, false, 0, true );
			
			LoadWords();
		}
		
		private function LoadWords():void
		{
			var _xml:XML;
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("data/words_list.xml"));
			myLoader.addEventListener(Event.COMPLETE, OnCompleted);
		}
		private function OnCompleted(e:Event):void 
		{
			_words = new Array();
			
			_xml = new XML(e.target.data);
			
			var i:int;
			for( i = 0; i < _xml.WORD.length(); i++ )
			{
				_words[ i ] = String( _xml.WORD[ i ].@TITLE ).toUpperCase();
			}
			
			removeChild( loader );
		}
		
		protected function ChangeScene(event:GameEvent):void
		{
			if( event.next_scene == "game" )
			{
				removeChild( start_screen );
				
				game_engine = new GameEngine();
				addChild( game_engine );
				game_engine.Init( _words );
			}
			else if( event.next_scene == "start" )
			{
				removeChild( game_engine );
				game_engine = null;
				
				addChild( start_screen );
			}
			
			addChildAt( hangman, numChildren - 1 );
		}
	}
}