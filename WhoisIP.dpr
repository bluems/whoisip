program WhoisIP;

uses
  System.StartUpCopy,
  FMX.Forms,
  mainFrm in 'mainFrm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
