local J=8

 local delta=cc.Director:getInstance():getDeltaTime()

local fangkuai=class("fangkuai")

function fangkuai:ctor(type,node)
	local vis= cc.Director:getInstance():getVisibleSize()
		self.T={}
    self.y=0
    self.changeType=1
    self.Down=0--下落层数
    self.active=true
    self.type=type
    self.enemy=node.T
    self.subX=0--变形后的偏移值
    self.pause=false
    self.End=false
    node.activingT=self



    if type==1 then
      self.maxChangeType=1
		 local sp1=display.newSprite("body.png")
		   sp1:pos(display.cx,display.top-64)
		   node.layer:addChild(sp1)
		   table.insert(self.T,sp1)
		 local sp2=display.newSprite("body.png")
		   sp2:pos(display.cx -8-16,display.top-64)
		   node.layer:addChild(sp2)
		   table.insert(self.T,sp2)
		 local sp3=display.newSprite("body.png")
		   sp3:pos(display.cx,display.top-8-16-64)
		   node.layer:addChild(sp3)
		   table.insert(self.T,sp3)
	  	local sp4=display.newSprite("body.png")
		   sp4:pos(display.cx-8-16,display.top-8-16-64)
		   node.layer:addChild(sp4)
		   table.insert(self.T,sp4)

     elseif type==2 then
      self.maxChangeType=4
      self.TPosX={{-24,0,24},{-24,0,24},{-24},{24}}
      self.TPosY={{-24},{24},{24,0,-24},{24,0,-24}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end
     
     elseif type==3 then
      self.maxChangeType=4
      self.TPosX={{0,24,48},{0,-24,-48},{-24},{24}}
      self.TPosY={{-24},{24},{0,-24,-48},{0,24,48}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end

     elseif type==4 then
      self.maxChangeType=4
      self.TPosX={{0,-24,-48},{0,24,48},{24},{-24}}
      self.TPosY={{-24},{24},{0,-24,-48},{0,24,48}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end
      
      elseif type==5 then
      self.maxChangeType=2
      self.TPosX={{0},{24,48,72}}
      self.TPosY={{-24,-48,-72},{0}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][1]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end

      elseif type==6 then
      self.maxChangeType=2
      self.TPosX={{24,24,48},{0,-24,-24}}
      self.TPosY={{0,-24,-24},{-24,-24,-48}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end

      elseif type==7 then
      self.maxChangeType=2
      self.TPosX={{-24,-24,-48},{0,24,24}}
      self.TPosY={{0,-24,-24},{-24,-24,-48}}
      local sp=display.newSprite("body.png")
      sp:pos(display.cx,display.top-64)
      node.layer:addChild(sp)
      table.insert(self.T,sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        node.layer:addChild(sp1)
        table.insert(self.T,sp1)
      end

      

	  end

  local function move2()

        if self.pause then
          return
        end
     ----------------------- 防止在顶部时下落后重合----------------------
        if (self:check("down") and self.active) then
         
           node.ALLMove=false

        elseif self.End then
          return

        else 

          node.push=true--防重合
          self.active=false
          cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.Move2)
          
          for i=1,#self.T,1 do
            if self.T==nil then
              return
            end
            local TPos=cc.p(self.T[i]:getPositionX(),self.T[i]:getPositionY())
            table.insert(node.T,TPos)
          end

          if node:check() then
            node.activingT=nil
            node:restart()
            return
          end
          node.activingT=nil
          node:createNew()
          return

        end
         for i=1,#self.T,1 do
         
         self.T[i]:setPosition(self.T[i]:getPositionX(),self.T[i]:getPositionY()-24)
         end

         --------------------防止在leveup时重合-------------------

         if (self:check("down") and self.active) then
         
           

        else 
          
         node.ALLMove=true

        end
        
        node.push=false
   end

self.Move2=cc.Director:getInstance():getScheduler():scheduleScriptFunc(move2,0.3,false)
 
end

--判断是否超出边界
function fangkuai:check(type)
  if (self.active==false or self.pause) then 
    return false
  end
----------------------------------移动时检测--------------------------------------
  if type=="down"then
    for i=1,#self.T,1 do
      local pos=cc.p(self.T[i]:getPositionX(),self.T[i]:getPositionY()-24)
        if (pos.y<80 or self:enemyCheck(pos)) then
          
        return false
      end

    end

  elseif type=="left" then

    for i=1,#self.T,1 do
         
      local pos=cc.p(self.T[i]:getPositionX()-24,self.T[i]:getPositionY())
        if (pos.x<56 or self:enemyCheck(pos))then
        return false
      end

    end

    elseif type=="right" then

      for i=1,#self.T,1 do
         
        local pos=cc.p(self.T[i]:getPositionX()+24,self.T[i]:getPositionY())
          if (pos.x>488 or self:enemyCheck(pos)) then
          return false
        end
    
      end
---------------------------------------end----------------------------------
--------------------------------方块变化时候检测------------------------------------
    elseif type=="change" then

    local sp=self.T[1]
   
--i形  
    if (self.maxChangeType<4 and self.type<6) then

     if self.changeType==1 then
       for i=1,3,1 do
          
          local pos=cc.p(self.TPosX[self.changeType][1]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][i])
          if (pos.x>488 or pos.y<80  or pos.y>920 or self:enemyCheck(pos)) then
            
            return false
          end

       end
     else
       for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][1])
          if (pos.y<80 or pos.y>920 or self:enemyCheck(pos)) then
            return false
          elseif pos.x>488 then

            if self:changeMove()==false then
              return false
            end

          end

       end
    end

--z形
    elseif self.type>5 then

      for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][i])
          if (pos.y<80 or pos.y>920 or self:enemyCheck(pos)) then
            return false
          elseif (pos.x<56 or pos.x>488 ) then

            if self:changeMove()==false then
              return false
            end

          end

      end

--L形、土形
   else

    if self.changeType<3 then
      for i=1,3,1 do

         local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][1])
         if (pos.y<80 or pos.y>920 or self:enemyCheck(pos)) then
            return false

         elseif (pos.x<56 or pos.x>488 ) then

            if self:changeMove()==false then
              return false
            end

          end

      end
    else
      for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][1]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][i])
          if (pos.y<80 or pos.y>920 or self:enemyCheck(pos)) then
            return false

          elseif (pos.x<56 or pos.x>488 ) then

            if self:changeMove()==false then
              return false
            end


          end
       end

    end
  end
------------------------------------------end----------------------------------
end

 return true

end


---------------------------------变化偏移------------------------------------
function fangkuai:changeMove()
  local sp=self.T[1]
   
--i形  
    if (self.maxChangeType<4 and self.type<6) then

     if self.changeType==1 then
       for i=1,3,1 do
          
          local pos=cc.p(self.TPosX[self.changeType][1]+sp:getPositionX(),sp:getPositionY()+self.TPosY[self.changeType][i])
          if (pos.x>488 or pos.y<80  or pos.y>920 or self:enemyCheck(pos)) then
            return false
          end

       end
     else
       for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][1])
          if  self:enemyCheck(pos) then
            self.subX=0
            return false
          elseif pos.x>488 then
            self.subX=self.subX+24

            if self:changeMove() ==false then
              return false
            end

          end

       end
        return true

    end

--z形
    elseif self.type>5 then

      for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][i])
          if self:enemyCheck(pos) then
            self.subX=0
            return false
          
          elseif pos.x<56 then
            
            self.subX=self.subX-24
            if self:changeMove()==false then
              self.subX=0
              return false
            end
          elseif pos.x>488 then

             self.subX=self.subX+24
            if self:changeMove()==false then
              return false
            end
          end
      end
      return true

--L形、土形
   else

    if self.changeType<3 then
      for i=1,3,1 do

         local pos=cc.p(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][1])
         if self:enemyCheck(pos) then
            self.subX=0
            return false
          
          elseif pos.x<56 then
            
            self.subX=self.subX-24
            if self:changeMove()==false then
              return false
            end
          elseif pos.x>488 then

             self.subX=self.subX+24
            if self:changeMove()==false then
              return false
            end
          end

      end
    
    else

      for i=1,3,1 do

          local pos=cc.p(self.TPosX[self.changeType][1]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][i])
          if self:enemyCheck(pos) then
            self.subX=0
            return false
          elseif pos.x<56 then
            
            self.subX=self.subX-24
            if self:changeMove()==false then
              return false
            end
          elseif pos.x>488 then

             self.subX=self.subX+24
            if self:changeMove()==false then
              return false
            end

          end
       end

    end
  end

  return true

end

----------------------方块碰撞------------------
function fangkuai:enemyCheck(pos)
local l=#self.enemy
   
   if l ~=0 then
   -- print("no")
   end
  if l==0 then
    --print("yes")
    return false
  end

  for i=1,#self.enemy,1 do

    if (self.enemy[i].x==pos.x and self.enemy[i].y==pos.y) then
      return true
    end

  end

  return false
end


function fangkuai:KeyMove(dir)

   if self.Move1 ~= nil then
      return
   end

   local move=function()

     

     if dir=="down" then
     

     elseif dir=="left" then

      if self:check(dir) then
     	   for i=1,#self.T,1 do
           self.T[i]:setPosition(self.T[i]:getPositionX()-24,self.T[i]:getPositionY())
         end
        
      end


     elseif dir=="right" then
      if self:check(dir) then
       for i=1,#self.T,1 do
         self.T[i]:setPosition(self.T[i]:getPositionX()+24,self.T[i]:getPositionY())
        end

      end


     end

   end

  
     if dir=="left" then

      if self:check(dir) then
         for i=1,#self.T,1 do
           self.T[i]:setPosition(self.T[i]:getPositionX()-24,self.T[i]:getPositionY())
         end
        
      end


     elseif dir=="right" then
      if self:check(dir) then
       for i=1,#self.T,1 do
         self.T[i]:setPosition(self.T[i]:getPositionX()+24,self.T[i]:getPositionY())
        end
      end
    end


   self.Move1=cc.Director:getInstance():getScheduler():scheduleScriptFunc(move,0.1,false)
   

end

function fangkuai:MoveEnd(dir)

   if self.Move1 ==nil then
      return
   end
  cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.Move1)
  self.Move1 =nil

end

----------------------落到最低层------------------------
function fangkuai:down(pos)
  
  if self.active==false or self.pause then
    return
  end
  
  if pos ==nil then

    local TempPos={}

     for i=1,#self.T,1 do
      local pos=cc.p(self.T[i]:getPositionX(),self.T[i]:getPositionY()-24)
      table.insert(TempPos,pos)
     end

     self:down(TempPos)

     return

  end
  
  local a=false

  for i=1,#pos,1 do

    a= (self:enemyCheck(pos[i]) or pos[i].y<80)

    if a then

      for j=1,#self.T,1 do
      self.T[j]:setPosition(self.T[j]:getPositionX(),self.T[j]:getPositionY()-24*self.Down)
      self.active=false
      end

      return

    end

  end
    
    self.Down=self.Down+1
    local TempPos={}

    for i=1,#pos,1 do
      local pos=cc.p(pos[i].x,pos[i].y-24)
      table.insert(TempPos,pos)
    end
    self:down(TempPos)

end

function fangkuai:toPause()

  self.pause=true

end

function fangkuai:toStar()

  self.pause=false

end


--方块变形
function fangkuai:Fchange()
  if self.maxChangeType ==nil then
    return
  end
 self.changeType=self.changeType%self.maxChangeType+1

 --田形
 local sp=self.T[1]
   if self.type==1 then
    return

--i形
   elseif (self.maxChangeType<4 and self.type<6) then

    if self:check("change")==false then
      return
    end
    
    
    if self.changeType==1 then
      for i=1,3,1 do
          
          self.T[i+1]:pos(self.TPosX[self.changeType][1]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][i])

      end
      self.subX=0
    else
      for i=1,3,1 do

          self.T[i+1]:pos(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][1])

      end
      self.T[1]:setPosition(self.T[1]:getPositionX()-self.subX,self.T[1]:getPositionY())
      self.subX=0
    end

--z形
    elseif self.type>5 then
     if self:check("change")==false then
      return
     end
      for i=1,3,1 do

          self.T[i+1]:pos(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][i])

      end
      self.T[1]:setPosition(self.T[1]:getPositionX()-self.subX,self.T[1]:getPositionY())
      self.subX=0

--L形土形
   else
    if self:check("change")==false then
      return
    end
    if self.changeType<3 then
      for i=1,3,1 do

          self.T[i+1]:pos(self.TPosX[self.changeType][i]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][1])

      end
      self.T[1]:setPosition(self.T[1]:getPositionX()-self.subX,self.T[1]:getPositionY())
      self.subX=0
    else
      for i=1,3,1 do

          self.T[i+1]:pos(self.TPosX[self.changeType][1]+sp:getPositionX()-self.subX,sp:getPositionY()+self.TPosY[self.changeType][i])
       end
       self.T[1]:setPosition(self.T[1]:getPositionX()-self.subX,self.T[1]:getPositionY())
       self.subX=0

    end

  end

end

function fangkuai:setenemy(T)
  self.enemy=T
end

return fangkuai