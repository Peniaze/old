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
var tim:integer = 0; tom:integer = 0;


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
end;
function drawopacity(bitmap,background:TBitmap; topp,leftt,opacity:integer) :TBitmap;
var i,j,k,a:integer; clrsnew,clrsback:array [1..3] of 0..$FFFFFF;
begin
     drawopacity:=TBitmap.create;
     drawopacity.Height:=bitmap.height;
     drawopacity.width:=bitmap.width;
     for i:=0 to bitmap.width do
         for j:=0 to bitmap.height do
             begin
                  a:=background.canvas.Pixels[leftt+i,topp+j];
                  clrsback[1]:=a mod $100;
                  clrsback[2]:=a mod $10000 div $100;
                  clrsback[3]:=a div $10000;
                  a:=bitmap.canvas.Pixels[i,j];
                  clrsnew[1]:=a mod $100;
                  clrsnew[2]:=a mod $10000 div $100;
                  clrsnew[3]:=a div $10000;
                  if not (a=$646464) then
                  for k:=1 to 3 do
                      if clrsback[k]*(100-opacity) / 100+clrsnew[k]*opacity/100>$FF then
                         clrsback[k]:=$FF
                      else
                         clrsback[k]:=round(clrsback[k]*(100-opacity) / 100)+round(clrsnew[k]*opacity/100);
                  drawopacity.canvas.pixels[i,j]:=clrsback[1]+clrsback[2]*$100+clrsback[3]*$10000;
             end;
end;
procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var salto,backg:TBitmap;
begin
     salto:=TBitmap.create;
     salto.LoadFromFile('test.bmp');
     backg:=TBitmap.create;
     backg.LoadFromFile('woods-wallpaper-hd-1.bmp');
     image1.canvas.Draw(tim*200,tom*200,drawopacity(salto,backg,tom*200,tim*200,30));
     salto.Free;
     backg.Free;
     tim+=1;
     if tim>7 then
        begin
             tim:=0;
             tom+=1;
        end;
     if tom>3 then timer1.enabled:=false;
end;

end.

