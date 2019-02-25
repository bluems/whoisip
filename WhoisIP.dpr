program WhoisIP;

uses
  System.StartUpCopy,
  FMX.Forms,
  WhoisIP in 'WhoisIP.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
