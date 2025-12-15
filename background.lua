cx = 0
cy = 0

function draw_background(p_is_dead)
  if not p_is_dead then
    cx += p.vx
    cy += p.vy

    lim=32

    if cx>lim then
      cx=-lim+(cx-lim)
    end
    if cx<-lim then
      cx=lim-(abs(cx+lim))
    end
    if cy>lim then
      cy=-lim+(cy-lim)
    end
    if cy<-lim then
      cy=lim-(abs(cy+lim))
    end

    cx = flr(cx)+0.5
    cy = flr(cy)+0.5
  end

  local y=-lim
  local step=4
  local num=8

  while y<lim do
    local x=-lim
    while x<lim do
      map(124,60,(num*x)+cx/2,(num*y)+cy/2,4,4)
      x+=step
    end
    y+=step
  end
end
