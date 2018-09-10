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
    procedure peniaze;
  private
    { private declarations }
  public
    { public declarations }
  end;

var a0,a1,a2,b0,b1,b2:real; x,x1,x2:integer;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.canvas.fillrect(clientrect);
  a1:=20;
  randomize;
  b1:=20;
  a0:=a1;
  b0:=b1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Image1.canvas.brush.color:=clwhite;
  Image1.canvas.FillRect(clientrect);
  if (a1<=a2) and (b2>=b1) then begin
  a1:=a1+((a2-a0) / ( Sqrt ((b2-b0)*(b2-b0)+(a2-a0)*(a2-a0)) / 10));
  b1:=b1+((b2-b0) / ( Sqrt ((b2-b0)*(b2-b0)+(a2-a0)*(a2-a0)) / 10));
  peniaze;
  end;
  if (a1>=a2) and (b2>=b1) then begin
  a1:=a1-((a0-a2) / ( Sqrt ((b2-b0)*(b2-b0)+(a0-a2)*(a0-a2)) / 10));
  b1:=b1+((b2-b0) / ( Sqrt ((b2-b0)*(b2-b0)+(a0-a2)*(a0-a2)) / 10));
  peniaze;
  end;
  if (a1<=a2) and (b2<=b1) then begin
  a1:=a1+((a2-a0) / ( Sqrt ((b0-b2)*(b0-b2)+(a2-a0)*(a2-a0)) / 10));
  b1:=b1-((b0-b2) / ( Sqrt ((b0-b2)*(b0-b2)+(a2-a0)*(a2-a0)) / 10));
  peniaze;
  end;
  if (a1>=a2) and (b2<=b1) then begin
  a1:=a1-((a0-a2) / ( Sqrt ((b0-b2)*(b0-b2)+(a0-a2)*(a0-a2)) / 10));
  b1:=b1-((b0-b2) / ( Sqrt ((b0-b2)*(b0-b2)+(a0-a2)*(a0-a2)) / 10));
  peniaze;
  end;
  if (b1>=(Image1.height-20)) or (b1<=0) or (a1<=0) or (a1>=(Image1.width-20)) then begin
  x:=random(4);
  case x of
    0: begin a2:=455; b2:=random((Image1.height-20)); end;
    1: begin a2:=random((Image1.width-20)); b2:=388; end;
    2: begin a2:=0; b2:=random((Image1.height-20)); end;
    3: begin a2:=random((Image1.width-20)); b2:=0; end;
  end;
  if (b1>=(Image1.height-20)) then b1:=b1-5;
  if  (b1<=0) then b1:=b1+5;
  if  (a1<=0) then a1:=a1+5;
  if   (a1>=(Image1.width-20)) then a1:=a1-5;
  a0:=a1;
  b0:=b1;
  end;
end;
procedure TForm1.peniaze;
begin
  Form1.Image1.canvas.Brush.color:=clblack;
  Form1.Image1.canvas.pen.color:=clblack;
  x1:=round(a1);
  x2:=round(b1);
  Form1.Image1.canvas.Ellipse(x1,x2,x1+20,x2+20);
end;


end.

