package tv.bilibili.script.interfaces
{
   public interface IMotionManager
   {
       
      function get running() : Boolean;
      
      function reset() : void;
      
      function play() : void;
      
      function stop() : void;
      
      function forcasting(param1:Number) : Boolean;
      
      function setPlayTime(param1:Number) : void;
      
      function initTween(param1:Object, param2:Boolean = false) : String;
      
      function initTweenGroup(param1:Array, param2:Number = NaN) : void;
      
      function setCompleteListener(param1:Function) : void;
   }
}
