
Computer={
  search=200,
  cur_c=0
}
Computer.__index=Computer

setmetatable(Computer, Entity)

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

function Computer:draw(i)
  spr(68,self.px,self.py)
  spr(69,self.px+8,self.py)
  spr(84,self.px,self.py+8)
  spr(85,self.px+8,self.py+8)
  if self.search>0 then
    if p.is_searching and p.cp_selected==i then
      local val=ceil(0.2*(self.search/7))
      rectfill(self.px+4,self.py+4,self.px+4+7,self.py+4+6,9)
      rectfill(self.px+5,self.py+5,self.px+4+val,self.py+5,11)
    else
      self.cur_c+=1
      local int=20
      if self.cur_c>=int then
        pset(self.px+5,self.py+9,11)
      end
      if self.cur_c>=int*2 then
        self.cur_c=0
      end
    end
  else
    rectfill(self.px+3,self.py+3,self.px+4+8,self.py+4+7,9)
  end
end

function check_can_search()
  local can_search=false
  for i,c in ipairs(computers) do
    if c.px>54 and c.px<66 and c.py>56 and c.py<64 and c.search>0 then
      can_search=true
      p.cp_selected=i
      break
    end
  end
  p.can_search=can_search
end

function search_computer()
  if p.is_searching then
    computers[p.cp_selected].search-=1
  end
end

function draw_can_search()
  if p.can_search then
    local s=flr(computers[p.cp_selected].search/2)
    local ox=62
    if not p.md then
      rectfill(ox,46,ox+10,54,7)
      print(chr(131), ox+2, 48, 1)
    end
    local len_box = s==100 and 22 or (s>9 and 18 or 14)
    rectfill(ox,46,ox+len_box,54,7)
    print(chr(131)..""..s, ox+2, 48, 1)
  end
end

function draw_computers()
  for i,c in ipairs(computers) do
    c:draw(i)
  end
end
function computers_move()
  for _,c in ipairs(computers) do
    c:move()
  end
end

