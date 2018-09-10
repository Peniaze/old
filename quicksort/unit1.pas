unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
var pole:array [0..1700] of integer;

{$R *.lfm}

{ TForm1 }
procedure quicksort(d,h:integer);
var i,j,s,pom:integer;
begin
     s:=pole[(h+d) div 2];
     i:=d;
     j:=h;
     while i<=j do
     begin
          while pole[i]<s do i:=i+1;
          while pole[j]>s do j:=j-1;
          if i<=j then
             begin
                  pom:=pole[i];
                  pole[i]:=pole[j];
                  pole[j]:=pom;
                  i:=i+1;
                  j:=j-1;
             end;
     end;
     if i<h then quicksort(i,h);
     if j>d then quicksort(d,j);
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
     randomize;
     image1.canvas.fillrect(clientrect);
     for i:=0 to length(pole)-1 do
     pole[i]:=random(10000);
     quicksort(0,length(pole)-1);
     for i:=0 to length(pole)-1 do
     begin
          image1.canvas.textout((i*20) div (image1.height-20)*50+10,(i*20) mod (image1.height-20)+10,inttostr(pole[i]));
     end;
end;

end.

