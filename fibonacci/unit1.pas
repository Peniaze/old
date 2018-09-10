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

var x1,x2,y1,y2,a,b,i,s,d:integer;
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
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  a:=a+b;
  b:=a-b;
  i:=i+1;
  d:=d+1;
  if d=17 then formcreate(timer1);
  case i of
     1:begin x1:=x1-(a-b); y1:=y1-a; y2:=y2-b;
   image1.canvas.MoveTo(x1,y1);  for s:=1 to a do begin image1.canvas.lineto(x1+s,y2-round(sqrt(sqr(a)-sqr(s)))); end; end;
     2:begin x1:=x1-a; x2:=x2-b; y2:=y2+(a-b);
   image1.canvas.moveto(x1,y2); for s:=1 to (a+1) do begin image1.canvas.Lineto(x1+s,y2-round(sqrt(s*(2*a-s)))); end; end;
     3:begin y1:=y1+b; x2:=x2+(a-b); y2:=y2+a;
   image1.canvas.moveto(x1,y1); for s:=1 to (a+1) do begin image1.canvas.lineto(x1+s,y2-round(a-sqrt(s*(2*a-s)))); end; end;
     4:begin x1:=x1+b; y1:=y1-(a-b); x2:=x2+a; i:=0;
   image1.canvas.moveto(x1,y2); for s:=1 to a do begin image1.canvas.lineto(x1+s,y2-round(a-sqrt(sqr(a)-sqr(s)))); end; end;
  end;
end;

end.

