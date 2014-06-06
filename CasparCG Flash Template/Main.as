package
{
	import flash.events.TimerEvent;
    import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
    import CountTimer;
	import se.svt.caspar.template.CasparTemplate;
    public class Main extends CasparTemplate
	{
     //An array to hold the minutes and seconds in elements [0] and [1]
    private var timeArray:Array;
    //Our countTimer
    private var countTimer:CountTimer;
    //A boolean that tells us whether this is the first timer
    //(the one used when the movie first starts)
    private var firstTimer:Boolean = true;
    //Direction of our timer can be "up" or "down"
    private var direction:String;
    //The minutes
    public var min:int;
    //The second
    public var sec:int;
	public var totalSecond:int;
       public function Main()
           {
        //min = 1;
        //sec = 0;

        //timer_txt.text = "01:00";
        ///countTimer.start();
		
            }
		public function TimeStop():void
		   {
			countTimer.stop();
		    }
	    public function TimeStart():void
		   {
			countTimer.start();
		    }
        override public function SetData(xmlData:XML):void 
		   {
			super.SetData(xmlData);
			for each(var element:XML in xmlData.elements())
			{
				if(element.@id == "timer_txt")
				{
					 timer_txt.text = element.data.@value;
				}
				if(element.@id == "minn")
				{
					 min = int(element.data.@value);
				}
				if(element.@id == "secc")
				{
					 sec = int(element.data.@value);
				}
				if(element.@id == "startUPTime")
				{
					 totalSecond = int(element.data.@value);
				}
				if(element.@id == "Dirr")
				{
					 direction = element.data.@value;
				}
			}
					//direction="up";
        countTimer = new CountTimer(min,sec,direction,totalSecond,timer_txt);
		              }
	               }
             }