Enemy={
  init_px=0,
  init_py=0,
  vx=0,
  vy=0,
  spr=0,
  spr_lim=0,
  spr_c=0
}
Enemy.__index=Enemy

setmetatable(Enemy,Entity)

function Enemy:new(px,py,tile_x,tile_y,vx,vy)
  local entity = { init_px=px, init_py=py, map_x=tile_x*8, map_y=tile_y*8, px=px, py=py, vx=vx, vy=vy }
  setmetatable(entity,self)
  entity.__index=entity
  return entity
end

function Enemy:draw(p_is_dead)
  if not p_is_dead then
    self.spr_c +=abs(self.vx)
    if self.spr+self.spr_c>=self.spr_lim then
      self.spr_c=0
    end
  end
  spr(flr(self.spr+self.spr_c),self.px,self.py,1,1,self.vx<=0)
end

function Enemy:move()
  local gravity=0.1
  self.vy+=gravity
  self.map_x+=self.vx
  self.map_y+=self.vy
  self.px=self.map_x+mx
  self.py=self.map_y+my
  --self.py=flr(self.py)+0.5
end

function move_del_enemies()
  for de in all(del_enemies) do
    de.e.px=de.e.map_x+mx
    de.e.py=de.e.map_y+my
  end
end

function draw_del_enemies()
  for de in all(del_enemies) do
    de.e:draw()
    --spr(29,de.e.px,de.e.py,1,1,de.e.vx<0)
  end
end

function subclass(class)
  local subc={}
  subc.__index=subc
  setmetatable(subc,class)
  return subc
end

Robot=subclass(Enemy)
Robot.spr=25
Robot.spr_lim=29
Robot.hb_l=2
Robot.hb_r=2

function Robot:collisions()
  local posx=self.map_x
  local posy=self.map_y
  if self.vy>0 and flag(posx+(8-self.hb_r),posy+8,0) or flag(posx+self.hb_l,posy+8,0) then
    self.map_y=flr(self.map_y/8)*8
    self.vy=0
  end
  if self.vy<0 and flag(posx+(8-self.hb_r),posy,0) or flag(posx+self.hb_l,posy,0) then
    self.map_y=ceil(self.map_y/8)*8
    self.vy=0
  end
  if self.vx<0 and flag(posx+self.hb_l,posy,0) or flag(posx+self.hb_l,posy+7,0)
    or not flag(posx+self.hb_l,posy+8,0) then
    self.map_x=-self.hb_l + ceil(self.map_x/8)*8
    self.vx -= 2*self.vx
  end
  if self.vx>0 and flag(posx+(8-self.hb_r),posy,0) or flag(posx+(8-self.hb_r),posy+7,0)
    or not flag(posx+(8-self.hb_r),posy+8,0) then
    self.map_x=self.hb_r + flr(self.map_x/8)*8
    self.vx -= 2*self.vx
  end
end

function Robot:bullet(b)
  local dx = abs((b.px+3) - (self.px+3))
  local dy = abs((b.py+3) - (self.py+3))

  if dx < 3 and dy < 6 then
    local del_e=del(enemies,self)
    del_e.spr=29
    del_e.spr_lim=30
    local dt={
      e=del_e,
      c=0
    }
    add(del_enemies,dt)
    sfx(9)
    del(bullets,b)
    create_bullet_particles(b)
  end
end

function respawn_enemies()
  for de in all(del_enemies) do
    if de.c<200 then
      de.c+=1
      if de.c>=160 and de.e.spr~=30 then
        de.e.spr_lim=31
      end
    else
      e=del(del_enemies,de)
      e.e.spr=25
      e.e.spr_lim=29
      add(enemies,e.e)
    end
  end
end

function check_if_bullet_hit_enemies()
  for e in all(enemies) do
    for b in all(bullets) do
      e:bullet(b)
    end
  end
end


function generate_entities()
  local map_width = 128
  local map_height = 128

  local velocities = {-0.1,-0.15,0.1,0.15}

  for x = 0, map_width - 1 do
    for y = 0, map_height - 1 do
      local px,py,tile_x,tile_y=(x+1)*8-128,(y+1)*8-24,x,y
      local tile = mget(x, y)
      if fget(tile, 1) then
        local new_enemy = Robot:new(px,py,tile_x,tile_y,rnd(velocities),0)
        mset(x,y,0)
        add(enemies, new_enemy)
      elseif fget(tile, 6) then
        local new_c = Computer:new(px,py,tile_x,tile_y)
        mset(x,y,0)
        mset(x+1,y,0)
        mset(x,y+1,0)
        mset(x+1,y+1,0)
        add(computers, new_c)
      elseif fget(tile, 3) then
        local new_p = Pickup:new(px,py,tile_x,tile_y)
        mset(x,y,0)
        add(pickups, new_p)
      elseif fget(tile, 4) then
        local new_cp = Checkpoint:new(px,py,tile_x,tile_y)
        add(checkpoints, new_cp)
        new_cp.id = x.."-"..y
        if x==24 and y==11 then
          spawn.cp_active=new_cp.id
        end
      end
    end
  end
end

function draw_enemies(p_is_dead)
  for _,e in ipairs(enemies) do
    e:draw(p_is_dead)
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

function Enemy:player_collision()
  local x_ok_l = self.px+1<64+5 and self.px+6>=66
  local x_ok_r = self.px+6>66 and self.px+1<64+5
  local y_ok = self.py<64+7 and self.py>64

  local check_ok=x_ok_r or x_ok_l

  if check_ok and y_ok then
    return true
  end
end

function check_enemies_collision()
  for _,e in ipairs(enemies) do
    if e:player_collision() then
      return true
    end
  end
  return false
end
