unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ExtCtrls,
  IdContext, IdCmdTCPClient, Jpeg;

type
  TForm1 = class(TForm)
    tcpClient: TIdTCPClient;
    screenImage: TImage;
    sendDataTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure sendDataTimerTimer(Sender: TObject);
    procedure screenImageClick(Sender: TObject);
    procedure screenImageDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  hello : String = '101,';  //����������� ��������
  coordMouse : String = '102,'; //�������� ��������� �����
  mouseClick : String = '103,'; //���� ���� �������
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  idUsers: string;
begin
  tcpClient.Connect();
  tcpClient.Socket.WriteLn(hello+'1000000001');
  //idUsers:=tcpClient.Socket.ReadLn;
  Form1.Text:=idUsers;
end;



procedure TForm1.screenImageClick(Sender: TObject);
begin
sendDataTimer.Enabled:=true;

end;

procedure TForm1.screenImageDblClick(Sender: TObject);
var
pointCur: TPoint;
begin
GetCursorPos(pointCur);
pointCur := Form1.ScreenToClient(pointCur);
//mouseEvents:=TMouse.Create;
tcpClient.Socket.WriteLn(mouseClick+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
end;

procedure TForm1.sendDataTimerTimer(Sender: TObject);
var
  streamJpg: TMemoryStream;
  jpegImage: TJPEGImage;
  //mouseEvents: TMouse;
  pointCur: TPoint;
begin
if tcpClient.Connected=true then
begin
//������������ �����
GetCursorPos(pointCur);
pointCur := Form1.ScreenToClient(pointCur);
//****************************
 //mouseEvents:=TMouse.Create;
 //tcpClient.Socket.WriteLn(coordMouse+'1000000001,'+inttostr(mouseEvents.CursorPos.x)+'_'+inttostr(mouseEvents.CursorPos.y));
 tcpClient.Socket.WriteLn(coordMouse+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
 streamJpg:=TMemoryStream.Create;
 tcpClient.Socket.ReadStream(streamJpg);
 streamJpg.Position:=0;
 jpegImage := TJPEGImage.Create;
 jpegImage.LoadFromStream(streamJpg);
 //jpegImage.SaveToFile('1a.jpeg');
 screenImage.Picture.Graphic:=jpegImage;
 jpegImage.Free;
 streamJpg.Clear;
 streamJpg.Free;
end
else
tcpClient.Connect();
end;

end.
