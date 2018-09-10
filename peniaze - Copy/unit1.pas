unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
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
var a,b,c,d,f:integer; e:string;
begin
  a:=strtoint(Edit1.text);
  b:=strtoint(Edit2.text);
  c:=strtoint(Edit3.text);
  d:=0;
  e:='';
  f:=b-a+1;
  while c>0 do begin
    d:=random(f)+a;
    e:=e+inttostr(d)+'  ';
    Label4.Caption:=e;
    c:=c-1;
  end;


end;

end.

