unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  ttaz = array [0..65535] of integer;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var taz:ttaz;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i,k,j,l,m,lava,prava,predmet:integer; lav,prav:boolean;
  lavaa,pravaa,pravtemp,lavtemp:string;
begin
  taz[0]:=1;
  for i:=0 to 65535 do
  taz[i+1]:=taz[i]*3;
  k:=-1;
  i:=-1;
  j:=0;
  l:=0;
  lava:=0;
  m:=0;
  lav:=false;
  prav:=false;
  predmet:=strtoint(Edit1.text);
  while lava<predmet do
        begin
          inc(i);
          lava:=lava+taz[i];
        end;
  k:=i;
  lava:=taz[i];
  prava:=predmet;
  lavaa:=inttostr(lava);
  pravaa:=inttostr(prava);
  lavtemp:=lavaa;
  pravtemp:=pravaa;
  m:=prava;
  l:=lava;
  if lava>prava then prav:=true else lav:=true;
  if lava=prava then ShowMessage(inttostr(i))
  else repeat
         dec(k);
         if (lava<prava) and lav then begin lava:=lava+taz[k]; end;
         if (lava<=prava) and lav then lavaa:=lavaa+'+'+inttostr(taz[k]);
         if (prava<lava) and lav then begin lavtemp:=lavaa; l:=lava; j:=k; lava:=lava-taz[k]; end;
         if (lava>prava) and prav then begin prava:=prava+taz[k]; end;
         if (lava>=prava) and prav then pravaa:=pravaa+'+'+inttostr(taz[k]);
         if (prava>lava) and prav then begin pravtemp:=pravaa; m:=prava; j:=k; prava:=prava-taz[k]; end;
         if (k=-1) and lav then begin
           lav:=false;
           lava:=l;
           prava:=m;
           k:=j;
           prav:=true;
           lavaa:=lavtemp+'+'+inttostr(taz[k]);
           lavtemp:=lavaa;
         end;
         if (k=-1) and prav then begin
           prav:=false;
           prava:=m;
           lava:=l;
           k:=j;
           lav:=true;
           pravaa:=pravtemp+'+'+inttostr(taz[k]);
           pravtemp:=lavaa;
         end;
       until lava=prava;
  ShowMessage(pravaa+'='+lavaa);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FormCreate(Button1);
end;

end.

