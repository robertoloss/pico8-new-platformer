debug = ""

function p:check_boundaries()
  if p.px + p.vx <= 0 then
    p.vx = 0
    p.px = 0
  end
  if p.px + 7 + p.vx >= 128 then
    p.vx = 0
    p.px = 120
  end
  if p.py + p.vy <= 0 then
    p.vy = 0
    p.onground = true
    p.py = 0
  end
  if p.py + 7 + p.vy >= 112 then
    p.vy = 0
    p.onground = true
    p.py = 104
  end
end

function p:resolve_collision()
  p.onground=false
  if p.vy > 0 and (flag(-p.vx+(64-mx),-p.vy+(64-my),0) or flag(-p.vx+(64-mx)+7,-p.vy+(64-my),0)) then
    p.vy,my=0,ceil(my/8)*8
    p.jtm=0
  end
  if p.vy <= 0 and (flag(-p.vx+(64-mx),-p.vy+(64-my)+8,0) or flag(-p.vx+(64-mx)+7,-p.vy+(64-my)+8,0)) then
    p.vy,my,p.onground=0,flr(my/8)*8,true
  end
  if p.vx > 0 and (flag(-p.vx+(64-mx),-p.vy+(64-my),0) or flag(-p.vx+(64-mx),-p.vy+(64-my)+7,0)) then
    p.vx,mx=0,ceil(mx/8)*8
  end
  if p.vx < 0 and (flag(-p.vx+(64-mx)+7,-p.vy+(64-my),0) or flag(-p.vx+(64-mx)+7,-p.vy+(64-my)+7,0)) then
    p.vx,mx=0,flr(mx/8)*8
  end
end

function p:resolve_collision_old()
  if p.vx == 0 and p.vy == 0 then return end

  local px_tl = 64 - mx
  local py_tl = 64 - my
  local nx_tl = (64 - (mx+p.vx))
  local ny_tl = (64 - (my+p.vy))

  if p.vy > 0 or not (flag(nx_tl, ny_tl + 8, 0) or flag(nx_tl + 7, ny_tl + 8, 0)) then
    p.onground = false
  end

  local inc_y = 7

  local tl = flag(nx_tl, ny_tl, 0)
  local tr = flag(nx_tl + 7, ny_tl, 0)
  local bl = flag(nx_tl, ny_tl + inc_y, 0)
  local br = flag(nx_tl + 7, ny_tl + inc_y, 0)

  local hit_left = flr((mx+p.vx)/8) * 8
  local hit_top = flr((my+p.vy)/8) * 8
  local hit_right = ceil((mx+p.vx)/8) * 8
  local hit_bottom = ceil((my+p.vy)/8) * 8

  if p.vx == 0 then
    if p.vy > 0 then
      if tl or tr then
        my = hit_top
        p.vy = 0
      end
    else
      if br or bl then
        my = hit_bottom
        p.vy = 0
        p.onground = true
      end
    end
    p:check_boundaries()
    return
  end

  if p.vy == 0 then
    if p.vx > 0 then
      if tl or bl then
        mx = hit_left
        p.vx = 0
      end
    else
      if tr or br then
        mx = hit_right
        p.vx = 0
      end
    end
    p:check_boundaries()
    return
  end

  if p.vy > 0 then
    if p.vx > 0 then -- up left
      if tr then
        p.vy = 0
        my = hit_top
      end
      if bl then
        p.vx = 0
        mx = hit_left
      end
      if tl then
        local px = px_tl
        local py = py_tl
        local nx = nx_tl
        local ny = ny_tl
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
        if nx == tile_x_max and ny == tile_y_max then
          if tr and not bl then
            p.vy = 0
          elseif bl and not tr then
            p.vx = 0
          elseif (tr and bl) then
            p.vx = 0
            p.vy = 0
          elseif not (tr or bl) then
            p.vy = 0
          end
          return
        end
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
      if tl then
        p.vy = 0
        my = hit_top
      end
      if br then
        p.vx = 0
        mx = hit_right
      end
      if tr then
        local px = 7 + px_tl
        local py = py_tl
        local nx = 7 + nx_tl
        local ny = ny_tl
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
        if nx == tile_x_min and ny == tile_y_max then
          if tl and not br then
            p.vy = 0
          elseif br and not tl then
            p.vx = 0
          elseif (tl and br) then
            p.vx = 0
            p.vy = 0
          elseif not (tl or br) then
            p.vy = 0
          end
          return
        end
        if px > tile_x_min then
          debug = "pollo"
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
    if p.vx > 0 then -- DOWN LEFT
      if br then
        p.vy = 0
        my = hit_bottom
        p.onground = true
      end
      if tl then
        p.vx = 0
        mx = hit_left
      end
      if bl then
        local px = px_tl
        local py = 7 + py_tl
        local nx = nx_tl
        local ny = 7 + ny_tl
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
        if nx == tile_x_max and ny == tile_y_min then
          if br and not tl then
            p.vy = 0
            p.onground = true
          elseif tl and not br then
            p.vx = 0
          elseif (br and tl) then
            p.vx = 0
            p.vy = 0
            p.onground = true
          elseif not (br or tl) then
            p.vy = 0
            p.onground = true
          end
          return
        end
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
    else -- down right
      if bl then
        p.vy = 0
        my = hit_bottom
        p.onground = true
      end
      if tr then
        p.vx = 0
        mx = hit_right
      end
      if br then
        local px = px_tl
        local py = 7 + py_tl
        local nx = nx_tl
        local ny = 7 + ny_tl
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
        if nx + 7 == tile_x_min + 7 and ny + 7 == tile_y_min then
          if bl and not tr then
            p.vy = 0
            p.onground = true
          elseif tr and not bl then
            p.vx = 0
          elseif (bl and tr) then
            p.vx = 0
            p.vy = 0
            p.onground = true
          elseif not (bl or tr) then
            p.vy = 0
            p.onground = true
          end
          return
        end
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
  p:check_boundaries()
end
