
Player = {
 px = 64,
 py = 64,
 mr = true,
 vx = 0,
 vy = 0,
 spr = 33,
 spr_c = 0,
 accy=0,
 canjump=0,
 onground=false,
 jtm=0,
 lr_dir="r",
 can_fire = true,
 reload_count = 0,
 reload_lim = 8,
 just_fired = 0
}

Player.__index = Player

p = {}

setmetatable(p,Player)

function Player:draw()
 if p.vx~=0 then
  spr(flr(p.spr+p.spr_c),p.px,p.py,1,1,p.lr_dir=='l' and true or false)

  p.spr_c+=0.17

  if p.spr_c>=3 then
   p.spr_c=0
  end
 else
  spr(p.spr,p.px,p.py,1,1,p.lr_dir=='l' and true or false)
 end
end

function reload_gun()
 if not p.can_fire then
   if p.reload_count >= p.reload_lim and not btn(5) then
    p.can_fire=true
    p.reload_count=0
   else
    p.reload_count+=1
   end
 end
end


