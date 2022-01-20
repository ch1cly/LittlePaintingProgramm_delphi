unit Figure;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type

TFigure = class
  protected
    fColor: TColor;
    function GetPointCount():Integer; virtual; abstract;
    function GetPoint(index: Integer): TPoint; virtual; abstract;
    procedure SetPoint(index:Integer; Point:TPoint); virtual; abstract;
  public
    function  CentreOfFigure():Tpoint; virtual; abstract;
    constructor Create;
    function DoesCollide(Point :TPoint): Boolean; virtual; abstract;
    procedure Paint(const c: TCanvas); virtual; abstract;
    property Point[index :Integer]:TPoint read GetPoint write SetPoint;
    property PointCount:Integer read GetPointCount;
    property Color: TColor read fColor write fColor;
    procedure Assign(Point1 :TPoint; Point2 :TPoint); virtual; abstract;
    procedure MoveBy(Point1 :TPoint); virtual; abstract;
    procedure ChangingInCreation(Point_1 :TPoint; Point_2 :TPoint); virtual; abstract;
    procedure ChangeColor(cl :TColor);
    procedure PaintEditingDots(const c: TCanvas); virtual; abstract;

  end;



implementation


{ TFigure }

constructor TFigure.Create;
begin
  fColor := clRed;
end;

procedure TFigure.ChangeColor(cl :TColor);
begin
  fColor :=  cl;
end;


end.
