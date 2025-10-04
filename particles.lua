
Particle = {
  px,py,vx,vy,inc_x,inc_y,col,count,lim,dead=0,0,0,0,0,0,0,0,0,false
}

Particle.__index = Particle

function create_jump_particles()
  local c=p.lr_dir=='l' and 0.1 or -0.1
  local c_inc=p.lr_dir=='l' and -0.03 or 0.03
  local x_inc=p.lr_dir=='l' and 0.02 or -0.02
  local x_pos=p.lr_dir=='l' and 8 or 0
  for _=0,8 do
    local col=flr(rnd(2))==0 and 1 or 3
    local newp = new_particle(64+x_pos,71,c,0,x_inc,rnd(8,12)/100,col,13)
    add(particles,newp)
    c+=c_inc
  end
end

function new_particle(px,py,vx,vy,inc_x,inc_y,col,lim)
  local newp={px=px,py=py,vx=vx,vy=vy,inc_x=inc_x,inc_y=inc_y,col=col,count=0,lim=lim,dead=false}
  setmetatable(newp,Particle)
  return newp
end

function Particle:update()
  self.vx+=self.inc_x
  self.vy+=self.inc_y
end

function Particle:move()
  self.count += 1
  if self.count >= self.lim then
    self.dead=true
    return
  end
  self.px+=self.vx
  self.py+=self.vy
end

function Particle:draw()
  pset(self.px,self.py,self.col)
end

function update_particles()
  for _,p in ipairs(particles) do
    p:update()
  end
end

function move_particles()
  for _,p in ipairs(particles) do
    p:move()
  end
end

function draw_particles()
  for _,p in ipairs(particles) do
    p:draw()
  end
end

function del_particles()
  for i,p in ipairs(particles) do
    if p.dead then
      deli(particles,i)
    end
  end
end

