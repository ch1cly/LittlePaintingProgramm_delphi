unit SignalDot;


interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
       Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Elipse, Figure, Math;


type

 TSignalDot = class(TElipse)
  protected
  fCentrePoint : TPoint;
  findexInVector : Integer;
  function GetCentrePoint(): TPoint;
  public
  property PointOfFigure : TPoint read GetCentrePoint;
  property indexInVector : Integer read findexInVector write findexInVector;
  procedure Paint(const c: TCanvas); override;
  constructor Create(centre : TPoint; indexInVector : Integer);
  end;

implementation

constructor TSignalDot.Create(centre : TPoint; indexInVector : Integer);
begin
     fCentrePoint := centre;
     self.fPoint[0] := fCentrePoint;
     self.fPoint[1] := TPoint.Create(7,7);
     self.Color :=  clPurple;
     self.findexInVector := indexInVector;
end;


procedure TSignalDot.Paint(const c: TCanvas);
var Point1,Point2:TPoint;
begin
  c.Pen.Color := self.fColor;
  self.absRadius();
  Point1 := TPoint.Create(self.fPoint[0].X - self.fPoint[1].X, self.fPoint[0].y - self.fPoint[1].Y);
  Point2 := TPoint.Create(self.fPoint[0].X + self.fPoint[1].X, self.fPoint[0].y + self.fPoint[1].Y);
  c.Ellipse(Point1.x, Point1.y, Point2.x, Point2.y);

end;

function TSignalDot.GetCentrePoint: TPoint;
begin
  self.fCentrePoint := self.fPoint[0];
  Result := fCentrePoint;
end;


end.
