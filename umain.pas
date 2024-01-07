unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, DateUtils;

type

  { TfMain }

  TfMain = class(TForm)
    buPause: TSpeedButton;
    buStart: TSpeedButton;
    buStop: TSpeedButton;
    laDisplay: TLabel;
    Timer1: TTimer;
    procedure buStartClick(Sender: TObject);
    procedure buPauseClick(Sender: TObject);
    procedure buStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

var
  ElapsedTime: int64;
  StartTime: TDateTime;

  { TfMain }

procedure TfMain.buStartClick(Sender: TObject);
begin
  StartTime := Now();
  Timer1.Enabled := True;
end;

procedure TfMain.buPauseClick(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TfMain.buStopClick(Sender: TObject);
begin
  ElapsedTime := 0;
  laDisplay.Caption := '00:00:00';
  buPauseClick(Sender);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  ElapsedTime := 0;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
var
  Min, Sec, Frac: int64;
begin
  ElapsedTime := ElapsedTime + MilliSecondsBetween(Now(), StartTime);

  Frac := ElapsedTime mod 1000;
  Sec := (ElapsedTime - Frac) div 1000;
  Min := (Sec - Sec mod 60) div 60;
  Sec := Sec mod 60;
  Frac := Frac div 10;

  laDisplay.Caption := Format('%.2d:%.2d:%.2d', [Min, Sec, Frac]);
  StartTime := Now();
end;

end.
