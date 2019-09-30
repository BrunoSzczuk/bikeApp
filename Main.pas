unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, CPort, StdCtrls, AdvSmoothGauge, jpeg, Math,
  AdvSmoothLedLabel, AdvSmoothProgressBar;

type
  TForm1 = class(TForm)
    velocimetro1: TAdvSmoothGauge;
    Button1: TButton;
    ComPort1: TComPort;
    Timer1: TTimer;
    distancia1: TAdvSmoothLedLabel;
    velocimetro2: TAdvSmoothGauge;
    distancia2: TAdvSmoothLedLabel;
    Label3: TLabel;
    winner2: TImage;
    Label2: TLabel;
    winner1: TImage;
    Button2: TButton;
    distanciaPercorrida1: TAdvSmoothProgressBar;
    AdvSmoothProgressBar2: TAdvSmoothProgressBar;
    function converteDeStringParaAscii(Texto: String): byte;
    function leUmValorParaAscii(Count: integer): byte;
    procedure ComPort1RxChar(Sender: TObject; Count: integer);
    procedure Button1Click(Sender: TObject);
    function verificaCheckSum(): boolean;
    procedure verificaGanhador();
    function geraTamanho( low: integer; high: integer): Extended;
    procedure stopTudao();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Dados: array [0 .. 9] of integer;
    competidor1_distancia: Extended;
    competidor2_distancia: Extended;
    competidor1_distanciaAnterior: Extended;
    competidor2_distanciaAnterior: Extended;

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
    DISTANCIA = 1000;
    METRO_POR_PULSO = 0.375;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

procedure TForm1.Button1Click(Sender: TObject);
begin
  ComPort1.Connected := not ComPort1.Connected;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ComPort1RxChar(Sender: TObject; Count: integer);
var
  Buffer: string;
  valor: byte;
  i: integer;
  vel, vel2: Extended;

begin
  if (ComPort1.ReadStr(Buffer, Count) > 0) then
  begin
    valor := converteDeStringParaAscii(Buffer);
    if valor = INIT_BIT then
    begin
      for i := 1 to Length(Dados) do
      begin
        Dados[i] := leUmValorParaAscii(Count);
      end;
      if verificaCheckSum() then
      begin
        competidor1_distancia := geraTamanho(Dados[LOW_BIKE_1],
          Dados[HIGH_BIKE_1]) * METRO_POR_PULSO;
        competidor2_distancia := geraTamanho(Dados[LOW_BIKE_2],
          Dados[HIGH_BIKE_2]) * METRO_POR_PULSO;
        distancia1.Caption.Value := competidor1_distancia;
        distancia2.Caption.Value := competidor2_distancia;

        vel := ((competidor1_distancia - competidor1_distanciaAnterior)) * 3.6;

        vel2 := ((competidor2_distancia - competidor2_distanciaAnterior)) * 3.6;
        competidor2_distanciaAnterior := competidor2_distancia;
        velocimetro2.Value := vel2;
        competidor1_distanciaAnterior := competidor1_distancia;
        velocimetro1.Value := vel;
        distanciaPercorrida1.Position := competidor1_distancia;
        //distanciaPercorrida2.Position := competidor2_distancia;
        if (competidor1_distancia >= DISTANCIA) then
          distancia1.Caption.Value := DISTANCIA
        else if (competidor2_distancia >= DISTANCIA) then
          distancia2.Caption.Value := DISTANCIA;

        verificaGanhador();
      end;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ComPort1.Connected := false;
end;

function TForm1.geraTamanho( low, high: integer): Extended;
begin
  result := low + ( high * Power(2, 8));
end;

function TForm1.converteDeStringParaAscii(Texto: String): byte;
var
  i: integer;
begin
  // Converte a String para ASCII
  for i := 1 to Length(Texto) do
  begin
    result := Ord(Texto[i]);
    // Memo1.Lines.Add(IntToStr(result))
  end;
end;

function TForm1.leUmValorParaAscii(Count: integer): byte;
var
  Buffer: string;
begin
  ComPort1.ReadStr(Buffer, Count);
  result := converteDeStringParaAscii(Buffer);
end;

procedure TForm1.stopTudao;
begin
  ComPort1.Connected := false;
  velocimetro1.Value := 0;
  velocimetro2.Value := 0;
  Timer1.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  distancia1.Caption.Value := distancia1.Caption.Value + 100.5;
  competidor1_distancia := distancia1.Caption.Value;
  distanciaPercorrida1.Position := competidor1_distancia;
  verificaGanhador();
end;

function TForm1.verificaCheckSum(): boolean;
var
  soma1, soma2, soma3: integer;
begin
  begin
    result := Dados[LOW_BIKE_1] + Dados[LOW_BIKE_2] +
      (Dados[HIGH_BIKE_1] * Power(2, 8)) + (Dados[HIGH_BIKE_2] * Power(2, 8))
      = Dados[CHECK_SUM_1] + (Dados[CHECK_SUM_2] * Power(2, 8)) +
      (Dados[CHECK_SUM_3] * Power(2, 16)) + (Dados[CHECK_SUM_4] * Power(2,
        24));
  end;

end;

procedure TForm1.verificaGanhador;
begin
  if competidor1_distancia >= DISTANCIA then
  begin
    winner1.Visible := true;
    stopTudao();
  end
  else if competidor2_distancia >= DISTANCIA then
  begin
    winner2.Visible := true;
    stopTudao();
  end;
end;
{$R *.dfm}

end.
