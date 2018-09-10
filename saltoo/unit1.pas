unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var a,b,c,d,e,f,i:integer;
begin
  c:=-1000;
  e:=300;
  f:=1500;                         // e = v2, f = 2p
  a:=image1.Width div 2+c;
  b:=c*c div f+e;
  i:=0;
  d:=f div 2;
  image1.canvas.moveto(a,b);
  for i:=1 to 2000 do begin
      b:=c*c div f+e;
      a:=a+1;
      c:=c+1;
      image1.canvas.lineto(a,b);
  end;
  image1.canvas.Brush.style:=bsClear;
  image1.canvas.Ellipse(image1.width div 2-d,e,image1.width div 2+d,e+d+d);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  image1.canvas.fillrect(clientrect);
end;

end.

