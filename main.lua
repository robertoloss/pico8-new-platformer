
function _init()
	mx=0
	my=-1
end

tick=0
tick_lim=0

function _update60()
  if tick < tick_lim then
    return
  end
  controls()
  resolve_collisions()
  p.vy=max(-2,p.vy)
  --p.vx = mid(-1, p.vx, 1)
  mx+=p.vx
  my+=p.vy

  anti_cs()
end

function _draw()
  if tick < tick_lim then
    tick+=1
    return
  end
  tick=0
  ntx = mx<=0 and mx or 0
  nty = my<=0 and my or 0
  cls()
  map(0,0,mx,my,16-ntx,16-nty)
  spr(p.spr,p.px,p.py,1,1,p.lr_dir=='l' and true or false)
  debugging()
end
