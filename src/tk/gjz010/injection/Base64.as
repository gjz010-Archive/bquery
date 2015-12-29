package tk.gjz010.injection
{
//所谓的Injection就是指注入（字节码）啦
//当然这里的注入，不包含脚本字节码注入（因为这有违安全策略）
//但是这里提供了一堆在高级弹幕中注入字节码的办法
//而注入的基础便是传说中的大杀器——Base64
//Base64最牛的地方在于把字节码转化为可读字符（自然可以写入高级弹幕）
//（因此这段废话放在了这个类里）
import mx.utils.Base64Encoder;
import mx.utils.Base64Decoder;
import flash.utils.ByteArray;
   public class Base64
   {
        public static function decode(s:String):ByteArray{
            var o:Object=_inner_createDecoder();
            o.decode(s);
            return o.toByteArray();
        }
//由于一般来说脚本内不需要encode所以只提供了字节转base64的方法
        public static function encode(b:ByteArray):String{
            var o:Object=_inner_createEncoder();
            o.encodeBytes(b);
            return o.toString();
        }
//顺便暴露出两个类供进阶使用
//但是强烈不推荐使用这两个类
//万一有一天biliplayer转到html5了呢（bQuery只应依赖于biliplayer）
//注：返回类型如果不是Object会导致无影片（可能火星）
        public static function _inner_createEncoder():Object{
            return new Base64Encoder();
        }
        public static function _inner_createDecoder():Object{
            return new Base64Decoder();
        }
   }
}
