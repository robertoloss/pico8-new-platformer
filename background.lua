cx = 0
cy = 0

function draw_background()
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

  local y=-lim

  while y<16+lim do
    local x=-lim
    while x<16+lim do
      map(124,60,(8*x)+cx/2,(8*y)+cy/2)
      x+=4
    end
    y+=4
  end
end
