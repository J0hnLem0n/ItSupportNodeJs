object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object screenImage: TImage
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    Align = alClient
    OnClick = screenImageClick
    OnDblClick = screenImageDblClick
    OnMouseDown = screenImageMouseDown
    OnMouseUp = screenImageMouseUp
    ExplicitLeft = 392
    ExplicitTop = 88
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object tcpClient: TIdTCPClient
    ConnectTimeout = 0
    Host = '172.16.0.110'
    IPVersion = Id_IPv4
    Port = 8124
    ReadTimeout = -1
    Left = 56
    Top = 32
  end
  object sendDataTimer: TTimer
    Interval = 500
    OnTimer = sendDataTimerTimer
    Left = 224
    Top = 104
  end
end
