unit Demo.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses cosmo.api, cosmo.classes;

procedure TForm1.Button1Click(Sender: TObject);
begin
  var LProd : TObject;
  try
    LProd :=
      TCosmoApi
        .New
        .Token('MT5ji0bEPr26AdHQcDrvUQ')
        .Gtins('7896084101183');

    if LProd is TProductClass then
      Memo1.Lines.Add(TProductClass(LProd).description)
    else
      Memo1.Lines.Add(TCosmoError(LProd).message);

  finally
    LProd.DisposeOf;
  end;
end;

end.
