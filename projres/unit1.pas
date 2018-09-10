unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type
  frbtil = record
    x,y:integer;
  end;

  farba = (modra,zlta,oranzova,cervena,fialova,zelena,cyan,non);
  tbl = array [0..9,0..22] of farba;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
var kocka:array [0..3] of frbtil;
  imgg:tbl;
  koc:farba;
  spat:boolean = false;
  novv:boolean = false;
  zrychli:boolean = false;
  koniec:boolean = false;
  kocc:integer;
  skore:integer = 0;
  levell:integer = 10;
  hrddrp:integer = 1;
  intervall:real = 1000;



procedure score(lvl,pointt:integer);
begin
  levell:=levell+lvl;
  if zrychli and (levell mod 10=0) then
     begin
          intervall:=intervall*0.881;
          form1.timer1.interval:=round(intervall);
          zrychli:=false;
     end;
  skore:=skore+pointt*levell div 10;
  form1.Label1.caption:='SCORE: '+inttostr(skore);
  form1.Label2.caption:='LEVEL: '+inttostr(levell div 10);
end;

procedure nova;
var farb:integer;
begin
  farb:=kocc;
  spat:=false;
  kocc:=random(7);
  form1.image2.canvas.brush.color:=($E1E1E1);
  form1.image2.canvas.rectangle(0,0,60,60);
  case kocc of
       0:
         with form1.image2.canvas do
         begin
              brush.color:=clblue;
              fillrect(7,15,width-7,height-15);
              brush.color:=($E1E1E1);
              fillrect(7,15,width-22,height-30);
         end;
       1:
         with form1.image2.canvas do
         begin
              brush.color:=clyellow;
              fillrect(15,15,width-15,height-15);
         end;
       2:
         with form1.image2.canvas do
         begin
              brush.color:=($0080FF);
              fillrect(7,15,width-7,height-15);
              brush.color:=($E1E1E1);
              fillrect(22,15,width-7,height-30);
         end;
       3:
         with form1.image2.canvas do
         begin
              brush.color:=clred;
              fillrect(7,15,width-7,height-15);
              brush.color:=($E1E1E1);
              fillrect(7,15,width-37,height-30);
              fillrect(37,30,width-7,height-15);
         end;
       4:
         with form1.image2.canvas do
         begin
              brush.color:=clfuchsia;
              fillrect(7,15,width-7,height-15);
              brush.color:=($E1E1E1);
              fillrect(7,15,width-37,height-30);
              fillrect(37,15,width-7,height-30);
         end;
       5:
         with form1.image2.canvas do
         begin
              brush.color:=clgreen;
              fillrect(7,15,width-7,height-15);
              brush.color:=($E1E1E1);
              fillrect(37,15,width-7,height-30);
              fillrect(7,30,width-37,height-15);
         end;
       6:
         with form1.image2.canvas do
         begin
              brush.color:=claqua;
              fillrect(0,22,width,height-23);
         end;

  end;
  case farb of
       0:
         begin
              koc:=modra;
              kocka[0].x:=4;
              kocka[0].y:=18;
              kocka[1].x:=5;
              kocka[1].y:=18;
              kocka[2].x:=6;
              kocka[2].y:=18;
              kocka[3].x:=6;
              kocka[3].y:=19;
         end;
       1:
         begin
              koc:=zlta;
              kocka[0].x:=4;
              kocka[0].y:=18;
              kocka[1].x:=4;
              kocka[1].y:=19;
              kocka[2].x:=5;
              kocka[2].y:=18;
              kocka[3].x:=5;
              kocka[3].y:=19;
         end;
       2:
         begin
              koc:=oranzova;
              kocka[0].x:=4;
              kocka[0].y:=18;
              kocka[1].x:=5;
              kocka[1].y:=18;
              kocka[2].x:=4;
              kocka[2].y:=19;
              kocka[3].x:=6;
              kocka[3].y:=18;
         end;
       3:
         begin
              koc:=cervena;
              kocka[0].x:=4;
              kocka[0].y:=18;
              kocka[1].x:=5;
              kocka[1].y:=18;
              kocka[2].x:=5;
              kocka[2].y:=19;
              kocka[3].x:=6;
              kocka[3].y:=19;
         end;
       4:
         begin
              koc:=fialova;
              kocka[0].x:=4;
              kocka[0].y:=18;
              kocka[1].x:=5;
              kocka[1].y:=18;
              kocka[2].x:=5;
              kocka[2].y:=19;
              kocka[3].x:=6;
              kocka[3].y:=18;
         end;
       5:
         begin
              koc:=zelena;
              kocka[0].x:=4;
              kocka[0].y:=19;
              kocka[1].x:=5;
              kocka[1].y:=18;
              kocka[2].x:=5;
              kocka[2].y:=19;
              kocka[3].x:=6;
              kocka[3].y:=18;
         end;
       6:
         begin
              koc:=cyan;
              kocka[0].x:=3;
              kocka[0].y:=19;
              kocka[1].x:=4;
              kocka[1].y:=19;
              kocka[2].x:=5;
              kocka[2].y:=19;
              kocka[3].x:=6;
              kocka[3].y:=19;
         end;
  end;
  if imgg[5,18]<>non then
  begin
    form1.timer1.enabled:=false;
    koniec:=true;
    Form1.Label3.caption:='GAME OVER';
  end;
  novv:=true;
end;

procedure vymaz;
var i:integer;
begin
  with form1.image1.canvas do
  begin
    brush.color:=clwhite;
    for i:=0 to 3 do
      fillrect(kocka[i].x*20,form1.image1.height-20*(kocka[i].y+1),
      (kocka[i].x+1)*20,form1.image1.height-kocka[i].y*20);
  end;
end;
procedure kresli;
var i:integer;
begin
  with form1.image1.canvas do
  begin
    case koc of
           modra:brush.color:=clblue;
           zlta:brush.color:=clyellow;
           oranzova:brush.color:=($0080FF);
           cervena:brush.color:=clred;
           fialova:brush.color:=clfuchsia;
           cyan:brush.color:=claqua;
           zelena:brush.color:=clgreen;
      end;
    for i:=0 to 3 do
    rectangle(kocka[i].x*20,form1.image1.height-20*(kocka[i].y+1),
    (kocka[i].x+1)*20,form1.image1.height-kocka[i].y*20);
  end;
end;

procedure otoc;
var temp:array [0..3] of frbtil;
  i,j:integer; outt:boolean;
begin
  outt:=false;
  if (koc<>zlta) then
     begin
          for i:=0 to 3 do
              begin
                   temp[i].x:=kocka[1].x+kocka[i].y-kocka[1].y;
                   temp[i].y:=kocka[1].y-kocka[i].x+kocka[1].x;
              end;
     end;
  if (koc in [zelena,cervena,cyan]) and spat then
     begin
          for j:=0 to 1 do
              for i:=0 to 3 do
                  begin
                       temp[i].x:=kocka[1].x-kocka[i].y+kocka[1].y;
                       temp[i].y:=kocka[1].y+kocka[i].x-kocka[1].x;
                  end;
     end;
  if koc=zlta then
     for i:=0 to 3 do
         begin
              temp[i].x:=kocka[i].x;
              temp[i].y:=kocka[i].y;
         end;
  for i:=0 to 3 do
      while temp[i].x<0 do
         for j:=0 to 3 do
             temp[j].x:=temp[j].x+1;
      while temp[i].x>9 do
         for j:=0 to 3 do
             temp[j].x:=temp[j].x-1;
  for i:=0 to 3 do
      if imgg[temp[i].x,temp[i].y]<>non then
         begin
              outt:=true;
              exit;
         end;
  if not outt then
     begin
          vymaz;
          for i:=0 to 3 do
              begin
                   kocka[i].x:=temp[i].x;
                   kocka[i].y:=temp[i].y;
              end;
          kresli;
     end;
  if spat then spat:=false
  else spat:=true;
end;
procedure posun(vpravo:boolean);
var i:integer;
  temp:array [0..3] of integer;
  outt:boolean;
begin
  if vpravo then
     for i:=0 to 3 do
         begin
              temp[i]:=kocka[i].x+1;
              outt:=(temp[i]>9) or (imgg[temp[i],kocka[i].y]<>non);
              if outt then exit;
         end
  else
      for i:=0 to 3 do
          begin
               temp[i]:=kocka[i].x-1;
               outt:=(temp[i]>9) or (imgg[temp[i],kocka[i].y]<>non);
               if outt then exit;
          end;
  if not outt then
     begin
          vymaz;
          for i:=0 to 3 do
              kocka[i].x:=temp[i];
          kresli;
     end;
end;

procedure nakresli;
var i,j:integer;
begin
  form1.image1.canvas.brush.color:=clwhite;
  form1.image1.canvas.fillrect(form1.clientrect);
  for i:=0 to 9 do
  begin
    for j:=0 to 22 do
      with form1.image1.canvas do
      begin
      case imgg[i,j] of
           modra:brush.color:=clblue;
           zlta:brush.color:=clyellow;
           oranzova:brush.color:=($0080FF);
           cervena:brush.color:=clred;
           fialova:brush.color:=clfuchsia;
           cyan:brush.color:=claqua;
           zelena:brush.color:=clgreen;
      end;
      if not (imgg[i,j]=non) then
      rectangle(i*20,form1.image1.height-20*(j+1),(i+1)*20,
      form1.image1.height-j*20);
      end;
  end;
  hrddrp:=1;
end;
procedure lajn;
var x,i,j,k,tmp:integer;
begin
  tmp:=0;
  x:=0;
  j:=kocka[1].y-3;
  repeat
      begin
           tmp:=0;
           for i:=0 to 9 do
               if imgg[i,j]<>non then
               inc(tmp);
           if tmp=10 then
              begin
                   zrychli:=true;
                   inc(x);
                   for i:=j to 18 do
                     for k:=0 to 9 do
                       imgg[k,i]:=imgg[k,i+1];
                   for i:=0 to 3 do
                   j:=j-1;;
              end;
           inc(j);
      end;
  until j=kocka[1].y+2;
  case x of
       1:score(x,100);
       2:score(x,300);
       3:score(x,500);
       4:score(x,800);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,j:integer;  g:boolean;
begin
  score(0,hrddrp);
  novv:=false;
  g:=false;
  for i:=0 to 3 do
  begin
    if (imgg[kocka[i].x,kocka[i].y-1]<>non) or (kocka[i].y=0) then
    begin
      g:=true;
      for j:=0 to 3 do
        if imgg[kocka[j].x,kocka[j].y]=non then
        imgg[kocka[j].x,kocka[j].y]:=koc;
      lajn;
      nakresli;
      nova;
      kresli;
    end;
  end;
  if not g then
  begin
    vymaz;
    for i:=0 to 3 do
    kocka[i].y:=kocka[i].y-1;
    kresli;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var o,p:integer;
begin
  randomize;
  spat:=false;
  novv:=false;
  zrychli:=false;
  timer1.enabled:=true;
  koniec:=false;
  skore:=0;
  levell:=10;
  hrddrp:=1;
  intervall:=1000;
  kocc:=random(7);
  image1.canvas.brush.Color:=clwhite;
  image1.canvas.fillrect(clientrect);
  image2.canvas.fillrect(clientrect);
  begin
       for o:=0 to 10 do
           for p:=0 to 22 do
               imgg[o,p]:=non;
  end;
  nova;
  nakresli;
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word);
var i:integer;
begin
  if not koniec then
  case Key of                                 //up=38   left=37 right=39 down=40   32=space
       38:otoc;
       39:posun(true);
       37:posun(false);
       40:Timer1Timer(Application);
       32:begin
               hrddrp:=2;
               repeat
                     Timer1Timer(Application);
               until novv;
       end;
       $50:if timer1.enabled then begin
             timer1.enabled:=false;
             with image1.canvas do
                  begin
                       pen.color:=clsilver;
                       i:=height+width;
                       repeat
                       begin
                       moveto(0,i);
                       lineto(width,i-width);
                       dec(i,15);
                       end;
                       until i<=0;
                       pen.color:=clblack;
                  end;
         end
            else
                begin
                     timer1.enabled:=true;
                     nakresli;
                     kresli;
                end;
  end;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  FormCreate(Application);
  Label1.caption:='SCORE: ';
  Label2.caption:='LEVEL: ';
  Label3.caption:='';
  skore:=0;
  nova;
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  Timer1.Destroy;
  Application.Terminate;
end;

end.

