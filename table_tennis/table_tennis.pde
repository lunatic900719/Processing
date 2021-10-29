import processing.sound.*;

SoundFile file;
PImage img1, img2, img3, img4;
int x=500;
int y=300;
int sx=4;
int sy=2;
int p1y=250;
int p2y=250;
int score1=0;
int score2=0;
int winner=0;
int goal=3;
int pn=0;
boolean start=false;
boolean end=false;

void setup() {
  size(1000, 600);
  img1 = loadImage("court.jpg");
  img2 = loadImage("racket left.png");
  img3 = loadImage("racket right.png");
  img4 = loadImage("ball.png");
}
 
void draw() {
  background(img1);
  textSize(24);
  fill(0, 0, 0);
  text(str(score1)+":"+str(score2), 480, 570);
  if (!end)
  {
    if (start)
    {
      draw_paddle();
      y=y+sy;
      x=x+sx;
      pn=hit_paddle();
      if (pn>0)
      {
        file = new SoundFile(this, "flying_pan.mp3");
        file.play();
        if (pn==1) sx=4;
        else if (pn==2) sx=-4;
      }
      if (y<=0 || y+30>=600)
      {
        file = new SoundFile(this, "bomb.mp3");
        file.play();
        sy=-sy;
      }
      if (x>=50 && x<=950) image(img4, x, y, 50, 50);
      else
      {
        if (x<50) score2++;
        else if (x>950) score1++;
        file = new SoundFile(this, "explosion2.mp3");
        file.play();
        start=false;
        if (score2>=goal && score2-score1>=2)
        {
          winner=2;
          end=true;
        } else if (score1>=goal && score1-score2>=2)
        {
          winner=1;
          end=true;
        }
      }
    }else
    {
      textSize(24);
      fill(0);
      text("Click mouse to start the game!",330, 30);
      fill(0, 0, 0);
      text(str(score1)+":"+str(score2), 480, 570);
    }
  }else
  {
    textSize(24);
    fill(0);
    if (winner==1) text("Left player wins the game! Click mouse to restart the game!",190,30);
    else  text("Right player wins the game! Click mouse to restart the game!",190,30);
  }
}

int hit_paddle()
{
  if (x+25<=150 && y>=p1y && y+30<=p1y+100) return 1;
  else if (x+25>=850 && y>=p2y && y+30<=p2y+100) return 2;
  else return 0;
}

void draw_paddle()
{
  image(img2,0,p1y,150,100);
  image(img3,850,p2y,150,100);
}

void mousePressed()
{
  if (end)
  {
    score1=0;
    score2=0;
    x=500;
    y=300;
    start=true;
    end=false;
  }else if (!start)
  {
    x=500;
    y=300;
    sx=-sx;
    sy=-sy;
    start=true;
  }
}

void keyPressed()
{
  if (key=='a' || key=='A')
  {
    if (p1y>0) p1y-=10;
    else p1y=0;
  }else if (key=='z' || key=='Z')
  {
    if (p1y+60<height) p1y+=10;
    else p1y=height-60;
  }else if (key == CODED) {
    if (keyCode == UP) {
      if (p2y>0) p2y-=10;
      else p2y=0;
    }else if (keyCode == DOWN) {
      if (p2y+60<height) p2y+=10;
      else p2y=height-60;
    }
  }
}
  
