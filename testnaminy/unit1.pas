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
type salto = record
                 x,y,vx,vy:integer;
                 end;
var gul1,gul2:array [0..9] of salto;
  t:integer; farba:integer = 0;
  farb: array [0..9] of TColor = (clNavy,clBlue,clAqua,clLime,clgreen,clyellow,clred,clmaroon,clfuchsia,clpurple);

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i,temx,temy:integer;
begin
     randomize;
     t:=0;
     image1.canvas.brush.color:=clblack;
     image1.canvas.fillrect(clientrect);
     temx:=25000-random(10000)+5000;
     temy:=25000-random(10000)+5000;
     for i:=0 to 9 do
     begin
     with gul1[i] do
     begin
          x:=temx;
          y:=temy;
          vx:=random(400)-200;
          vy:=random(3000) div 10-600;
     end;
     with gul2[i] do
     begin
          x:=gul1[i].x;
          y:=gul1[i].y;
          vx:=gul1[i].vx;
          vy:=gul1[i].vy;
     end;
     end;
     timer1.enabled:=true;
     image1.canvas.pen.Width:=7;
     farba:=farba+1;
     if farba>9 then
     farba:=0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,j:integer;
begin
     t:=t+1;
     if t>40 then
     begin
          timer1.enabled:=false;
          formcreate(image1);
     end;
     for i:=0 to 9 do
     begin
     if t>20 then
     with gul2[i] do
         begin
              image1.canvas.pen.color:=clblack;
              image1.canvas.moveto(x div 100,y div 100);
              for j:=1 to 2 do
              begin
                   vy:=vy+20;
                   x:=x+vx;
                   y:=y+vy;
                   if y>=49000 then
                   begin
                        y:=49000;
                        vy:=(-1)*vy+50;
                        end;
              end;
              image1.canvas.lineto(x div 100,y div 100);
         end;
     if t mod 2=0 then
     with gul1[i] do
         begin
              image1.canvas.pen.color:=farb[farba];
              image1.canvas.moveto(x div 100,y div 100);
              for j:=1 to 2 do
              begin
                   vy:=vy+20;
                   x:=x+vx;
                   y:=y+vy;
                   if y>=49000 then
                   begin
                        y:=49000;
                        vy:=(-1)*vy+50;
                        end;
              end;
              image1.canvas.lineto(x div 100,y div 100);
          end;
     end;
end;

end.

