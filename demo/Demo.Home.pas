unit Demo.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    btnGtin: TButton;
    Memo1: TMemo;
    btnGpc: TButton;
    btnNcm: TButton;
    btnProducts: TButton;
    procedure btnGtinClick(Sender: TObject);
    procedure btnGpcClick(Sender: TObject);
    procedure btnNcmClick(Sender: TObject);
    procedure btnProductsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  TOKEN = 'seu token';

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses cosmos.api, cosmos.classes;

procedure TForm1.btnGpcClick(Sender: TObject);
begin
  var LObj: TGpcProductsClass;
  try
    LObj :=
      TCosmosApi
        .New
        .Token(TOKEN)
        .Gpc('10000161');

    if not Assigned(LObj.Error) then
      Memo1.Lines.Add(LObj.portuguese)
    else
      Memo1.Lines.Add(LObj.Error.message);

  finally
    LObj.DisposeOf;
  end;
end;

procedure TForm1.btnGtinClick(Sender: TObject);
begin
  var LObj : TProductClass;
  try
    LObj :=
      TCosmosApi
        .New
        .Token(TOKEN)
        .Gtin('7896084101183');

    if not Assigned(LObj.Error) then
      Memo1.Lines.Add(LObj.description)
    else
      Memo1.Lines.Add(LObj.Error.message);

  finally
    LObj.DisposeOf;
  end;
end;

procedure TForm1.btnNcmClick(Sender: TObject);
begin
  var LObj : TNcmProductsClass;
  try
    LObj :=
      TCosmosApi
        .New
        .Token(TOKEN)
        .Ncm('04061010');

    if not Assigned(LObj.Error) then
      Memo1.Lines.Add(LObj.full_description)
    else
      Memo1.Lines.Add(LObj.Error.message);

  finally
    LObj.DisposeOf;
  end;
end;

procedure TForm1.btnProductsClick(Sender: TObject);
begin
  var LObj : TProductsClass;
  try
    LObj :=
      TCosmosApi
        .New
        .Token(TOKEN)
        .Products('Bolacha');

    if not Assigned(LObj.Error) then
      Memo1.Lines.Add(LObj.total_count.ToString)
    else
      Memo1.Lines.Add(LObj.Error.message);

  finally
    LObj.DisposeOf;
  end;
end;

end.
