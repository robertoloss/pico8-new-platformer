
Enemy={
  init_px=0,
  init_py=0,
  map_x=0,
  map_y=0,
  px=0,
  py=0,
  vx=0,
  vy=0,
  spr=0
}
Enemy.__index=Enemy

function Enemy:new(px,py,tile_x,tile_y,vx,vy)
  local entity = { init_px=px, init_py=py, map_x=tile_x*8, map_y=tile_y*8, px=px, py=py, vx=vx, vy=vy }
  setmetatable(entity,self)
  entity.__index=entity
  return entity
end

function Enemy:draw()
  spr(self.spr,self.px,self.py)
end

function Enemy:move()
  local gravity=0.6
  self.map_x+=self.vx
  self.map_y+=self.vy+gravity
  self.px+=(p.vx + self.vx)
  self.py+=p.vy+gravity
  self.py=flr(self.py)+0.5
end

function subclass(class)
  local subc={}
  subc.__index=subc
  setmetatable(subc,class)
  return subc
end

Robot=subclass(Enemy)
Robot.spr=25


function Robot:collisions()
  posx=self.map_x
  posy=self.map_y
  if flag(posx,posy+8,0) then
    hit="true"
    self.py=flr(self.py/8)*8
    self.map_y=flr(self.map_y/8)*8
  else
    hit="false"
  end
end

function generate_enemies(enemies)
  local map_width = 128
  local map_height = 128

  local velocities = {(-0.1)}

  for x = 0, map_width - 1 do
    for y = 0, map_height - 1 do
      local tile = mget(x, y)
      if fget(tile, 1) then
        local new_enemy = Robot:new((x+1)*8-128,(y+1)*8-24,x,y,rnd(velocities),0)
        mset(x,y,0)
        add(enemies, new_enemy)
      end
    end
  end
end

function draw_enemies()
  for _,e in ipairs(enemies) do
    e:draw()
  end
end

function move_enemies()
  for _,e in ipairs(enemies) do
    e:move()
  end
end

function enemies_collisions()
  for _,e in ipairs(enemies) do
    e:collisions()
  end
end
