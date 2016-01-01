//libbQuery的主类
//多写点注释抛砖引玉^_^
package
{
   import flash.display.Sprite;
   import tv.bilibili.script.interfaces.*; //直接从play.swf里反编译出来的接口（接口而已）
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.getDefinitionByName;
   import flash.net.URLRequestMethod;
   import flash.display.DisplayObjectContainer;
   import tv.bilibili.script.bilibili;
   import flash.system.Security;
   import tk.gjz010.injection.*;
   import tk.gjz010.enhancement.*;
   import flash.utils.ByteArray;
   public class libbQuery extends Sprite implements IExternalScriptLibrary
//没想明白为什么要作为Sprite被加载
   {
      public static var btrace:Function;
      private var map:Object;
      private static const createlist:Object={
        soundclip:SoundClip,
        localstorage:LocalStorage,
        bytearray:ByteArray
        }
      public function libbQuery() //构造函数 大概是读取的时候调用的吧
      {
         super();
         Security.allowDomain("*"); //报废掉跨域限制 这样就可以随心所欲地地网络连接（干坏事）了
      }
//改造：从远端加载核心库
//这样可以方便更新代码
//过不了审核再说
      private function loadRemoteLib(url:String,f:Function):void{
            var loader:*=new Loader();
            
       var cremote:*=function(event:Event):void {
            
            var loader2:*=new Loader();
            loader2.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete2);
            loader2.loadBytes(loader.contentLoaderInfo.bytes);
        }
        var clocal:*=function(event:Event):void {
            //this.addChild(loader2.content);
            f(event.currentTarget.loader.content);
        }
loader.contentLoaderInfo.addEventListener(Event.COMPLETE,cremote);
            loader.load(new URLRequest(url));
        
       }
      private function initMap():void
        {
        map={};
        map["Base64"]=Base64;
        map["create"]=createObject;
        map["extractimage"]=ImageHelper.loadCompressedImage;
      }
//拓展性第一
/*测试代码
load("libbQuery",function(){
var s=$$.create("soundclip","");
trace(s);
});
*/
        private function createObject(name:String,...args):Object{
            if(args.length==0){
            return new createlist[name]();
            }
            return new createlist[name](args);
        }
//这里应该是真·加载外部库的时候调用的
//param1：AS-BS映射表
//param2：容器？
//param3：脚本管理器
      public function initVM(param1:Object, display:DisplayObjectContainer, param3:IScriptManager) : uint
      {
         btrace =param1.trace;
         initMap();
         param1["$$"] = map;
         param1.bQuery = map;
         return 0;
      }
   }
}
