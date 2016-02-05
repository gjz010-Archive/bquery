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
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import tv.bilibili.script.bilibili;
   import flash.system.Security;
   import tk.gjz010.injection.*;
   import tk.gjz010.enhancement.*;
   import flash.utils.ByteArray;
   import flash.events.Event;
   import flash.system.ApplicationDomain; 
   public class libbQuery extends Sprite implements IExternalScriptLibrary
//没想明白为什么要作为Sprite被加载
   {
      public static var VERSION:String="0.0.1";
      public static var BQUERY_URL:String="https://github.com/gjz010/bquery/raw/master/target/"
      public static var btrace:Function;
      private var globalobject:*,displaycontainer:*,iscriptmanager:*;
      private var map:Object;
      public var isFallback:Boolean;
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
        var clocal:*=function(event:Event):void {
            //this.addChild(loader2.content);
            f(event.target);
        }
       var cremote:*=function(event:Event):void {
            
            var loader2:*=new Loader();
            loader2.contentLoaderInfo.addEventListener(Event.COMPLETE,clocal);
            loader2.loadBytes(loader.contentLoaderInfo.bytes);
        }
	     loader.contentLoaderInfo.addEventListener(Event.COMPLETE,cremote);
            loader.load(new URLRequest(url));
        
       }
private function loadbQueryfromRemote(version:String,callback:Function):void{
            try
            {
if(!isFallback){
throw new Error("You can only load remote bQuery from fallback!")
}
               btrace("Loading bQuery " + version + " from Remote...");
loadRemoteLib(BQUERY_URL+version+".swf",function(target:*):void{
var swfTarget:LoaderInfo=target as LoaderInfo;
var appDomain:ApplicationDomain=swfTarget.applicationDomain as ApplicationDomain;
            var getClass:Class =appDomain.getDefinition("libbQuery") as Class;
            var childObj:IExternalScriptLibrary=new getClass() as IExternalScriptLibrary;
               btrace("bQuery(from Remote): create object..." + childObj.initVM(globalobject,displaycontainer,iscriptmanager));
               btrace("bQuery(from Remote): done!Switched bQuery fallback "+VERSION+" to "+version);
               callback();

});
               return;
            }
            catch(e:Error)
            {
               btrace("Loading bQuery from Remote: Error " + e.toString());
		 btrace("Still using current version:"+VERSION);

               return;
            }
}

      private function initMap():void
        {
        map={};
        map["Base64"]=Base64;
        map["create"]=createObject;
        map["extractimage"]=ImageHelper.loadCompressedImage;
	 map["switchversion"]=loadbQueryfromRemote;
	 map["version"]=function():void{
		showVersion();
		}
      }
private function showVersion():void{
btrace("bQuery "+(isFallback?"(fallback)":"(remote)")+" "+VERSION);
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
//param1：AS-biliscript映射表 可以用来调用biliscript里的原生方法
//param2：显示容器
//param3：脚本管理器
      public function initVM(param1:Object, display:DisplayObjectContainer, param3:IScriptManager) : uint
      {
isFallback=(param1["$$"]==undefined);
	globalobject=param1;
displaycontainer=display;
iscriptmanager=param3;
         btrace =param1.trace;
	showVersion();
         initMap();
         param1["$$"] = map;
         param1.bQuery = map;
         return 0;
      }
   }
}
