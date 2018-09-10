unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var a,b,c,d:integer;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 randomize;
 Image1.canvas.FillRect(clientrect);
 a:=0;
 b:=10;
 c:=490;
 d:=373;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word);
begin
  if Key=VK_M then Timer1.enabled:=True;
  if Key=VK_L then ShowMessage('fakoff');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Image1.canvas.brush.color:=clwhite;
  Image1.canvas.fillrect(clientrect);
  if a=490 then begin
    b:=random(383);
    a:=0;
  end;
  if a<490 then begin
    a:=a+35;
    Image1.canvas.brush.color:=clblue;
    Image1.canvas.pen.color:=clblue;
    Image1.canvas.Rectangle(a-50,b+20,a,b);
  end;
  if c=0 then begin
    d:=random(383);
    c:=490;
  end;
  if c>0 then begin
    c:=c-35;
    Image1.canvas.brush.color:=clred;
    Image1.canvas.pen.color:=clred;
    Image1.canvas.Rectangle(c,d,c+50,d+20);
  end;
  if (b+20>d) and (d+20>b) and (a=c) then begin
    Timer1.Enabled:=False;
    ShowMessage('peniaze peniaze');
  end;
end;



end.

