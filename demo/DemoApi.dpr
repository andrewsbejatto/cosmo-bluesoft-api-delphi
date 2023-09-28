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
  cosmos.api in '..\src\cosmos.api.pas',
  cosmos.classes in '..\src\cosmos.classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
