unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LCLType, StdCtrls, math;

type
  tladder = array [0..9] of integer;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    title: TLabel;
    main: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word);
    procedure FormKeyUp(Sender: TObject; var Key: Word);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure mainTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var tempo,a,ball,ba1,ba2,b1,b2,x1,x2,y1,y2,u1,u2,s2,s1,sZ,v,MP,MPc,sc1,sc2,slo,bump,pwrn,time1,time2,limit,score,aimbot,spawn,p1,p2,poweruptime:integer; o1,o2,s1border,s2border,s1topbot,s2topbot:real; powerup,over,reactiv,menur:boolean;
  Form1: TForm1;

implementation
function readfromfile:tladder;
var salto:text;
  j,l,i:integer;
  one,path:string;
  temp:real;
  letter:array [1..5] of integer;
begin
  temp:=0;
  path:=extractfiledir(ParamStr(0));
  assignfile(salto,path+'\salto.txt');
  reset(salto);
  for i:=0 to 9 do
  begin
    readln(salto,one);
    for j:=0 to (length(one) div 5)-1 do
    begin
      for l:=1 to 5 do
      letter[l]:=ord(one[j*5+l]);
      if letter[1]+letter[2]+letter[3]+letter[4]+letter[5]=j+230 then
      temp:=temp+intpower(2,j) else
      if not letter[1]+letter[2]+letter[3]+letter[4]+letter[5]=j+231 then
      begin
        ShowMessage('chyba');
        halt;
      end;
    end;
    readfromfile[i]:=trunc(temp);
    temp:=0;
    one:='';
  end;
  closefile(salto);
end;

procedure highscore;
var salto:text;
  i,k,m,z1,z2,z3,z4,z5:integer;
  path:string;
  scoreC:tladder;
  bin:array [0..15] of boolean;
  txt:array [0..15] of string;
begin
  path:=extractfiledir(ParamStr(0));
  assignfile(salto,path+'\salto.txt');
  scoreC:=readfromfile;
  k:=-1;
  while a>scoreC[k+1] do
    k:=k+1;
  for i:=0 to k-1 do
  scoreC[i]:=scoreC[i+1];
  if (k>-1) and (not menur) then
  begin
    rewrite(salto);
    scoreC[k]:=a;
    for i:=0 to 9 do
    begin                                     ////////
    m:=0;
    repeat
    begin
      bin[m]:=scoreC[i] mod 2=1;
      scoreC[i]:=scoreC[i] div 2;
      if bin[m] then
      begin
      repeat
      begin
        z1:=random(192)+33;
        z2:=random(192)+33;
        z3:=random(192)+33;
        z4:=random(192)+33;
        z5:=random(192)+33;
      end;
      until z1+z2+z3+z4+z5=m+230;
      end
      else
      begin
      repeat
      begin
        z1:=random(192)+33;
        z2:=random(192)+33;
        z3:=random(192)+33;
        z4:=random(192)+33;
        z5:=random(192)+33;
      end;
      until z1+z2+z3+z4+z5=m+231;
      end;
      txt[m]:=chr(z1)+chr(z2)+chr(z3)+chr(z4)+chr(z5);
      m:=m+1;
    end;

    until scoreC[i]=0;                                                        ////
    writeln(salto,txt[0]+txt[1]+txt[2]+txt[3]+txt[4]+txt[5]+txt[6]+txt[7]+txt[8]+txt[9]+txt[10]+txt[11]+txt[12]+txt[13]+txt[14]+txt[15]);
    end;
    closefile(salto);
  end;
end;

procedure singleplayer;
var c1,c2:real; milestone,i:integer; //stemp,sstemp:integer;
begin
  //stemp:=s2;
  //sstemp:=s1;
  o1:=o1-(s1-o1)*10/sqrt((sqr(s2-o2)+sqr(s1-o1)));
  o2:=o2-(s2-o2)*10/sqrt((sqr(s2-o2)+sqr(s1-o1)));
  i:=0;
  repeat
    begin
      o1:=o1+(s1-o1)*0.005/sqrt((sqr(s1-o1)+sqr(s2-o2)));
      o2:=o2+(s2-o2)*0.005/sqrt((sqr(s1-o1)+sqr(s2-o2)));
      i:=i+1;
      if i>10000 then exit;
    end;
  until round(sqr(o1-ba1)+sqr(o2-ba2))<=2501;
  c1:=((o2-s2)*(o2-ba2)*(o1-ba1)+s1*sqr(o2-ba2)+o1*sqr(o1-ba1))/(sqr(o2-ba2)+sqr(o1-ba1));
  c2:=((o1-s1)*(o1-ba1)*(o2-ba2)+s2*sqr(o1-ba1)+o2*sqr(o2-ba2))/(sqr(o1-ba1)+sqr(o2-ba2));
  s1:=round(2*c1-s1);
  s2:=round(2*c2-s2);
  s1:=round(s1+(s1-o1)*100);
  s2:=round(s2+(s2-o2)*100);
  if s2>o2 then v:=1 else v:=0;
  a:=a+score;
  i:=0;
  milestone:=readfromfile[0];
  while (a>readfromfile[i]) and (i<10) do
  begin
    i:=i+1;
    milestone:=readfromfile[i];
  end;
  form1.image5.canvas.Rectangle(10,580,320,610);
  form1.image5.canvas.textout(10,580,'Points: '+inttostr(a)+'       //      '+inttostr(milestone)+' points to get #'+inttostr(10-i));
  if i=10 then
  with form1.image5.canvas do
  begin
    Rectangle(10,580,320,610);
    textout(10,580,'Points: '+inttostr(a)+'       //      You hit #1!');
  end;
  with form1.image5.canvas.brush do
  case i of
        0..6:color:=clblack;
        8:color:=$000066AA;
        9:color:=clsilver;
        10:color:=clyellow;
  end;
  form1.image5.canvas.Ellipse(305,575,335,605);
  form1.image5.canvas.brush.color:=clblack;
  ball:=0;
  bump:=0;
  //form1.main.enabled:=false;
  //ShowMessage('a1='+inttostr(sstemp)+' a2='+inttostr(stemp)+' b1='+floattostr(o1)+' b2='+floattostr(o2)+' s1='+inttostr(ba1)+' s2='+inttostr(ba2)+' x1='+floattostr(c1)+' x2='+floattostr(c2)+' X='+inttostr(s1)+' y='+inttostr(s));
end;
procedure powericon;
begin
  form1.image5.canvas.rectangle(85,5,180,30);
  case pwrn of
        1:form1.image5.canvas.Textout(85,5,'earthquake');
        2:form1.image5.canvas.Textout(85,5,'2x');
        3:form1.image5.canvas.Textout(85,5,'aimbot');
        4:form1.image5.canvas.Textout(85,5,'random');
        5:form1.image5.canvas.textout(85,5,'helpline');
        6:form1.image5.canvas.textout(85,5,'slowmotion');
  end;
  if pwrn=3 then form1.image5.canvas.Brush.color:=clred;
  form1.image5.canvas.FillRect(0,40,5,570);
  form1.image5.canvas.brush.color:=clblack;
end;
procedure powerreset;
begin
  time1:=0;
  time2:=0;
  form1.image1.top:=40;
  form1.image1.left:=5;
  score:=1;
  aimbot:=0;
  limit:=0;
  tempo:=7;
  powericon;
end;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
  main.enabled:=False;
  Image1.Visible:=False;
  label3.visible:=false;
  label4.visible:=false;
  label5.visible:=false;
  Image5.canvas.font.color:=clwhite;
  Image5.canvas.font.Bold:=true;
  Image5.canvas.font.Size:=12;
  image1.Top:=40;
  image1.left:=5;
  MP:=0;
  MPc:=0;
  s2:=random(530);
  sZ:=0;
  if s2<=300 then v:=0 else v:=1;
  o1:=10;
  o2:=265;
  x1:=0;
  x2:=0;
  b1:=265;
  y1:=0;
  y2:=0;
  b2:=265;
  sc1:=0;
  sc2:=0;
  slo:=0;
  ball:=0;
  ba1:=0;
  ba2:=0;
  a:=0;
  s1:=620;
  pwrn:=0;
  powericon;
  bump:=0;
  time1:=0;
  time2:=0;
  limit:=0;
  score:=1;
  aimbot:=0;
  poweruptime:=0;
  spawn:=39;
  tempo:=7;
  powerup:=false;
  menur:=false;
  with image5.canvas do
  begin
    Brush.color:=clwhite;
    FillRect(0,0,305,610);
    brush.color:=clblack;
    FillRect(305,0,610,610);
    fillrect(200,76,400,194);
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word);
begin
   if Key=VK_M then
    x1:=1;
   if Key=VK_K then
    x2:=1;
   if Key=VK_Y then
    y1:=1;
   if Key=VK_A then
    y2:=1;
   if Key=VK_P then
   begin
     if main.enabled then main.enabled:=false
     else main.enabled:=true;
     with Image1.canvas do
     begin
       font.color:=clgray;
       font.Size:=64;
       brush.color:=clwhite;
       textout(image1.width div 2-104,image1.Height div 2-52,'Pause');
       brush.color:=clblack;
       font.color:=clblack;
       font.size:=24;
     end;
   end;
   if (Key=VK_T) and (not over) and (not main.enabled) then begin
     o1:=300;
     o2:=265;
     s1:=620;
     s2:=random(80)+225;
     main.enabled:=True;
     reactiv:=true;
     b1:=265;
     b2:=265;
     x1:=0;
     x2:=0;
     y1:=0;
     y2:=0;
     ball:=0;
     pwrn:=0;
     powerreset;
     bump:=0;
     powerup:=false;
   end;
   if (Key=VK_U) and (not main.enabled) then FormCreate(title);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word);
begin
  if Key=VK_M then x1:=0;
  if Key=VK_K then x2:=0;
  if (Key=VK_Y) and (MPc=1) then y1:=0;
  if (Key=VK_A) and (MPc=1) then y2:=0;
end;

procedure TForm1.Label1Click(Sender: TObject);               //1 Player
begin
  Image1.Visible:=True;
  main.enabled:=True;
  Image5.canvas.fillrect(clientrect);
  Image5.canvas.TextOut(425,5,'Press "U" for menu.');
  Image5.canvas.textout(425,580,'Controls: "M"=↓ "K"=↑');
  MP:=1;
  label3.visible:=true;
  label4.visible:=true;
  label5.visible:=true;
  label3.caption:=inttostr(sc1);
  label4.caption:=inttostr(sc2);
end;                                                         //

procedure TForm1.Label2Click(Sender: TObject);                //2 Player
begin
  Image1.visible:=true;
  main.enabled:=true;
  image5.canvas.fillrect(clientrect);
  Image5.canvas.TextOut(425,5,'Press "U" for menu.');
  image5.canvas.textout(10,580,'Player2: "Y"=↓ "A"=↑');
  image5.canvas.textout(425,580,'Player1: "M"=↓ "K"=↑');
  MP:=1;
  MPc:=1;
  label3.visible:=true;
  label4.visible:=true;
  label5.visible:=true;
  label3.caption:=inttostr(sc1);
  label4.caption:=inttostr(sc2);
end;                                                          //

procedure TForm1.Label6Click(Sender: TObject);                 //Collect mode
begin
  Label7Click(Label6);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  Image1.visible:=true;
  image5.canvas.fillrect(clientrect);
  main.enabled:=true;
  MP:=0;
  with image5.canvas do
  begin
    textout(10,580,'Points: '+inttostr(a)+'       //      '+inttostr(readfromfile[0])+' points to get #10');
    textout(375,5,'Fails:');
    TextOut(425,580,'Press "U" for menu.');
    textout(10,5,'Powerup:');
  end;
end;                                                             //

procedure TForm1.Label8Click(Sender: TObject);
var highsc:tladder; i:integer;
begin
  menur:=true;
  image1.visible:=true;
  highsc:=readfromfile;                                          //22,52    24,240,80
  with image1.canvas do
    begin
      brush.color:=clwhite;
      fillrect(clientrect);
      font.Bold:=true;
      font.Size:=32;
      for i:=0 to 9 do
      begin
        font.color:=clblack;
        case i of
              9:brush.color:=clyellow;
              8:brush.color:=clsilver;
              7:brush.color:=$000066AA;
              else brush.color:=clwhite;
        end;
        case highsc[i] of
              0..9:textout(image1.width div 2-12,image1.Height-5-(i+1)*52,inttostr(highsc[i]));
              10..99:textout(image1.width div 2-24,image1.Height-5-(i+1)*52,inttostr(highsc[i]));
              100..999:textout(image1.width div 2-36,image1.Height-5-(i+1)*52,inttostr(highsc[i]));
              1000..9999:textout(image1.width div 2-48,image1.Height-5-(i+1)*52,inttostr(highsc[i]));
              10000..65535:textout(image1.width div 2-60,image1.Height-5-(i+1)*52,inttostr(highsc[i]));
        end;
        brush.color:=clwhite;
        font.color:=clmedgray;
        textout(5,image1.height-6-(i+1)*52,inttostr(10-i)+'.');
      end;
      font.orientation:=750;
      textout(380,image1.height-90,'Press "U" to return.');
      font.color:=clblack;
      font.orientation:=0;
    end;
  image5.canvas.fillrect(clientrect);
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  halt;
end;


procedure TForm1.mainTimer(Sender: TObject);
begin
  u1:=round(o1);
  u2:=round(o2);
  Image1.canvas.brush.color:=clwhite;
  Image1.canvas.FillRect(clientrect);
  Image1.canvas.Brush.color:=clblack;
  Image1.canvas.rectangle(590,b1-45,600,b1+45);              //obdĺžniky
  if (b1>50) and (x2=1) then b1:=b1-4;
  if (b1<480) and (x1=1) then b1:=b1+4;
  if MP=1 then begin
    Image1.canvas.rectangle(0,b2-45,10,b2+45);
    if (b2>50) and (y2=1) then b2:=b2-4;
    if (b2<480) and (y1=1) then b2:=b2+4;
  end;                                                         //
  if (MP=1) and (MPc=0) then begin                             //AI
    slo:=slo+1;
      if slo>9 then begin
      if (s2>530) and (s1=-20) then sZ:=1060-s2+random(200)-100;
      if (s2<0) and (s1=-20) then sZ:=s2*(-1)+random(200)-100;
      if (s1=-20) and (s2>=0) and (s2<=530) then sZ:=s2+random(200)-100;
      if s1=620 then sZ:=265+random(200)-100;
      slo:=0;
    end;
    if sZ<b2 then y2:=1 else y2:=0;
    if sZ>b2 then y1:=1 else y1:=0;
  end;                                                           //
  Image1.canvas.Rectangle(u1-5,u2-5,u1+5,u2+5);                  //loptička//
  if reactiv then
  begin
    sleep(200);
    reactiv:=false;
  end;
  case spawn of                                                   //powerup
        0:image1.canvas.brush.color:=clyellow;
        1:image1.canvas.brush.color:=clgreen;
        2:image1.canvas.brush.color:=clblue;
        3:image1.canvas.brush.color:=clred;
        4:image1.canvas.brush.color:=cllime;
        5:image1.canvas.brush.color:=clfuchsia;
  end;
  if powerup=true then
   begin
     image1.canvas.EllipseC(p1,p2,20,20);
     if sqr(o1-p1)+sqr(o2-p2)<=400 then
     begin
       powerup:=false;
       pwrn:=spawn+1;
       powerreset;
     end;
     poweruptime:=poweruptime+1;
     if poweruptime=2000 then
     begin
       poweruptime:=0;
       powerup:=false;
     end;
   end;
  if (ball=1) and (MP=0) then begin                        //Collect mode
    image1.canvas.brush.color:=claqua;
    Image1.canvas.EllipseC(ba1,ba2,50,50);
    image1.canvas.brush.color:=clblack;
    if (sqr(o1-ba1)+sqr(o2-ba2))<=2500 then singleplayer;
  end;
  if (bump=2) and (MP=0) and (ball=0) then ball:=1;
  if (bump=4) and (MP=0) then
  begin
    s1:=-20;
    s2:=265;
    bump:=0;
    pwrn:=random(5)+1;
    powerreset;
  end;
  if pwrn>0 then
  begin
    time1:=time1+1;
    if time1=limit then
    begin
      pwrn:=0;
      powerreset;
    end;
    case pwrn of
         1:begin
           time2:=time2+1;
           if time2=4 then
           begin
             image1.top:=40+random(19)-10;
             image1.Left:=5+random(19)-10;
             time2:=0;
             limit:=1000;
           end;
         end;
         2:begin
           limit:=3000;
           score:=2;
         end;
         3:begin
           limit:=2000;
           aimbot:=1;
         end;
          4:begin
          time2:=time2+1;
          if time2=2 then
          begin
            ba1:=ba1+random(20)-10;
            ba2:=ba2+random(20)-10;
            time2:=0;
          end;
            if ba1 or ba2<0 then
            begin
              ba1:=ba1+10;
              ba2:=ba2+10;
            end;
            if ba2>530 then
            ba2:=ba2-10;
            limit:=1000;
          end;
          5:begin
            if (s1-o1)>0 then
            begin
              image1.canvas.pen.color:=clsilver;
              image1.canvas.MoveTo(u1,u2);
              image1.canvas.lineto(s1,s2);
              s1border:=o1;
              s2border:=o2;
              s1topbot:=o1;
              s2topbot:=o2;
              repeat
                begin
                  s1border:=s1border+(s1-s1border)*7/sqrt((sqr(s2-s2border)+sqr(s1-s1border)));
                  s2border:=s2border+(s2-s2border)*7/sqrt((sqr(s2-s2border)+sqr(s1-s1border)));
                end;
              until s1border>=585;
              if sqr(s2border-b1)<2025 then
              begin
                image1.canvas.moveto(round(s1border),round(s2border));
                image1.canvas.lineto(-20,round(b1+(s2border-b1)*18));
              end;
              if (s2<0) or (s2>530) then
              begin
                repeat
                  s1topbot:=s1topbot+(s1-s1topbot)*7/sqrt((sqr(s2-s2topbot)+sqr(s1-s1topbot)));
                  s2topbot:=s2topbot+(s2-s2topbot)*7/sqrt((sqr(s2-s2topbot)+sqr(s1-s1topbot)));
                until (s2topbot<0) or (s2topbot>530);
                image1.canvas.MoveTo(round(s1topbot),round(s2topbot));
                if s2topbot<0 then
                image1.canvas.lineto(s1,s2*(-1))
                else image1.canvas.lineto(s1,1060-s2);
              end;
              image1.canvas.pen.color:=clblack;
              image1.canvas.Brush.color:=clblack;
              Image1.canvas.rectangle(590,b1-45,600,b1+45);
            end;
            limit:=3000;
          end;
          6:begin
            tempo:=4;
            limit:=1000;
          end;
    end;
  end;                                                                                 //
  if (MP=1) and ((o1<=7) and ((o2<(b2-45)) or (o2>(b2+45)))) then begin  //Kolízia vľavo
    main.enabled:=false;
    sc1:=sc1+1;
    over:=sc1=10;
    with image1.canvas do
    begin
      font.color:=clblack;
      font.Bold:=true;
      font.Size:=12;
      brush.color:=clwhite;
      if sc1<10 then textout(200,200,'Press "T" to reset the ball.')
      else
        begin
          textout(235,180,'Player one wins.');
          textout(170,200,'Press "U" to return to main menu.');
        end;
    end;
    Label4.Caption:=inttostr(sc1);
  end;                                                                      //
  if (MP=0) and ((o1>=593) and ((o2>(b1+45)) or (o2<b1-45))) then begin    //Kolízia vpravo
    main.enabled:=false;
    sc2:=sc2+1;
    over:=sc2=3;
    if over then highscore;
    with image5.canvas do
    begin
      Pen.color:=clred;
      pen.width:=5;
      MoveTo(390+sc2*30,10);
      LineTo(410+sc2*30,30);
      moveto(390+sc2*30,30);
      lineto(410+sc2*30,10);
      pen.color:=clblack;
      pen.width:=1;
    end;
    with image1.canvas do
    begin
      font.color:=clblack;
      font.Bold:=true;
      font.Size:=12;
      brush.color:=clwhite;
      if not over then textout(200,70,'Press "T" to reset the ball.')
      else textout(150,70,'You lost. Press "U" to return to main menu.');
    end;
  end;
  if (MP=1) and ((o1>=593) and ((o2>(b1+45)) or (o2<b1-45))) then begin
    main.enabled:=False;
    sc2:=sc2+1;
    over:=sc2=10;
    with image1.canvas do
    begin
      font.color:=clblack;
      font.Bold:=true;
      font.Size:=12;
      brush.color:=clwhite;
      if sc2<10 then textout(200,200,'Press "T" to reset the ball.')
      else
        begin
          textout(235,180,'Player one wins.');
          textout(170,200,'Press "U" to return to main menu.');
        end;
    end;
    label3.caption:=inttostr(sc2);
  end;                                                                      //
                                                                              //základ
    o1:=o1+(s1-o1)*tempo/sqrt((sqr(s2-o2)+sqr(s1-o1)));
    o2:=o2+(s2-o2)*tempo/sqrt((sqr(s2-o2)+sqr(s1-o1)));

                                                                      //
  if (o2>525) and (v=1) then                                          //odraz hore a dole
  begin
    s2:=1060-s2;
    v:=0;
    if ball=0 then
    begin
      ba1:=random(280)+50;
      ba2:=random(465)+25;
    end;
    bump:=bump+1;
    if (random(35)<6) and (MP=0) then
    begin
      p1:=random(540)+30;
      p2:=random(470)+30;
      spawn:=random(6);
      powerup:=true;
      poweruptime:=0;
    end;
  end;
  if (o2<5) and (v=0) then
  begin
    s2:=s2*(-1);
    v:=1;
    if ball=0 then
    begin
      ba1:=random(280)+50;
      ba2:=random(465)+25;
    end;
    bump:=bump+1;
    if (random(35)<6) and (MP=0) then
    begin
      p1:=random(540)+30;
      p2:=random(470)+30;
      spawn:=random(6);
      powerup:=true;
      poweruptime:=0;
    end;
  end;                        //
  if (o1>=585) then begin                                                                       //odraz vpravo
    bump:=0;
    if (o2=b1) then begin s1:=-20; s2:=round(o2); end;
    if (o2<b1) and (o2>=(b1-50)) then begin s1:=-20; s2:=round(b1-((b1-o2)*18)); v:=0; end;
    if (o2>b1) and (o2<=(b1+50)) then begin s1:=-20; s2:=round(b1+((-b1+o2)*18)); v:=1; end;
    if (MP=0) and (ball=0) then begin ball:=1; ba1:=random(280)+50; ba2:=random(465)+25  end;           //
  end;
  if (o1<=15) then begin
    if (MP=1) and (o2=b2) then begin s1:=620; s2:=round(o2); end;                                      //odraz vľavo
    if (MP=1) and (o2<b2) and (o2>=(b2-50)) then begin s1:=620; s2:=round(b2-((b2-o2)*18)); v:=0; end;
    if (MP=1) and (o2>b2) and (o2<=(b2+50)) then begin s1:=620; s2:=round(b2+((-b2+o2)*18)); v:=1; end;
  end;                                                                                                                            //
  if (o1<5) and (MP=0) then begin
    bump:=0;
    s2:=random(1590)-530;
    s1:=620;
    if o2>s2 then v:=0 else v:=1;
    if aimbot=1 then s2:=b1;
    if (ball=0) then begin
      ball:=1;
      ba1:=random(280)+50;
      ba2:=random(465)+25;
    end;
  end;

end;



end.

