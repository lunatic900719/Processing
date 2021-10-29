import processing.sound.*;

SoundFile file;
int score=0;
boolean hit=false;
int rx, ry, rf;
int s1, m1;
int pt=0;
int period=3;
int ttp=30;

void setup()
{
  size(1500,1500);
  m1=minute();
  s1=second();
  initial_face();
}

void draw()
{
  background(#FC8003);
  if (ttp>timer())
  {
    textSize(48);
    fill(0);
    text(str(ttp-timer())+" seconds left, Score:"+str(score), 200, 575);
    if (pt/period!=timer()/period)
    {
      period=3-timer()/10;
      initial_face();
      pt+=period;
      hit=false;
    }
    if (!hit)
    {
      if (rf==0)face();
      else face2();
    }
    crosshair();
  } else
  {
    textSize(48);
    fill(0, 0, 255);
    text("Time is up , your score is:"+str(score), 200, 575);
  }
}

void initial_face()
{
  rx=int(random(40, 560));
  ry=int(random(40, 560));
  rf=int(random(2));
}

int timer()
{
  int s2=second()-s1;
  int m2=minute()-m1;
  if (m2<0) m2+=60;
  return s2+m2*60;
}

void crosshair()
{
  noStroke();
  for (int i=0; i<5; i++)
  {
    if (i%2==0)
      fill(255,0,0,160);
    else
      fill(255,255,255,160);
    ellipse(mouseX,mouseY, 50-i*10, 50-i*10);
  }
}

void face() 
{
  stroke(0);
  fill(#FFA805);
  ellipse(rx+75, ry+140, 525, 525);
  fill(#F72505);
  rect(rx-75,ry+60,295,220);
  fill(#FFFFFF);
  ellipse(rx, ry, 80, 60);
  ellipse(rx+150, ry, 80, 60);
  rect(rx-75,ry+60,75,70);
  rect(rx,ry+60,75,70);
  rect(rx+70,ry+60,75,70);
  rect(rx+145,ry+60,75,70);
  rect(rx-75,ry+280,75,70);
  rect(rx,ry+280,75,70);
  rect(rx+70,ry+280,75,70);
  rect(rx+145,ry+280,75,70);
  fill(#0D0200);
  ellipse(rx, ry, 80/2, 60/2);
  ellipse(rx+150, ry, 80/2, 60/2);
}

void face2()
{
  stroke(#FFFFFF);
  fill(#05FF30);
  ellipse(rx+75, ry+140, 525, 525);
  fill(#900AFF);
  rect(rx-75,ry+60,295,270);
  fill(#050505);
  ellipse(rx, ry, 80, 60);
  ellipse(rx+150, ry, 80, 60);
  rect(rx-75,ry+60,75,70);
  rect(rx,ry+60,75,70);
  rect(rx+70,ry+60,75,70);
  rect(rx+145,ry+60,75,70);
  rect(rx-75,ry+280,75,70);
  rect(rx,ry+280,75,70);
  rect(rx+70,ry+280,75,70);
  rect(rx+145,ry+280,75,70);
  fill(#FFFCFC);
  ellipse(rx, ry, 80/2, 60/2);
  ellipse(rx+150, ry, 80/2, 60/2);
}

void mousePressed()
{
  if (abs(mouseX-rx)<=225 && abs(mouseY-ry)<=225)
  {
    if (rf==0 && mouseButton==LEFT)
    {
      score++;
      file = new SoundFile(this, "bomb.mp3");
      file.play();
      hit=true;
    } else if (rf==1 && mouseButton==RIGHT)
    {
      score++;
      file = new SoundFile(this, "destruction1.mp3");
      file.play();
      hit=true;
    } else
    {
      if (score>0) score--;
      file = new SoundFile(this, "flying_pan.mp3");
      file.play();
    }
  } else
  {
    if (score>0) score--;
    file = new SoundFile(this, "flying_pan.mp3");
    file.play();
  }
}
