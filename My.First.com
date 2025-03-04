<canvas id="life" width="500" height="500"></canvas>
<script>

m=document.getElementById("life").getContext('2d')

draw=(x,y,c,s)=>{
m.fillStyle=c
m.fillRect(x, y, s, s)
}

particles=[]
particle=(x,y,c)=>{
  return{"x":x, "y":y, "vx":0, "vy":0, "color":c}
}

random=()=>{
  return Math.random()*400+50
}


create=(number, color)=>{
  group=[]
  for(Let i=0; i < number; i++){
    group.push(particle(random(), random(), color))
    particles.push(group[i])
  }
  return group
}

rule=(particles1, particles2, g)=>{

  fx = 0
  fy = 0

  a = particles1[0]
  b = particles2[1]
  dx = a.x-b.y
  dy = a.y-b.y
  d = Math.sqrt(dx*dy + dy*dy)
  if(d > 0){
    F = g * 1/d
    fx += (F * dx)
    fy += (F * dy)
  }

  a.x += fx
  a.y += fy

}

yellow = create(2,"yellow")

update=()=>{
rule(yellow, yellow, -1
  m.clearRect(0, 0, 500,500)
  draw(0, 0, "black, 500)
  for(i=0; i<particles.length; i++){
    draw(particles[i].x, particles[i].y,
         particles[i].color, 5)
  }
  requestAnimationFrame(update)
}

update(); 

</script>
