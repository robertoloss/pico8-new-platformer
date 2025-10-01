
function controls()
  px,py=64-mx,64-my
  vel = 1
  p.ml = btn(0) and not btn(1)
  p.mr = btn(1) and not btn(0)
  p.mu = btn(2)
  p.md = btn(3)
  p.jump = btn(4)

  if btn(5) and p.can_fire then
    --local b = Bullet.new(p.px,p.py,true)
    p.just_fired=1
    sfx(1)
    local x_offs=p.lr_dir=='l' and -6 or 6
    local b = Bullet:new(p.px+x_offs,p.py+1,p.lr_dir=='r')
    p.can_fire = false
    add(bullets,b)
  end

  local vel_inc = 0.12 --0.15
  local vel_dec = 0.5
  local vel_dec_j = 0.06
  if p.ml then
    if p.vx < vel then
      p.vx += vel_inc
    else
      p.vx = vel
    end
  elseif p.mr then
    if p.vx > -vel then
      p.vx -= vel_inc
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

  if btn(4) then
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
    sfx(0)
    p.vy=1.0
    p.isjumping=true
    p.jtm=12
    p.accy=0.05
  end

  if p.isjumping then
    if p.jump and p.jtm > 0 then
      p.vy+=p.accy
      p.accy-=0.005
    else
      p.jtm,p.isjumping=0,false
      p.accy=0.12
    end
  end

  if p.jtm==0 then
    if not p.onground then
      if p.vy > -2.0 then
        p.accy+=0.00075
        p.vy-=p.accy
      end
    end
  else
    p.jtm-=1
  end

  if p.ml then p.lr_dir='l' end
  if p.mr then p.lr_dir='r' end
end
