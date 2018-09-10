unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  public
    Timer1,Timer2:TTimer;
    procedure Fire(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  end;
  TSalto = class(TGraphicControl)
    procedure paint; override;
    constructor create(AOwner: TComponent); override;
  end;


var
  Form1: TForm1;

implementation

{$R *.lfm}
{$I fireworks.inc}

procedure TForm1.FormCreate(Sender: TObject);
begin
     Form1.Fire(nil);
end;

end.

