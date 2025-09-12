
function controls()
  px,py=64-mx,64-my
  vel = 1
  p.ml = btn(0) and not flag(px,py,0) and not flag(px,py+7,0)
  p.mr = btn(1) and not flag(px+8+p.vx,py,0) and not flag(px+9+p.vx,py+7,0)
  p.mu = btn(2)
  p.md = btn(3)
  p.jump = btn(4)
  p.vx = p.ml and vel or (p.mr and -vel or 0)
  --p.vy = p.mu and vel or (p.md and -vel or 0)

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
   -- and p.onground
    p.vy=1.5
    p.isjumping=true
    p.jtm=10
    p.accy=0.05
  end

  if p.isjumping then
    if p.jump and p.jtm > 0 then
      p.vy+=p.accy
      p.accy-=0.005
    else
      p.jtm,p.isjumping=0,false
      p.accy=0.07
    end
  end

  if p.jtm==0 then
    if not p.onground then
      if p.vy > -3.0 then
        p.accy+=0.008
        p.vy-=p.accy
      end
    end
  else
    p.jtm-=1
  end
end
