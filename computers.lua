
Computer={
  px=0,
  py=0,
  map_x,
  map_y,
  search=100
}
Computer.__index=Computer

function Computer:new(px,py,tile_x,tile_y)
  local c={px=px,py=py,map_x=tile_x*8,map_y=tile_y*8}
  setmetatable(c,self)
  c.__index=self
  return c
end

function Computer:move()
  self.px=self.map_x+mx
  self.py=self.map_y+my
end

function Computer:draw()
  spr(68,self.px,self.py)
  spr(69,self.px+8,self.py)
  spr(84,self.px,self.py+8)
  spr(85,self.px+8,self.py+8)
  --fset(6,self.px,self.py)
  --fset(6,self.px+8,self.py)
  --fset(6,self.px,self.py+8)
  --fset(6,self.px+8,self.py+8)
end

function draw_computers()
  for _,c in ipairs(computers) do
    c:draw()
  end
end
function computers_move()
  for _,c in ipairs(computers) do
    c:move()
  end
end

