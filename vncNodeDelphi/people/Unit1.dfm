object mainForm: TmainForm
  Left = 0
  Top = 0
  Caption = 'mainForm'
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
  PixelsPerInch = 96
  TextHeight = 13
  object tcpClient: TIdTCPClient
    ConnectTimeout = 0
    Host = 'johnlemon.ru'
    IPVersion = Id_IPv4
    Port = 8124
    ReadTimeout = -1
    Left = 32
    Top = 48
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 288
    Top = 216
  end
end