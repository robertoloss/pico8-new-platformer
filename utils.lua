
function px2tile(px)
  return flr(px/8)
end

function tile_at_px(x,y)
  return mget(px2tile(x),px2tile(y))
end

function flag(x,y,flag_num)
  return fget(tile_at_px(x,y),flag_num)
end


function anti_cs()
  nmx=flr(mx)+0.5
  nmy=flr(my)+0.5

  local nx_tl = (64 - nmx)
  local ny_tl = (64 - nmy)

  local tl = fget(mget(flr(nx_tl/8), flr(ny_tl/8)), 0)
  local tr = fget(mget(ceil(nx_tl/8), flr(ny_tl/8)), 0)
  local bl = fget(mget(flr(nx_tl/8), ceil(ny_tl/8)), 0)
  local br = fget(mget(ceil(nx_tl/8), ceil(ny_tl/8)), 0)

  if not tl and not tr and not bl and not br then
    mx=nmx
    my=nmy
  end
end

function update_state()
  if p.vy<-1 and not p.jumping then
    p.isfalling=true
  end
  if p.onground then
    p.fuel=p.fuel_max
    if p.isjumping then
      sfx(3)
      p.isjumping=false
    end
    if p.isfalling then
      p.isfalling=false
      sfx(3)
    end
  end
end

