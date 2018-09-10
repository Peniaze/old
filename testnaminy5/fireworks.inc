type sssalto = record
    x,y,vx,vy:integer;
    gulli:array [0..9] of TSalto;
  end;
  saltooo = array [0..9] of sssalto;

var x:array [0..2] of saltooo;
  tim:integer = 0;
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
     width:=10;
     height:=10;
     paint;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,k:integer;
begin
     for k:=0 to 2 do
     for i:=0 to 9 do
         with x[k,i] do
              begin
                   if y div 100<Form1.height+500 then
                   begin
                        x+=vx;
                        y+=vy;
                        vy+=20;
                        gulli[tim].Left:=x div 100+gulli[tim].width div 2;
                        gulli[tim].top:=y div 100+gulli[tim].height div 2;
                   end;
              end;
     tim+=1;
     if tim=10 then
     tim:=0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var i:integer;
begin
     if random(500)>150 then
     begin
          for i:=0 to 9 do
              with x[koun][i] do
                   begin
                        x:=Form1.width*50;
                        y:=Form1.height*50+200;
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
                       x:=-300;
                       y:=0;
                       vx:=-200;
                       vy:=400;
                       cl:=random($FFFFFF)+1;
                        for k:=0 to 9 do
                            begin
                                 gulli[k]:=TSalto.Create(Form1);
                                 gulli[k].Canvas.brush.color:=cl;
                            end;
                  end;
     Timer1:=TTimer.Create(Form1);
     Timer1.Interval:=10;
     Timer1.OnTimer:=@Timer1Timer;
     Timer2:=TTimer.Create(Form1);
     Timer2.Interval:=800;
     Timer2.OnTimer:=@Timer2Timer;
end;

