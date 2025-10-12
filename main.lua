
function _init()
	mx=-128
	my=-1-(8*2)
  bullets={}
  particles={}
end

function _update60()
  if p.just_fired > 0 then
    if p.just_fired > 2 then
      p.just_fired = 0
    else
      p.just_fired+=1
    end
  end

  controls()
  resolve_collisions()
  update_state()

  p.vy=max(-2,p.vy)
  mx+=p.vx
  my+=p.vy

  for i,b in ipairs(bullets) do
    b:move(i)
    b:collision(i)
  end
  reload_gun()

  anti_cs()

  update_particles()
  del_particles()
  move_particles()
end

function _draw()
  ntx = mx<=0 and mx or 0
  nty = my<=0 and my or 0

  cls()

  draw_background()

  map(0,0,mx,my,16-ntx,16-nty)
  p:draw()
  spr(32,p.px+(p.lr_dir=='l' and 5 or -5),p.py+1,1,1,p.lr_dir=='l' and true or false)

  local ng = p.just_fired==0 and 0 or 1
  spr(
    17,
    p.px+(p.lr_dir=='l' and -(3-ng) or 3-ng),
    p.py+2,
    1,1,p.lr_dir=='l' and true or false
  )
  for i=1,p.fuel do
    pset(p.lr_dir=='l' and 72 or 63,71-i,1)
  end

  for _,b in ipairs(bullets) do
    b:draw()
  end
  draw_particles()
  --debugging()
end
