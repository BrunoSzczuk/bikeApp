unit frmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles;

type
  TufrmConfig = class(TForm)
    colorBackground: TColorBox;
    Label1: TLabel;
    colorLedBike1: TColorBox;
    Label2: TLabel;
    colorLedBike2: TColorBox;
    Label3: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    fConfig: TIniFile;
  end;

var
  ufrmConfig: TufrmConfig;

implementation

{$R *.dfm}

procedure TufrmConfig.Button1Click(Sender: TObject);
begin
  fConfig := TIniFile.Create(ExtractFilePath(Application.ExeName)
      + 'Configuracao.ini');
  fConfig.WriteString('MENU', 'BACKGROUND',
    ColorToString(colorBackground.Selected));
  fConfig.WriteString('BIKE_1', 'LED', ColorToString(colorLedBike1.Selected));
  fConfig.WriteString('BIKE_2', 'LED', ColorToString(colorLedBike2.Selected));
end;

procedure TufrmConfig.FormCreate(Sender: TObject);
begin
  fConfig := TIniFile.Create(ExtractFilePath(Application.ExeName)
      + 'Configuracao.ini');
  colorBackground.Selected := StringToColor(fConfig.ReadString('MENU',
      'BACKGROUND', 'clBlack'));
  colorLedBike1.Selected := StringToColor(fConfig.ReadString('BIKE_1', 'LED',
      'clGreen'));
  colorLedBike2.Selected := StringToColor(fConfig.ReadString('BIKE_2', 'LED',
      'clBlue'));

end;

end.
