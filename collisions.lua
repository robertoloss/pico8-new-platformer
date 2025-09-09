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
    p.py = 0
  end
  if p.py + 7 + p.vy >= 112 then
    p.vy = 0
    p.py = 104
  end
end

function p:resolve_collision()
  if p.vx == 0 and p.vy == 0 then return end

  local nx = (64 - (mx+p.vx))
  local ny = (64 - (my+p.vy))

  local tl = flag(nx, ny, 0)
  local tr = flag(nx + 7, ny, 0)
  local bl = flag(nx, ny + 7, 0)
  local br = flag(nx + 7, ny + 7, 0)

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
        local px = 64 - mx
        local py = 64 - my
        local dx = nx - px
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_max = (ceil(ny/8) * 8) - 1
        if py < tile_y_max then
          debug = "track"
          debug2 = tostring(tile_y_max)
          debug3 = py
          p.vx = 0
          mx = hit_left
          return
        end
        local tile_x_max = flr(nx/8) * 8
        if px < tile_x_max + 7 then
          debug = "track2"
          debug2 = tostring(tile_y_max)
          debug3 = py
          p.vy = 0
          my = hit_top
          return
        end
        if hy < tile_y_max then
          debug = "track3"
          debug2 = tostring(tile_y_max)
          debug3 = hy
          p.vx = 0
          mx = hit_left
        elseif hy > tile_y_max then
          debug = "track4"
          p.vx = 0
          mx = hit_left
        end
      end
    else -- UP RIGHT
      if tl then
        p.vy = 0
        p.py = ceil(ny/8) * 8
      end
      if br then
        p.vx = 0
        p.px = flr(nx/8) * 8
      end
      if tr then
        local px = mx + 64
        local py = my + 64
        local dx = nx - px
        local dy = py - ny
        local hy = py + (dx * (dy/dx))
        local tile_y_max = (flr(ny/8) * 8) + 7
        if py < tile_y_max then
          p.vx = 0
          p.px = (flr(nx/8) * 8) - 8
          return
        end
        local tile_x = flr(nx/8) * 8
        if px > tile_x + p.vx then
          p.vy = 0
          p.py = tile_y_max + 1
          return
        end
        if hy <= tile_y_max then
          p.vx = 0
          p.px = flr(nx/8) * 8
        else
          p.vy = 0
          p.py = tile_y_max + 1
        end
      end
    end
  else -- DOWN
    if p.vx > 0 then -- DOWN LEFT
      if br then
        p.vy = 0
        p.py = flr(ny/8) * 8
      end
      if tl then
        p.vx = 0
        p.px = ceil(nx/8) * 8
      end
      if bl then
        local px = p.px
        local py = p.py + 7
        local dx = px - nx
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_min = flr(ny/8) * 8
        if py > tile_y_min then
          p.vx = 0
          p.px = ceil(px/8) * 8
          return
        end
        local tile_x = flr(nx/8) * 8
        if px < tile_x + 7 then
          p.vy = 0
          p.py = tile_y_min - 8
          return
        end
        if hy >= tile_y_min then
          p.vx = 0
          p.px = ceil(nx/8) * 8
        else
          p.vy = 0
          p.py = tile_y_min - 8
        end
      end
    else -- down right
      if bl then
        p.vy = 0
        p.py = flr(ny/8) * 8
      end
      if tr then
        p.vx = 0
        p.px = flr((p.px + p.vx)/8) * 8
      end
      if br then
        local px = p.px + 7
        local py = p.py + 7
        local dx = nx - px
        local dy = ny - py
        local hy = py + (dx * (dy/dx))
        local tile_y_min = flr(ny/8) * 8
        if py > tile_y_min then
          p.vx = 0
          p.px = flr(px/8) * 8
          return
        end
        local tile_x = flr(nx/8) * 8
        if px > tile_x then
          p.vy = 0
          p.py = tile_y_min - 8
          return
        end
        if hy >= tile_y_min then
          p.vx = 0
          p.px = (flr(nx/8) * 8) - 8
        else
          p.vy = 0
          p.py = tile_y_min - 8
        end
      end
    end
  end
  p:check_boundaries()
end
