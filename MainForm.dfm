object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Painter'
  ClientHeight = 425
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = OnCreate
  OnDestroy = OnDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 24
    Width = 658
    Height = 401
    OnMouseDown = PaintBox1OnMouseDown
    OnMouseMove = PaintBox1OnMouseMove
    OnMouseUp = PaintBox1MouseUp
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 658
    Height = 29
    ButtonHeight = 29
    ButtonWidth = 78
    Caption = 'ToolBar1'
    TabOrder = 0
    object ToolButtonElipse: TToolButton
      Left = 0
      Top = 0
      Caption = 'Elipse'
      ImageIndex = 0
      OnClick = ToolButtonElipseClick
    end
    object ToolButton2: TToolButton
      Left = 78
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButtonRect: TToolButton
      Left = 86
      Top = 0
      Caption = 'Rectangle'
      ImageIndex = 1
      OnClick = ToolButtonRectClick
    end
    object ToolButton4: TToolButton
      Left = 164
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButtonLine: TToolButton
      Left = 172
      Top = 0
      Caption = 'Line'
      ImageIndex = 2
      OnClick = ToolButtonLineClick
    end
    object ToolButton6: TToolButton
      Left = 250
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButtonErase: TToolButton
      Left = 258
      Top = 0
      Caption = 'Eraser'
      ImageIndex = 3
      OnClick = ToolButtonEraseClick
    end
    object ToolButton1: TToolButton
      Left = 336
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButtonEdit: TToolButton
      Left = 344
      Top = 0
      Caption = 'ToolButton3'
      ImageIndex = 4
      OnClick = ToolButtonEditClick
    end
    object ToolButton3: TToolButton
      Left = 422
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButtonEraseAll: TToolButton
      Left = 430
      Top = 0
      Caption = 'ToolButton5'
      ImageIndex = 5
      OnClick = ToolButtonEraseAllClick
    end
    object ToolButton7: TToolButton
      Left = 508
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 6
      Style = tbsSeparator
    end
  end
end
