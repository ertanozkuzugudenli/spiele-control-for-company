object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 537
  ClientWidth = 1108
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1108
    Height = 537
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Operation Center'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1100
        Height = 507
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 40
          Top = 115
          Width = 120
          Height = 28
          Caption = 'Search Player:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object pnlConnectionStatus: TPanel
          Left = 40
          Top = 447
          Width = 241
          Height = 41
          Caption = 'CONNECTING TO DATABASE...'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object edtSearch: TEdit
          Left = 40
          Top = 149
          Width = 241
          Height = 23
          TabOrder = 1
          TextHint = 'Type a player name to search...(z.B. ertan)'
          OnChange = edtSearchChange
        end
        object memoLog: TMemo
          Left = 40
          Top = 331
          Width = 241
          Height = 97
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Lines.Strings = (
            '')
          ParentFont = False
          TabOrder = 2
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 1100
          Height = 105
          Align = alTop
          Caption = 'USER INTERFACE'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold, fsUnderline]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
        end
        object lbxResults: TListBox
          Left = 40
          Top = 181
          Width = 241
          Height = 97
          ItemHeight = 15
          TabOrder = 4
          Visible = False
          OnClick = lbxResultsClick
        end
        object btnDelete: TButton
          Left = 800
          Top = 153
          Width = 251
          Height = 65
          Caption = 'Delete Player'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = btnDeleteClick
        end
        object pnlResetButton: TPanel
          Left = 800
          Top = 398
          Width = 251
          Height = 65
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Reset All Data'
          Color = clFirebrick
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          OnClick = pnlResetButtonClick
        end
        object btnPlayerScores: TButton
          Left = 800
          Top = 275
          Width = 251
          Height = 65
          Caption = 'Show Score'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = btnPlayerScoresClick
        end
        object GroupBox1: TGroupBox
          Left = 408
          Top = 118
          Width = 289
          Height = 100
          Caption = 'Live System Analytitcs:'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          ShowFrame = False
          TabOrder = 8
          object lblTotalPlayers: TLabel
            Left = 16
            Top = 32
            Width = 133
            Height = 28
            Caption = 'Total Players: 0 '
          end
          object lblTotalGames: TLabel
            Left = 16
            Top = 66
            Width = 126
            Height = 28
            Caption = 'Total Games: 0'
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'High Scores for Game 2'
      ImageIndex = 2
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 1100
        Height = 507
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 1
          Top = 1
          Width = 1098
          Height = 505
          Align = alClient
          DataSource = dsGame2
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object cbTopLimit: TComboBox
          Left = 936
          Top = 1
          Width = 145
          Height = 23
          TabOrder = 1
          Text = 'Top 24'
          OnChange = cbTopLimitChange
          Items.Strings = (
            '5'
            '10'
            '25'
            '50'
            '100')
        end
        object btnExportGame2: TButton
          Left = 936
          Top = 480
          Width = 145
          Height = 23
          Caption = 'Export to Excel (CSV)'
          TabOrder = 2
          OnClick = btnExportGame2Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'High Scores for Game 3'
      ImageIndex = 3
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 1102
        Height = 515
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object DBGrid2: TDBGrid
          Left = 1
          Top = 1
          Width = 1100
          Height = 513
          Align = alClient
          DataSource = dsGame3
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object cbTopLimit1: TComboBox
          Left = 936
          Top = 1
          Width = 145
          Height = 23
          TabOrder = 1
          Text = 'Top 24'
          OnChange = cbTopLimitChange
          Items.Strings = (
            '5'
            '10'
            '25'
            '50'
            '100')
        end
        object btnExportGame3Click: TButton
          Left = 936
          Top = 480
          Width = 145
          Height = 23
          Caption = 'Export to Excel (CSV)'
          TabOrder = 2
          OnClick = btnExportGame3ClickClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'High Scores Total'
      ImageIndex = 4
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1102
        Height = 515
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object DBGrid3: TDBGrid
          Left = 1
          Top = 1
          Width = 1100
          Height = 513
          Align = alClient
          DataSource = dsTotal
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object cbTopLimit2: TComboBox
          Left = 936
          Top = 1
          Width = 145
          Height = 23
          TabOrder = 1
          Text = 'Top 24'
          OnChange = cbTopLimitChange
          Items.Strings = (
            '5'
            '10'
            '25'
            '50'
            '100')
        end
        object btnExportTotalClick: TButton
          Left = 936
          Top = 480
          Width = 145
          Height = 23
          Caption = 'Export to Excel (CSV)'
          TabOrder = 2
          OnClick = btnExportTotalClickClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Connection Settings'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1102
        Height = 515
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 32
          Top = 128
          Width = 27
          Height = 15
          Caption = 'Port:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 32
          Top = 28
          Width = 55
          Height = 15
          Caption = 'Server IP:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 32
          Top = 228
          Width = 28
          Height = 15
          Caption = 'Path:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnBrowseClick: TButton
          Left = 276
          Top = 248
          Width = 23
          Height = 23
          Caption = '...'
          TabOrder = 0
          OnClick = btnBrowseClickClick
        end
        object pnlConnectTest: TPanel
          Left = 32
          Top = 448
          Width = 185
          Height = 41
          Caption = 'SAVE AND CONNECT'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = pnlConnectTestClick
        end
        object edtPath: TEdit
          Left = 32
          Top = 248
          Width = 242
          Height = 23
          TabOrder = 2
        end
        object edtServerIP: TEdit
          Left = 32
          Top = 48
          Width = 242
          Height = 23
          TabOrder = 3
        end
        object edtPort: TEdit
          Left = 32
          Top = 148
          Width = 242
          Height = 23
          TabOrder = 4
        end
      end
    end
  end
  object FDConnection1: TFDConnection
    Left = 464
    Top = 336
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 360
    Top = 264
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 568
    Top = 264
  end
  object QuerySearch: TFDQuery
    Connection = FDConnection1
    Left = 568
    Top = 336
  end
  object QueryDelete: TFDQuery
    Connection = FDConnection1
    Left = 664
    Top = 264
  end
  object FDIBBackup1: TFDIBBackup
    Left = 472
    Top = 264
  end
  object OpenDialog1: TOpenDialog
    Left = 652
    Top = 338
  end
  object QueryGame2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT FIRST :TopLimit '
      '       RANK() OVER (ORDER BY MIN(E.ZEITSTEMPEL) ASC) AS RANKING,'
      '       S.ANZEIGENAME AS PLAYER_NAME, '
      '       MIN(E.ZEITSTEMPEL) AS BEST_TIME'
      'FROM TDOT_ERGEBNIS E'
      'JOIN TDOT_SPIELER S ON E.SPIELER_ID = S.ID'
      'WHERE E.SPIEL_ID = 2 '
      '  AND E.ZEITSTEMPEL >= 0 '
      '  AND E.ZEITSTEMPEL <= 15000'
      'GROUP BY S.ANZEIGENAME, E.SPIELER_ID')
    Left = 380
    Top = 418
    ParamData = <
      item
        Name = 'TOPLIMIT'
        ParamType = ptInput
      end>
  end
  object dsGame2: TDataSource
    DataSet = QueryGame2
    Left = 380
    Top = 490
  end
  object QueryGame3: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT FIRST :TopLimit1  '
      '       RANK() OVER (ORDER BY MAX(E.ZAEHLER) DESC) AS RANKING,'
      '       S.ANZEIGENAME AS PLAYER_NAME, '
      '       MAX(E.ZAEHLER) AS BEST_SCORE'
      'FROM TDOT_ERGEBNIS E'
      'JOIN TDOT_SPIELER S ON E.SPIELER_ID = S.ID'
      'WHERE E.SPIEL_ID = 3'
      'GROUP BY S.ANZEIGENAME, E.SPIELER_ID')
    Left = 476
    Top = 418
    ParamData = <
      item
        Name = 'TOPLIMIT1'
        ParamType = ptInput
      end>
  end
  object dsGame3: TDataSource
    DataSet = QueryGame3
    Left = 468
    Top = 482
  end
  object QueryTotal: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'WITH Rank2_CTE AS ('
      '    SELECT SPIELER_ID, '
      '           MIN(ZEITSTEMPEL) AS BEST_TIME, '
      '           RANK() OVER (ORDER BY MIN(ZEITSTEMPEL) ASC) AS R2'
      '    FROM TDOT_ERGEBNIS'
      '    WHERE SPIEL_ID = 2 AND ZEITSTEMPEL >= 0 '
      '    GROUP BY SPIELER_ID'
      '),'
      'Rank3_CTE AS ('
      '    SELECT SPIELER_ID, '
      '           MAX(ZAEHLER) AS BEST_SCORE, '
      '           RANK() OVER (ORDER BY MAX(ZAEHLER) DESC) AS R3'
      '    FROM TDOT_ERGEBNIS'
      '    WHERE SPIEL_ID = 3'
      '    GROUP BY SPIELER_ID'
      ')'
      'SELECT FIRST :TopLimit2 '
      
        '       ROW_NUMBER() OVER (ORDER BY (R2.R2 + R3.R3) ASC, R2.R2 AS' +
        'C, R2.BEST_TIME ASC) AS RANKING,'
      '       S.ANZEIGENAME AS PLAYER_NAME, '
      '       (R2.R2 + R3.R3) AS TOTAL_RANK_SCORE'
      'FROM TDOT_SPIELER S'
      'INNER JOIN Rank2_CTE R2 ON S.ID = R2.SPIELER_ID'
      'INNER JOIN Rank3_CTE R3 ON S.ID = R3.SPIELER_ID'
      'ORDER BY RANKING ASC')
    Left = 564
    Top = 418
    ParamData = <
      item
        Name = 'TOPLIMIT2'
        ParamType = ptInput
      end>
  end
  object dsTotal: TDataSource
    DataSet = QueryTotal
    Left = 556
    Top = 482
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'Excel CSV Dosyas'#305' (*.csv)|*.csv'
    Left = 652
    Top = 418
  end
end
