# bquery
A third-party external library for Biliscript Player aiming to enhance Mode8 Danmaku.
一个bilibili高级弹幕的扩展库
##这是什么？
bQuery是一个（大坑一样的）对biliscript进行扩展的库，由biliscript和ActionScript编写而成（虽然还没成）。
##等一下，ActionScript是怎么回事？
B站播放器已经禁止了对$.root的调用，这意味着不再能注入字节码。

但播放器本身存在一些局限性，比如不支持全键盘侦听、不支持声音等，所以计划用as写一个外部库与biliscript配合，并且向官方申请提交。

在申请提交之前，将会提供一个修改过的播放器（解锁root等安全策略并且允许从URL读取外部库，虽然bQuery并不打算加入getRoot之类绕过安全策略的方法）供测试。

如果顺利的话，bQuery本身都将会作为一个外部库出现（毕竟可以在as里直接eval biliscript的代码）。不顺利的话（很有可能，毕竟民间成功提交External库史无前例），甚至可以考虑重写播放器实现biliscript，与B站播放器剥离。
##所以这个库到底想实现些什么？
正如这个项目名字所抄袭的项目（jQuery）一样，write less do more。

TODO：...
