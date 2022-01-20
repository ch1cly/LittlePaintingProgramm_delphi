unit Elipse;


interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
       Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Figure, Math;

type

 TElipse = class(TFigure)
  protected
  fPoint  : Array[0..1] of TPoint;
  function GetPointCount():Integer; override;
  function GetPoint(index: Integer): TPoint; override;
  procedure SetPoint(index:Integer; Point:TPoint); override;
  procedure absRadius();
  public
    procedure Paint(const c: TCanvas); override;
    function DoesCollide(Point :TPoint): Boolean; override;
    procedure Assign(Point1 :TPoint; Point2 :TPoint); override;
    procedure MoveBy(Point1 :TPoint); override;
    procedure ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint); override;
   // procedure PaintEditingDots(const c: TCanvas); override;

  end;

implementation


procedure TElipse.Paint(const c: TCanvas);
var Point1,Point2:TPoint;
var bt : TBitMap;
begin
  inherited;

  c.Pen.Color := fColor;
  c.brush.style:= bsclear;
  self.absRadius();
  Point1 := TPoint.Create(self.fPoint[0].X - self.fPoint[1].X, self.fPoint[0].y - self.fPoint[1].Y);
  Point2 := TPoint.Create(self.fPoint[0].X + self.fPoint[1].X, self.fPoint[0].y + self.fPoint[1].Y);
  c.Ellipse(Point1.x, Point1.y, Point2.x, Point2.y);

end;

function TElipse.GetPointCount():Integer;
begin
  Result := Length(fPoint);
end;

function TElipse.GetPoint(index: Integer): TPoint;
begin
  Result := fPoint[index];
end;

procedure TElipse.SetPoint(index:Integer; Point:TPoint);
begin
  fPoint[index] := Point;
end;

function TElipse.doesCollide(Point :TPoint): Boolean;
var Ans : Boolean;
var xvar, yvar : Double;
begin
if (self.fPoint[1].X <> 0) and (self.fPoint[1].Y <> 0) then begin
  xvar:= (Point.X - self.fPoint[0].x)  / self.fPoint[1].X;
  yvar := (Point.y - self.fPoint[0].y) / self.fPoint[1].y;
  Ans := power(xvar,2) + power(yvar,2) <= 1 ;
  end else
  begin
  Ans := false;
  end;

  Result := Ans;
end;


procedure TElipse.Assign(Point1 :TPoint; Point2 :TPoint);
begin
fPoint[1] := TPoint.Create((Point2.X - Point1.X), (Point2.Y - Point1.Y));
fPoint[0] := Point2;
end;

procedure TElipse.MoveBy(Point1 :TPoint);
begin
  //does object point delete?
fPoint[0] := TPoint.Create(fPoint[0].X+Point1.X, fPoint[0].Y + Point1.Y);
end;

procedure TElipse.ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint);
var centre, radius : TPoint;
begin
  fPoint[1] := TPoint.Create((Point_2.X - Point_1.X), (Point_2.Y - Point_1.Y));
  fPoint[0] := Point_2;
end;

procedure TElipse.absRadius();
begin
  self.fPoint[1] := TPoint.Create(abs(self.fPoint[1].X),abs(self.fPoint[1].Y));
end;

end.
