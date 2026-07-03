
Pickup = {
  sprite=18,
  active=true,
  cooloff_time=240,
  cooloff_counter=0
}

Pickup.__index = Pickup

setmetatable(Pickup, Entity)

function draw_pickups()
  for _,p in ipairs(pickups) do
    local almost = not p.active and p.cooloff_counter > p.cooloff_time - 40 and p.cooloff_counter%10<3
    if p.active or almost then
      p:draw()
    end
  end
end

function move_pickups()
  for _,p in ipairs(pickups) do
    p:move()
  end
end

function Pickup:player_collision()
  local x_ok = self.px+6>66 and self.px+1<64+5
  local y_ok = self.py<64+7 and self.py>64
  return x_ok and y_ok
end

function check_pickups_collision()
  for _,pickup in ipairs(pickups) do
    if pickup:player_collision() then
      if pickup.active then
        sfx(6)
      end
      pickup.active=false
      p.bullets_to_fire = 3
    end
  end
end

function activate_pickups()
  for _,pickup in ipairs(pickups) do
    if not pickup.active then
      if pickup.cooloff_counter < pickup.cooloff_time then
        pickup.cooloff_counter += 1
      else
        pickup.cooloff_counter = 0
        pickup.active = true
      end
    end
  end
end



