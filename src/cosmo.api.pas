unit cosmo.api;

interface

uses
  System.Classes,
  System.SysUtils,
  REST.Types,
  Rest.Json,
  RESTRequest4D,
  cosmo.classes;

type
  ICosmoApi = interface
  ['{6E5B1E9C-2E87-4FEB-B6D8-DE9611109FAB}'] //Ctrl + Sift + G = gerar assinatura da intgerface
    function Token(AValue: String): ICosmoApi;
    function Gtins(AValue: String): TObject;
    function Gpcs(AValue: String): TObject;
  end;

  TCosmoApi = class (TInterfacedObject, ICosmoApi)
    private
      FToken : String;
    private
      Constructor Create;
      Destructor Destroy; override;

      function Token(AValue: String): ICosmoApi;

      /// <summary> Recupera detalhes do produto atráves do GTIN/EAN informado. </summary>
      /// <param name="AValue"> Código GTIN/EAN </param>
      /// <returns>
      /// TProductClass se deu certo;
      /// TCosmoError se der algum erro.
      /// </returns>
      function Gtins(AValue: String): TObject;
      function Gpcs(AValue: String): TObject;
    public
      class function New: ICosmoApi;
  end;

const
  FBaseUrl = 'https://api.cosmos.bluesoft.com.br';

implementation

{ TCosmoApi }

constructor TCosmoApi.Create;
begin

end;

destructor TCosmoApi.Destroy;
begin

  inherited;
end;

class function TCosmoApi.New: ICosmoApi;
begin
  Result := Self.Create;
end;

function TCosmoApi.Token(AValue: String): ICosmoApi;
begin
  Result := Self;
  FToken := AValue;
end;

function TCosmoApi.Gtins(AValue: String): TObject;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(FBaseUrl)
    .Resource('gtins')
    .ResourceSuffix(AValue)
    .AddHeader('X-Cosmos-Token', FToken, [poDoNotEncode])
    .Accept('application/json; charset=UTF-8')
    .Get;
  if LResponse.StatusCode = 200 then
  begin
    try
      Result := TJson.JsonToObject<TProductClass>(LResponse.Content, [joIgnoreEmptyStrings]);
    except on E:Exception do
      begin
        Result := TCosmoError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
    Result := TJson.JsonToObject<TCosmoError>(LResponse.Content, [joIgnoreEmptyStrings]);
end;

function TCosmoApi.Gpcs(AValue: String): TObject;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(FBaseUrl)
    .Resource('gpcs')
    .ResourceSuffix(AValue)
    .AddHeader('X-Cosmos-Token', FToken, [poDoNotEncode])
    .Accept('application/json; charset=UTF-8')
    .Get;
  if LResponse.StatusCode = 200 then
  begin
    try
      Result := TJson.JsonToObject<TGpcProductsClass>(LResponse.Content, [joIgnoreEmptyStrings]);
    except on E:Exception do
      begin
        Result := TCosmoError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
    Result := TJson.JsonToObject<TCosmoError>(LResponse.Content, [joIgnoreEmptyStrings]);
end;

end.
