object SettingPagesDlg: TSettingPagesDlg
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = #20843#29226#40060#36873#39033#35774#32622
  ClientHeight = 452
  ClientWidth = 870
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 409
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    ExplicitWidth = 866
    ExplicitHeight = 408
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 860
      Height = 399
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 856
      ExplicitHeight = 398
      object TabSheet1: TTabSheet
        Caption = #20018#21475#35774#32622
        object Panel19: TPanel
          Left = 5
          Top = 97
          Width = 310
          Height = 250
          TabOrder = 0
          object Label13: TLabel
            Left = 5
            Top = 171
            Width = 64
            Height = 17
            Hint = #21457#36865#25968#25454#30340#26684#24335'ASCI'#20026#23383#31526'HEX'#20026#21313#20845#36827#21046'CMD'#20026#25191#34892#26412#22320'Shell'#21629#20196
            Caption = #21457#36865#26684#24335
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label15: TLabel
            Left = 5
            Top = 139
            Width = 64
            Height = 17
            Caption = #27969#25511#21046#31526
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 5
            Top = 108
            Width = 64
            Height = 17
            Caption = #26657#39564#20301#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 5
            Top = 77
            Width = 64
            Height = 17
            Caption = #20572#27490#20301#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 5
            Top = 46
            Width = 64
            Height = 17
            Caption = #25968#25454#20301#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 5
            Top = 15
            Width = 64
            Height = 17
            Caption = #27874#29305#29575#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 5
            Top = 201
            Width = 64
            Height = 17
            Caption = #25509#25910#26684#24335
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object ComboBox6: TComboBox
            Left = 76
            Top = 167
            Width = 224
            Height = 25
            Style = csDropDownList
            ItemIndex = 0
            ParentColor = True
            TabOrder = 0
            Text = 'ASCII Format            '#23383#31526#20018
            Items.Strings = (
              'ASCII Format            '#23383#31526#20018
              'Hexadecimal Format '#21313#20845#36827#21046' '
              'Octopus Protocol      '#21327#35758' ')
          end
          object ComboBox5: TComboBox
            Left = 76
            Top = 136
            Width = 224
            Height = 25
            Style = csDropDownList
            ParentColor = True
            TabOrder = 1
          end
          object ComboBox4: TComboBox
            Left = 76
            Top = 105
            Width = 224
            Height = 25
            Style = csDropDownList
            ParentColor = True
            TabOrder = 2
          end
          object ComboBox3: TComboBox
            Left = 76
            Top = 74
            Width = 224
            Height = 25
            Style = csDropDownList
            ParentColor = True
            TabOrder = 3
          end
          object ComboBox2: TComboBox
            Left = 76
            Top = 43
            Width = 224
            Height = 25
            Style = csDropDownList
            ParentColor = True
            TabOrder = 4
          end
          object ComboBox1: TComboBox
            Left = 76
            Top = 7
            Width = 224
            Height = 25
            Style = csDropDownList
            DropDownCount = 40
            ParentColor = True
            TabOrder = 5
          end
          object ComboBox7: TComboBox
            Left = 76
            Top = 198
            Width = 224
            Height = 25
            Style = csDropDownList
            ParentColor = True
            TabOrder = 6
          end
        end
        object Panel3: TPanel
          Left = 5
          Top = 13
          Width = 310
          Height = 73
          TabOrder = 1
          object ComboBoxEx1: TComboBoxEx
            Left = 5
            Top = 3
            Width = 295
            Height = 26
            ItemsEx = <>
            Style = csExDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnChange = ComboBoxEx1Change
          end
          object Button4: TButton
            Left = 5
            Top = 35
            Width = 295
            Height = 34
            Caption = #21047#26032#21487#29992#35774#22791
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object Button2: TButton
          Left = 665
          Top = 21
          Width = 88
          Height = 55
          Caption = #20445#23384#35774#32622
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ImageAlignment = iaRight
          ImageIndex = 0
          ParentFont = False
          TabOrder = 2
          OnClick = Button2Click
        end
        object Panel11: TPanel
          Left = 337
          Top = 13
          Width = 308
          Height = 193
          TabOrder = 3
          object Label4: TLabel
            Left = 8
            Top = 80
            Width = 140
            Height = 17
            Caption = #21313#20845#36827#21046#23545#40784#26041#24335'   '
          end
          object CheckBox12: TCheckBox
            Left = 8
            Top = 17
            Width = 287
            Height = 17
            Hint = #21246#19978#65292#25903#25345#20013#25991#31561#22810#22269#35821#35328#30340#25509#25910
            Caption = #25509#25910#20351#29992' UNICODE '#23383#31526#38598#32534#30721#65288#20013#25991#65289
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 0
          end
          object Combobox_CodePage: TComboBox
            Left = 8
            Top = 45
            Width = 293
            Height = 25
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 1
            Text = ' CP_ACP                { ANSI / GB2312  }'
            Items.Strings = (
              ' CP_ACP                { ANSI / GB2312  }'
              ' CP_OEMCP           { OEM  code page }'
              ' CP_MACCP           { MAC  code page }'
              ' CP_SYMBOL          { SYMBOL translations }'
              ' CP_UTF7               { UTF-7 translation }'
              ' CP_UTF8               { UTF-8 translation }')
          end
          object ComboBox8: TComboBox
            Left = 8
            Top = 102
            Width = 293
            Height = 25
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = 'Hexadecimal 16Bytes Align'
            Items.Strings = (
              'Hexadecimal 16Bytes Align'
              'Hexadecimal 32Bytes Align'
              'None')
          end
          object LabeledEdit1: TLabeledEdit
            Left = 8
            Top = 156
            Width = 293
            Height = 25
            Color = clWhite
            EditLabel.Width = 128
            EditLabel.Height = 17
            EditLabel.Caption = #25509#25910#24310#36831#65288#27627#31186#65289
            EditLabel.Color = clBtnHighlight
            EditLabel.ParentColor = False
            NumbersOnly = True
            TabOrder = 3
            Text = '30'
          end
        end
        object Button1: TButton
          Left = 665
          Top = 82
          Width = 88
          Height = 55
          Caption = #25171#24320
          TabOrder = 4
        end
      end
      object TabSheet2: TTabSheet
        Caption = #32593#32476#35774#32622
      end
      object TabSheet3: TTabSheet
        Caption = #39640#32423
        object GroupBox4: TGroupBox
          Left = 3
          Top = 3
          Width = 307
          Height = 210
          TabOrder = 0
          object CheckBox2: TCheckBox
            Left = 8
            Top = 8
            Width = 297
            Height = 25
            Caption = #22987#32456#20445#25345#22312#25152#26377#31383#21475#30340#26368#39030#23618
            TabOrder = 0
          end
          object CheckBox25: TCheckBox
            Left = 8
            Top = 39
            Width = 273
            Height = 25
            Caption = #21457#36865#21644#25509#25910#35760#24405#21069#38754#26174#31034#26102#38388#20449#24687
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMenuText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object CheckBox3: TCheckBox
            Left = 8
            Top = 67
            Width = 273
            Height = 25
            Caption = #21457#36865#21644#25509#25910#35760#24405#21069#38754#26174#31034#24180#26376#26085#26399
            TabOrder = 2
          end
          object CheckBox4: TCheckBox
            Left = 8
            Top = 95
            Width = 258
            Height = 25
            Caption = #25968#25454#35760#24405#21069#38754#26174#31034#34892#21495
            TabOrder = 3
          end
          object CheckBox5: TCheckBox
            Left = 8
            Top = 123
            Width = 249
            Height = 25
            Caption = #26174#31034#20018#21475#27491#22312#21457#36865#30340#25968#25454
            TabOrder = 4
          end
          object CheckBox6: TCheckBox
            Left = 8
            Top = 179
            Width = 258
            Height = 25
            Caption = 'Switch To English Language'
            Enabled = False
            TabOrder = 5
          end
          object CheckBox1: TCheckBox
            Left = 8
            Top = 151
            Width = 209
            Height = 25
            Caption = #22312#26700#38754#21019#24314#24555#25463#26041#24335
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 6
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 409
    Width = 870
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    ExplicitTop = 408
    ExplicitWidth = 866
    object OKBtn: TButton
      Left = 594
      Top = 1
      Width = 75
      Height = 34
      Caption = #36864#20986
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 674
      Top = 1
      Width = 75
      Height = 34
      Cancel = True
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
    object HelpBtn: TButton
      Left = 754
      Top = 1
      Width = 75
      Height = 34
      Caption = '&'#24110#21161
      TabOrder = 2
    end
  end
  object DeviceIconList: TImageList
    Left = 529
    Top = 1
  end
end
