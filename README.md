# cosmo-bluesoft-api-delphi
Access Api Cosmo Bluesoft for Delphi (Pascal)

Classes para acessar a api Cosmo Bluesoft pelo Delphi

Criado por Andrews Bejatto.

Como utilizar:

**uses cosmos.api, cosmos.classes;**

	  var LObj: TGpcProductsClass;
	  try
	    LObj :=
	      TCosmoApi
	        .New
	        .Token('you token')
	        .Gtin('7896084101183');

	    if not Assigned(LObj.Error) then
		  Memo1.Lines.Add(LObj.description)
	    else
	      Memo1.Lines.Add(LObj.Error.message);
	  finally
	    LObj.DisposeOf;
	  end;
