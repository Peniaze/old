unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}
uses Unit1;
var pom:textfile;
  odstran:boolean;

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  if Edit1.text<>''
  then begin
       reset(F);
       if eof(F) then rewrite(F)
       else append(F);
       writeln(F,Edit1.text);
       writeln(F,Edit2.text);
       writeln(F,Edit3.text);
       closefile(F);
  end;
  close;
end;

procedure TForm4.Button2Click(Sender: TObject);
var map,adr,tel:string;
begin
  if not odstran then
  begin
  writeln(pom,Edit1.text);
  writeln(pom,Edit2.text);
  writeln(pom,Edit3.text);
  end;
  odstran:=false;
  if not eof(F)
  then
      begin
           readln(F,map);
           Edit1.text:=map;
           readln(F,adr);
           Edit2.text:=adr;
           readln(F,tel);
           Edit3.text:=tel;
      end;
  if eof(F) then
      begin
      Button4.visible:=true;
      Button2.visible:=false;
      end;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  odstran:=true;
  Button2Click(Button3);
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  writeln(pom,Edit1.text);
  writeln(pom,Edit2.text);
  writeln(pom,Edit3.text);
  closefile(F);
  closefile(pom);
  erase(F);
  rename(pom,subor);
  assignfile(F,subor);
  close;
end;

procedure TForm4.FormCreate(Sender: TObject);
var map,adr,tel:string;
begin
  if edituj then
begin
  button2.visible:=true;
  button3.visible:=true;
end
else button1.visible:=true;
  if edituj then begin
  assignfile(pom,'pomocny.txt');
  rewrite(pom);
  end;
  reset(F);
  if edituj and not eof(F)
  then
      begin
           readln(F,map);
           Edit1.text:=map;
           readln(F,adr);
           Edit2.text:=adr;
           readln(F,tel);
           Edit3.text:=tel;
      end
  else
      closefile(F);
  edituj:=false;
end;



end.

