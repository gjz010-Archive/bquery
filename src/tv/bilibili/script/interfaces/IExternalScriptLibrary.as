package tv.bilibili.script.interfaces
{
   import flash.display.DisplayObjectContainer;
   
   public interface IExternalScriptLibrary
   {
       
      function initVM(param1:Object, param2:DisplayObjectContainer, param3:IScriptManager) : uint;
   }
}
