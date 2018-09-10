unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
  Tsalto = class(TGraphicControl)
    public
      procedure paint; override;
  end;

var
  Form1: TForm1;
  salto:array [0..31] of Tsalto;
  bckgrd:TBitmap;
  tim:integer = 0;
  tom:integer = 0;
  count:integer = 0;

implementation

{$R *.lfm}
function drawopacity(bitmap,background:TBitmap; topp,leftt,opacity:integer) :TBitmap;
var i,j,k,a,bw,bh,t,l,o:integer; clrsnew,clrsback:array [1..3] of 0..$FFFFFF;  bitma,backgroun:TBitmap;
begin
     drawopacity:=TBitmap.create;
     bitma:=TBitmap.create;
     backgroun:=TBitmap.create;
     bitma:=bitmap;
     backgroun:=background;
     drawopacity.Height:=bitmap.height;
     drawopacity.width:=bitmap.width;
     bw:=bitmap.width;
     bh:=bitmap.height;
     t:=topp;
     l:=leftt;
     o:=opacity;
     drawopacity.BeginUpdate(true);
     for i:=0 to bw do
         for j:=0 to bh do
             begin
                  a:=backgroun.canvas.Pixels[l+i,t+j];
                  clrsback[1]:=a mod $100;
                  clrsback[2]:=a mod $10000 div $100;
                  clrsback[3]:=a div $10000;
                  a:=bitma.canvas.Pixels[i,j];
                  clrsnew[1]:=a mod $100;
                  clrsnew[2]:=a mod $10000 div $100;
                  clrsnew[3]:=a div $10000;
                  if not (a=$646464) then
                  for k:=1 to 3 do
                      if (clrsback[k]*(100-o)) div 100+(clrsnew[k]*o) div 100>$FF then
                         clrsback[k]:=$FF
                      else
                         clrsback[k]:=(clrsback[k]*(100-o)) div 100+(clrsnew[k]*o) div 100;
                  drawopacity.canvas.pixels[i,j]:=clrsback[1]+clrsback[2]*$100+clrsback[3]*$10000;
             end;
     drawopacity.EndUpdate(true);
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     bckgrd:=TBitmap.create;
     bckgrd.LoadFromFile('woods-wallpaper-hd-1.bmp');
end;

procedure Tsalto.paint;
var bitmap:TBitmap; i,j,h,w:integer;
begin
     bitmap:=TBitmap.create;
     bitmap.LoadFromFile('test.bmp');
     bitmap:=drawopacity(bitmap,bckgrd,top,left,30);
     canvas.Draw(0,0,bitmap);
     h:=bitmap.height;
     w:=bitmap.width;
     bitmap.Free;
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
     salto[count]:=Tsalto.create(nil);
     with salto[count] do
          begin
               parent:=Form1;
               width:=200;
               height:=200;
               left:=tim*200;
               top:=tom*200;
               paint;
          end;
     count+=1;
     tim+=1;
     if tim>7 then
        begin
             tim:=0;
             tom+=1;
             if tom>3 then
             timer1.enabled:=false;
        end;
end;


end.

