object EntityForm: TEntityForm
  Left = 0
  Top = 0
  Width = 314
  Height = 448
  Caption = 'Entity'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 306
    Height = 73
    Align = alTop
    TabOrder = 0
    object lblID: TLabel
      Left = 8
      Top = 8
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object lblType: TLabel
      Left = 8
      Top = 27
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object sbAdd: TSpeedButton
      Left = 11
      Top = 46
      Width = 21
      Height = 21
      Glyph.Data = {
        E6010000424DE60100000000000036000000280000000C0000000C0000000100
        180000000000B001000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFE8E8E8D6D6D6D5D5D5D4D4D4D4D3D3E1E1E1FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFD6D6D6C8C8C8E0E0E0EEEEEEEFEFEFE7E7E7CDCDCDCCCCCCFFFFFFFF
        FFFFFFFFFFD7D7D7C3C3C3E6E6E6F5F5F5F6F6F6F6F6F6F5F5F5EEEEEECCCCCC
        C9C9C9FFFFFFE3E3E3BEBEBED1D1D1E7E7E7ECECEC808080808080EEEEEEE8E8
        E8DCDCDCBDBDBDDADADAD3D2D2B7B7B7D4D4D4DEDEDEE3E3E3808080808080E5
        E5E5DFDFDFD8D8D8BEBEBEC7C7C7CCCCCBB2B2B2CDCDCD808080808080808080
        808080808080808080D0D0D0B9B9B9C1C1C1CECECEB3B3B3C8C8C88080808080
        80808080808080808080808080CBCBCBB7B7B7C3C3C3DADADAB5B5B5C8C8C8E4
        E4E4E5E5E5808080808080E4E4E4E6E6E6D3D3D3B3B3B3D0D0D0E3E4E4C6C6C6
        BCBCBCEAEAEAF4F4F4808080808080F2F2F2F2F2F2C8C8C8BABABADFDFDFFFFF
        FFDCDCDCBFBFBFC1C1C1DFDFDFEDEDEDEFEFEFE5E5E5CACACABABABAD4D4D3FF
        FFFFFFFFFFFFFFFFDAD9D9C6C6C6BABABABCBCBCBDBDBDBBBBBBC0C0C0D6D5D5
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E2E1D4D4D4CACBCACACBCAD1D1D1DFE0
        DFFFFFFFFFFFFFFFFFFF}
      OnClick = sbAddClick
    end
    object sbDelete: TSpeedButton
      Left = 38
      Top = 46
      Width = 21
      Height = 21
      Glyph.Data = {
        E6010000424DE60100000000000036000000280000000C0000000C0000000100
        180000000000B001000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFE8E8E8D6D6D6D5D5D5D4D4D4D4D3D3E1E1E1FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFD6D6D6C8C8C8E0E0E0EEEEEEEFEFEFE7E7E7CDCDCDCCCCCCFFFFFFFF
        FFFFFFFFFFD7D7D7C3C3C3E6E6E6F5F5F5F6F6F6F6F6F6F5F5F5EEEEEECCCCCC
        C9C9C9FFFFFFE3E3E3BEBEBED1D1D1E7E7E7ECECECF0F0F0F1F1F1EEEEEEE8E8
        E8DCDCDCBDBDBDDADADAD3D2D2B7B7B7D4D4D4DEDEDEE3E3E3E9E9E9E9E9E9E5
        E5E5DFDFDFD8D8D8BEBEBEC7C7C7CCCCCBB2B2B2CDCDCD808080808080808080
        808080808080808080D0D0D0B9B9B9C1C1C1CECECEB3B3B3C8C8C88080808080
        80808080808080808080808080CBCBCBB7B7B7C3C3C3DADADAB5B5B5C8C8C8E4
        E4E4E5E5E5E5E5E5E5E5E5E4E4E4E6E6E6D3D3D3B3B3B3D0D0D0E3E4E4C6C6C6
        BCBCBCEAEAEAF4F4F4F2F2F2F2F2F2F2F2F2F2F2F2C8C8C8BABABADFDFDFFFFF
        FFDCDCDCBFBFBFC1C1C1DFDFDFEDEDEDEFEFEFE5E5E5CACACABABABAD4D4D3FF
        FFFFFFFFFFFFFFFFDAD9D9C6C6C6BABABABCBCBCBDBDBDBBBBBBC0C0C0D6D5D5
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E2E1D4D4D4CACBCACACBCAD1D1D1DFE0
        DFFFFFFFFFFFFFFFFFFF}
      OnClick = sbDeleteClick
    end
    object edID: TEdit
      Left = 80
      Top = 0
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object btType: TButton
      Left = 200
      Top = 24
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
    end
    object cbType: TComboBox
      Left = 80
      Top = 24
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 380
    Width = 306
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btOK: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btApply: TButton
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
    end
  end
  object ValueListEditor: TValueListEditor
    Left = 0
    Top = 73
    Width = 306
    Height = 307
    Align = alClient
    TabOrder = 2
    ColWidths = (
      150
      150)
  end
end