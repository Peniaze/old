unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
ttshp = record
  vx,vy,posx,posy,q:real;
  xtime,ytime:integer;
end;
tshp = array [0..5] of ttshp;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
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
var shp:tshp;
  ax,ay:array [0..5] of real;
procedure speed;
var i,j:integer; dx,dy,r:real;
begin
  dx:=0;
  dy:=0;
  r:=0;
  for i:=0 to 5 do
  begin
    ax[i]:=0;
    ay[i]:=0;
    for j:=0 to 5 do
    begin
      dx:=shp[j].posx-shp[i].posx;
      dy:=shp[j].posy-shp[i].posy;
      r:=sqr(dx)+sqr(dy);
      if r>4225 then
      begin
      if (((i<3) and (j>2)) or ((i>2) and (j<3))) and (i<>j) then
      begin
        ax[i]:=ax[i]+(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]+(dy/sqrt(r))*shp[j].q/r;
      end
      else
      if i<>j then
      begin
        ax[i]:=ax[i]-(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]-(dy/sqrt(r))*shp[j].q/r;
      end;
      end;
      if r<5000 then
      begin
      if (abs(j-i)>2) and (i<>j) then
      begin
        ax[i]:=ax[i]-1.01*(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]-1.01*(dy/sqrt(r))*shp[j].q/r;
      end
      else
      if i<>j then
      begin
        ax[i]:=ax[i]-1.51*(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]-1.51*(dy/sqrt(r))*shp[j].q/r;
      end;
      end;
    end;
    with shp[i] do
         begin
           xtime:=xtime+1;
           ytime:=ytime+1;
           vx:=vx+ax[i];
           vy:=vy+ay[i];
           posx:=posx+vx;
           posy:=posy+vy;
           if ((posx>form1.image1.width) or (posx<0)) and (xtime>5) then begin vx:=vx*(-1); xtime:=0; end;
           if ((posy>form1.image1.height) or (posy<0)) and (ytime>5) then begin vy:=vy*(-1); ytime:=0; end;
         end;
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  randomize;
  image1.canvas.fillrect(clientrect);
  for i:=0 to 5 do
  with shp[i] do
       begin
         posx:=random(image1.width-400)+200;
         posy:=random(image1.height-400)+200;
         vx:=0;
         vy:=0;
         q:=2000;
         xtime:=0;
         ytime:=0;
       end;
  shape1.left:=round(shp[0].posx)-shape1.width div 2;
  shape1.top:=round(shp[0].posy)-shape1.height div 2;
  shape2.left:=round(shp[1].posx)-shape2.width div 2;
  shape2.top:=round(shp[1].posy)-shape2.height div 2;
  shape3.left:=round(shp[2].posx)-shape3.width div 2;
  shape3.top:=round(shp[2].posy)-shape3.height div 2;
  shape4.left:=round(shp[3].posx)-shape4.width div 2;
  shape4.top:=round(shp[3].posy)-shape4.height div 2;
  shape5.left:=round(shp[4].posx)-shape5.width div 2;
  shape5.top:=round(shp[4].posy)-shape5.height div 2;
  shape6.left:=round(shp[5].posx)-shape6.width div 2;
  shape6.top:=round(shp[5].posy)-shape6.height div 2;
  timer1.enabled:=false;
end;

procedure TForm1.Image1Click(Sender: TObject);
var i:integer;
begin
  if timer1.enabled then timer1.enabled:=false
  else timer1.enabled:=true;
  for i:=0 to 5 do
  with shp[i] do
       begin
         vx:=0;
         vy:=0;
       end;
  image1.canvas.fillrect(clientrect);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  speed;
  image1.canvas.pen.color:=clblue;
  image1.canvas.MoveTo(shape1.left+shape1.width div 2,shape1.top+shape1.height div 2);
  shape1.left:=round(shp[0].posx)-shape1.width div 2;
  shape1.top:=round(shp[0].posy)-shape1.height div 2;
  image1.canvas.lineTo(shape1.left+shape1.width div 2,shape1.top+shape1.height div 2);
  image1.canvas.MoveTo(shape2.left+shape2.width div 2,shape2.top+shape2.height div 2);
  shape2.left:=round(shp[1].posx)-shape2.width div 2;
  shape2.top:=round(shp[1].posy)-shape2.height div 2;
  image1.canvas.lineTo(shape2.left+shape2.width div 2,shape2.top+shape2.height div 2);
  image1.canvas.MoveTo(shape3.left+shape3.width div 2,shape3.top+shape3.height div 2);
  shape3.left:=round(shp[2].posx)-shape3.width div 2;
  shape3.top:=round(shp[2].posy)-shape3.height div 2;
  image1.canvas.lineTo(shape3.left+shape3.width div 2,shape3.top+shape3.height div 2);
  image1.canvas.pen.color:=clred;
  image1.canvas.MoveTo(shape4.left+shape4.width div 2,shape4.top+shape4.height div 2);
  shape4.left:=round(shp[3].posx)-shape4.width div 2;
  shape4.top:=round(shp[3].posy)-shape4.height div 2;
  image1.canvas.lineTo(shape4.left+shape4.width div 2,shape4.top+shape4.height div 2);
  image1.canvas.MoveTo(shape5.left+shape5.width div 2,shape5.top+shape5.height div 2);
  shape5.left:=round(shp[4].posx)-shape5.width div 2;
  shape5.top:=round(shp[4].posy)-shape5.height div 2;
  image1.canvas.lineTo(shape5.left+shape5.width div 2,shape5.top+shape5.height div 2);
  image1.canvas.MoveTo(shape6.left+shape6.width div 2,shape6.top+shape6.height div 2);
  shape6.left:=round(shp[5].posx)-shape6.width div 2;
  shape6.top:=round(shp[5].posy)-shape6.height div 2;
  image1.canvas.lineTo(shape6.left+shape6.width div 2,shape6.top+shape6.height div 2);
end;

end.

