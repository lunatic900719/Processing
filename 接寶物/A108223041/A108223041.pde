import processing.sound.*;

SoundFile file;

PImage img1, img2, img3, img4;
int x1, y1;
int x2, y2;
int x3, y3;
int x4, y4;
float speed=0;
float gravity=0.2;
int life=3;
int score=0;
boolean start=false;
boolean end=false;

void setup()
{
  size(1000, 900);
  img1=loadImage("background.png");
  img2=loadImage("star.png");
  img3=loadImage("burger.png");
  img4=loadImage("heart.png");
  x1=500;
  y1=700;
  x3=0;
  y3=20;
  initial_burger();
}

void draw()
{
  background(img1);
  for (int i=0; i<life; i++)
    image(img4, x3+i*60, y3, 50, 40);
  x4=500;
  y4=0;
  image(img3, x4, y4, 50, 40);
  textSize(24);
  fill(0);
  text(str(score), 560, 30);
  if (!end)
  {
    if (start)
    {
      image(img2, x1, y1, 380, 200);
      speed+=gravity;
      y2+=speed;
      if (y2>=y1+50)
      {
        if (x2>=x1 && x2+120<=x1+380)
        {
          score++;
          file = new SoundFile(this, "crrect_answer3.mp3");
          file.play();
        } else
        {
          life--;
          file = new SoundFile(this, "bomb.mp3");
          file.play();
          if (life==0)
          {
            end=true;
          }
        }
        if (!end) initial_burger();
      }
      if (y2<750)
      {
        image(img3, x2, y2, 120, 80);
      }
    } else
    {
      textSize(20);
      fill(0);
      text("Game over! Click mouse to start a new game!", 40, 20);
    }
  }
}


void initial_burger()
{
  x2=int(random(880));
  file = new SoundFile(this, "falling1.mp3");
  file.play();
  y2=0;
  speed=0;
}



  void keyPressed()
  {
    if (key == CODED) {
      if (keyCode == LEFT) {
        if (x1>=20) x1-=20;
        else x1=0;
      } else if (keyCode == RIGHT) {
        if (x1<=600) x1+=20;
        else x1=620;
      }
    }
  }

void mousePressed()
{
  if (!start)
  {
    start=true;
    initial_burger();
  } else if (end)
  {
    start=true;
    end=false;
    life=3;
    score=0;
    x1=500;
    y1=700;
    initial_burger();
  }
}
