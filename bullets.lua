
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

function Bullet:collision(idx)
  local px = self.px - mx
  local py = self.py - my

  local clt = fget(mget(flr((px+3)/8),flr((py+4)/8)),0)
  local clb = fget(mget(flr((px+3)/8),flr((py+6)/8)),0)
  local crt = fget(mget(flr((px+5)/8),flr((py+4)/8)),0)
  local crb = fget(mget(flr((px+5)/8),flr((py+6)/8)),0)

  if clt or clb or crt or crb then
    sfx(8)
    deli(bullets,idx)
    create_bullet_particles(self)
  end
end

function create_bullet_particles(bullet)
  for _ = 1,25 do
    local vxr = rnd({0.3,0.4,0.5})
    local particle = Particle:new({
      map_x=bullet.px - mx + (bullet.right and 4 or 4),
      map_y=bullet.py - my +3,
      py=bullet.py,
      px=bullet.px,
      vy=rnd({0.3,0.4,0.2}),
      vx=bullet.right and -vxr or vxr,
      inc_y=rnd({-0.03,-0.02}),
      inc_x=bullet.right and rnd({0.01,0.02}) or rnd({-0.01,-0.02}),
      lim=10,
      kind="bullet",
      p_dir=bullet.right and "right" or "left",
      col=rnd({1,1,2}),
      dead=false,
      count=0
    })
    add(particles,particle)
  end
end

function Bullet:draw()
  spr(flr(self.spr+self.spr_c),self.px,self.py,1,1,self.right)
end


function check_collision_w_bullets_reload()
  local x = p.px - mx
  local y = p.py - my

  if flag(x,y,3)
    or flag(x+7,y,3)
    or flag(x,y+7,3)
    or flag(x+7,y+7,3) then
    p.bullets_to_fire = 3
  end
end
