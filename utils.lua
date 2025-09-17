

function px2tile(px)
  return flr(px/8)
end

function tile_at_px(x,y)
  return mget(px2tile(x),px2tile(y))
end

function flag(x,y,flag_num)
  return fget(tile_at_px(x,y),flag_num)
end

