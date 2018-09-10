unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
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
var a,b,c,d,f:integer; e,g:string;
begin
  randomize;
  a:=1;
  b:=72;
  d:=0;
  e:='';
  f:=b-a+1;
  g:='';
  for c:=1 to 2 do begin
    d:=random(f)+a;
    g:='';
    begin case d of
      1:g:='Agni';2:g:='Ah Muzen Cab';3:g:='Ah Puch';4:g:='Amaterasu';5:g:='Anhur';6:g:='Anubis';7:g:='Ao Kuang';8:g:='Aphrodite';9:g:='Apollo';10:g:='Arachne';11:g:='Ares';12:g:='Artemis';13:g:='Athena';14:g:='Awilix';15:g:='Bacchus';16:g:='Bakasura';17:g:='Bastet';18:g:='Bellona';19:g:='Cabracan';20:g:='Chaac';21:g:='Chang"e';22:g:='Chiron';23:g:='Chronos';24:g:='Cupid';25:g:='Fenrir';26:g:='Freya';27:g:='Geb';28:g:='Guan Yu';29:g:='Hades';30:g:='He Bo';31:g:='Hel';32:g:='Hercules';33:g:='Hou Yi';34:g:='Hun Batz';35:g:='Isis';36:g:='Janus';37:g:='Kali';38:g:='Khepri';39:g:='Kukulkan';40:g:='Kumbhakarna';41:g:='Loki';42:g:='Medusa';43:g:='Mercury';44:g:='Ne Zha';45:g:='Neith';46:g:='Nemesis';47:g:='Nox';48:g:='Nu Wa';49:g:='Odin';50:g:='Osiris';51:g:='Poseidon';52:g:='Ra';53:g:='Rama';54:g:='Ratatoskr';55:g:='Ravana';56:g:='Scylla';57:g:='Serquet';58:g:='Sobek';59:g:='Sol';60:g:='Sun Wukong';61:g:='Sylvanus';62:g:='Thanatos';63:g:='Thor';64:g:='Tyr';65:g:='Ullr';66:g:='Vamana';67:g:='Vulcan';68:g:='Xbalanque';69:g:='Xing Tian';70:g:='Ymir';71:g:='Zeus';72:g:='Zhong kui';
    end;
    e:=e+g+'  ';
    end;
    Label4.Caption:=e;
  end;


end;

end.

