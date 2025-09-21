
function resolve_collisions()

  if p.vx == 0 and p.vy == 0 then return end

  local px_tl = 64 - mx
  local py_tl = 64 - my
  local nx_tl = (64 - (mx+p.vx))
  local ny_tl = (64 - (my+p.vy))

  if p.vy > 0 or not (flag(nx_tl+3, ny_tl + 8, 0) or flag(nx_tl + 4, ny_tl + 8, 0)) then
    p.onground = false
  end

  local hb = {
    l=p.lr_dir=='r' and 3 or 0,
    r=p.lr_dir=='l' and -3 or 0,
    t=3
  }

  tl = fget(mget(flr((nx_tl+hb.l)/8), flr((ny_tl+hb.t)/8)), 0)
  tr = fget(mget(ceil((nx_tl+hb.r)/8), flr((ny_tl+hb.t)/8)), 0)
  bl = fget(mget(flr((nx_tl+hb.l)/8), ceil((ny_tl)/8)), 0)
  br = fget(mget(ceil((nx_tl+hb.r)/8), ceil((ny_tl)/8)), 0)

  local hit_left = flr((mx+p.vx)/8) * 8
  local hit_top = hb.t + flr((my+p.vy)/8) * 8
  local hit_right = ceil((mx+p.vx)/8) * 8
  local hit_bottom = ceil((my+p.vy)/8) * 8

  if p.vy >= 0 then
    if p.vx > 0 then -- up left
      if res_sec_tiles(tr,hit_top,bl,hit_left,false) then return end
      if tl then
        local px = px_tl
        local py = py_tl+hb.t
        local nx = nx_tl
        local ny = ny_tl+hb.t
        local dx = nx - px
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_max = (ceil(ny/8) * 8) - 1
        if py < tile_y_max then
          p.vx = 0
          mx = hit_left
          return
        end
        local tile_x_max = 7 + flr(nx/8) * 8
        if px < tile_x_max then
          p.vy = 0
          my = hit_top
          return
        end
        if hy <= tile_y_max then
          p.vx = 0
          mx = hit_left
          return
        end
      end
    else -- UP RIGHT
      if res_sec_tiles(tl,hit_top,br,hit_right,false) then return end
      if tr then
        local px = 7 + px_tl
        local py = py_tl + hb.t
        local nx = 8 + nx_tl
        local ny = ny_tl + hb.t
        local dx = px - nx
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_max = (ceil(ny/8) * 8) - 1
        if py < tile_y_max then
          p.vx = 0
          mx = hit_right
          return
        end
        local tile_x_min = flr(nx/8) * 8
        if px > tile_x_min then
          p.vy = 0
          my = hit_top
          return
        end
        if hy <= tile_y_max then
          p.vx = 0
          mx = hit_right
          return
        end
      end
    end
  else -- DOWN
    if p.vx >= 0 then -- DOWN LEFT
      if res_sec_tiles(br,hit_bottom,tl,hit_left,true) then return end
      if br or tl then return end
      if bl then
        local px = px_tl
        local py = 7 + py_tl
        local nx = nx_tl
        local ny = 8 + ny_tl
        local dx = nx - px
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_min = flr(ny/8) * 8
        if py > tile_y_min then
          p.vx = 0
          mx = hit_left
          return
        end
        local tile_x_max = 7 + flr(nx/8) * 8
        if px < tile_x_max then
          p.vy = 0
          p.onground = true
          my = hit_bottom
          return
        end
        if hy >= tile_y_min then
          p.vx = 0
          mx = hit_left
          return
        end
      end
    else -- DOWN RIGHT
      if res_sec_tiles(bl,hit_bottom,tr,hit_right,true) then return end
      if bl or tr then return end
      if br then
        local px = px_tl
        local py = 7 + py_tl
        local nx = nx_tl
        local ny = 8 + ny_tl
        local dx = nx - px
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_min = flr(ny/8) * 8
        if py > tile_y_min then
          p.vx = 0
          mx = hit_right
          return
        end
        local tile_x_min = flr(nx/8) * 8
        if px > tile_x_min then
          p.vy = 0
          p.onground = true
          my = hit_bottom
          return
        end
        if hy >= tile_y_min then
          p.vx = 0
          mx = hit_right
          return
        end
      end
    end
  end
end


function res_sec_tiles(h_sec,hit_h_sec,v_sec,hit_v_sec,on_ground_true)
  if h_sec then
    p.vy=0
    my=hit_h_sec
    if on_ground_true then p.onground=true end
  end
  if v_sec then
    p.vx=0
    mx=hit_v_sec
  end
  if h_sec or v_sec then
    return true
  end
  return false
end
