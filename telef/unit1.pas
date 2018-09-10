unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus, Unit2, Unit3, Unit4;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var  F:text; subor:string; edituj:boolean = false;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
var x:TForm3;
begin
  x:=TForm3.Create(Application);
  try
    x.ShowModal;
  finally
    x.Free;
  end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
var x:TForm4;
begin
  x:=TForm4.Create(Application);
  try
    x.ShowModal;
  finally
    x.Free;
  end;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  if OpenDialog1.Execute
  then
      begin
      subor:=OpenDialog1.filename;
      assignfile(F,subor);
      end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  subor:=InputBox('Premenuj','Nový názov súboru (bez prípony)','')+'.txt';
  rename(F,subor);
  assignfile(F,subor);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var x:TForm4;
begin
  edituj:=true;
  x:=TForm4.Create(Application);
  try
    x.ShowModal;
  finally
    x.Free;
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
var x:TForm2;
begin
  x:=TForm2.Create(Application);
  try
    x.ShowModal;
  finally
    x.Free;
  end;
end;
initialization
subor:='zoznam.txt';
assignfile(F,subor);
try
   reset(F);
except
      ShowMessage('Súbor nenájdený, vytváram nový.');
      rewrite(F);
end;
closefile(F);
end.

