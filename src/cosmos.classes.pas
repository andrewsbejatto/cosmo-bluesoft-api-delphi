unit cosmos.classes;

interface

uses Generics.Collections;

type
  TCosmosError = class
    private
      FMessage: String;
    public
      property &message: String read FMessage write FMessage;
      constructor Create(AValue: String); overload;
  end;

  TCosmosClass = class
    private
      FError: TCosmosError;
    public
      property Error: TCosmosError read FError write FError;
      destructor Destroy; override;
  end;

  TNcmClass = class
  private
    FCode: String;
    FDescription: String;
    FFull_description: String;
  public
    property code: String read FCode write FCode;
    property description: String read FDescription write FDescription;
    property full_description: String read FFull_description write FFull_description;
  end;

  TCommercial_unitClass = class
  private
    FQuantity_packaging: Extended;
    FType_packaging: String;
  public
    property quantity_packaging: Extended read FQuantity_packaging write FQuantity_packaging;
    property type_packaging: String read FType_packaging write FType_packaging;
  end;

  TGtinsClass = class
  private
    FCommercial_unit: TCommercial_unitClass;
    FGtin: Extended;
  public
    property commercial_unit: TCommercial_unitClass read FCommercial_unit write FCommercial_unit;
    property gtin: Extended read FGtin write FGtin;
    constructor Create;
    destructor Destroy; override;
  end;

  TCestClass = class
  private
    FCode: String;
    FDescription: String;
    FId: Extended;
    FParent_id: Extended;
  public
    property code: String read FCode write FCode;
    property description: String read FDescription write FDescription;
    property id: Extended read FId write FId;
    property parent_id: Extended read FParent_id write FParent_id;
  end;

  TGpcClass = class
  private
    FCode: String;
    FDescription: String;
  public
    property code: String read FCode write FCode;
    property description: String read FDescription write FDescription;
  end;

  TBrandClass = class
  private
    FName: String;
    FPicture: String;
  public
    property name: String read FName write FName;
    property picture: String read FPicture write FPicture;
  end;

  TProductClass = class(TCosmosClass)
  private
    FAvg_price: Extended;
    FBarcode_image: String;
    FCreated_at: String;
    FDescription: String;
    FGtin: Extended;
    FGtins: TArray<TGtinsClass>;
    FMax_price: Extended;
    FMin_price: Extended;
    FNcm: TNcmClass;
    FOrigin: String;
    FPrice: String;
    FUpdated_at: String;
    FLength: Extended;
    FWidth: Extended;
    FCest: TCestClass;
    FGpc: TGpcClass;
    FHeight: Extended;
    FBrand: TBrandClass;
  public
    property avg_price: Extended read FAvg_price write FAvg_price;
    property barcode_image: String read FBarcode_image write FBarcode_image;
    property created_at: String read FCreated_at write FCreated_at;
    property description: String read FDescription write FDescription;
    property gtin: Extended read FGtin write FGtin;
    property gtins: TArray<TGtinsClass> read FGtins write FGtins;
    property max_price: Extended read FMax_price write FMax_price;
    property min_price: Extended read FMin_price write FMin_price;
    property ncm: TNcmClass read FNcm write FNcm;
    property origin: String read FOrigin write FOrigin;
    property price: String read FPrice write FPrice;
    property updated_at: String read FUpdated_at write FUpdated_at;
    property cest: TCestClass read FCest write FCest;
    property gpc: TGpcClass read FGpc write FGpc;
    property height: Extended read FHeight write FHeight;
    property length: Extended read FLength write FLength;
    property width: Extended read FWidth write FWidth;
    property brand: TBrandClass read FBrand write FBrand;
    constructor Create;
    destructor Destroy; override;
  end;

  TGeneralClass = class(TCosmosClass)
  private
    FCode: String;
    FCurrent_page: Extended;
    FNext_page: String;
    FPer_page: Extended;
    FProducts: TArray<TProductClass>;
    FTotal_count: Extended;
    FTotal_pages: Extended;
  public
    property code: String read FCode write FCode;
    property current_page: Extended read FCurrent_page write FCurrent_page;
    property next_page: String read FNext_page write FNext_page;
    property per_page: Extended read FPer_page write FPer_page;
    property products: TArray<TProductClass> read FProducts write FProducts;
    property total_count: Extended read FTotal_count write FTotal_count;
    property total_pages: Extended read FTotal_pages write FTotal_pages;
    destructor Destroy; override;
  end;

  TGpcProductsClass = class(TGeneralClass)
  private
    FEnglish_description: String;
    FId: Extended;
    FLevel: Extended;
    FParent_id: Extended;
    FPortuguese: String;
  public
    property english_description: String read FEnglish_description write FEnglish_description;
    property id: Extended read FId write FId;
    property level: Extended read FLevel write FLevel;
    property parent_id: Extended read FParent_id write FParent_id;
    property portuguese: String read FPortuguese write FPortuguese;
  end;

  TNcmProductsClass = class(TGeneralClass)
  private
    FDescription: String;
    FFull_description: String;
  public
    property description: String read FDescription write FDescription;
    property full_description: String read FFull_description write FFull_description;
  end;

  TProductsClass = class(TGeneralClass);

implementation

{TGtinsClass}

constructor TGtinsClass.Create;
begin
  inherited;
  FCommercial_unit := TCommercial_unitClass.Create();
end;

destructor TGtinsClass.Destroy;
begin
  FCommercial_unit.free;
  inherited;
end;

{TProductClass}

constructor TProductClass.Create;
begin
  inherited;
  FNcm := TNcmClass.Create();
end;

destructor TProductClass.Destroy;
var
  LgtinsItem: TGtinsClass;
begin

 for LgtinsItem in FGtins do
   LgtinsItem.free;

  FGpc.free;
  FNcm.free;
  FCest.free;
  FBrand.Free;
  inherited;
end;

{ TCosmosError }

constructor TCosmosError.Create(AValue: String);
begin
  inherited Create;
  FMessage := AValue;
end;

{ TCosmosClass }

destructor TCosmosClass.Destroy;
begin
  FError.Free;
  inherited;
end;

{ TGeneralClass }

destructor TGeneralClass.Destroy;
begin
  for var LproductsItem in FProducts do
    LproductsItem.free;
  inherited;
end;

end.

