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
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
var kocka:record
       Sx:real;
       Sy:real;
       Sz:real;
       Xx:real;
       Xy:real;
       Xz:real;
       Yx:real;
       Yy:real;
       Yz:real;
       Zx:real;
       Zy:real;
       Zz:real;
       Nx:real;
       Ny:real;
       Nz:real;
end;
    X1,Y1:integer;
procedure kresli;
begin
     with kocka do
          begin
              with form1.image1.canvas do
                   begin
                        moveto(round(2*Sx-Yx),round(2*Sy-Yy));
                        lineto(round(Xx),round(Xy));
                        lineto(round(2*Sx-Zx),round(2*Sy-Zy));
                        moveto(round(Xx),round(Xy));
                        lineto(round(Nx),round(Ny));
                        lineto(round(Yx),round(Yy));
                        lineto(round(2*Sx-Zx),round(2*Sy-Zy));
                        moveto(round(Yx),round(Yy));
                        lineto(round(2*Sx-Xx),round(2*Sy-Xy));
                        lineto(round(Zx),round(Zy));
                        lineto(round(2*Sx-Yx),round(2*Sy-Yy));
                        moveto(round(Zx),round(Zy));
                        lineto(round(Nx),round(Ny));
                   end;
          end;
end;
{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  image1.canvas.fillrect(clientrect);
  X1:=0;
  Y1:=0;
  with kocka do
       begin
       Sx:= 250;
       Sy:= 250;
       Sz:= 250;
       Xx:= 300;
       Xy:= 200;
       Xz:= 200;
       Yx:= 200;
       Yy:= 300;
       Yz:= 200;
       Zx:= 200;
       Zy:= 200;
       Zz:= 300;
       Nx:= 200;
       Ny:= 200;
       Nz:= 200;
       end;
  kresli;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssleft] then
     begin
     with kocka do
          begin
          Xx:=Xx;
          Xy:=Xy;
          Xz:=Xz;
          end;
     X1:=X;
     Y1:=Y;
     kresli;
     end;
end;

end.

