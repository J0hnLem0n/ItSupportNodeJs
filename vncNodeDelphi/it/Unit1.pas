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
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure screenImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  idUsers: string;
begin
  tcpClient.Connect();
  tcpClient.Socket.WriteLn('helloIt,1000000001');
  //idUsers:=tcpClient.Socket.ReadLn;
  Form1.Text:=idUsers;
end;



procedure TForm1.screenImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  mouseCoord: TMouse;
begin
  mouseCoord:=TMouse.Create;
  tcpClient.Socket.WriteLn('coordMouse,1000000001,'+inttostr(mouseCoord.CursorPos.x)+'_'+inttostr(mouseCoord.CursorPos.y));
  Timer1.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  streamJpg: TMemoryStream;
  jpegImage: TJPEGImage;
begin
if tcpClient.Connected=true then
begin
 //tcpClient.IOHandler.WriteLn('connect');
 //tcpClient.Socket.WriteLn('getImage,1000000001');
 streamJpg:=TMemoryStream.Create;
 tcpClient.Socket.ReadStream(streamJpg);
 //*tcpClient.Socket.ReadStream(streamJpg);
 streamJpg.Position:=0;
 jpegImage := TJPEGImage.Create;
 jpegImage.LoadFromStream(streamJpg);
 jpegImage.SaveToFile('1a.jpeg');
 screenImage.Picture.Graphic:=jpegImage;
 jpegImage.Free;
 streamJpg.Clear;
 streamJpg.Free;
end
else
tcpClient.Connect();

end;

end.