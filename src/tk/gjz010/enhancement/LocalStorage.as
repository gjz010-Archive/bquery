package tk.gjz010.enhancement
{
import 	flash.net.SharedObject;
//话说回来，libStorage有多久不能用了来着？（误）
//这个类可以用来跨P甚至跨视频储存信息
    public class LocalStorage
    {
        private var _storage_name:String;
        private var sobject:SharedObject;
        public function get StorageName():String
        {
            return _storage_name;
        }
        public function LocalStorage(name:String)
        {
            _storage_name=name;
            sobject=SharedObject.getLocal(_storage_name);
        }
        public function set(id:String, value:*):void
        {
            sobject.data[id]=value;
        }
        public function get(id:String):*
        {
            return sobject.data[id];
        }
        public function remove(id:String):void
        {
            delete sobject.data[id];
        }
    }
}
