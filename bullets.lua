
Bullet = {}

Bullet.__index = Bullet

function Bullet:new(x,y,right)
  local b = setmetatable({},Bullet)
  b.px = x
  b.py = y
  b.right = right
  b.vx = right and 1 or -1
  b.spr = right and 49 or 54
  return b
end

function Bullet:move(idx)
  local new_x = flr(self.px+self.vx)+0.5
  local new_y = flr(self.py+p.vy)+0.5
  if new_x < 0 or new_x > 128 or new_y < 0 or new_y > 128 then
    deli(bullets,idx)
  end
  self.px = new_x
  self.py = new_y
end

function Bullet:draw()
  spr(self.spr,self.px,self.py)
end



