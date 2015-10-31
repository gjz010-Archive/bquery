package tk.gjz010.enhancement
{
//对于非角色扮演类游戏keyTrigger在某种程度上就是个废物（只能侦听asdw）
//而且如果要长时间侦听还得用上INTEGER_MAX这种奇怪的东西
//不如自己推倒重写一个
//顺手履行在Bilitaiko里的诺言：多键侦听API
//（话说这种正常的东西还要一个Enhanced来补充实在是6- -）
//大部分直接照抄反编译的代码
//暂时只做到了全键盘侦听
   public class EnhancedKeyboardManager
   {
       
      private var stage:Stage;
      private var hooks:Vector.<Function>;
      private var hooksUp:Vector.<Function>;
      public function ScriptEventManager(param1:Stage)
      {
         this.hooks = new Vector.<Function>();
         this.hooksUp = new Vector.<Function>();
         super();
         this.stage = param1;
         this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         this.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         var code:uint = 0;
         var f:Function = null;
         var event:KeyboardEvent = param1;
         if(this.hooks.length)
         {
            code = event.keyCode;
            //if(code == 27 || code >= 96 && code <= 105 || code >= 34 && code <= 40 || code == Keyboard.W || code == Keyboard.S || code == Keyboard.A || code == Keyboard.D)
            //{
               for each(f in this.hooks)
               {
                  try
                  {
                     f(code);
                  }
                  catch(e:Error)
                  {
                     trace("KeyTriggerError:" + e.toString());
                     continue;
                  }
               }
            //}
         }
      }
      
      private function keyUpHandler(param1:KeyboardEvent) : void
      {
         var code:uint = 0;
         var f:Function = null;
         var event:KeyboardEvent = param1;
         if(this.hooksUp.length)
         {
            code = event.keyCode;
            //if(code == 27 || code >= 96 && code <= 105 || code >= 34 && code <= 40 || code == Keyboard.W || code == Keyboard.S || code == Keyboard.A || code == Keyboard.D)  做你的美梦！——孔文革
            //{
               for each(f in this.hooksUp)
               {
                  try
                  {
                     f(code);
                  }
                  catch(e:Error)
                  {
                     trace("KeyTriggerError:" + e.toString());
                     continue;
                  }
               }
            //}
         }
      }
      
      public function addKeyboardHook(param1:Function, param2:Boolean = false) : void
      {
         if(param2)
         {
            this.hooksUp.push(param1);
         }
         else
         {
            this.hooks.push(param1);
         }
      }
      
      public function removeKeyboardHook(f:Function, up:Boolean = false) : void
      {
         var pos:* = 0;
         if(up)
         {
            pos = this.hooksUp.indexOf(f);
            if(pos !== -1)
            {
               this.hooksUp.splice(pos,1);
            }
         }
         else
         {
            pos = this.hooks.indexOf(f);
            if(pos !== -1)
            {
               this.hooks.splice(pos,1);
            }
         }
      }
      
      public function removeAll() : void
      {
         this.hooks = new Vector.<Function>();
         this.hooksUp = new Vector.<Function>();
      }
   } 
   }
}
