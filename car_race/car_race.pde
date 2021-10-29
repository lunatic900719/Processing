import processing.sound.*;

SoundFile file;

int num=11;
PImage[] img=new PImage[num];
int xc=0;
int yc=160;
int opponent=3;
int life=3;
int m1;
int s1;
int t;
int countdown=3;
int speed=0;
int acc=1;
int stage=1;
int order=0;
int[] xo=new int[opponent];
int[] yo=new int[opponent];
int[] spo=new int[opponent];
int[] cid=new int[opponent];
int[] mark=new int[opponent];
String[] place={"first", "second", "third", "fourth"};
boolean start=false;
boolean end=false;
boolean lose=false;

void setup()
{
  size(1200, 400);
  img[1]=loadImage("road.jpg");
  img[2]=loadImage("heart.png");
  img[3]=loadImage("trophy.png");
  img[4]=loadImage("car1.png");
  img[5]=loadImage("car2.png");
  img[6]=loadImage("car3.png");
  img[7]=loadImage("car4.png");
  img[8]=loadImage("gress.jpg");
  img[9]=loadImage("desert.jpg");
  img[10]=loadImage("space.jpg");
}

void draw()
{
  draw_background();
  if (!end)
  {
    if (start)
    {
      if (countdown<=0)
      {
        if (speed<=0)
        {
          textSize(100);
          fill(255, 0, 0);
          text("Go", 520, 200);
        }
        xc+=speed;
        textSize(24);
        fill(0, 0, 255);
        text("Speed:"+str(speed)+"    "+str(timer())+" second(s)", 430, 30);
        text("Stage"+str(stage), 520, 350);
        if (xc+80-(stage-1)*1200>=width)
        {
          if (stage<3)
          {
            stage++;
          } else
          {
            file = new SoundFile(this, "kendo_audience2.mp3");
            file.play();
            end=true;
            lose=false;
            start=false;
            t=timer();
          }
        }
      } else
      {
        countdown=3-timer();
        textSize(100);
        fill(255, 0, 0);
        if (countdown>0)
        {
          text(str(countdown), 550, 200);
        } else
        {
          text("Go", 520, 200);
          file = new SoundFile(this, "small_car_engine1.mp3");
          file.play();
          s1=second();
          m1=minute();
        }
      }
    } else
    {
      textSize(24);
      fill(0, 0, 255);
      text("Click mouse to start the game!", 400, 30);
    }
  } else
  {
    if (!lose)
    {
      textSize(24);
      fill(255);
      if (order==0) image(img[3], 450, 50, 300, 300);
      text("You are in the "+place[order]+"place! You have completed the game in "+str(t)+" seconds!", 180, 350);
      text("Click mouse to restart the game!", 450, 380);
    } else
    {
      textSize(24);
      fill(255, 0, 0);
      text("You have lose the game in "+str(t)+" seconds! Click mouse to restart the game!", 190, 350);
    }
  }
}

void draw_background()
{
  background(img[stage+7]);
  image(img[1], 0, 150, 600, 120);
  image(img[1], 600, 150, 600, 120);
  for (int i=0; i<life; i++ )
  {
    image(img[2], 10+i*40, 10, 30, 30);
  }
  image(img[4], xc-(stage-1)*1200, yc, 80, 40);
}

int timer()
{
  int s2=second()-s1;
  int m2=minute()-m1;
  if (m2<0) m2+=60;
  return s2+m2*60;
}

void mousePressed()
{
  if (end)
  {
    xc=0;
    yc=160;
    stage=1;
    speed=0;
    life=3;
    order=0;
    start=true;
    end=false;
    lose=false;
    countdown=3;
    s1=second();
    m1=minute();
  } else if (!start)
  {
    start=true;
    s1=second();
    m1=minute();
  }
}

void keyPressed()
{
  if (key==CODED)
  {
    if (keyCode==RIGHT)
    {
      if (speed<80) speed+=acc;
      else speed=0;
    } else if (keyCode==LEFT)
    {
      if (speed>acc) speed-=acc;
      else speed=0;
    } else if (keyCode==UP)
    {
      if (yc>=160) yc-=10;
      else yc=150;
    } else if (keyCode==DOWN)
    {
      if (yc<=220) yc+=10;
      else yc=230;
    }
  }
}
