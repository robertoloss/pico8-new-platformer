---@class Particle
---@field map_x number
---@field map_y number
---@field px number
---@field py number
---@field vx number
---@field vy number
---@field inc_x number
---@field inc_y number
---@field col number
---@field count number
---@field lim number
---@field dead boolean
---@field p_dir string
---@field kind string

Particle = {}

Particle.__index = Particle

function create_jump_particles(p_dir)
  local c=p.lr_dir=='l' and 0.1 or -0.1
  local c_inc=p.lr_dir=='l' and -0.03 or 0.03
  local x_inc=p.lr_dir=='l' and 0.02 or -0.02
  local x_pos=p.lr_dir=='l' and 8 or 0
  for _=0,8 do
    local col=flr(rnd(2))==0 and 1 or 3
    local newp = Particle:new({
      map_x=0,
      map_y=0,
      px=64+x_pos,
      py=71,
      vx=c,
      vy=0,
      inc_x=x_inc,
      inc_y=rnd(8,12)/100,
      col=col,
      lim=13,
      p_dir=p_dir,
      count=0,
      dead=false,
      kind="jump"
    })
    add(particles,newp)
    c+=c_inc
  end
end

---@param args Particle
---@return Particle
function Particle:new(args)
  local newp={
    map_x=args.map_x,
    map_y=args.map_y,
    px=args.px,
    py=args.py,
    vx=args.vx,
    vy=args.vy,
    inc_x=args.inc_x,
    inc_y=args.inc_y,
    col=args.col,
    count=0,
    lim=args.lim,
    dead=false,
    p_dir=args.p_dir,
    kind=args.kind
  }
  setmetatable(newp,Particle)
  return newp
end


function Particle:update()
  self.vx+=self.inc_x
  self.vy+=self.inc_y
  self.count += 1
  if self.count >= self.lim then
    self.dead=true
    return
  end
  local not_map_anchored = self.kind == 'jump'
  if not_map_anchored then
    self.px+=self.vx
    self.py+=self.vy
  else
    self.map_x += self.vx
    self.map_y += self.vy
    self.px = self.map_x + mx
    self.py = self.map_y + my
  end
end

function Particle:draw()
  pset(self.px,self.py,self.col)
end

function update_particles()
  for _,p in ipairs(particles) do
    p:update()
  end
end

function draw_particles()
  for _,p in ipairs(particles) do
    p:draw()
  end
end

function del_particles()
  for i,pt in ipairs(particles) do
    if pt.dead or (pt.kind=="jump" and pt.p_dir~=p.lr_dir) then
      deli(particles,i)
    end
  end
end

