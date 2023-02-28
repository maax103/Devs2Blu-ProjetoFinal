unit UService.Team;

interface

uses
  UEntity.Teams,
  UService.Base,
  Generics.Collections;

type
  TServiceTeam = class(TServiceBase)
    private
      FTeam: TTeam;
      FTeams: TObjectList<TTeam>;

      function GetTeams: TObjectList<TTeam>;
    public
      constructor Create; overload;
      constructor Create(aTeam: TTeam); overload;
      destructor  Destroy; override;

      procedure Registrar; override;
      procedure Listar; override;
      procedure Excluir; override;

      function ObterRegistro(const aId: Integer): TObject; override;

      property Teams: TObjectList<TTeam> read GetTeams;
  end;

implementation

uses
  System.SysUtils,
  System.JSON, UUtils.Constants,
  DataSet.Serialize,
  FireDAC.comp.Client,
  REST.Types;

{ TServiceTeam }

constructor TServiceTeam.Create;
begin
  Inherited Create;

  FTeams := TObjectList<TTeam>.Create;
end;

constructor TServiceTeam.Create(aTeam: TTeam);
begin
  FTeam := aTeam;

  Self.Create;
end;

destructor TServiceTeam.Destroy;
begin
  FreeAndNil(FTeam);
  FreeAndNil(FTeams);
  inherited;
end;

procedure TServiceTeam.Excluir;
begin
  if (not Assigned(FTeam)) or (FTeam.Id = 0) then
    raise Exception.Create('Nenhum time foi escolhido para exclus�o.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_TEAM + '/%d', [FTeam.Id]);
    FRESTRequest.Method := rmDelete;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO_SEM_RETORNO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro n�o catalogado.');
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TServiceTeam.GetTeams: TObjectList<TTeam>;
begin
  Result := FTeams;
end;

procedure TServiceTeam.Listar;
var
  xMemTable: TFDMemTable;
begin
  FTeams.Clear;

  xMemTable := TFDMemTable.Create(nil);

  try
    try
      FRESTClient.BaseURL := URL_BASE_TEAM;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FTeams.Add(TTeam.Create(xMemTable.FieldByName('id').AsInteger,
                                    xMemTable.FieldByName('name').AsString));

            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usu�rio n�o autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de Times. C�digo do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except
      on e: exception do
        raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

function TServiceTeam.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //M�todo sem implementa��o no momento
end;

procedure TServiceTeam.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_TEAM;
    FRESTRequest.Method := rmPost;
    FRESTRequest.Params.AddBody(FTeam.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro n�o catalogado.');
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
