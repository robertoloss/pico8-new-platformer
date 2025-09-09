
function _init()
	mx=0
	my=0
end

function _update()
  vel = 1
  p.ml = btn(0)
  p.mr = btn(1)
  p.mu = btn(2)
  p.md = btn(3)
  p.vx = p.ml and vel or (p.mr and -vel or 0)
  p.vy = p.mu and vel or (p.md and -vel or 0)
  p:resolve_collision()
end

function _draw()
  mx+=p.vx
  my+=p.vy
  ntx = mx<=0 and mx or 0
  nty = my<=0 and my or 0
  cls()
  map(0,0,mx,my,16-ntx,16-nty)
  spr(p.spr,p.px,p.py)
  print(tostring(flag(0,0,0)))
  print(debug)
  print("mx: "..tostring(mx)..", my: "..tostring(my))
  print(debug2)
  print(debug3)
end
