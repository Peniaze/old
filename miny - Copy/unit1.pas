unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, StdCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Timer1,Timer2,Timer3: TTimer;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
 X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Fire(Sender: TObject);
    procedure destruc;
  private
    { private declarations }
  public
    { public declarations }
  end;
  TSalto = class(TGraphicControl)
    procedure paint; override;
    constructor create(AOwner: TComponent); override;
  end;
  typobr = 1..11;    //1-8 -> numbers
                       //9 -> flag, 10->mina, 11->minaa

var
  Form1: TForm1;
  sirka:integer = 30;
  vyska:integer = 16;
  pocetmin:integer = 99;

implementation

{$I fireworks.inc}


{$R *.lfm}
var revealed:array of array of boolean;
    miny:array of array of integer;
    tagged:array of array of boolean;
    start,game:boolean;
    tim,revealedcount,minyy:integer;


{$I obrazok.inc}


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
              pic.LoadFromFile('digit\'+x[i+1]+'.bmp');
              img.canvas.draw(21*i,0,pic);
         end;
     pic.Destroy;
end;
procedure win;                                                                //dorobiť
var n,o:integer; pic:TBitmap;
begin
  form1.Timer1.enabled:=false;
  game:=false;
  pic:=TBitmap.create;
  obrazok(pic,9);
  //pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\flag.bmp');
  for n:=0 to (sirka-1) do
      for o:=0 to (vyska-1) do
          if not tagged[n,o] and (miny[n,o]>8) then
             form1.image1.canvas.draw(n*form1.image1.width div sirka+1,
             o*form1.image1.height div vyska+1,pic);
  pic.destroy;
  form1.Label1.caption:='YOU WON!';
  Form1.Fire(nil);
end;

procedure gameover;
var pic:TBitmap; n,o:integer;
begin
  form1.Timer1.enabled:=false;
  game:=false;
  pic:=TBitmap.create;
  pic.LoadFromFile('pics\ded.bmp');
  form1.Image2.canvas.draw(0,0,pic);
  obrazok(pic,11);
  //pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\minaa.bmp');
  for n:=0 to (sirka-1) do
      for o:=0 to (vyska-1) do
          if not tagged[n,o] and (miny[n,o]>8) then
             form1.image1.canvas.draw(n*form1.image1.width div sirka+1,
             o*form1.image1.height div vyska+1,pic);
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
            form1.image1.canvas.fillrect(x*form1.image1.width div sirka+1,
            y*form1.image1.height div vyska+1,(x+1)*form1.image1.width div sirka,
            (y+1)*form1.image1.height div vyska);
            form1.image1.canvas.brush.color:=($C8C8C8);
       end
       else
       begin
            pic:=TBitmap.Create;
            obrazok(pic,miny[x,y]);
            //pic.LoadFromFile(ExtractFilePath(ParamStr(0))+'pics\'+inttostr(miny[x,y])+'.bmp');
            form1.image1.canvas.Draw(x*form1.image1.width div sirka+1,
            y*form1.image1.height div vyska+1,pic);
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
  //---------------------------------
  for n:=-1 to 1 do
      for o:=-1 to 1 do
          if not(((pos1+n)>=0) and ((pos1+n)<=(sirka-1)) and ((pos2+o)>=0) and ((pos2+o)<=(vyska-1))) then
              miny[pos1,pos2]-=1;
  //---------------------------------
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
                        begin
                           if (miny[x+n,y+o]<9) and ((o<>0) or (n<>0)) then
                           begin
                                miny[x+n,y+o]:=miny[x+n,y+o]-1;
                                miny[x,y]-=1;
                           end;
                        end
                        else
                            miny[x,y]-=1;
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
  form1.Width:=sirka*30;
  form1.height:=vyska*30+60;
  form1.Label1.left:=sirka*15-label1.Canvas.textwidth('YOU WON!') div 2;
  form1.label1.top:=vyska*15-label1.Canvas.textheight('YOU WON!') div 2;
  checkbox1.Left:=form1.width div 2+25;
  checkbox2.Left:=checkbox1.Left+checkbox1.Width+5;
  image1.width:=sirka*30;
  image1.Picture.Bitmap.Width:=sirka*30;
  image1.height:=vyska*30;
  image1.picture.bitmap.height:=vyska*30;
  image2.left:=sirka*15-20;
  image4.left:=sirka*30-73;
  with image1.canvas do
       begin
         image1.canvas.brush.color:=($C8C8C8);
         fillrect(0,0,sirka*30,vyska*30);
         for i:=0 to vyska do
             begin
               moveto(0,i*30);
               lineto(sirka*30,i*30);
             end;
         for i:=0 to sirka do
             begin
               moveto(i*30,0);
               lineto(i*30,vyska*30);
             end;
       end;
end;

procedure TForm1.FormChangeBounds(Sender: TObject);
var i:integer;
begin
     if not checkbox1.Checked then
     begin
          revealedcount:=0;
          game:=true;
          minyy:=pocetmin;
          inttotim(pocetmin,image3);
          inttotim(tim,image4);
          form1.height:=form1.height div vyska * vyska;
          if checkbox2.Checked then
             form1.width:=(form1.height-60) div vyska*sirka
          else
              form1.width:=form1.width div sirka * sirka;
          Label1.left:=form1.width div 2-label1.Canvas.textwidth('YOU WON!') div 2;
          label1.top:=form1.height div 2-60-label1.Canvas.textheight('YOU WON!') div 2;
          checkbox1.Left:=form1.width div 2+25;
          checkbox2.Left:=checkbox1.Left+checkbox1.Width+5;
          image1.width:=form1.width;
          image1.Picture.Bitmap.Width:=form1.width;
          image1.height:=form1.height-60;
          image1.picture.bitmap.height:=form1.height-60;
          image2.left:=form1.width div 2-image2.width div 2;
          image4.left:=form1.Width-73;
          with image1.canvas do
               begin
                    image1.canvas.brush.color:=($C8C8C8);
                    fillrect(clientrect);
                    for i:=0 to vyska do
                        begin
                             moveto(0,i*image1.height div vyska);
                             lineto(image1.width,i*image1.height div vyska);
                        end;
                    for i:=0 to sirka do
                        begin
                             moveto(i*image1.width div sirka,0);
                             lineto(i*image1.width div sirka,image1.height);
                        end;
               end;
     end
     else
         begin
              form1.width:=image1.width;
              form1.height:=image1.height+60;
         end;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
     checkbox2.Visible:=not checkbox1.Checked;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
 X, Y: Integer);
var xx,yy,i,j,temp:integer; pic:TBitmap;
begin
  if game then
  begin
  xx:=X div (image1.width div sirka);
  yy:=Y div (image1.height div vyska);
  if not start then
    reset(xx,yy);
  if ((Button=mbMiddle) or (Button=mbLeft)) and revealed[xx,yy] then                                               //todo: zle spravené??? ideas?
     begin
          temp:=0;
          for i:=-1 to 1 do
              for j:=-1 to 1 do
                  if ((xx+i)>=0) and ((xx+i)<=(sirka-1)) and ((yy+j)>=0) and ((yy+j)<=(vyska-1)) then
                     if tagged[xx+i,yy+j] then
                        temp+=1;
          if temp=miny[xx,yy] then
             for i:=-1 to 1 do
              for j:=-1 to 1 do
                  if ((xx+i)>=0) and ((xx+i)<=(sirka-1)) and ((yy+j)>=0) and ((yy+j)<=(vyska-1)) then
                  if not tagged[xx+i,yy+j] then
                     if miny[xx+i,yy+j]>8 then
                        begin
                             gameover;
                             pic:=TBitmap.create;
                             obrazok(pic,10);
                             image1.canvas.Draw((xx+i)*image1.width div sirka+1,(yy+j)*image1.height div vyska+1,pic);
                             pic.destroy;
                        end
                     else
                         if miny[xx+i,yy+j]>0 then
                            kresli(xx+i,yy+j)
                         else
                             skumaj(xx+i,yy+j);
     end;
  if (Button=mbLeft) and not (revealed[xx,yy]) and not (tagged[xx,yy]) then
     begin
       if miny[xx,yy]>8 then
          begin
          gameover;
          pic:=TBitmap.create;
          obrazok(pic,10);
          //pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\mina.bmp');
          image1.canvas.Draw(xx*image1.width div sirka+1,yy*image1.height div vyska+1,pic);
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
                         obrazok(pic,9);
                         //pic.LoadFromFile(ExtractFilepath(ParamStr(0))+'pics\flag.bmp');
                         image1.canvas.draw(xx*image1.width div sirka+1,
                         yy*image1.height div vyska+1,pic);
                         pic.destroy;
                    end

          end
       else
       if tagged[xx,yy] then
           begin
                tagged[xx,yy]:=False;
                pocetmin:=pocetmin+1;
                inttotim(pocetmin,image3);
                image1.canvas.fillrect(xx*image1.width div sirka+1,
                yy*image1.height div vyska+1,(xx+1)*image1.width div sirka,
                (yy+1)*image1.height div vyska);
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
          pic.LoadFromFile('pics\o.bmp');
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
           pic.LoadFromFile('pics\happy.bmp');
           image2.picture:=pic;
           pic.destroy;
           pocetmin:=minyy;
           tim:=0;
           if checkbox1.Checked then
           begin
                checkbox1.Checked:=false;
                Form1.FormChangeBounds(image2);
                checkbox1.checked:=true;
           end
           else
               Form1.FormChangeBounds(image2);
           form1.destruc;
           form1.Label1.Caption:='';
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

