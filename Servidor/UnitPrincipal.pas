unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TFrmPrincipal = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Horse,
     Horse.Jhonson,
     Horse.Exception,
     Horse.CORS,
     System.JSON;

procedure ListarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
    json: TJsonObject;
begin
    json := TJsonObject.Create;
    json.AddPair('idcliente', 1);
    json.AddPair('nome', 'Igor da Silva');
    json.AddPair('cidade', 'Tubarão');
    json.AddPair('uf', 'Sc');

    Res.Send<TJSONObject>(json);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    // Registro da rota...
    THorse.Get('/clientes', ListarClientes);

    THorse.Listen(3001);
end;

end.
