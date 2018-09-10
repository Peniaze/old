unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
 X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  sirka:integer = 30;
  vyska:integer = 16;
  pocetmin:integer = 99;

implementation


{$R *.lfm}
var revealed:array of array of boolean;
    miny:array of array of integer;
    tagged:array of array of boolean;
    start,game:boolean;
    tim,revealedcount,minyy:integer;


procedure inttotim(numb:integer;img:Timage);
var pic:TBitmap; x:string; i:integer;
begin
     x:=inttostr(numb);
     if numb<10 then
        x:='00'+x
        else
           if numb<100 then
              x:='0'+x;
     pic:=TBitmap.create;
     for i:=0 to 2 do
         begin
              pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'digit\'+x[i+1]+'.bmp');
              img.canvas.draw(21*i,0,pic);
         end;
     pic.Destroy;
end;
procedure win;
var n,o:integer; pic:TBitmap;
begin
  form1.Timer1.enabled:=false;
  game:=false;
  pic:=TBitmap.create;
  pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\flag.bmp');
  for n:=0 to (sirka-1) do
      for o:=0 to (vyska-1) do
          if not tagged[n,o] and (miny[n,o]>8) then
             form1.image1.canvas.draw(n*20+1,o*20+1,pic);
  pic.destroy;
  ShowMessage('woohooo');
end;

procedure gameover;
var pic:TBitmap; n,o:integer;
begin
  form1.Timer1.enabled:=false;
  game:=false;
  pic:=TBitmap.create;
  pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\ded.bmp');
  form1.Image2.canvas.draw(0,0,pic);
  pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\minaa.bmp');
  for n:=0 to (sirka-1) do
      for o:=0 to (vyska-1) do
          if not tagged[n,o] and (miny[n,o]>8) then
             form1.image1.canvas.draw(n*20+1,o*20+1,pic);
  pic.destroy;
end;
procedure kresli(x,y:integer);
var pic:TBitmap;
begin
  if not revealed[x,y] then
  begin
       revealed[x,y]:=True;
       revealedcount:=revealedcount+1;
       if miny[x,y]=0 then
       begin
            form1.image1.canvas.brush.color:=clgray;
            form1.image1.canvas.fillrect(x*20+1,y*20+1,(x+1)*20,(y+1)*20);
            form1.image1.canvas.brush.color:=($C8C8C8);
       end
       else
       begin
            pic:=TBitmap.Create;
            pic.LoadFromFile(ExtractFilePath(ParamStr(0))+'pics\'+inttostr(miny[x,y])+'.bmp');
            form1.image1.canvas.Draw(x*20+1,y*20+1,pic);
            pic.Destroy;
       end;
       if (revealedcount+minyy)=(sirka*vyska) then
       win;
  end;
end;

procedure skumaj(x,y:integer);
var n,o:integer;
begin
  if (not revealed[x,y]) and (miny[x,y]<9) then
begin
  kresli(x,y);
  for n:=-1 to 1 do
      for o:=-1 to 1 do
          if ((x+n)>=0) and ((x+n)<=(sirka-1)) and ((y+o)>=0) and ((y+o)<=(vyska-1)) then
             if miny[x+n,y+o]>0 then
                kresli(x+n,y+o)
             else
                skumaj(x+n,y+o);

end;
end;
procedure reset(pos1,pos2:integer);
var i,x,y,n,o:integer;
begin
  revealedcount:=0;
  form1.timer1.enabled:=True;
  game:=true;
  start:=true;
  setlength(miny,sirka);
  setlength(revealed,sirka);
  setlength(tagged,sirka);
     for n:=0 to (sirka-1) do
         begin
              setlength(miny[n],vyska);
              setlength(revealed[n],vyska);
              setlength(tagged[n],vyska);
              for o:=0 to (vyska-1) do
              begin
                   revealed[n,o]:=False;
                   tagged[n,o]:=False;
              end;
              if pocetmin<sirka*vyska div 2 then
              for o:=0 to (vyska-1) do
                  miny[n,o]:=0
              else
              for o:=0 to (vyska-1) do
                  miny[n,o]:=9;
          end;
     i:=0;
  if pocetmin<sirka*vyska div 2 then
  repeat
      begin
        x:=random(sirka);
        y:=random(vyska);
        if (miny[x,y]<9) and (x<>pos1) and (y<>pos2) then
           begin
                i:=i+1;
                miny[x,y]:=9;
                for n:=-1 to 1 do
                    for o:=-1 to 1 do
                        if ((x+n)>=0) and ((x+n)<=(sirka-1)) and ((y+o)>=0) and ((y+o)<=(vyska-1)) then
                          miny[x+n,y+o]:=miny[x+n,y+o]+1;
           end
      end;
  until i=pocetmin
  else
  begin
  i:=i+1;
  miny[pos1,pos2]:=miny[pos1,pos2]-1;
  while i<>sirka*vyska-pocetmin do
      begin
        x:=random(sirka);
        y:=random(vyska);
        if (miny[x,y]>8) then
           begin
                i:=i+1;
                miny[x,y]:=miny[x,y]-1;
                for n:=-1 to 1 do
                    for o:=-1 to 1 do
                        if ((x+n)>=0) and ((x+n)<=(sirka-1)) and ((y+o)>=0) and ((y+o)<=(vyska-1)) then
                           if miny[x+n,y+o]<9 then
                          miny[x+n,y+o]:=miny[x+n,y+o]-1;
           end
      end;
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  randomize;
  revealedcount:=0;
  game:=true;
  minyy:=pocetmin;
  inttotim(pocetmin,image3);
  inttotim(tim,image4);
  form1.Width:=sirka*20;
  form1.height:=vyska*20+60;
  image1.width:=sirka*20;
  image1.Picture.Bitmap.Width:=sirka*20;
  image1.height:=vyska*20;
  image1.picture.bitmap.height:=vyska*20;
  image2.left:=sirka*10-20;
  image4.left:=sirka*20-73;
  with image1.canvas do
       begin
         image1.canvas.brush.color:=($C8C8C8);
         fillrect(0,0,sirka*20,vyska*20);
         for i:=0 to vyska do
             begin
               moveto(0,i*20);
               lineto(sirka*20,i*20);
             end;
         for i:=0 to sirka do
             begin
               moveto(i*20,0);
               lineto(i*20,vyska*20);
             end;
       end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
 X, Y: Integer);
var xx,yy:integer; pic:TBitmap;
begin
  if game then
  begin
  xx:=X div 20;
  yy:=Y div 20;
  if not start then
    reset(xx,yy);
  if (Button=mbLeft) and not (revealed[xx,yy]) and not (tagged[xx,yy]) then
     begin
       if miny[xx,yy]>8 then
          begin
          gameover;
          pic:=TBitmap.create;
          pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\mina.bmp');
          image1.canvas.Draw(xx*20+1,yy*20+1,pic);
          pic.destroy;
          end
       else
          if miny[xx,yy]>0 then
             kresli(xx,yy)
          else
             skumaj(xx,yy);
     end;
  if (Button=mbRight) and not revealed[xx,yy] then
     begin
       if not tagged[xx,yy] and (pocetmin>0) then
          begin
               tagged[xx,yy]:=True;
               pocetmin:=pocetmin-1;
               inttotim(pocetmin,image3);
               with image1.canvas do
                    begin
                         pic:=TBitmap.create;
                         pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\flag.bmp');
                         image1.canvas.draw(xx*20+1,yy*20+1,pic);
                         pic.destroy;
                    end

          end
       else
       if tagged[xx,yy] then
           begin
                tagged[xx,yy]:=False;
                pocetmin:=pocetmin+1;
                inttotim(pocetmin,image3);
                image1.canvas.fillrect(xx*20+1,yy*20+1,xx*20+19,yy*20+19);
           end;
     end;
  end;
end;


procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton);
var pic:TPicture;
begin
  if Button=mbLeft then
     begin
          pic:=TPicture.Create;
          pic.LoadFromFile(Extractfilepath(ParamStr(0))+'pics\o.bmp');
          image2.picture:=pic;
          pic.destroy;
     end;
end;

procedure TForm1.Image2MouseUp(Sender: TObject; Button: TMouseButton);
var pic:TPicture;
begin
   if Button=mbLeft then
      begin
           pic:=TPicture.create;
           pic.LoadFromFile(Extractfilepath(ParamStr(0))+'pics\happy.bmp');
           image2.picture:=pic;
           pic.destroy;
           pocetmin:=minyy;
           tim:=0;
           Form1.FormCreate(image2);
           start:=false;
      end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var opt:TForm2;
begin
     timer1.enabled:=false;
     opt:=TForm2.create(Application);
     try
       opt.ShowModal;
     finally
       opt.Free;
       Form1.FormCreate(Application);
       start:=false;
     end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     tim:=tim+1;
     inttotim(tim,image4);
end;

end.

