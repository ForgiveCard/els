local preview=class("preview",function ()
	return display.newLayer()
end)

function preview:ctor(type)
	
	self:create(type)
end

function preview:create(type)
	 if type==1 then
      self.maxChangeType=1
		 local sp1=display.newSprite("body.png")
		   sp1:pos(584,800)
		   self:addChild(sp1)
		 local sp2=display.newSprite("body.png")
		   sp2:pos(584-8-16,800)
		   self:addChild(sp2)
		 local sp3=display.newSprite("body.png")
		   sp3:pos(584,800-8-16)
		   self:addChild(sp3)
	  	local sp4=display.newSprite("body.png")
		   sp4:pos(584-8-16,800-8-16)
		   self:addChild(sp4)

     elseif type==2 then
      self.maxChangeType=4
      self.TPosX={{-24,0,24},{-24,0,24},{-24},{24}}
      self.TPosY={{-24},{24},{24,0,-24},{24,0,-24}}
      local sp=display.newSprite("body.png")
      sp:pos(560,800)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        self:addChild(sp1)
      end
     
     elseif type==3 then
      self.maxChangeType=4
      self.TPosX={{0,24,48},{0,-24,-48},{-24},{24}}
      self.TPosY={{-24},{24},{0,-24,-48},{0,24,48}}
      local sp=display.newSprite("body.png")
      sp:pos(536,800)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        self:addChild(sp1)
      end

     elseif type==4 then
      self.maxChangeType=4
      self.TPosX={{0,-24,-48},{0,24,48},{24},{-24}}
      self.TPosY={{-24},{24},{0,-24,-48},{0,24,48}}
      local sp=display.newSprite("body.png")
      sp:pos(584,800)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][1])
        self:addChild(sp1)
      end
      
      elseif type==5 then
      self.maxChangeType=2
      self.TPosX={{0},{24,48,72}}
      self.TPosY={{-24,-48,-72},{0}}
      local sp=display.newSprite("body.png")
      sp:pos(560,848)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][1]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        self:addChild(sp1)
      end

      elseif type==6 then
      self.maxChangeType=2
      self.TPosX={{24,24,48},{0,-24,-24}}
      self.TPosY={{0,-24,-24},{-24,-24,-48}}
      local sp=display.newSprite("body.png")
      sp:pos(560,800)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        self:addChild(sp1)
      end

      elseif type==7 then
      self.maxChangeType=2
      self.TPosX={{-24,-24,-48},{0,24,24}}
      self.TPosY={{0,-24,-24},{-24,-24,-48}}
      local sp=display.newSprite("body.png")
      sp:pos(584,800)
      self:addChild(sp)
      for i=1,3,1 do
        local sp1=display.newSprite("body.png")
        sp1:pos(self.TPosX[1][i]+sp:getPositionX(),sp:getPositionY()+self.TPosY[1][i])
        self:addChild(sp1)
      end
    end
end

function preview:update(type)
	local Temp=self:getChildren()
    for i=1,#Temp,1 do
    	Temp[i]:removeFromParent()
    end
    self:create(type)
end
return preview