package tv.bilibili.script.interfaces
{
   import flash.utils.Timer;
   
   public interface IScriptManager
   {
       
      function pushTimer(param1:Timer) : void;
      
      function popTimer(param1:Timer) : void;
      
      function clearTimer() : void;
      
      function pushEl(param1:IMotionElement) : void;
      
      function popEl(param1:IMotionElement) : void;
      
      function clearEl() : void;
      
      function clearTrigger() : void;
   }
}
