unit Line;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
      Figure, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Math;

type

 TLine = class(TFigure)
  protected
    fPoint  : Array[0..1] of TPoint;
    function GetPointCount():Integer; override;
    function GetPoint(index: Integer): TPoint; override;
    procedure SetPoint(index:Integer; Point:TPoint); override;
    procedure FindParametersOfLine(var k:Double; var b:Double);
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

{ TLine }

procedure TLine.Paint(const c: TCanvas);
begin
  inherited;
  c.Pen.Color := fColor;
  c.MoveTo(fPoint[0].x, fPoint[0].y);
  c.LineTo(fPoint[1].x, fPoint[1].y);
end;


function TLine.GetPointCount():Integer;
begin
  Result := Length(fPoint);
end;

function TLine.GetPoint(index: Integer): TPoint;
begin
  Result := fPoint[index];
end;

procedure TLine.SetPoint(index:Integer; Point:TPoint);
begin
  fPoint[index] := Point;
end;

function TLine.doesCollide(Point :TPoint): Boolean;
var k,b : Double;
var Ans, IsInLine, IsInEdge : Boolean;
var minx,miny,maxx,maxy: Integer;
begin

  FindParametersOfLine(k,b);

  minx := Min(fPoint[1].x,fPoint[0].x);
  miny := Min(fPoint[1].y,fPoint[0].y);
  maxx := Max(fPoint[1].x,fPoint[0].x);
  maxy := Max(fPoint[1].y,fPoint[0].y);

  IsInEdge := (Point.x <= maxx) and  (Point.y <= maxy) and
              (Point.x >= minx) and  (Point.y >= miny);

  IsInLine := abs(Point.y - (k * Point.x + b)) < 6;
  Ans := IsInLine and IsInEdge;
  Result := Ans;
end;

function  TLine.CentreOfFigure():Tpoint;
var centre : TPoint;
begin
centre.x := (fPoint[1].x - fPoint[0].x) div 2 + fPoint[0].x;
centre.y := (fPoint[1].y - fPoint[0].y) div 2 + fPoint[0].y;
Result := centre;
end;

procedure TLine.FindParametersOfLine(var k:Double; var b:Double);
begin

    if(abs(fPoint[0].x-fPoint[1].x) = 0) then begin
        b := fPoint[0].x;
        k := 0;
  end else begin
        k := (fPoint[1].y - fPoint[0].y) / (fPoint[1].x - fPoint[0].x);
        b := -fPoint[0].x * k + fPoint[0].y;
  end;

end;

procedure TLine.Assign(Point1 :TPoint; Point2 :TPoint);
var x,y:Integer;
begin
fPoint[0] := Point1;
fPoint[1] := Point2;
end;


procedure TLine.MoveBy(Point1 :TPoint);
begin
  //does object point delete?
fPoint[0] := TPoint.Create(fPoint[0].X+Point1.X, fPoint[0].Y + Point1.Y);
fPoint[1] := TPoint.Create(fPoint[1].X+Point1.X, fPoint[1].Y + Point1.Y);
end;


procedure TLine.ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint);
var centre,radius : TPoint;
begin
   fPoint[0] := Point_1;
  fPoint[1] := Point_2;
end;

end.
