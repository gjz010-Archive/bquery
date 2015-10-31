# bquery
A third-party external library for Biliscript Player aiming to enhance Mode8 Danmaku.

一个bilibili高级弹幕的扩展库
##这是什么？
bQuery是一个（大坑一样的）对biliscript进行扩展的库，由ActionScript编写而成（虽然还没成）。
##等一下，ActionScript是怎么回事？
B站播放器已经禁止了对$.root的调用，这意味着不再能注入字节码。

但播放器本身存在一些局限性，比如不支持全键盘侦听、不支持声音等，所以计划用as写一个外部库与biliscript配合，并且向官方申请提交。（官方：提交试试吧）

在申请提交之前，将会提供测试方法。

如果提交顺利的话，bQuery本身将会作为一个外部库出现。
##所以这个库到底想实现些什么？
正如这个项目名字所模仿的项目（jQuery）一样，write less do more。

不同于（伟大的）Akari.biliscript，bQuery提供的功能更倾向于交互性高级弹幕（包括但不限于游戏）。
* 全键盘侦听（替代keyTrigger,考虑到非角色扮演游戏的需要） 部分实现
* 内置的Bitmap及Sound注入及外部读取方法（图像来说，附带JPEG解码器的封装来压缩体积；音频来说，弥补官方createSound的严重不足，允许从字节码加载Sound） 部分实现
* 对Box2D的封装（对Box2D的二次封装，针对物理类游戏） 未实现
* 对Scene3D的封装（B站打MC指日可待） 未实现
* 对WebSocket的封装（喂喂喂！） 未实现

对于艺术类高级弹幕来说，也会有一些有用的特性。
* 加载子视频（或图像序列）（似乎可以用来绕过弹幕大赛的黑屏视频限制，但不建议这样做，因为不能保证性能，而且用非弹幕作品参加弹幕大赛有违公平） 未实现
* Scene3D（用来做3D系MAD可能用得上） 未实现
* Bitmap与Sound 部分实现
* 自适应、对齐与相对坐标（宽屏小窗口之类的） 未实现
###现在又实现了什么？
* 外部库基本框架
* 非脚本字节码Base64注入，暂时仅限于图片
* 全键盘侦听的部分实现
* 本地存储
###怎么测试这个库？
嘛，很抱歉，不提供“一键测试”的方法。

基本思路是先编译出来（需要Flex SDK，只提供Linux下的compile.sh，Windows下模仿着写就好），然后把http://static.hdslb.com/playerLibrary/libbQuery_2.swf定向（注意，不能是人工302，会受到跨域限制）到编译好的库。（如果不太走运的话，可能还要劫持https连接）

我的方法是用nginx搭建了一个“用于劫持指定URL”的反向代理（已经蠢到一定程度了），然后找弹幕大赛自己的参赛作品用代码预览功能调试（因此target文件夹里自带了另外两个官方外部库）。
附测试代码：
```
var jpeg="略去一大长串的Base64";
load("libbQuery",function(){
ScriptManager.clearEl();
ScriptManager.clearTrigger();
ScriptManager.clearTimer();
var sc=$$.create("soundclip");
var ls=$$.create("localstorage","gjz010");
trace(ls.get("name"));
var bar=$$.Base64.decode(jpeg);
$$.extractimage(bar,function(bd){
var bmp=createBitmap({
bitmapData:bd
});
});
});
```

