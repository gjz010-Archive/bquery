package tk.gjz010.injection
{
import flash.display.*;
import flash.utils.ByteArray;
import flash.events.Event;
import libbQuery;
//ss
   public class BulkInjector
    {
//读取PNG、JPEG、GIF（仅限第一帧）的方法
//尽量避免直接接触Loader，所以complete只有一个参数：BitmapData
        public static function loadCompressedImage(bytes:ByteArray,complete:Function):void{
            var loader:Loader=new Loader();
            var onloaded:Function=function(e:Event):void{
                libbQuery.btrace("image loaded!");
                var target:*=e.currentTarget;
                var loader:Loader = target.loader as Loader;
                var b:Bitmap=loader.content as Bitmap
                var bd:BitmapData=b.bitmapData;
                complete(bd);
                libbQuery.btrace("load done");
              }
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onloaded);
            loader.loadBytes(bytes);
        }
    }
}
