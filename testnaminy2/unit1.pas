unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
var gula:record
    x,y:integer;
    vx,vy:real;
end;
  farb: array [0..9] of TColor = (clNavy,clBlue,clAqua,clLime,clgreen,clyellow,clred,clmaroon,clfuchsia,clpurple);
  c,t,n,i:integer;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     randomize;
     n:=1;
     image1.canvas.pen.width:=15;
     image1.canvas.brush.color:=clblack;
  image1.canvas.fillrect(clientrect);
  c:=0;
  with gula do
  begin
       x:=1000*image1.width div 2;
       y:=100000;
       vx:=0.89443*1500;
       vy:=0.89443*3000;
  end;
  timer1.enabled:=true;
  t:=0;
  i:=0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var pom:real;
begin
     t:=t+1;
     if (t>9) and (gula.x div 1000<image1.width-100) and (gula.x div 1000>100)
     and (gula.y div 1000<image1.height-100) and (gula.y div 1000>100) then
     n:=n*(-1);
     if t>9 then
     begin
     image1.canvas.Pen.color:=farb[i];
     i:=i+1;
     if i>9 then
     i:=0;
     t:=0;
     end;
     with gula do
     begin
          image1.canvas.moveto(x div 1000,y div 1000);
          x:=x+round(vx);
          y:=y+round(vy);
          pom:=vx;
          vx:=0.99504*(vx+n*(-1)*vy/10);
          vy:=0.99504*(vy+n*pom/10);
          image1.canvas.lineto(x div 1000,y div 1000);
     end;
end;

end.

