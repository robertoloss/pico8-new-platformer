
Bullet = {}

Bullet.__index = Bullet

function Bullet:new(x,y,right)
  local b = setmetatable({},Bullet)
  b.px = x
  b.py = y
  b.right = right
  b.vx = right and 2 or -2
  b.spr = 53 --right and 49 or 54
  b.spr_c = 0
  return b
end

function Bullet:move(idx)
  local pvx = p.lr_dir=='l' and abs(p.vx) or -abs(p.vx)

  local new_x = flr(self.px+self.vx+pvx)+0.5
  local new_y = abs(p.vy) < 0.5 and self.py or flr(self.py+p.vy)+0.5

  if flr(self.spr+self.spr_c) < 55 then
    self.spr_c+=0.2
  else
    self.spr_c=0
  end

  if new_x < 0 or new_x > 128 or new_y < 0 or new_y > 128 then
    deli(bullets,idx)
  end

  self.px = new_x
  self.py = new_y
end

function Bullet:draw()
  spr(flr(self.spr+self.spr_c),self.px,self.py,1,1,not self.right)
end



