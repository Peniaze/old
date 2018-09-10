unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Edit3EditingDone(Sender: TObject);
    procedure EditEditingDone(Sender: TEdit);
    procedure FormClose(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure skrij(valu: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}
uses unit1;
procedure TForm2.skrij(valu: boolean);
begin
     Edit1.enabled:=valu;
     Edit2.enabled:=valu;
     Edit3.enabled:=valu;
     Label1.enabled:=valu;
     Label2.enabled:=valu;
     Label3.enabled:=valu;
     Label4.enabled:=valu;
     Label5.enabled:=valu;
end;

{ TForm2 }

procedure TForm2.RadioGroup1Click(Sender: TObject);
begin
     case radiogroup1.Items[radiogroup1.itemindex] of
          'Easy':begin unit1.vyska:=10; unit1.sirka:=10; unit1.pocetmin:=10;end;
          'Medium':begin unit1.vyska:=12; unit1.sirka:=20; unit1.pocetmin:=40;end;
          'Hard':begin unit1.vyska:=16; unit1.sirka:=30; unit1.pocetmin:=99;end;
     end;
     if radiogroup1.Items[radiogroup1.itemindex]='Custom' then
     skrij(True)
     else
     skrij(False);
end;

procedure TForm2.FormClose(Sender: TObject);
begin
     if radiogroup1.Items[radiogroup1.itemindex]='Custom' then
     begin
          EditEditingDone(Edit1);
          EditEditingDone(Edit2);
          Edit3EditingDone(Form2);
          unit1.sirka:=strtoint(edit1.text);
          unit1.vyska:=strtoint(edit2.text);
          unit1.pocetmin:=strtoint(edit3.text);
     end;
end;

procedure TForm2.EditEditingDone(Sender: TEdit);
var x:integer;
begin
     x:=0;
     if trystrtoint(Sender.text,x) then
     begin
        if (x>40) or (x<10) then
           Sender.text:='10';
     end
     else
         Sender.text:='10';
end;

procedure TForm2.Edit3EditingDone(Sender: TObject);
var x:integer;
begin
     x:=0;
     if trystrtoint(Edit3.text,x) then
     begin
        if x>strtoint(edit1.text)*strtoint(edit2.text)-1 then
           Edit3.text:=inttostr(strtoint(edit1.text)*strtoint(edit2.text)-1);
        case x of
             0..10:Edit3.text:='10';
             1000..Maxint:Edit3.text:='999';
        end;
     end
     else
         Edit3.text:='10';
end;

{ TForm2 }



end.

