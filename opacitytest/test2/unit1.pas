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


{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var x:byte; y:TColor;
begin
  x:=$AA;
  y:=$FA45EF;

  ShowMessage(inttostr(x));
  x:=y;
  ShowMessage(hexstr(x,2));
  y := y div $100;
  ShowMessage(hexstr(y,6));
  x:=y;
  ShowMessage(hexstr(x,2));
  y := y div $100;
  x:=y;
  ShowMessage(hexstr(x,2));


end;

end.

