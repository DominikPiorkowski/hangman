package view
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	
	public class Car extends MovieClip
	{
		public function Car()
		{
			super();
		}
		
		public function GoRight():void
		{
			
			TweenLite.to(this, 6, {x: 400});
		}
	}
}