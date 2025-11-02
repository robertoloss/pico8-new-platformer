
function debugging()
  print("mx: "..tostring(mx).." my:"..tostring(my),0,0,1)
  --print("cx: "..tostring(cx).." cy:"..tostring(cy))
  print("vx: "..tostring(p.vx))
  print("vy: "..tostring(p.vy))
  print("computers: "..tostring(#computers))
  print("cp_selected"..tostring(p.cp_selected))
  --print("enemies: "..tostring(#enemies))
  -- print("jpressed: "..tostring(p.jpressed))
  -- print("tl: "..tostring(tl).." tr: "..tostring(tr))
  -- print("tl_near: "..tostring(tl_near))
  -- print("bl: "..tostring(bl).." br: "..tostring(br))
  -- print("bullets: "..tostring(#bullets))
  --print("particles: "..tostring(#particles))
  --print(tostring(#particles>0 and particles[1].px or "empty"))
  --print("p.mr:"..tostring(p.mr))
  --print("p.jump: "..tostring(p.jump and true or ""))
  --print("p.isjumping: "..tostring(p.isjumping))
  -- print("p.canjump: "..tostring(p.canjump))
  --print("p.onground: "..tostring(p.onground))
  --print("p.isfalling: "..tostring(p.isfalling))
  -- for _,e in ipairs(enemies) do
  --   print(tostring(e.px).." "..tostring(e.py))
  -- end
  for i,c in ipairs(computers) do
    print(i)
    print(tostring(c.px).." "..tostring(c.py))
    print(tostring(c.search))
  end
end
