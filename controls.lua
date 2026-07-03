
function controls()
  px,py=64-mx,64-my
  vel = 1
  p.ml = btn(0) and not btn(1)
  p.mr = btn(1) and not btn(0)
  p.mu = btn(2)
  p.md = btn(3)
  p.jump = btn(4)

  if not p.is_searching then
    if btn(5) and p.can_fire and p.bullets_to_fire > 0 then
      p.just_fired=1
      p.bullets_to_fire -= 1
      sfx(4)
      local x_offs=p.lr_dir=='l' and -6 or 6
      local b = Bullet:new(p.px+x_offs,p.py+1,p.lr_dir=='r')
      p.can_fire = false
      add(bullets,b)
    end
  end

  local vel_inc = 0.12--0.15
  local vel_dec = 1
  local vel_dec_j = 1 --0.06
  if p.ml then
    if p.vx < vel then
      p.vx = vel -- += vel_inc
    else
      p.vx = vel
    end
  elseif p.mr then
    if p.vx > -vel then
      p.vx = -vel -- -= vel_inc
    else
      p.vx = -vel
    end
  else
    if p.vx > 0 then
      if not p.onground then
        p.vx -= vel_dec_j
      else
        p.vx -= vel_dec
      end
      if p.vx < 0 then
        p.vx = 0
      end
    elseif p.vx < 0 then
      if not p.onground then
        p.vx += vel_dec_j
      else
        p.vx += vel_dec
      end
      if p.vx > 0 then
        p.vx = 0
      end
    end
  end

  if p.jump then
    if p.jpressed == false then
      p.j_newlypressed = true
    else
      p.j_newlypressed = false
    end
    p.jpressed = true
  else
    p.jpressed = false
  end

  if p.j_newlypressed then
    if p.fuel>0 then
      p.fuel = max(0,p.fuel-1)
      create_jump_particles(p.lr_dir)
      sfx(0)
      p.vy=0.5 --1.0
      p.jumpcheck=true
      p.isjumping=true
      p.jtm=12
      p.accy=0.1 --0.05
    end
  end

  if p.jumpcheck then
    if p.jump and p.jtm > 0 then
      p.vy+=p.accy
      p.accy-=0.005
    else
      p.jtm,p.jumpcheck=0,false
      p.accy=0.12
    end
  end

  local max_gravity = -2.0

  if p.jtm==0 then
    if not p.onground then
      if p.vy > max_gravity then
        p.accy+=0.0001
        p.vy-=p.accy
      end
    end
  else
    p.jtm-=1
  end

  if p.ml then p.lr_dir='l' end
  if p.mr then p.lr_dir='r' end
end
