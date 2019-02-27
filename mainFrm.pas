unit mainFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Ani, FMX.Edit, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, ipwcore, ipwipinfo;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    btnSearch: TButton;
    edtIPorAS: TEdit;
    Layout3: TLayout;
    layIpInfo: TLayout;
    layAsnInfo: TLayout;
    BitmapAnimation1: TBitmapAnimation;
    Layout4: TLayout;
    Text1: TText;
    ListView1: TListView;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    ipwIPInfo1: TipwIPInfo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

function chkVirtualIP(const AValue:string):boolean;
var
  sList:TStringList;
  ipList: array[0..3] of integer;
begin
  sList:=TStringList.Create;
  try
    sList.Delimiter:='.';
    sList.DelimitedText:=AValue;

    ipList[0] :=  strtoint(sList[0]);
    ipList[1] :=  strtoint(sList[1]);
    ipList[2] :=  strtoint(sList[2]);
    ipList[3] :=  strtoint(sList[3]);
  finally
    sList.Free;
  end;

  Result:= false;
  case ipList[0] of
    10,127: Result:=true;
    169: if ipList[1] = 254 then Result:= true;
    172: if (ipList[1] > 15) and (ipList[1] < 31) then Result:= true;
    192: if ipList[1] = 168 then Result:= true;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
var I:integer;
begin
  for I := 0 to ipwIPInfo1.AdapterCount-1 do
  begin
    ipwIPInfo1.AdapterIndex := I;
    if chkVirtualIP(ipwIPInfo1.AdapterIPAddress) then Continue;

    edtIPorAS.Text := ipwIPInfo1.AdapterIPAddress;
    Break;
  end;
end;

end.
