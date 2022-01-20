unit Rectangle;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
       Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Figure, Math;

type

 TRectangle = class(TFigure)
  protected
    fPoint  : Array[0..1] of TPoint;
    function GetPointCount():Integer; override;
    function GetPoint(index: Integer): TPoint; override;
    procedure SetPoint(index:Integer; Point:TPoint); override;
  public
    function  CentreOfFigure():Tpoint; override;
    procedure Paint(const c: TCanvas); override;
    function DoesCollide(Point :TPoint): Boolean; override;
    procedure Assign(Point1 :TPoint; Point2 :TPoint); override;
    procedure MoveBy(Point1 :TPoint); override;
    procedure ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint); override;
    //procedure PaintEditingDots(const c: TCanvas); override;
  end;

implementation

procedure TRectangle.Paint(const c: TCanvas);
begin
  inherited;
  c.Pen.Color := fColor;
  c.brush.style:=bsclear;
  c.Rectangle(fPoint[0].x, fPoint[0].y, fPoint[1].x, fPoint[1].y);

end;


function TRectangle.GetPointCount():Integer;
begin
  Result := Length(fPoint);
end;

function TRectangle.GetPoint(index: Integer): TPoint;
begin
  Result := fPoint[index];
end;

procedure TRectangle.SetPoint(index:Integer; Point:TPoint);
begin
  fPoint[index] := Point;
end;

function TRectangle.doesCollide(Point :TPoint): Boolean;
var Ans : Boolean;
var maxx, maxy, minx, miny : Integer;
begin
  minx := Min(fPoint[1].x,fPoint[0].x);
  miny := Min(fPoint[1].y,fPoint[0].y);
  maxx := Max(fPoint[1].x,fPoint[0].x);
  maxy := Max(fPoint[1].y,fPoint[0].y);

  Ans := (Point.x <= maxx) and  (Point.y <= maxy) and
              (Point.x >= minx) and  (Point.y >= miny);

  Result := Ans;
end;

function  TRectangle.CentreOfFigure():Tpoint;
var centre : TPoint;
begin
centre.x := (fPoint[1].x - fPoint[0].x) div 2 + fPoint[0].x;
centre.y := (fPoint[1].y - fPoint[0].y) div 2 + fPoint[0].y;
Result := centre;
end;

procedure TRectangle.Assign(Point1 :TPoint;Point2 :TPoint);
begin
fPoint[0] := Point1;
fPoint[1] := Point2;
end;



procedure TRectangle.MoveBy(Point1 :TPoint);
begin
  //does object point delete?
fPoint[0] := TPoint.Create(fPoint[0].X+Point1.X, fPoint[0].Y + Point1.Y);
fPoint[1] := TPoint.Create(fPoint[1].X+Point1.X, fPoint[1].Y + Point1.Y);
end;


procedure TRectangle.ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint);
begin
  var Point1,Point2 :TPoint;
begin

  if (Point_1.X >= Point_2.X) and
      (Point_1.Y >= Point_2.Y) then begin
    //first
      Point1 :=  Point_2;
      Point2 :=  Point_1;

  end else if (Point_1.X < Point_2.X) and
      (Point_1.Y > Point_2.Y) then begin
      //second
       Point1 := TPoint.Create(Point_2.x,Point_1.Y);
      Point2 :=   TPoint.Create(Point_1.X, Point_2.Y);

  end else if (Point_1.X <= Point_2.X) and
      (Point_1.Y <= Point_2.Y) then begin
      //third

      Point1 :=  Point_1;
      Point2 := Point_2;

  end else if (Point_1.X > Point_2.X) and
      (Point_1.Y < Point_2.Y) then begin
       //forth
       Point1 := TPoint.Create(Point_1.X, Point_2.Y);
      Point2 :=  TPoint.Create(Point_2.x,Point_1.Y);

  end; end;

  fPoint[0] := Point1;
  fPoint[1] := Point2;


end;

end.
