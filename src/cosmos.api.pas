unit cosmos.api;

interface

uses
  System.Classes,
  System.SysUtils,
  REST.Types,
  Rest.Json,
  RESTRequest4D,
  cosmos.classes;

type
  ICosmosApi = interface
  ['{6E5B1E9C-2E87-4FEB-B6D8-DE9611109FAB}'] //Ctrl + Sift + G = gerar assinatura da intgerface
    function Token(AValue: String): ICosmosApi;
    function Gtin(AValue: String): TProductClass;
    function Gpc(AValue: String): TGpcProductsClass;
    function Ncm(AValue: String): TNcmProductsClass;
    function Products(AValue: String): TProductsClass;
  end;

  TCosmosApi = class (TInterfacedObject, ICosmosApi)
    private
      FToken : String;
    private
      Constructor Create;
      Destructor Destroy; override;

      function Token(AValue: String): ICosmosApi;

      /// <summary> Recupera detalhes do produto atráves do GTIN/EAN informado. </summary>
      /// <param name="AValue"> Código GTIN/EAN </param>
      /// <returns>
      /// TProductClass se deu certo;
      /// TCosmoError se der algum erro.
      /// </returns>
      function Gtin(AValue: String): TProductClass;
      function Gpc(AValue: String): TGpcProductsClass;
      function Ncm(AValue: String): TNcmProductsClass;
      function Products(AValue: String): TProductsClass;
    public
      class function New: ICosmosApi;
  end;

const
  FBaseUrl = 'https://api.cosmos.bluesoft.com.br';

implementation

{ TCosmosApi }

constructor TCosmosApi.Create;
begin

end;

destructor TCosmosApi.Destroy;
begin

  inherited;
end;

function TCosmosApi.Ncm(AValue: String): TNcmProductsClass;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(FBaseUrl)
    .Resource('ncms')
    .ResourceSuffix(AValue + '/products')
    .AddHeader('X-Cosmos-Token', FToken, [poDoNotEncode])
    .Accept('application/json; charset=UTF-8')
    .Get;
  if LResponse.StatusCode = 200 then
  begin
    try
      Result := TJson.JsonToObject<TNcmProductsClass>(LResponse.Content, [joIgnoreEmptyStrings]);
    except on E:Exception do
      begin
        Result       := TNcmProductsClass.Create;
        Result.Error := TCosmosError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
  begin
    Result := TNcmProductsClass.Create;
    Result.Error := TJson.JsonToObject<TCosmosError>(LResponse.Content, [joIgnoreEmptyStrings]);
  end;
end;

class function TCosmosApi.New: ICosmosApi;
begin
  Result := Self.Create;
end;

function TCosmosApi.Products(AValue: String): TProductsClass;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.BaseURL(FBaseUrl)
    .Resource('products')
    .AddParam('query', AValue)
    .AddHeader('X-Cosmos-Token', FToken, [poDoNotEncode])
    .Accept('application/json; charset=UTF-8')
    .Get;
  if LResponse.StatusCode = 200 then
  begin
    try
      Result := TJson.JsonToObject<TProductsClass>(LResponse.Content, [joIgnoreEmptyStrings]);
    except on E:Exception do
      begin
        Result       := TProductsClass.Create;
        Result.Error := TCosmosError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
  begin
    Result := TProductsClass.Create;
    Result.Error := TJson.JsonToObject<TCosmosError>(LResponse.Content, [joIgnoreEmptyStrings]);
  end;
end;

function TCosmosApi.Token(AValue: String): ICosmosApi;
begin
  Result := Self;
  FToken := AValue;
end;

function TCosmosApi.Gtin(AValue: String): TProductClass;
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
        Result       := TProductClass.Create;
        Result.Error := TCosmosError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
  begin
    Result := TProductClass.Create;
    Result.Error := TJson.JsonToObject<TCosmosError>(LResponse.Content, [joIgnoreEmptyStrings]);
  end;
end;

function TCosmosApi.Gpc(AValue: String): TGpcProductsClass;
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
        Result       := TGpcProductsClass.Create;
        Result.Error := TCosmosError.Create('Error in json converter: ' + E.Message);
      end;
    end;
  end else
  begin
    Result       := TGpcProductsClass.Create;
    Result.Error := TJson.JsonToObject<TCosmosError>(LResponse.Content, [joIgnoreEmptyStrings]);
  end;
end;

end.
