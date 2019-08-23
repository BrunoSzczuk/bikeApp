unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, MATH,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.ExtCtrls,
  Vcl.StdCtrls, AdvGaugeCircle, AdvSmoothGauge, AdvGauge, CPort;

type
  TForm1 = class(TForm)
    AdvGauge1: TAdvGauge;
    AdvSmoothGauge1: TAdvSmoothGauge;
    AdvGaugeCircle1: TAdvGaugeCircle;
    ComPort1: TComPort;
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    function converteDeStringParaAscii(Texto: String): byte;
    function leUmValorParaAscii(Count: integer): byte;
    procedure ComPort1RxChar(Sender: TObject; Count: integer);
    procedure Button1Click(Sender: TObject);
    function verificaCheckSum(): boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Dados: array [0 .. 9] of integer;

  const
    INIT_BIT: byte = 170;

    LOW_BIKE_1: byte = 1;
    HIGH_BIKE_1: byte = 2;

    LOW_BIKE_2: byte = 3;
    HIGH_BIKE_2: byte = 4;

    CHECK_SUM_1: byte = 5;
    CHECK_SUM_2: byte = 6;
    CHECK_SUM_3: byte = 7;
    CHECK_SUM_4: byte = 8;
    END_BIT: byte = 171;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ComPort1.Connected := not ComPort1.Connected;
end;

procedure TForm1.ComPort1RxChar(Sender: TObject; Count: integer);
var
  Buffer: string;
  valor: byte;
  i: integer;

begin
  while ComPort1.ReadStr(Buffer, Count) > 0 do
  begin
    valor := converteDeStringParaAscii(Buffer);
    if valor = INIT_BIT then
    begin
      for i := 1 to Length(Dados) do
      begin
        Dados[i] := leUmValorParaAscii(Count);
      end;
      if verificaCheckSum() then
        Memo1.Lines.Add('Checksum correto');
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ComPort1.Connected := false;
end;

function TForm1.converteDeStringParaAscii(Texto: String): byte;
var
  i: integer;
begin
  // Converte a String para ASCII
  for i := 1 to Length(Texto) do
  begin
    result := Ord(Texto[i]);
    Memo1.Lines.Add(IntToStr(result))
  end;
end;

function TForm1.leUmValorParaAscii(Count: integer): byte;
var
  Buffer: string;
begin
  ComPort1.ReadStr(Buffer, Count);
  result := converteDeStringParaAscii(Buffer);
end;

function TForm1.verificaCheckSum(): boolean;
var
  soma1, soma2, soma3: integer;
begin
  begin
    result := Dados[LOW_BIKE_1] + Dados[LOW_BIKE_2] +
      (Dados[HIGH_BIKE_1] * Power(2, 8)) + (Dados[HIGH_BIKE_2] * Power(2, 8))
      = Dados[CHECK_SUM_1] + (Dados[CHECK_SUM_2] * Power(2, 8)) +
      (Dados[CHECK_SUM_3] * Power(2, 16)) + (Dados[CHECK_SUM_4] * Power(2, 24));
  end;

end;

end.
