--tick = 0

function _init()
	mx=0
	my=0
end

function _update60()
  -- if tick > 1 then
  --   return
  -- end
  controls()
  p:resolve_collision_old()
  p.vy=max(-2,p.vy)
  mx+=p.vx
  my+=p.vy
end

function _draw()
  -- if tick > 2 then
  --   tick += 1
  --   if tick > 10 then
  --     tick = 0
  --   end
  --   return
  -- end
  -- tick += 0

  ntx = mx<=0 and mx or 0
  nty = my<=0 and my or 0
  cls()
  map(0,0,mx,my,16-ntx,16-nty)
  spr(p.spr,p.px,p.py)
  --debug()
end
