unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.IBWrapper, System.UITypes, Vcl.VirtualImage,
  Vcl.ComCtrls, IniFiles, Vcl.Grids, Vcl.DBGrids;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QuerySearch: TFDQuery;
    QueryDelete: TFDQuery;
    FDIBBackup1: TFDIBBackup;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    pnlConnectionStatus: TPanel;
    Label1: TLabel;
    edtSearch: TEdit;
    memoLog: TMemo;
    Panel2: TPanel;
    lbxResults: TListBox;
    btnDelete: TButton;
    pnlResetButton: TPanel;
    Panel3: TPanel;
    btnBrowseClick: TButton;
    Label3: TLabel;
    Label2: TLabel;
    pnlConnectTest: TPanel;
    edtPath: TEdit;
    Label4: TLabel;
    edtServerIP: TEdit;
    edtPort: TEdit;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    DBGrid1: TDBGrid;
    QueryGame2: TFDQuery;
    dsGame2: TDataSource;
    DBGrid2: TDBGrid;
    QueryGame3: TFDQuery;
    dsGame3: TDataSource;
    QueryTotal: TFDQuery;
    dsTotal: TDataSource;
    DBGrid3: TDBGrid;
    cbTopLimit: TComboBox;
    cbTopLimit1: TComboBox;
    cbTopLimit2: TComboBox;
    btnPlayerScores: TButton;
    GroupBox1: TGroupBox;
    lblTotalPlayers: TLabel;
    lblTotalGames: TLabel;
    btnExportGame2: TButton;
    SaveDialog1: TSaveDialog;
    btnExportGame3Click: TButton;
    btnExportTotalClick: TButton;
    procedure FormCreate(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure lbxResultsClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure pnlResetButtonClick(Sender: TObject);
    procedure pnlConnectTestClick(Sender: TObject);
    procedure btnBrowseClickClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbTopLimitChange(Sender: TObject);
    procedure btnPlayerScoresClick(Sender: TObject);
    procedure btnExportGame2Click(Sender: TObject);
    procedure btnExportGame3ClickClick(Sender: TObject);
    procedure btnExportTotalClickClick(Sender: TObject);

  private
    procedure UpdateDashboardStats;
    procedure ExportToCSV(DataSet: TDataSet; const FileName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}



procedure TForm3.edtSearchChange(Sender: TObject);
begin
  if Length(edtSearch.Text) < 2 then
  begin
    lbxResults.Visible := False;
    Exit;
  end;

  // Prepare and execute the search query
  QuerySearch.Close;
  QuerySearch.SQL.Text := 'SELECT ID, ANZEIGENAME FROM TDOT_SPIELER WHERE UPPER(ANZEIGENAME) LIKE UPPER(:SearchText) ORDER BY ANZEIGENAME';
  QuerySearch.ParamByName('SearchText').AsString := edtSearch.Text + '%';

  try
    QuerySearch.Open;
    lbxResults.Items.Clear;

    // Populate the listbox with the search results
    while not QuerySearch.Eof do
    begin
      lbxResults.Items.Add(QuerySearch.FieldByName('ANZEIGENAME').AsString);
      QuerySearch.Next;
    end;

    // Show the listbox only if we found matching records
    lbxResults.Visible := (lbxResults.Items.Count > 0);
  except
    on E: Exception do
    begin
      memoLog.Lines.Add('[ERROR] Search query failed: ' + E.Message);
    end;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
  memoLog.Clear;
  memoLog.Lines.Add('--- System Initialized ---');
   PageControl1.ActivePageIndex := 4;

  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  try

    edtServerIP.Text := Ini.ReadString('ConnectionSettings', 'ServerIP', '127.0.0.1');
    edtPort.Text     := Ini.ReadString('ConnectionSettings', 'Port', '3050');
    edtPath.Text     := Ini.ReadString('ConnectionSettings', 'DatabasePath', 'C:\Database\Path\Game.fdb');
  finally
    Ini.Free;
  end;

  var
  Rgn: HRGN;
begin
  Rgn := CreateRoundRectRgn(0, 0, pnlresetbutton.Width, pnlresetbutton.Height, 8, 8);
  SetWindowRgn(pnlresetbutton.Handle, Rgn, True);
end;
end;

procedure TForm3.lbxResultsClick(Sender: TObject);
begin
  // If a valid item is selected
  if lbxResults.ItemIndex <> -1 then
  begin
    // Put the selected name into the search box
    edtSearch.Text := lbxResults.Items[lbxResults.ItemIndex];

    // Hide the listbox after selection
    lbxResults.Visible := False;
  end;
end;

procedure TForm3.PageControl1Change(Sender: TObject);
var
limit, limit1, limit2 : integer;
begin
  if not FDConnection1.Connected then Exit;

  limit := strtointdef(cbTopLimit.text,24);
  limit1 := strtointdef(cbTopLimit1.text,24);
  limit2 := strtointdef(cbTopLimit2.text,24);
  case PageControl1.ActivePageIndex of
    1:
      begin
        QueryGame2.Close;
        QueryGame2.ParamByName('TopLimit').AsInteger :=limit;
        QueryGame2.Open;
      end;

    2:
      begin
        QueryGame3.Close;
        QueryGame3.ParamByName('TopLimit1').AsInteger := limit1;
        QueryGame3.Open;
      end;

    3:
      begin
        QueryTotal.Close;
        QueryTotal.ParamByName('TopLimit2').AsInteger :=limit2;
        QueryTotal.Open;
      end;
  end;
end;

procedure TForm3.pnlConnectTestClick(Sender: TObject);
var
  Ini: TIniFile;
begin

  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  try
    Ini.WriteString('ConnectionSettings', 'ServerIP', edtServerIP.Text);
    Ini.WriteString('ConnectionSettings', 'Port', edtPort.Text);
    Ini.WriteString('ConnectionSettings', 'DatabasePath', edtPath.Text);
  finally
    Ini.Free;
  end;

  FDConnection1.Connected := False;
  FDConnection1.Params.Clear;

  FDConnection1.Params.Add('DriverID=FB');

  FDConnection1.Params.Add('Database=' + edtServerIP.Text + '/' + edtPort.Text + ':' + edtPath.Text);

  FDConnection1.Params.Add('User_Name=SYSDBA');
  FDConnection1.Params.Add('Password=stranger');
  FDConnection1.Params.Add('CharacterSet=UTF8');

  try

    FDConnection1.Connected := True;


    pnlConnectionStatus.Color := clGreen;
    pnlConnectionStatus.Caption := 'SYSTEM STATUS: ONLINE';
    UpdateDashboardStats;

    ShowMessage('Connection Successful! Ready for operations.');

    PageControl1.ActivePageIndex := 0;

  except
    on E: Exception do
    begin

      pnlConnectionStatus.Color := clRed;
      pnlConnectionStatus.Caption := 'SYSTEM OFFLINE (CONNECTION FAILED)';

      ShowMessage('CONNECTION FAILED! Please check your IP, Port, or Path.' + sLineBreak + 'Error Details: ' + E.Message);
    end;
  end;
end;

procedure TForm3.pnlResetButtonClick(Sender: TObject);
var
  AdminPass: string;
  BackupFileName: string;
begin
  // SECURITY CHECK
  AdminPass := InputBox('System Reset', 'Please enter the admin password:', '');

  if AdminPass <> 'ertan' then
  begin
    memoLog.Lines.Add('[SECURITY] Incorrect password. Reset aborted.');
    ShowMessage('Access Denied!');
    Exit;
  end;

  if MessageDlg('WARNING! A backup will be created and ALL data will be wiped. Continue?',
     mtWarning, [mbYes, mbNo], 0) <> mrYes then
  begin
    memoLog.Lines.Add('[INFO] Reset operation cancelled by user.');
    Exit;
  end;

  // DATABASE BACKUP
  memoLog.Lines.Add('[INFO] Starting database backup...');

  BackupFileName := 'C:\Users\Casper\OneDrive\Belgeler\Embarcadero\Studio\Projects\högemann\SPIELE_BACKUP\Backup_' + FormatDateTime('yyyymmdd_hhnn', Now) + '.fbk';

  FDIBBackup1.DriverLink := FDPhysFBDriverLink1;
  FDIBBackup1.Host := '127.0.0.1';
  FDIBBackup1.Protocol := ipTCPIP;
  FDIBBackup1.Port := 3050;

  FDIBBackup1.Database := 'C:\Users\Casper\OneDrive\Belgeler\Embarcadero\Studio\Projects\högemann\SPIELE_2608\SPIELE_2608.FDB';
  FDIBBackup1.BackupFiles.Clear;
  FDIBBackup1.BackupFiles.Add(BackupFileName);

  FDIBBackup1.UserName := 'SYSDBA';
  FDIBBackup1.Password := 'stranger';

  try
    FDIBBackup1.Backup;
    memoLog.Lines.Add('[SUCCESS] Backup created successfully: ' + BackupFileName);
  except
    on E: Exception do
    begin
      memoLog.Lines.Add('[CRITICAL] Backup failed! Deletion aborted to prevent data loss.');
      memoLog.Lines.Add('Details: ' + E.Message);
      Exit;
    end;
  end;

  // MASS DELETION
  memoLog.Lines.Add('[INFO] Backup secured. Initiating mass deletion...');

  FDConnection1.StartTransaction;
  try

    FDConnection1.ExecSQL('DELETE FROM TDOT_ERGEBNIS');


    FDConnection1.ExecSQL('DELETE FROM TDOT_SPIELER');


    FDConnection1.Commit;

    memoLog.Lines.Add('[SUCCESS] SYSTEM RESET COMPLETE. All tables are empty.');
    ShowMessage('System has been successfully reset.');
    UpdateDashboardStats;
  except
    on E: Exception do
    begin

      FDConnection1.Rollback;
      memoLog.Lines.Add('[CRITICAL] Deletion failed. Changes rolled back.');
      memoLog.Lines.Add('Details: ' + E.Message);
    end;
  end;
end;

procedure TForm3.btnBrowseClickClick(Sender: TObject);
begin

  OpenDialog1.Filter := 'Firebird Database (*.fdb)|*.fdb|All Files (*.*)|*.*';

  if OpenDialog1.Execute then
  begin
    edtPath.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm3.btnDeleteClick(Sender: TObject);
var
  SelectedName: string;
  PlayerID: Integer;
begin
  SelectedName := Trim(edtSearch.Text);

  if SelectedName = '' then
  begin
    memoLog.Lines.Add('[WARNING] Please select a user to delete.');
    Exit;
  end;

  if MessageDlg('Are you sure you want to completely delete "' + SelectedName + '" and all their data?',
     mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    memoLog.Lines.Add('[INFO] Delete operation cancelled by user.');
    Exit;
  end;

  // Finding players ID
  QueryDelete.Close;
  QueryDelete.SQL.Text := 'SELECT ID FROM TDOT_SPIELER WHERE ANZEIGENAME = :PlayerName';
  QueryDelete.ParamByName('PlayerName').AsString := SelectedName;
  QueryDelete.Open;

  if QueryDelete.IsEmpty then
  begin
    memoLog.Lines.Add('[ERROR] User "' + SelectedName + '" not found in database.');
    Exit;
  end;

  PlayerID := QueryDelete.FieldByName('ID').AsInteger;


  // Deleting
  FDConnection1.StartTransaction;

  try

    QueryDelete.Close;
    QueryDelete.SQL.Text := 'DELETE FROM TDOT_ERGEBNIS WHERE SPIELER_ID = :PID';
    QueryDelete.ParamByName('PID').AsInteger := PlayerID;
    QueryDelete.ExecSQL;


    QueryDelete.Close;
    QueryDelete.SQL.Text := 'DELETE FROM TDOT_SPIELER WHERE ID = :PID';
    QueryDelete.ParamByName('PID').AsInteger := PlayerID;
    QueryDelete.ExecSQL;


    FDConnection1.Commit;


    memoLog.Lines.Add('[SUCCESS] User "' + SelectedName + '" and their results were deleted.');
    edtSearch.Text := '';
    UpdateDashboardStats;
  except
    on E: Exception do
    begin

      FDConnection1.Rollback;
      memoLog.Lines.Add('[ERROR] Delete operation failed. Rolling back changes.');
      memoLog.Lines.Add('Details: ' + E.Message);
    end;
  end;
end;

procedure TForm3.ExportToCSV(DataSet: TDataSet; const FileName: string);
var
  List: TStringList;
  Line: string;
  i: Integer;
begin
  List := TStringList.Create;
  try

    Line := '';
    for i := 0 to DataSet.FieldCount - 1 do
    begin
      Line := Line + DataSet.Fields[i].DisplayLabel;

      if i < DataSet.FieldCount - 1 then Line := Line + ';';
    end;
    List.Add(Line);


    DataSet.DisableControls;
    DataSet.First;
    while not DataSet.Eof do
    begin
      Line := '';
      for i := 0 to DataSet.FieldCount - 1 do
      begin
        Line := Line + DataSet.Fields[i].AsString;
        if i < DataSet.FieldCount - 1 then Line := Line + ';';
      end;
      List.Add(Line);
      DataSet.Next;
    end;
    DataSet.First;
    DataSet.EnableControls;


    List.SaveToFile(FileName, TEncoding.UTF8);
  finally
    List.Free;
  end;
end;

procedure TForm3.btnExportGame2Click(Sender: TObject);
begin
  if not FDConnection1.Connected then Exit;
  if QueryGame2.IsEmpty then Exit;

  if SaveDialog1.Execute then
  begin
    ExportToCSV(QueryGame2, SaveDialog1.FileName);
    ShowMessage('The Game 2 list has been successfully exported to Excel!');
  end;
end;

procedure TForm3.btnExportGame3ClickClick(Sender: TObject);
begin
  if not FDConnection1.Connected then Exit;
  if QueryGame3.IsEmpty then Exit;

  if SaveDialog1.Execute then
  begin
    ExportToCSV(QueryGame3, SaveDialog1.FileName);
    ShowMessage('The Game 3 list has been successfully exported to Excel!');
  end;
end;

procedure TForm3.btnExportTotalClickClick(Sender: TObject);
begin
  if not FDConnection1.Connected then Exit;
  if QueryTotal.IsEmpty then Exit;

  if SaveDialog1.Execute then
  begin
    ExportToCSV(QueryTotal, SaveDialog1.FileName);
    ShowMessage('Total scores list has been successfully exported to Excel!');
  end;
end;

procedure TForm3.btnPlayerScoresClick(Sender: TObject);
var
Qry : TFDQuery;
PlayerID : Integer;
PlayerName : string;
G2Score, G3Score : string;
begin
 if not FDConnection1.Connected then exit;

 if QuerySearch.IsEmpty then
  begin
    ShowMessage('Choose a player from the list');
    exit;
  end;

  PlayerID := QuerySearch.FieldByName('ID').AsInteger;
  PlayerName := QuerySearch.FieldByName('ANZEIGENAME').AsString;

  Qry :=TFDQuery.Create(nil);
  try
    Qry.Connection := FDConnection1;
    Qry.SQL.Text :=
    'SELECT ' +
      '(SELECT MIN(ZEITSTEMPEL) FROM TDOT_ERGEBNIS WHERE SPIELER_ID = :PID AND SPIEL_ID = 2 AND ZEITSTEMPEL >= 0) AS BEST_G2, ' +
      '(SELECT MAX(ZAEHLER) FROM TDOT_ERGEBNIS WHERE SPIELER_ID = :PID AND SPIEL_ID = 3) AS BEST_G3 ' +
      'FROM RDB$DATABASE';

    Qry.ParamByName('PID').AsInteger := PlayerID;
    Qry.Open;

    if qry.FieldByName('Best_G2').IsNull then
    G2Score := 'Not Played'
    else
    G2Score := qry.FieldByName('Best_G2').AsString + ' ms';

    if qry.FieldByName('Best_G3').IsNull then
    G3Score := 'Not Played'
    else
    G3Score := qry.FieldByName('Best_G3').AsString + ' pts';

    ShowMessage(
      '--- PLAYER SCORECARD ---' + sLineBreak + sLineBreak +
      'Player Name : ' + PlayerName + sLineBreak +
      'Player ID   : ' + IntToStr(PlayerID) + sLineBreak + sLineBreak +
      'Game 2 (Best Time)  : ' + G2Score + sLineBreak +
      'Game 3 (Best Score) : ' + G3Score
    );

  finally
   Qry.free;
  end;

end;

procedure TForm3.cbTopLimitChange(Sender: TObject);

begin
pagecontrol1change(nil);
end;

procedure TForm3.UpdateDashboardStats;
var
  Qry: TFDQuery;
begin
  if not FDConnection1.Connected then Exit;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDConnection1;

    Qry.SQL.Text := 'SELECT COUNT(*) AS SUMM FROM TDOT_SPIELER';
    Qry.Open;
    lblTotalPlayers.Caption := 'Total Registered Players: ' + Qry.FieldByName('SUMM').AsString;
    Qry.Close;

    Qry.SQL.Text := 'SELECT COUNT(*) AS SUMM FROM TDOT_ERGEBNIS';
    Qry.Open;
    lblTotalGames.Caption := 'Total Games Played: ' + Qry.FieldByName('SUMM').AsString;

  finally

    Qry.Free;
  end;
end;

end.
