unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    Shape2: TShape;
    Timer1: TTimer;
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
var shp1:record
        vx,vy,m,posx,posy:real;
        xtime:integer;
        ytime:integer;
        end;
    shp2:record
        vx,vy,m,posx,posy:real;
        xtime:integer;
        ytime:integer;
    end;
    switc:boolean = false;
    ttime:integer = 0;


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
  timer1.enabled:=false;
  with shp2 do
       begin
       vx:=random*10-5;
       vy:=random*10-5;
       posx:=shape2.Left+shape2.width/2;
       posy:=shape2.top+shape2.height/2;
       m:=5000;
       end;
  with shp1 do
       begin
       vx:=random*10-5;
       vy:=random*10-5;
       m:=5000;
       posx:=shape1.left+shape1.width/2;
       posy:=shape1.Top+shape1.Height/2;
       end;
  image1.canvas.fillrect(clientrect);
  image1.canvas.MoveTo(trunc(shape2.left+shape2.width/2),trunc(shape2.top+shape2.height/2));
end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  if timer1.enabled then timer1.Enabled:=false
  else timer1.enabled:=true;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var speed:real;
begin
  if button=mbright then
  if switc then switc:=false
  else switc:=true;
  if (Button = mbRight) and switc then
  begin
  image1.canvas.moveto(x,y);
  with shape2 do
       begin
       top:=y-shape2.height div 2;
       left:=x-shape2.Width div 2;
       end;
  with shp2 do
       begin
       posx:=x;
       posy:=y;
       end;
  end;
  if (Button = mbRight) and not switc then
  begin
  with shp2 do
       begin
       speed:=strtofloat(inputbox('Rýchlosť','Napíš veľkosť vektoru.',''));
       vx:=(x-posx)/sqrt(sqr(x-posx)+sqr(y-posy))*speed;
       vy:=(y-posy)/sqrt(sqr(x-posx)+sqr(y-posy))*speed;
       end;
  image1.canvas.fillrect(clientrect);
  image1.canvas.moveto(trunc(shp2.posx),trunc(shp2.posy));
  end;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if switc then
  with image1.canvas do
       begin
       fillrect(clientrect);
       pen.color:=clsilver;
       moveto(trunc(shp2.posx),trunc(shp2.posy));
       lineto(x,y);
       pen.color:=clblack;
       end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var r,dx,dy,k1,k2:real;
begin
  shp1.xtime:=shp1.xtime+1;
  shp1.ytime:=shp1.ytime+1;
  shp2.xtime:=shp2.xtime+1;
  shp2.ytime:=shp2.ytime+1;
  ttime:=ttime+1;
  with shp2 do
       begin
       if (xtime>1) and ((posx<=image1.left) or (posx>=image1.width)) then
       begin
       vx:=vx*(-1);
       xtime:=0;
       end;
       if (ytime>1) and ((posy<=image1.Top) or (posy>=image1.height)) then
       begin
       vy:=vy*(-1);
       ytime:=0;
       end;
       posx:=posx+vx;
       posy:=posy+vy;
       end;
  with shp1 do
       begin
       if (xtime>1) and ((posx<=image1.left) or (posx>=image1.width)) then
       begin
       vx:=vx*(-1);
       xtime:=0;
       end;
       if (ytime>1) and ((posy<=image1.Top) or (posy>=image1.height)) then
       begin
       vy:=vy*(-1);
       ytime:=0;
       end;
       posx:=posx+vx;
       posy:=posy+vy;
       end;
  image1.canvas.pen.color:=clblack;
  //image1.canvas.moveTo(shape2.left+shape2.width div 2,shape2.top+shape2.height div 2);
  image1.canvas.brush.color:=clwhite;
  image1.canvas.Ellipse(shape2.Left,shape2.top,shape2.left+shape2.width,shape2.top+shape2.height);
  shape2.left:=trunc(shp2.posx-shape2.width/2);
  shape2.top:=trunc(shp2.posy-shape2.height/2);
  //image1.canvas.lineTo(shape2.left+shape2.width div 2,shape2.top+shape2.height div 2);
  //image1.canvas.pen.color:=clred;
  //image1.canvas.moveTo(shape1.left+shape1.width div 2,shape1.top+shape1.height div 2);
  image1.canvas.Brush.color:=clred;
  image1.canvas.Ellipse(shape1.Left,shape1.top,shape1.left+shape1.width,shape1.top+shape1.height);
  shape1.left:=trunc(shp1.posx-shape1.width/2);
  shape1.top:=trunc(shp1.posy-shape1.height/2);
  //image1.canvas.lineTo(shape1.left+shape1.width div 2,shape1.top+shape1.height div 2);
  dx:=(shp1.posx)-(shp2.posx);
  dy:=(shp1.posy)-(shp2.posy);
  r:=sqrt(sqr(dx)+sqr(dy));
  if not (r<=85) then
  begin
  shp2.vx:=shp2.vx*0.9999+(dx/r)*(shp1.m/sqr(r));
  shp2.vy:=shp2.vy*0.9999+(dy/r)*(shp1.m/sqr(r));
  shp1.vx:=shp1.vx*0.9999-(dx/r)*(shp2.m/sqr(r));
  shp1.vy:=shp1.vy*0.9999-(dy/r)*(shp2.m/sqr(r));
  end;
  if (r<=85) then
  begin
  shp2.vx:=shp2.vx-1.2*(dx/r)*(shp1.m/sqr(r));
  shp2.vy:=shp2.vy-1.2*(dy/r)*(shp1.m/sqr(r));
  shp1.vx:=shp1.vx+1.2*(dx/r)*(shp2.m/sqr(r));
  shp1.vy:=shp1.vy+1.2*(dy/r)*(shp2.m/sqr(r));
  end;
end;
initialization
with shp1 do
     begin
       xtime:=0;
       ytime:=0;
     end;
with shp2 do
     begin
       xtime:=0;
       ytime:=0;
     end;

end.

