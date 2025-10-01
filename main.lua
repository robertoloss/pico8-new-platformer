
function _init()
	mx=0
	my=-1
  bullets={}
end

tick=0
tick_lim=0

function _update60()
  if p.just_fired > 0 then
    if p.just_fired > 2 then
      p.just_fired = 0
    else
      p.just_fired+=1
    end
  end
  if tick < tick_lim then
    return
  end
  controls()
  resolve_collisions()
  p.vy=max(-2,p.vy)
  --p.vx = mid(-1, p.vx, 1)
  mx+=p.vx
  my+=p.vy

  for i,b in ipairs(bullets) do
    b:move(i)
    b:collision(i)
  end
  reload_gun()
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
  draw_background()
  map(0,0,mx,my,16-ntx,16-nty)
  spr(p.spr,p.px,p.py,1,1,p.lr_dir=='l' and true or false)

  local ng = p.just_fired==0 and 0 or 1
  spr(
    17,
    p.px+(p.lr_dir=='l' and -(3-ng) or 3-ng),
    p.py+2,
    1,1,p.lr_dir=='l' and true or false)
  for _,b in ipairs(bullets) do
    b:draw()
  end
  debugging()
end
