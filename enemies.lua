
Enemy={
  px=0,
  py=0,
  vx=0,
  vy=0,
  spr=0
}
Enemy.__index=Enemy

function Enemy:new(px,py,vx,vy)
  local entity = { px=px, py=py, vx=vx, vy=vy }
  setmetatable(entity,self)
  entity.__index=entity
  return entity
end

function Enemy:draw()
  spr(self.spr,self.px,self.py)
end

function Enemy:move()
  pvy=(p.vy>-0.01 and p.vy<=0) and 0 or p.vy
  self.px+=(p.vx + self.vx)
  self.py+=pvy
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

function generate_enemies(enemies)
  local map_width = 128
  local map_height = 128

  local velocities = {(-0.06), (-0.08), (-0.02), -(0.04), -0.08, -0.1}

  for x = 0, map_width - 1 do
    for y = 0, map_height - 1 do
      local tile = mget(x, y)
      if fget(tile, 1) then
        local new_enemy = Robot:new((x+1)*8-128,(y+1)*8-24,rnd(velocities),0)
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
