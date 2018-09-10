unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type
ttshp = record
  vx,vy,posx,posy,q:real;
  xtime,ytime:integer;
end;

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
      Shapee: array of TShape;
  end;
  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Form2: TForm2;

implementation

{$R *.lfm}
{$R form2.lfm}
var shp:array of ttshp;
  ax,ay:array of real;
  e1:integer;

procedure TForm2.Button1Click(Sender: TObject);
var i,e2:integer;
begin
  if not trystrtoint(Edit1.text,e1) or not trystrtoint(Edit2.text,e2)
  then
  begin
  ShowMessage('Zlý vstup.');
  exit;
  end;
  e1:=e1*2-1;
  Setlength(shp,e1+1);
  Setlength(ax,e1+1);
  Setlength(ay,e1+1);
  Setlength(Form1.Shapee,e1+1);
  for i:=0 to e1 do
  begin
    Form1.Shapee[i]:=TShape.create(Application);
  with Form1.Shapee[i] do
       begin
         parent:=Form1;
         shape:=stCircle;
         left:=random(form1.image1.width-200)+200;
         top:=random(form1.image1.height-200)+200;
         height:=65;
         width:=65;
       end;
  end;
  for i:=0 to e1 div 2 do
  begin
    Form1.Shapee[i].brush.color:=clblue;
    Form1.Shapee[i+e1 div 2+1].brush.color:=clred;
  end;
  randomize;
  for i:=0 to e1 do
  with shp[i] do
       begin
         posx:=random(Form1.image1.width-400)+200;
         posy:=random(Form1.image1.height-400)+200;
         vx:=0;
         vy:=0;
         q:=e2;
         xtime:=0;
         ytime:=0;
       end;
  for i:=0 to e1 do
  begin
    Form1.shapee[i].Left:=round(shp[i].posx)-form1.shapee[i].width div 2;
    Form1.shapee[i].top:=round(shp[i].posy)-form1.shapee[i].height div 2;
  end;
  Form2.Close;
end;

procedure speed;
var i,j:integer; dx,dy,r:real;
begin
  dx:=0;
  dy:=0;
  r:=0;
  for i:=0 to e1 do
  begin
    ax[i]:=0;
    ay[i]:=0;
    for j:=0 to e1 do
    begin
      dx:=shp[j].posx-shp[i].posx;
      dy:=shp[j].posy-shp[i].posy;
      r:=sqr(dx)+sqr(dy);
      if r>4225 then
      begin
      if (((i<e1 div 2+1) and (j>e1 div 2)) or ((i>e1 div 2) and (j<e1 div 2+1))) and (i<>j) then
      begin
        ax[i]:=ax[i]+(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]+(dy/sqrt(r))*shp[j].q/r;
      end
      else
      if i<>j then
      begin
        ax[i]:=ax[i]-(dx/sqrt(r))*shp[j].q/r;
        ay[i]:=ay[i]-(dy/sqrt(r))*shp[j].q/r;
      end;
      end;
      if r<4225 then
      begin
      if (((i<e1 div 2+1) and (j>e1 div 2)) or ((i>e1 div 2) and (j<e1 div 2+1))) and (i<>j) then
      begin
        ax[i]:=ax[i]-(dx/sqrt(r))*shp[j].q/4225;
        ay[i]:=ay[i]-(dy/sqrt(r))*shp[j].q/4225;
      end
      else
      if i<>j then
      begin
        ax[i]:=ax[i]-(dx/sqrt(r))*shp[j].q/4225;
        ay[i]:=ay[i]-(dy/sqrt(r))*shp[j].q/4225;
      end;
      end;
    end;
    with shp[i] do
         begin
           xtime:=xtime+1;
           ytime:=ytime+1;
           vx:=vx*0.9999+ax[i];
           vy:=vy*0.9999+ay[i];
         end;
  end;
  for i:=0 to e1 do
  with shp[i] do
       begin
         posx:=posx+vx;
         posy:=posy+vy;
         if ((posx>form1.image1.width) or (posx<0)) and (xtime>5) then begin vx:=vx*(-1); xtime:=0; end;
         if ((posy>form1.image1.height) or (posy<0)) and (ytime>5) then begin vy:=vy*(-1); ytime:=0; end;
       end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form2:=TForm2.Create(Application);
  try
    Form2.ShowModal;
  finally
    Form2.Free;
  end;
  image1.canvas.fillrect(clientrect);
end;

procedure TForm1.Image1Click(Sender: TObject);
var i:integer;
begin
  if e1<1 then
  begin
  FormCreate(Form1);
  exit;
  end;
  if timer1.enabled then timer1.enabled:=false
  else timer1.enabled:=true;
  for i:=0 to e1 do
  with shp[i] do
       begin
         vx:=0;
         vy:=0;
       end;
  image1.canvas.fillrect(clientrect);
end;

procedure TForm1.Image1DblClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to e1 do Shapee[i].Destroy;
  timer1.enabled:=false;
  e1:=0;
  shp:=nil;
  Shapee:=nil;
  ax:=nil;
  ay:=nil;
  FormCreate(Form1);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
begin
  speed;
  for i:=0 to e1 do
  begin
    if i<e1 div 2+1 then image1.canvas.pen.color:=clblue
    else image1.canvas.Pen.color:=clred;
    image1.canvas.moveto(shapee[i].Left+shapee[i].width div 2,shapee[i].top+shapee[i].height div 2);
    shapee[i].Left:=round(shp[i].posx)-shapee[i].width div 2;
    shapee[i].top:=round(shp[i].posy)-shapee[i].height div 2;
    image1.canvas.lineto(shapee[i].Left+shapee[i].width div 2,shapee[i].top+shapee[i].height div 2);
  end;
end;



end.

