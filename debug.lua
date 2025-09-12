
function debug()
  print(debug)
  print("mx: "..tostring(mx)..", my: "..tostring(my))
  print("vy: "..tostring(p.vy))
  print("p.jump: "..tostring(p.jump and true or ""))
  print("p.isjumping: "..tostring(p.isjumping))
  print("p.keepjumping: "..tostring(p.keepjumping))
  print("p.canjump: "..tostring(p.canjump))
  print("p.onground: "..tostring(p.onground))
end
