program DemoApi;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  Demo.Home in 'Demo.Home.pas' {Form1},
  cosmo.api in '..\src\cosmo.api.pas',
  cosmo.classes in '..\src\cosmo.classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
