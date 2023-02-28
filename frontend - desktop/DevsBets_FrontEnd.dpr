program DevsBets_FrontEnd;

uses
  System.StartUpCopy,
  FMX.Forms,
  UEntity.Logins in '..\backend\model\entities\UEntity.Logins.pas',
  UEntity.Users in '..\backend\model\entities\UEntity.Users.pas',
  UEntity.Teams in '..\backend\model\entities\UEntity.Teams.pas',
  UEntity.Matchs in '..\backend\model\entities\UEntity.Matchs.pas',
  UEntity.Bets in '..\backend\model\entities\UEntity.Bets.pas',
  UfrmHome in 'views\UfrmHome.pas' {frmHome},
  UfrmLogin.Authentication in 'views\UfrmLogin.Authentication.pas' {frmLoginAuthentication},
  UfrmLogin in 'views\UfrmLogin.pas' {frmLogin},
  UfrmLogin.Registry in 'views\UfrmLogin.Registry.pas' {frmLoginRegistry},
  UService.Base in 'services\UService.Base.pas',
  UService.Bet in 'services\UService.Bet.pas',
  UService.Intf in 'services\UService.Intf.pas',
  UService.Login in 'services\UService.Login.pas',
  UService.Match in 'services\UService.Match.pas',
  UService.Team in 'services\UService.Team.pas',
  UService.User.Authenticated in 'services\UService.User.Authenticated.pas',
  UService.User in 'services\UService.User.pas',
  UUtils.Constants in 'utils\UUtils.Constants.pas',
  UUtils.Enums in 'utils\UUtils.Enums.pas',
  UUtils.Functions in 'utils\UUtils.Functions.pas',
  UfraBet in 'views\UfraBet.pas' {fraBet: TFrame},
  UfraBet.Registry in 'views\UfraBet.Registry.pas' {fraBetRegistry: TFrame},
  UfraTeam in 'views\UfraTeam.pas' {fraTeam: TFrame},
  UfraTeam.Registry in 'views\UfraTeam.Registry.pas' {fraTeamRegistry: TFrame},
  UfraMatch in 'views\UfraMatch.pas' {fraMatch: TFrame},
  UfraMatch.Registry in 'views\UfraMatch.Registry.pas' {fraMatchRegistry: TFrame};

{$R *.res}

begin
  //Nunca esquecer de desativar a coleta de MemoryLeak
  //Sen�o vai apresentar mensagem ao usu�rio caso a aplica��o
  //apresente MemoryLeak
  //Aqui Podemos utilizar diretiva de compila��o
  //para ficar ativo somente em modo Debug (#FicaADica)
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
