
function _init()
	mx_init=-128
	my_init=-1-(8*2)
	mx=-128
	my=-1-(8*2)
  bullets={}
  particles={}
  enemies={}
  pickups={}
  del_enemies={}
  computers={}
  generate_entities()
end

function _update60()
  if p.is_dead then
    return
  end
  if p.just_fired > 0 then
    if p.just_fired > 2 then
      p.just_fired = 0
    else
      p.just_fired+=1
    end
  end

  controls()
  resolve_collisions()
  update_state()

  p.vy=max(-1.8,p.vy)
  mx+=p.vx
  my+=p.vy
  respawn_enemies()
  move_enemies()
  move_pickups()
  enemies_collisions()
  check_pickups_collision()
  activate_pickups()

  for i,b in ipairs(bullets) do
    b:move(i)
    b:collision(i)
  end
  reload_gun()

  anti_cs()
  move_del_enemies()

  update_particles()
  del_particles()
  move_particles()
  computers_move()
  check_if_bullet_hit_enemies()
  check_can_search()
  is_player_searching()
  search_computer()
  p.is_dead = check_enemies_collision()
end

function _draw()
  ntx = mx<=0 and mx or 0
  nty = my<=0 and my or 0

  cls()

  draw_background(p.is_dead)
  map(0,0,mx,my,16-ntx,16-nty)

  draw_computers()
  draw_enemies(p.is_dead)
  draw_del_enemies()
  draw_pickups()

  if not p.is_dead then
    p:draw()

    if not p.is_searching then
      spr(32,p.px+(p.lr_dir=='l' and 5 or -5),p.py+1,1,1,p.lr_dir=='l' and true or false)
      local ng = p.just_fired==0 and 0 or 1
      if p.bullets_to_fire > 0 then
        spr(
          17,
          p.px+(p.lr_dir=='l' and -(3-ng) or 3-ng),
          p.py+2,
          1,1,p.lr_dir=='l' and true or false
        )
        local j=0
        local vb = 63
        for i=1,p.bullets_to_fire do
          if p.lr_dir=='l' then
            pset(65+j,vb,3)
          else
            pset(70-j,vb,3)
          end
          j +=1
        end
      end
      for i=1,p.fuel do
        pset(p.lr_dir=='l' and 72 or 63,71-i,1)
      end
    end

    for _,b in ipairs(bullets) do
      b:draw()
    end
    check_collision_w_bullets_reload()

    draw_particles()
    draw_can_search()
    --debugging()
  else
    --debugging()
    player_dies()
  end
end
