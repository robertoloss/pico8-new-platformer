
Checkpoint={
  sprite=3,
}

Checkpoint.__index=Checkpoint

setmetatable(Checkpoint,Entity)

function Checkpoint:check_collision()
  return
    self.py<73 and self.py>72 and
    self.px>60 and self.px<70
end

function Checkpoint:new(px,py,tile_x,tile_y)
  local e={px=px,py=py,map_x=tile_x*8,map_y=tile_y*8}
  setmetatable(e,self)
  e.__index=self
  return e
end

function check_checkpoints_collision()
  for cp in all(checkpoints) do
    if cp:check_collision() and cp.id~=spawn.cp_active then
      sfx(7)
      mx_init=64-cp.map_x
      my_init=71-cp.map_y
      spawn={x=cp.map_x, y=cp.map_y, cp_active=cp.id}
    end
  end
end

function move_checkpoints()
  for _,cp in ipairs(checkpoints) do
    cp:move()
  end
end

function spawn_particles()
  local toss = rnd(100)
  if toss>55 then
    local x_offset = rnd(4)+1
    local y_offset = 1
    local s = rnd({
      {inc_y=-0.02,lim=20},
      {inc_y=-0.03,lim=10},
    })
    local pt = Particle:new({
      map_x=spawn.x+x_offset,
      map_y=spawn.y-y_offset,
      kind="test",
      px=spawn.x+mx+x_offset,
      py=spawn.y+my-y_offset,
      vy=-0.2,
      vx=0,
      dead=false,
      count=0,
      col=rnd({10,11}),
      inc_x=0,
      inc_y=s.inc_y,
      lim=s.lim,
      p_dir=p.lr_dir
    })
    add(particles,pt)
  end
end

