

P = {
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

P.__index = P

p = {}

setmetatable(p,P)


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


