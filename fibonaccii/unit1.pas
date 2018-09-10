unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

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

var x1,x2,y1,y2,a,b,i,s,c:integer; q,d:real; salto: array of real;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  image1.canvas.fillrect(clientrect);
  x1:=960;
  x2:=961;
  y1:=505;
  y2:=506;
  a:=1;
  b:=0;
  i:=0;
  d:=0;
  s:=0;
  image1.canvas.pen.Width:=5;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if q>=(pi/2) then
  begin
  i:=i+1;
  if i=5 then i:=1;
  a:=a+b;
  b:=a-b;
  d:=0;
  s:=s+1;
  q:=0;
  if s=16 then formcreate(timer1);
  case i of
     1:begin x1:=x1-(a-b); y1:=y1-a; y2:=y2-b;  image1.canvas.MoveTo(x2,y2); end;
     2:begin x1:=x1-a; x2:=x2-b; y2:=y2+(a-b);  image1.canvas.moveto(x2,y1); end;
     3:begin y1:=y1+b; x2:=x2+(a-b); y2:=y2+a;  image1.canvas.moveto(x1,y1); end;
     4:begin x1:=x1+b; y1:=y1-(a-b); x2:=x2+a;  image1.canvas.moveto(x1,y2); end;
  end;
  end;
  case i of
     1:begin  image1.canvas.lineto(x2-trunc(d),y1+trunc(a-sqrt(d*(2*a-d)))); end;
     2:begin image1.canvas.Lineto(x2-trunc(d),y1+trunc(a-sqrt(sqr(a)-sqr(d)))); end;
     3:begin image1.canvas.lineto(x1+trunc(d),y2-trunc(a-sqrt(d*(2*a-d)))); end;
     4:begin image1.canvas.lineto(x1+trunc(d),y2-trunc(a-sqrt(sqr(a)-sqr(d)))); end;
  end;
  q:=q+pi/(2*a);
  d:=sin(q)*a;
end;

end.

