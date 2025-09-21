

P = {
  px = 64,
  py = 64,
  vx = 0,
  vy = 0,
  spr = 33, --17, -- 33,
  accy=0,
  canjump=0,
  onground=false,
  jtm=0,
  lr_dir="r"
}

P.__index = P

p = {}

setmetatable(p,P)


