unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,math;

type
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
procedure start;
var path,h:string; g:text;
begin
  path:=ExtractFilepath(ParamStr(0));
  Showmessage(path);
  assignfile(g,path+'salto.txt');
  reset(g);
  readln(g,h);
  form1.Edit2.text:=h;
  closefile(g);
end;

{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
begin
  start;
end;

procedure TForm1.Button1Click(Sender: TObject);
var cislo,i,x1,x2,x3,x4,x5:integer; f:text;
  a: array [0..15] of boolean;
  b: array [0..15] of string;
begin
  randomize;
  cislo:=strtoint(Edit1.text);
  i:=0;
  repeat
  begin
    a[i]:=cislo mod 2=1;
    cislo:=cislo div 2;
    if a[i] then
    begin
    repeat
    begin
      x1:=random(192)+33;
      x2:=random(192)+33;
      x3:=random(192)+33;
      x4:=random(192)+33;
      x5:=random(192)+33;
    end;
    until x1+x2+x3+x4+x5=i+230;
    end
    else
    begin
    repeat
    begin
      x1:=random(192)+33;
      x2:=random(192)+33;
      x3:=random(192)+33;
      x4:=random(192)+33;
      x5:=random(192)+33;
    end;
    until x1+x2+x3+x4+x5=i+231;
    end;
    b[i]:=chr(x1)+chr(x2)+chr(x3)+chr(x4)+chr(x5);
    i:=i+1;
  end;

  until cislo=0;
  ShowMessage(b[0]+b[1]+b[2]+b[3]+b[4]+b[5]+b[6]+b[7]+b[8]+b[9]+b[10]+b[11]+b[12]+b[13]+b[14]+b[15]);
  Assignfile(f,'C:\Users\Matej\Desktop\SALTOOOO\sifra\salto.txt');
  Append(f);
  writeln(f,b[0]+b[1]+b[2]+b[3]+b[4]+b[5]+b[6]+b[7]+b[8]+b[9]+b[10]+b[11]+b[12]+b[13]+b[14]+b[15]);
  closefile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
var b:string; i:integer; a:real;
begin
  a:=0;
  b:=edit2.text;
  for i:=0 to (length(b) div 5)-1 do
  begin
    if (ord(b[i*5+1])+ord(b[i*5+2])+ord(b[i*5+3])+ord(b[i*5+4])+ord(b[i*5+5]))=i+230 then
    a:=a+intpower(2,i) else
      if not (ord(b[i*5+1])+ord(b[i*5+2])+ord(b[i*5+3])+ord(b[i*5+4])+ord(b[i*5+5])=i+231) then
      begin
      a:=0;
      ShowMessage('chyba');
      exit;
      end;
  end;
  ShowMessage(floattostr(a));
end;


end.

