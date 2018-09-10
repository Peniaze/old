procedure obrazok(var obr:TBitmap;val: typobr);
begin
     //if obrazok<>nil then
     //Freeandnil(obrazok);
     //obrazok:=TBitmap.create;
     obr:=TBitmap.create;
     obr.height:=form1.image1.height div vyska;
     obr.width:=form1.image1.width div sirka;
     case val of
          9,11:
            with obr.canvas do
                 begin
                      brush.color:=$c8c8c8;
                      fillrect(0,0,obr.width-1,obr.height-1);
                 end;
          10:
            with obr.canvas do
                 begin
                      brush.color:=clred;
                      fillrect(0,0,obr.width-1,obr.height-1);
                 end;
          else
            with obr.canvas do
                 begin
                      brush.color:=clgray;
                      fillrect(0,0,obr.width-1,obr.height-1);
                 end;
     end;
     case val of
          9:
            with obr.canvas do
                 begin
                      pen.Width:=width div 19;
                      pen.color:=clblack;
                      moveto(width div 2,height div 6);
                      lineto(width div 2,height*5 div 6);
                      brush.color:=clred;
                      fillrect(width div 4,height div 4,width div 2,height div 2);
                      brush.color:=clblack;
                      fillrect(width div 4,height*8 div 10,width*3 div 4,height*9 div 10);
                 end;
          11,10:
            with obr.canvas do
                 begin
                      pen.color:=clblack;
                      brush.color:=clblack;
                      ellipsec(width div 2, height div 2, width*4 div 9,height*4 div 9);
                 end;
          1:
            with obr.canvas do
                 begin
                      pen.color:=clblue;
                      pen.width:=obr.width div 7;
                      moveto(obr.width div 5,obr.height div 2);
                      lineto(obr.width div 2,obr.height div 6);
                      lineto(obr.width div 2, obr.height*5 div 6);
                 end;
          2:
            with obr.canvas do
                 begin
                      pen.color:=$c2c200;
                      pen.width:=obr.width div 7;
                      moveto(obr.width div 6,obr.height div 2);
                      lineto(obr.width*29 div 150,obr.height*28 div 75);
                      lineto(obr.width*79 div 300,obr.height*79 div 300);
                      lineto(obr.width*28 div 75,obr.height*29 div 150);
                      lineto(obr.width div 2, obr.height div 6);
                      lineto(obr.width*117 div 200,obr.height*29 div 150);
                      lineto(obr.width*271 div 400,obr.height*79 div 300);
                      lineto(obr.Width*73 div 100,obr.height*28 div 75);
                      lineto(obr.width*2 div 3,obr.height div 2);
                      lineto(obr.width div 6,obr.height*5 div 6);
                      lineto(obr.width*5 div 6,obr.height*5 div 6);
                 end;
          3:
            with obr.canvas do
                 begin
                      pen.color:=clred;
                      pen.width:=obr.width div 7;
                      brush.style:=bsClear;
                      ellipsec(obr.width div 2,obr.height div 3,obr.width div 3,obr.height div 5);
                      ellipsec(obr.width div 2,obr.height*2 div 3,obr.width div 3,obr.height div 5);
                      brush.style:=bsSolid;
                      fillrect(0,obr.height div 3,obr.width div 2,obr.height*2 div 3);
                 end;
          4:
            with obr.canvas do
                 begin
                      pen.color:=$0000c8;
                      pen.width:=obr.width div 7;
                      moveto(obr.width*5 div 6, obr.height*5 div 9);
                      lineto(obr.width div 6, obr.height*5 div 9);
                      lineto(obr.width*5 div 9,obr.height div 6);
                      lineto(obr.width*5 div 9, obr.height*5 div 6);
                 end;
          5:
            with obr.canvas do
                 begin
                      pen.color:=$00FFFF;
                      pen.width:=obr.width div 7;
                      brush.Style:=bsClear;
                      ellipse(obr.width div 7,obr.height*4 div 9,obr.width*5 div 6,obr.height*5 div 6);
                      moveto(obr.width*5 div 6,obr.height div 6);
                      lineto(obr.width div 6,obr.Height div 6);
                      lineto(obr.Width div 6, obr.height*5 div 9);
                      brush.style:=bsSolid;
                      fillrect(0,obr.height*5 div 9,obr.width div 2,obr.height*13 div 18);
                 end;
          6:
            with obr.canvas do
                 begin
                      pen.color:=$c8ffc8;
                      pen.width:=obr.width div 7;
                      brush.style:=bsclear;
                      ellipsec(obr.width div 2,obr.height div 2,obr.width div 4, obr.Height div 3);
                      brush.style:=bssolid;
                      fillrect(obr.width div 2,obr.height div 4,obr.width,obr.height);
                      brush.style:=bsClear;
                      ellipsec(obr.width div 2,obr.height*3 div 4,obr.width div 4,obr.height div 4);
                 end;
          7:
            with obr.canvas do
                 begin
                      pen.color:=clblack;
                      pen.width:=obr.width div 7;
                      moveto(obr.width div 6, obr.height div 6);
                      lineto(obr.width*5 div 6,obr.height div 6);
                      lineto(obr.width div 6, obr.height*5 div 6);
                 end;
          8:
            with obr.canvas do
                 begin
                      pen.color:=$FF00FF;
                      pen.width:=obr.width div 7;
                      brush.style:=bsClear;
                      ellipsec(obr.width div 2,obr.height div 3,obr.width div 3,obr.height div 5);
                      ellipsec(obr.width div 2,obr.height*2 div 3,obr.width div 3,obr.height div 5);
                 end;
     end;
end;
