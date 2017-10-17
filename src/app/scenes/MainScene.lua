
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local f= require("app.fangkuai")
local preview=require("app.preview")

function MainScene:ctor()
  self.T={}--所有方块的坐标
  self.Clear={}--每层的方块数
  self.C={}--记录第几层被除去
  self.activingT=nil--活动中的方块
  self.Cleared=false--这一轮检测是否发生过消除
  self.score=0
  self.up=600
  self.push=false
  self.ALLMove=false
  self.layer=display.newLayer()
  self:addChild(self.layer,3)

  local bgGroung=display.newSprite("playBG.png")
  bgGroung:setPosition(display.cx,display.cy)
  self:addChild(bgGroung)

  local bgLayer=cc.LayerColor:create(cc.c4b(0,0,0,150))
  bgLayer:setAnchorPoint(0,0)
  bgLayer:setContentSize(464,848)
  bgLayer:setPosition(40,64)
  self:addChild(bgLayer,2)
  

  self.scoreLabel=cc.ui.UILabel.new({UILabelType=2,text=tostring(self.score),size=32})
  self.scoreLabel:align(display.CENTER,586,660)
  self:addChild(self.scoreLabel,10)

  local label=cc.ui.UILabel.new({UILabelType=2,text="当前分数",size=32})
  label:align(display.CENTER,576,620)
  self:addChild(label,10)


------------------------取消暂停-------------------------------------
 local function callback1(tag)

   if self.activingT.pause then
     return
   end

   if self.activingT ~= nil then
      self.activingT:toPause()
    end
    
    
    local pauseLayer=display.newColorLayer(cc.c4b(0,0,0,180))
  
    self.push=true

    local label=cc.ui.UILabel.new({UILabelType=2,text="暂停",size=98})
    label:align(display.CENTER, display.cx, display.cy)
    label:addTo(pauseLayer)
    
    pauseLayer:setTouchEnabled(true)
    pauseLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
    
      if event.name =="began" then

        if self.activingT ~= nil then
          self.activingT:toStar()
          self.push=false
        end
        
        self.activingT:toStar()
        pauseLayer:removeFromParent()
        return true
      end
    end)
self:addChild(pauseLayer,10)
 end

  local pauseSp=display.newSprite("pause.png")
    pauseSp:setTag(3)
    pauseSp:pos(560,920)
    pauseSp:setTouchEnabled(true)
    pauseSp:addNodeEventListener(cc.NODE_TOUCH_EVENT,callback1)
    pauseSp:addTo(self,5)


-----------------------------背景----------------------------
  for i=1,35,1 do
    table.insert(self.Clear,0)
  end

 for i=1,19,1 do

   for j=1,35,1 do

     local sp=display.newSprite("body.png")
     sp:pos(56+(i-1)*24,80+(j-1)*24)
     sp:addTo(self)
     sp:setCascadeOpacityEnabled(true)
     sp:setOpacity(100)


   end

 end

self.Next=math.round(math.random()*546)%7+1
 self.pr=preview.new(self.Next)
self:addChild(self.pr,4)

math.randomseed(tostring(os.time()):reverse():sub(1, 7))

self:LevelUp()
self:createNew()
end


----------------------------------难度上升------------------------
function MainScene:LevelUp()

 local function levelUp()
  
  
  if self.push==true then
    return
  end

  if self.up~=0 then
    self.up=self.up-1
    return
  end

  local sp=self.layer:getChildren()
  self.activingT:toPause()
  for i=1,#sp,1 do

    local pos=cc.p(sp[i]:getPositionX(),sp[i]:getPositionY())

    if self.ALLMove then
      sp[i]:pos(sp[i]:getPositionX(),sp[i]:getPositionY()+24)
    elseif self:UpCheck(pos)  then
      sp[i]:pos(sp[i]:getPositionX(),sp[i]:getPositionY()+24)
    end

  end

  for j=1,19,1 do

    local Bool=math.round(math.random()*543)%2
    if Bool==1 then
      local sp=display.newSprite("body.png")
      sp:pos(56+(j-1)*24,80)
      self.layer:addChild(sp)
    end
  end
  
  local sprites=self.layer:getChildren()
  self.T={}
  for i=1,#sprites,1 do

    local pos= cc.p(sprites[i]:getPositionX(),sprites[i]:getPositionY())
    if self:UpCheck(pos) then
      table.insert(self.T,pos) 
    end

  end
  if #self.T==0 then
  end

  self.activingT:setenemy(self.T)
  self.activingT:toStar()
  self.up=600
  if self:check() then
    self.activingT.active=false
    self.activingT.End=true
    self.activingT=nil
    self:restart()
    return
  end


 end
self.update1=cc.Director:getInstance():getScheduler():scheduleScriptFunc(levelUp,1/60,false)

end



function MainScene:createNew()

  local fuangkuai=f.new(self.Next,self)
  self.Next=math.round(math.random()*546)%7+1
  self.pr:update(self.Next)

  local listener =cc.EventListenerKeyboard:create()

  listener:registerScriptHandler(function(keyCode,event)

    if fuangkuai ~=nil then

      
      if keyCode == 146 then
        
        fuangkuai:Fchange()
      elseif  keyCode ==124 then
        fuangkuai:KeyMove("left")

      elseif keyCode ==127 then
        fuangkuai:KeyMove("right")
      end

    end

  end,cc.Handler.EVENT_KEYBOARD_PRESSED)

  listener:registerScriptHandler(function(keyCode,event)
    
    if fuangkuai ~=nil then

      if keyCode ==124 then
        fuangkuai:MoveEnd("left")
      --d
       elseif keyCode == 142 then
       
       self.push=true
       fuangkuai:down()

      elseif keyCode ==127 then
        fuangkuai:MoveEnd("right")
      end


    end

    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

  local eventDispatcher =self:getEventDispatcher()
  eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function MainScene:check()

-----------------------GameOver--------------------
  for i=1,#self.T,1 do

    if self.maxY==nil then
      self.maxX=self.T[i].x
      self.maxY=self.T[i].y
    elseif self.maxY<self.T[i].y then
      self.maxY=self.T[i].y
      self.maxX=self.T[i].x
    end

  end

  local sub=(896-self.maxY)/24
  local subX=math.abs(display.cx-self.maxX)
  if (sub<3 and self.next==5) then
    if subX>24 then

    end
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.update1)
    self.maxY=nil
    self.maxX=nil
    return true
  elseif (sub<1 ) then
    if (subX>24 and sub~=0) then

    end
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.update1)
    self.maxY=nil
    self.maxX=nil
    return true
  end
--------------------------end------------------------
--------------------检测并消除行---------------
if self.T==nil then
  return 
end


for i=1,#self.T,1 do

  local F=(self.T[i].y-56)/24
  self.Clear[F]=self.Clear[F]+1

end

for i=1,35,1 do

  if self.Clear[i]==19 then
    table.insert(self.C, i)
    self:CF(i)
  end
  self.Clear[i]=0
end
-------------------------end--------------------------
------------------------下落-------------------------
if self.Cleared then
self:drop()
self.C={}
self.maxY=nil
self.Cleared=false
end
return false

end
------------------清除+特效---------------------
function MainScene:CF(F)

  local sprites=self.layer:getChildren()
  for i=1,#sprites,1 do

    if ((sprites[i]:getPositionY()-56)/24)==F then
       --爆炸特效
      local time=0.3
      --爆炸圈
      local circleSprite=display.newSprite("circle.png")
            :pos(sprites[i]:getPosition())
            :addTo(self)
      circleSprite:setScale(0)
      circleSprite:runAction(cc.Sequence:create(cc.ScaleTo:create(time,0.32),
        cc.CallFunc:create(function ( ) circleSprite:removeFromParent() end)))

      --爆炸碎片
      local emitter=cc.ParticleSystemQuad:create("num.plist")
      emitter:setPosition(sprites[i]:getPosition())
      local batch=cc.ParticleBatchNode:createWithTexture(emitter:getTexture())
      batch:addChild(emitter)
      self:addChild(batch)
      sprites[i]:removeFromParent()
      --分数特效
     

    end

  end
   self:scorePopupEffect(1000,500, F*24+56)
  self.Cleared=true

end
----------------分数特效--------------------
function MainScene:scorePopupEffect(score, px, py)
  local labelScore = cc.ui.UILabel.new({UILabelType = 2, text = tostring(score), font = "fonts/earth32.fnt"})

  local move = cc.MoveBy:create(0.8, cc.p(0, 80))
  local fadeOut = cc.FadeOut:create(0.8)
  local action = transition.sequence({
    cc.Spawn:create(move,fadeOut),
    -- 动画结束移除 Label
    cc.CallFunc:create(function() labelScore:removeFromParent() end)
  })

  labelScore:pos(px, py)
    :addTo(self)
    :runAction(action)
 
  self.score=self.score+1000

self.scoreLabel:setString(tostring(self.score))

end
-------------------------下落---------------
function MainScene:drop()

  local sprites=self.layer:getChildren()
  self.T={}
  for j=1,#self.C,1 do

    for i=1,#sprites,1 do

      if ((sprites[i]:getPositionY()-56)/24)>(self.C[j]-j+1) then
        sprites[i]:setPosition(sprites[i]:getPositionX(),sprites[i]:getPositionY()-24)

      end

    end

  end

  for i=1,#sprites,1 do

    local pos= cc.p(sprites[i]:getPositionX(),sprites[i]:getPositionY())
    table.insert(self.T,pos) 

  end

end

-------------------------------上升检测-------------------------------------

function MainScene:UpCheck(pos)
   
   for j=1,#self.activingT.T,1 do

      local pos1=cc.p(self.activingT.T[j]:getPositionX(),self.activingT.T[j]:getPositionY())
      if (pos.x==pos1.x and pos.y==pos1.y) then
        return false
      end

    end

    return true

end

function MainScene:restart()
   self.T={}--所有方块的坐标
   self.layer:removeAllChildren()
   self:LevelUp()
   self.score=0
   self.scoreLabel:setString(tostring(0))
   self:createNew()
end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
