program Project6;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form6},
  Figure in 'Figure.pas',
  Line in 'Line.pas',
  Elipse in 'Elipse.pas',
  Rectangle in 'Rectangle.pas',
  SignalDot in 'SignalDot.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
