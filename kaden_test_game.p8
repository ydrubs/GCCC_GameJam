pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	p1 = {x=60,y=60}
	e1 = {x=20,y=20}
	enemy = {e1={20,20}, e2={20,100}}
	coin = {cnt=0,x=rnd(118),y=rnd(118)}	
	score = 0
	coin_count = 0
	enemy_count = 1
	total_bg = 1
	game_over = false
end

function hitbox_collide(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2)
  local c1 = ay1 <= by2
  local c2 = ay2 >= by1
  local c3 = ax1 <= bx2
  local c4 = ax2 >= bx1

  if c1 and c2 and c3 and c4 then
    return true
  else
    return false
  end
end

function playermvmt()
	if btn(⬆️) then
 		p1.y = p1.y - 1
 	elseif btn(⬇️) then
 		p1.y = p1.y + 1
 	end
 	
 	if btn(⬅️) then
 		p1.x = p1.x - 1
 	elseif btn(➡️) then
 		p1.x = p1.x + 1
 	end
end

function enemymvmt()
	for i,v in pairs(enemy) do
		if p1.x > v[1] then
			v[1] = v[1] + .44
		elseif p1.x < v[1] then
			v[1] = v[1] - .44
		end
			
		if p1.y > v[2] then
			v[2] = v[2] + .44
		elseif p1.y < v[1] then
			v[2] = v[2] - .44	
		end	
		
		if hitbox_collide(p1.x, p1.y, p1.x+8, p1.y+8,v[1],v[2],v[1]+8,v[2]+8) == true then
			game_over = true
		end
	end
end

function _update60()
	playermvmt()
	enemymvmt()
	if hitbox_collide(p1.x, p1.y, p1.x+8, p1.y+8, coin.x+2, coin.y+2, coin.x+6, coin.y+6) == true then
		coin.cnt = coin.cnt - 1
		score = score + 1
	end
end

function _draw()
	if not game_over then
		cls()
		print(score)
		if coin.cnt < 1 then
			coin.x = rnd(118)
			coin.y = rnd(118)
			coin.cnt = coin.cnt + 1
		end
		spr(2, coin.x, coin.y)
		spr(1,p1.x,p1.y)
		spr(3,enemy.e1[1],enemy.e1[2])
		spr(3,enemy.e2[1],enemy.e2[2])
	else
		cls()
		print("game over")
		print(score)
	end
end
__gfx__
0000000011111111000aa00055555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001dddddd100a99a0058888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007001dddddd10a9aa9a058888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770001dddddd1a9a99a9a58888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770001dddddd1a9a99a9a58888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007001dddddd10a9aa9a058888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001dddddd100a99a0058888885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111111000aa00055555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344

