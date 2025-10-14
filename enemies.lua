
Enemy={}
Enemy.__index=Enemy

function Enemy:new()
  local entity = {}
  setmetatable(entity,self)
  entity.__index=table
end
