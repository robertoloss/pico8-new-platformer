Entity={
  map_x=0,
  map_y=0,
  px=0,
  py=0,
  sprite=0
}
Entity.__index=Entity

function Entity:new(px,py,tile_x,tile_y)
  local e={px=px,py=py,map_x=tile_x*8,map_y=tile_y*8}
  setmetatable(e,self)
  e.__index=self
  return e
end

function Entity:draw()
  spr(self.sprite,self.px,self.py)
end

function Entity:move()
  self.px=self.map_x+mx
  self.py=self.map_y+my
end


