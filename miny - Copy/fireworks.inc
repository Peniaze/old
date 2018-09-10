type sssalto = record
    x,y,vx,vy:integer;
    gulli:array [0..9] of TSalto;
  end;
  saltooo = array [0..9] of sssalto;

var x:array [0..2] of saltooo;
  timm:integer = 0;
  koun:integer = 0;

procedure TSalto.paint;
begin
     canvas.pen.Style:=psClear;
     canvas.Ellipse(0,0,width,height);
end;

constructor TSalto.Create(AOwner: TComponent);
begin
     inherited create(AOwner);
     parent:=Form1;
     width:=15;
     height:=15;
     paint;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var i,k:integer;
begin
     for k:=0 to 2 do
     for i:=0 to 9 do
         with x[k,i] do
              begin
                   if y div 100<Form1.height+200 then
                   begin
                        x+=vx;
                        y+=vy;
                        vy+=20;
                        gulli[timm].Left:=x div 100+gulli[timm].width div 2;
                        gulli[timm].top:=y div 100+gulli[timm].height div 2;
                   end;
              end;
     timm+=1;
     if timm=10 then
     timm:=0;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var i,tempx,tempy:integer;
begin
     if random(500)>150 then
     begin
          tempx:=(random(Form1.width-50)+25)*100;
          tempy:=(random(Form1.height-50)+25)*100+200;
          for i:=0 to 9 do
              with x[koun][i] do
                   begin
                        x:=tempx;
                        y:=tempy;
                        vx:=random(400)-200;
                        vy:=random(3000) div 10-600;
                   end;
          koun+=1;
          if koun=3 then
          koun:=0;
     end;
end;



procedure TForm1.Fire(Sender: TObject);
var i,j,k,cl:integer;
begin
     randomize;
     for i:=0 to 2 do
         for j:=0 to 9 do
             with x[i,j] do
                  begin
                       x:=1500;
                       y:=1500;
                       vx:=0;
                       vy:=400;
                       cl:=random($FFFFFF)+1;
                        for k:=0 to 9 do
                            begin
                                 gulli[k]:=TSalto.Create(Form1);
                                 gulli[k].Canvas.brush.color:=cl;
                            end;
                  end;
     Timer2:=TTimer.Create(Form1);
     Timer2.Interval:=13;
     Timer2.OnTimer:=@Timer2Timer;
     Timer3:=TTimer.Create(Form1);
     Timer3.Interval:=800;
     Timer3.OnTimer:=@Timer3Timer;
end;

procedure TForm1.destruc;
var i,j,k:integer;
begin
     if Timer2<>nil then
     begin
          Freeandnil(Timer2);
          Freeandnil(Timer3);
          for i:=0 to 2 do
              for j:=0 to 9 do
                  for k:=0 to 9 do
                      Freeandnil(x[i,j].gulli[k]);
     end;
end;
