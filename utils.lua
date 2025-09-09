

function px2tile(px)
  return flr(px/8)
end

function tile_at_px(x,y)
  return mget(px2tile(x),px2tile(y))
end

function flag(x,y,flag_num)
  return fget(tile_at_px(x,y),flag_num)
end

function remove_tile(x, y)
  local tile_x = flr(x / 8)
  local tile_y = flr(y / 8)
  mset(tile_x, tile_y, 0)
end

function remove_tile_at_pixel(px, py)
  remove_tile(px, py)
end
