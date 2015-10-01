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
    procedure screenImageDblClick(Sender: TObject);
    procedure screenImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure screenImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  hello : string = '101,'; //����������� ��������
  coordMouse : string = '102,'; //�������� ��������� �����
  mouseClick : string = '103,'; //���� ���� �������
  mouseClickUp : string = '104,';
  mouseClickDown : string = '105,';
  mouseClickUpRbtn : string = '106,';
  mouseClickDownRbtn : string = '107,';
  keyBoardDown : string = '108,';
  keyBoardUp : string = '109,';
  keyBoardPress : string = '110,';
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



procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  btnShiftState:string;
begin
  //if ssShift in Shift then btnShiftState :='1' else btnShiftState:='0';
  tcpClient.Socket.WriteLn(keyBoardDown+'1000000001,'+IntToStr(Key));
end;


procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  btnShiftState:string;
begin
  //if ssShift in Shift then btnShiftState :='1' else btnShiftState:='0';
  tcpClient.Socket.WriteLn(keyBoardUp+'1000000001,'+IntToStr(Key));
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

procedure TForm1.screenImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pointCur: TPoint;
begin
  if Button = mbLeft then
  begin
    GetCursorPos(pointCur);
    pointCur := Form1.ScreenToClient(pointCur);
    tcpClient.Socket.WriteLn(mouseClickDown+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
  end;
  if Button = mbRight then
  begin
      GetCursorPos(pointCur);
      pointCur := Form1.ScreenToClient(pointCur);
      tcpClient.Socket.WriteLn(mouseClickDownRbtn+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
  end;
end;

procedure TForm1.screenImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pointCur: TPoint;
begin
  if Button = mbLeft then
  begin
    GetCursorPos(pointCur);
    pointCur := Form1.ScreenToClient(pointCur);
    tcpClient.Socket.WriteLn(mouseClickUp+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
  end;
  if Button = mbRight then
  begin
    GetCursorPos(pointCur);
    pointCur := Form1.ScreenToClient(pointCur);
    tcpClient.Socket.WriteLn(mouseClickUpRbtn+'1000000001,'+inttostr(pointCur.X)+'_'+inttostr(pointCur.Y));
  end;
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
