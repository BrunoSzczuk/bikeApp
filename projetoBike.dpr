program projetoBike;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  frmConfig in 'frmConfig.pas' {ufrmConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TufrmConfig, ufrmConfig);
  Application.Run;
end.
