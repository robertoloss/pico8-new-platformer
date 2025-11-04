
Player = {
  px = 64,
  py = 64,
  mr = true,
  vx = 0,
  vy = 0,
  spr = 33,
  spr_c = 0,
  spr_c_death=0,
  accy=0.12,
  canjump=0,
  isjumping=false,
  onground=false,
  jtm=0,
  lr_dir="r",
  can_fire = true,
  reload_count = 0,
  reload_lim = 8,
  just_fired = 0,
  fuel_max=2,
  fuel=2,
  can_search=false,
  is_searching=false,
  cp_selected=nil,
  is_dead=false,
}

Player.__index = Player

p = {}

setmetatable(p,Player)

function Player:draw()
 if p.isjumping then
  spr(38,p.px,p.py,1,1,p.lr_dir=='l' and true or false)
  return
 elseif not p.isjumping and p.vy<-0.5 then
  spr(38,p.px,p.py,1,1,p.lr_dir=='l' and true or false)
  return
 else
  if p.is_searching then
    p.spr=49
  else
    p.spr=33
  end
 end
  if btn(2) and p.vx==0 and p.vy==0 then
    p.spr=39
  end
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

function is_player_searching()
  if p.can_search and p.md and not p.isjumping and p.vy>-0.5 then
    p.is_searching=true
  else
    p.is_searching=false
  end
end

mm_c=0
p_d_sound=false
function player_dies()
  mset(0,8,8)
  spr(40+flr(p.spr_c_death),p.px,p.py,1,1,p.lr_dir=='l')
  p.spr_c_death+=0.08
  if p_d_sound==false then
    sfx(5)
    p_d_sound=true
  end

  if mm_c%2==0 then
    mx+=1
    --my+=1
  else
    mx-=1
    --my-=1
  end
  mm_c+=1
  if p.spr_c_death>7 then
    sfx(-1)
    p_d_sound=false
    mm_c=0
    p.vx=0
    p.vy=0
    p.is_dead=false
    p.spr_c_death=0
    p.onground=true
    mx=mx_init
    my=my_init+1
  end
end



