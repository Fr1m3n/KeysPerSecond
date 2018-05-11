unit diag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtnrs, StdCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  y: array[0..15] of integer;
  count, x, rev: integer;
  Form1: TForm1;

implementation



{$R *.dfm}

procedure move(var y: array of integer);
var
  i: integer;
begin
  for i := 0 to 8 do
    y[i] := y[i + 1];
  y[9] := rev;
end;

procedure draw(x: integer);
var
  i: integer;
begin
  form1.paintbox1.Canvas.MoveTo(0, 199 - y[0] * 10);
  for i := 1 to x do
  begin
    if i = 10 then
    begin
      form1.paintbox1.Canvas.LineTo(i * 20, 199 - rev * 10);
      form1.paintbox1.Canvas.MoveTo(i * 20, 199 - rev * 10);
    end
    else
    begin
      form1.paintbox1.Canvas.LineTo(i * 20, 199 - y[i] * 10);
      form1.paintbox1.Canvas.MoveTo(i * 20, 199 - y[i] * 10);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  x := 1;
  paintbox1.Canvas.MoveTo(0, 199 - y[x]);
  count := 0;
  paintbox1.Canvas.Pen.Color := clBlack;
  y[x] := 0;
  label1.Caption := 'Current speed - ' + inttostr(y[x]);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  label1.Caption := 'Current speed - ' + inttostr(y[x]);
  inc(count);
  if x < 10 then
  begin
    inc(x);
    draw(x - 1);
  end
  else
  begin
    paintbox1.Canvas.Pen.Color := clCream;
    draw(10);
    move(y);
    rev := y[x];
    paintbox1.Canvas.Pen.Color := clBlack;
    draw(10);
    y[x] := 0;
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inc(y[x]);
end;

end.
