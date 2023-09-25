# cosmo-bluesoft-api-delphi
Access Api Cosmo Bluesoft for Delphi (Pascal)

Classes para acessar a api Cosmo Bluesoft pelo Delphi

Criado por Andrews Bejatto.

Como utilizar:

uses cosmo.api, cosmo.classes;

  var LProd : TObject;
  try
    LProd :=
      TCosmoApi
        .New
        .Token('you token')
        .Gtins('7896084101183');

    if LProd is TProductClass then
      Memo1.Lines.Add(TProductClass(LProd).description)
    else
      Memo1.Lines.Add(TCosmoError(LProd).message);

  finally
    LProd.DisposeOf;
  end;
