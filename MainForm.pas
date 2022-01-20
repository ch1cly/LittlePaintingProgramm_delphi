unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Figure, Line, Elipse, Rectangle,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,  System.generics.collections,
  SignalDot;

type
  TCondition = (Elipse, Rectangle , Line,SelectType, Erase, Edit);

type tFigureList = TObjectList<TFigure>;
type tSignalDotList = TObjectList<TSignalDot>;


type
  TForm6 = class(TForm)
    ToolBar1: TToolBar;
    ToolButtonElipse: TToolButton;
    ToolButton2: TToolButton;
    ToolButtonRect: TToolButton;
    ToolButton4: TToolButton;
    ToolButtonLine: TToolButton;
    ToolButton6: TToolButton;
    ToolButtonErase: TToolButton;
    PaintBox1: TPaintBox;
    ToolButton1: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButton3: TToolButton;
    ToolButtonEraseAll: TToolButton;
    ToolButton7: TToolButton;
    procedure ToolButtonElipseClick(Sender: TObject);
    procedure ToolButtonRectClick(Sender: TObject);
    procedure ToolButtonLineClick(Sender: TObject);
    procedure ToolButtonEraseClick(Sender: TObject);

    procedure ToolButton1Click(Sender: TObject);
    procedure PaintCanvas();
    procedure CreateLittleRectangle();
    procedure OnCreate(Sender: TObject);
    procedure OnDestroy(Sender: TObject);
    procedure MoveAllSignalDots(diff: TPoint);
    procedure ToolButtonEraseAllClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    function indexOfCollidingFigureWithCursor(pt: TPoint):Integer;
    function indexOfCollidingSDWithCursor(pt: TPoint):Integer;
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1OnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1OnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    fObjectsList : tFigureList;
    fSDList : tSignalDotList;{for signal dots}
    fCondition : TCondition;
    fPrevPosClicked, fPrvePos : TPoint;
    fFigureConditionals : Set of TCondition;
    fCurrentFigureIndex : Integer;
    fCurSDIndex: integer;
    { Private declarations }
  public
    { Public declarations }
  end;



var
  Form6: TForm6;

implementation

{$R *.dfm}


procedure TForm6.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  var pt : TPoint;
  var i : Integer;
  var pp : TPoint;
begin

pt := TPoint.Create(X,Y);

if self.fCondition = TCondition.Edit then

  if (self.fCurrentFigureIndex <> -1) and (self.fCurSDIndex = -1) then
  begin

  end else begin
  end;
end;

procedure TForm6.PaintBox1OnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var pt, p1,p2: TPoint;
var obj:  TFigure;
var i: Integer;
var TempObject : TFigure;
begin
pt.X := X;
pt.Y := Y;

self.fPrevPosClicked := pt;
self.fPrvePos := pt;

  if fCondition = TCondition.SelectType then begin



  end else if fCondition = TCondition.Erase then begin
    i := self.indexOfCollidingFigureWithCursor(pt);
    if (i <> -1) and not (self.fObjectsList.Items[i] is TSignalDot) then
      self.fObjectsList.Delete(i);
      self.fSDList.Clear;

  end else if fCondition = TCondition.Edit then begin


       self.fCurrentFigureIndex := self.indexOfCollidingFigureWithCursor(pt);
       self.fCurSDIndex := self.indexOfCollidingSDWithCursor(pt);

       if self.fCurSDIndex = -1 then
         self.fSDList.Clear();

    if (self.fCurrentFigureIndex <> -1) and (self.fCurSDIndex = -1) then begin
    {have some cases to reshape figures  signal dots added to each point}

      if self.fObjectsList.Items[self.fCurrentFigureIndex] is TRectangle then
      begin

         p1 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[0];
         p2 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[1];
         self.fSDList.add(TSignalDot.Create(TPoint.Create(p1.x,p1.y),self.fCurrentFigureIndex));
        self.fSDList.add(TSignalDot.Create(TPoint.Create(p2.x,p1.y),self.fCurrentFigureIndex));
        self.fSDList.add(TSignalDot.Create(TPoint.Create(p2.x,p2.y),self.fCurrentFigureIndex));
        self.fSDList.add(TSignalDot.Create(TPoint.Create(p1.x,p2.y),self.fCurrentFigureIndex));
      end else if self.fObjectsList.Items[self.fCurrentFigureIndex] is TLine then begin
        p1 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[0];
        p2 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[1];
        self.fSDList.add(TSignalDot.Create(p1,self.fCurrentFigureIndex));
        self.fSDList.add(TSignalDot.Create(p2,self.fCurrentFigureIndex));
      end else if self.fObjectsList.Items[self.fCurrentFigureIndex] is TElipse then begin
          p1 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[0];
          p2 := self.fObjectsList.Items[self.fCurrentFigureIndex].Point[1];
          self.fSDList.add(TSignalDot.Create(TPoint.Create(p1.x+p2.x,p1.y+p2.y),self.fCurrentFigureIndex));
      end;


    end else if (self.fCurrentFigureIndex <> -1) and (self.fCurSDIndex <> -1) then begin
        self.fSDList.Clear();
    end;


  end else begin
       {creating objects}
    if fCondition = TCondition.Elipse then begin
    TempObject := TElipse.Create;
    end else if fCondition = TCondition.Rectangle then begin
    TempObject := TRectangle.Create;
    end else if fCondition = TCondition.Line then begin
    TempObject := TLine.Create;
    end;

    TempObject.Assign(TPoint.Create(X,Y),TPoint.Create(X,Y));
    fObjectsList.Add(TempObject);
    self.PaintCanvas;
  end;

  self.PaintCanvas();
end;

procedure TForm6.PaintBox1OnMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var i,indexOfFigure,indexOfSD:Integer;
  CursorPoint,pp,PointOfFigure0,PointOfFigure1: TPoint;
  dp:TPoint;
  var k : Boolean;
  var diff : TPoint;
begin

CursorPoint.x := X;
CursorPoint.Y := Y;
k := false;
diff := TPoint.Create(CursorPoint.x - self.fPrvePos.x ,CursorPoint.y - self.fPrvePos.y);

indexOfFigure := self.indexOfCollidingFigureWithCursor(CursorPoint);
indexOfSD := self.indexOfCollidingSDWithCursor(CursorPoint);

    if indexOfFigure <> -1 then begin
      k := true;
    end;

if ssLeft in Shift then begin
{if mouse left button pressed}
    if(fCondition in fFigureConditionals)  then begin
      {if figure still creating }
      self.fObjectsList.Last.ChangingInCreation(CursorPoint, self.fPrevPosClicked);

    end else if (self.fCondition = TCondition.Edit) and (self.fCurrentFigureIndex = -1)
                and (self.fCurSDIndex <> -1)  then begin
       {if figure is reshaping by dragging by circle}
      var iv,sdindex, findex: Integer;
      sdindex :=  self.fCurSDIndex;
      findex := self.fSDList.Items[sdindex].indexInVector;

      if self.fObjectsList.Items[findex] is TRectangle then begin
      pp := self.fSDList[sdindex].PointOfFigure;
      PointOfFigure0 := self.fObjectsList[findex].Point[0];
      PointOfFigure1 := self.fObjectsList[findex].Point[1];
        if sdindex = 0 then begin
          self.fObjectsList[findex].Point[0] := pp;

          self.fSDList.Items[1].MoveBy(TPoint.Create(0,diff.Y));
          self.fSDList.Items[3].MoveBy(TPoint.Create(diff.x, 0));
        end else if sdindex = 1 then begin
          self.fObjectsList[findex].Point[0] := TPoint.Create(PointOfFigure0.x,pp.y);
          self.fObjectsList[findex].Point[1] := TPoint.Create(pp.x,PointOfFigure1.y);
          self.fSDList.Items[0].MoveBy(TPoint.Create(0,diff.Y));
          self.fSDList.Items[2].MoveBy(TPoint.Create(diff.x, 0));

        end else if sdindex = 2 then begin
            self.fObjectsList[findex].Point[1] := pp;
            self.fSDList.Items[1].MoveBy(TPoint.Create(diff.x,0 ));
          self.fSDList.Items[3].MoveBy(TPoint.Create( 0,diff.Y));
        end else if sdindex = 3 then begin
          self.fObjectsList[findex].Point[0] := TPoint.Create(pp.x,PointOfFigure0.y);
          self.fObjectsList[findex].Point[1] := TPoint.Create(PointOfFigure1.x,pp.y);
          self.fSDList.Items[2].MoveBy(TPoint.Create(0,diff.Y));
          self.fSDList.Items[0].MoveBy(TPoint.Create(diff.x, 0));
        end;
      end else if self.fObjectsList.Items[findex] is TELipse then begin
        pp := self.fSDList[sdindex].PointOfFigure;
        PointOfFigure0 := self.fObjectsList[findex].Point[0];
        PointOfFigure1 := self.fObjectsList[findex].Point[1];
         if sdindex = 0 then begin
          self.fObjectsList[findex].Point[1] := TPoint.Create(pp.x - PointOfFigure0.X + diff.x, pp.y - PointOfFigure0.Y+diff.Y);

          end;
      end else if self.fObjectsList.Items[findex] is TLine then begin
      pp := self.fSDList[sdindex].PointOfFigure;
      PointOfFigure0 := self.fObjectsList[findex].Point[0];
      PointOfFigure1 := self.fObjectsList[findex].Point[1];
        if sdindex = 0 then begin
          self.fObjectsList[findex].Point[0] := pp;
        end else if sdindex = 1 then begin
          self.fObjectsList[findex].Point[1] := pp;
        end;
      end;



   
    self.fSDList.Items[self.fCurSDIndex].MoveBy(diff);

    end else if (self.fCondition = TCondition.Edit) and (self.fCurrentFigureIndex <> -1)
                and (self.fCurSDIndex = -1) then begin
                {if figure dragging}
      self.fObjectsList.Items[self.fCurrentFigureIndex].MoveBy(diff);
      self.MoveAllSignalDots(diff);

    end;

  end else
  begin


  end;

self.PaintCanvas();

if k then begin
  self.CreateLittleRectangle();
end;

self.fPrvePos := CursorPoint;

end;

procedure TForm6.ToolButton1Click(Sender: TObject);
begin
  fCondition := TCondition.SelectType;
end;



procedure TForm6.ToolButtonEditClick(Sender: TObject);
begin
    self.fCondition := TCondition.Edit;
end;

procedure TForm6.ToolButtonElipseClick(Sender: TObject);
begin
  self.fCondition := TCondition.Elipse;
end;

procedure TForm6.ToolButtonEraseAllClick(Sender: TObject);
begin

 self.fObjectsList.Clear;
 self.fSDList.Clear;
 self.PaintBox1.Repaint;
end;

procedure TForm6.ToolButtonEraseClick(Sender: TObject);
begin
self.fCondition := TCondition.Erase;
end;

procedure TForm6.ToolButtonLineClick(Sender: TObject);
begin
  fCondition := TCondition.Line;
end;

procedure TForm6.ToolButtonRectClick(Sender: TObject);
begin
  fCondition := TCondition.Rectangle;
end;


procedure TForm6.OnCreate(Sender: TObject);
begin

fFigureConditionals := [Elipse, Rectangle , Line];
fObjectsList := tFigureList.Create();
self.fSDList := tSignalDotList.Create();
fObjectsList.OwnsObjects := true;
self.fSDList.OwnsObjects := true;

end;

procedure TForm6.OnDestroy(Sender: TObject);
begin
fObjectsList.Clear;
self.fSDList.Clear;
end;

procedure TForm6.PaintCanvas();
var i:Integer;
begin
  self.PaintBox1.Repaint;
  for i := 0 to self.fObjectsList.Count - 1 do
       fObjectsList[i].Paint(self.PaintBox1.Canvas);
  for i := 0 to self.fSDList.Count - 1 do
       self.fSDList[i].Paint(self.PaintBox1.Canvas);


end;

procedure TForm6.CreateLittleRectangle();
  var pt: TPoint;
begin
  pt := self.CalcCursorPos;
  self.PaintBox1.Canvas.Pen.Color := clGreen;
  self.PaintBox1.Canvas.brush.style:=bsSolid;
  self.PaintBox1.Canvas.Rectangle(pt.x-5,pt.y-5,pt.x+5,pt.y+5);
end;

function TForm6.indexOfCollidingFigureWithCursor(pt: TPoint):Integer;
var j,i :Integer;
begin
j := -1;
for i := self.fObjectsList.Count - 1 downto 0 do begin
        if self.fObjectsList.Items[i].DoesCollide(pt) then begin
          j := i;
          break;
        end;
    end;
    Result := j;
end;

function TForm6.indexOfCollidingSDWithCursor(pt: TPoint):Integer;
var j,i :Integer;
begin
j := -1;
for i := self.fSDList.Count - 1 downto 0 do begin
        if self.fSDList.Items[i].DoesCollide(pt) then begin
          j := i;
          break;
        end;
    end;
    Result := j;
end;


procedure TForm6.MoveAllSignalDots(diff: TPoint);
var i :Integer;
begin

for i := self.fSDList.Count - 1 downto 0 do begin
        if self.fSDList.Items[i] is TSignalDot then begin
          self.fSDList.Items[i].MoveBy(diff);
        end;
    end;
end;




end.
