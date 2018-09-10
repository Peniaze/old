unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}
uses Unit1;

{ TForm3 }

procedure TForm3.FormActivate(Sender: TObject);
begin
  memo1.lines.loadfromfile(subor);
end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if MessageDlg('Uložiť?',mtwarning, [mbyes,mbno],0) = mryes
 then if SaveDialog1.Execute
      then begin
                subor:=SaveDialog1.Filename;
                if ExtractFileExt(subor)='' then subor:=subor+'.txt';
                memo1.lines.savetofile(subor);
                assignfile(F,subor);
      end;

end;

end.

