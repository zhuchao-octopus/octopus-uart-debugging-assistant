unit uDockableControllerPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  ClassTFormDockable, VCLTee.TeCanvas, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls,
  OcComPortObj, Vcl.AppEvnts,
  System.IniFiles, Vcl.Tabs;

type
  TStringGridEx = class(TStringGrid);

type
  TFrmDockableController = class(TFormDockable)
    Panel6: TPanel;
    Notebook3: TNotebook;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Memo2: TMemo;
    Panel8: TPanel;
    Button7: TButton;
    Button8: TButton;
    Button25: TButton;
    Panel12: TPanel;
    Panel4: TPanel;
    Button1: TButton;
    Button3: TButton;
    Panel10: TPanel;
    Memo5: TMemo;
    Panel16: TPanel;
    Button16: TButton;
    Button27: TButton;
    Button28: TButton;
    Panel18: TPanel;
    Label18: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    ComboBox12: TComboBox;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    Panel9: TPanel;
    GroupBox10: TGroupBox;
    CheckBox10: TCheckBox;
    Button15: TButton;
    Button18: TButton;
    Button19: TButton;
    ButtonColor1: TButtonColor;
    ButtonColor2: TButtonColor;
    CheckBox11: TCheckBox;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Panel15: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    TabSet3: TTabSet;
    ApplicationEvents1: TApplicationEvents;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure TabSet3Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure Button7Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    StringGrid1_Col, StringGrid1_Row: Integer;
    FCheck, FNoCheck: TBitmap;
    { Private declarations }
    procedure InitComponent();
    procedure ComponentResize();
    procedure InitStringGrid();
    function GetStringGridValidStr(sStr: String): String;

  public
    { Public declarations }
    procedure OnTabSetChange(Sender: TObject; NewTab: Integer);
    procedure StringGridSelectCell(ACol, ARow: Integer);
    procedure StringGridSave();
    procedure StringGridLoad();
  end;

const
  CHECKCOL: Integer = 3;

var
  FrmDockableController: TFrmDockableController;

implementation

{$R *.dfm}

uses uSetting, uOctopusFunction;

function TFrmDockableController.GetStringGridValidStr(sStr: String): String;
var
  strstr: String;
  Pos: Integer;
begin
  Result := '';
  // str := Trim(sStr);
  Pos := PosEx('#', sStr);
  if (Pos > 0) then
    strstr := Copy(sStr, 1, Pos - 1)
  else
    strstr := sStr;
  Pos := PosEx('//', strstr);
  if (Pos > 0) then
    Result := Trim(Copy(strstr, 1, Pos - 1))
  else
    Result := Trim(strstr)
end;

procedure TFrmDockableController.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Save();
end;

procedure TFrmDockableController.FormCreate(Sender: TObject);
begin
  InitComponent();
  InitStringGrid();
  //Load();
end;

procedure TFrmDockableController.FormResize(Sender: TObject);
begin
  ComponentResize();
end;

procedure TFrmDockableController.FormShow(Sender: TObject);
begin
  InitComponent();
  ComponentResize();
end;

procedure TFrmDockableController.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
// var
// vCol, vRow: Integer;
begin
  with TStringGridEx(StringGrid1) do
  begin
    if Msg.hwnd <> Handle then
      Exit;
    case Msg.message of
      WM_LBUTTONDOWN:
        begin
          MouseToCell(LoWord(Msg.lParam), HiWord(Msg.lParam), StringGrid1_Col, StringGrid1_Row);
          { if vCol = 3 then
            begin
            FocusCell(vCol, vRow, False);
            // Handled := True;
            end; }
        end;
    end;
  end;
end;

procedure TFrmDockableController.Button7Click(Sender: TObject);
begin
  Memo2.Clear;
end;

procedure TFrmDockableController.ComponentResize();
begin
  try
    Button1.Width := Panel6.Width - Button3.Width - 7;

    Button8.Width := Panel6.Width - Button7.Width - 7;

    Button16.Width := Panel6.Width - Button27.Width - 7;

    // Button9.Width := Memo3.Width + 2;
    // Button11.Width := Memo3.Width + 2;
    // Button25.Width := Button9.Width;
    // Button28.Width := Button9.Width;
    // Button13.Width := Button11.Width;

    ComboBox9.Width := Memo5.Width - Label7.Width - 25;
    ComboBox10.Width := ComboBox9.Width;
    ComboBox11.Width := ComboBox9.Width;
    ComboBox12.Width := ComboBox9.Width;

    ComboBox10.Left := ComboBox9.Left;
    ComboBox11.Left := ComboBox9.Left;
    ComboBox12.Left := ComboBox9.Left;

    Panel15.Width := GroupBox10.Width - 8;
    Button15.Width := Panel15.Width;
    Button21.Width := Panel15.Width;
    Button18.Width := Panel15.Width;
    Button19.Width := Panel15.Width;
    Button20.Width := Panel15.Width;
    Button22.Width := Panel15.Width;
    ButtonColor1.Width := Panel15.Width;
    ButtonColor2.Width := Panel15.Width;
  finally
  end;
end;

procedure TFrmDockableController.InitComponent();
begin
  Notebook3.Pages[0] := '数据发送';
  Notebook3.Pages[1] := '批量发送 ';
  Notebook3.Pages[2] := '协议发送 ';
  Notebook3.Pages[3] := '图形 ';
  TabSet3.Tabs := Notebook3.Pages;
end;

procedure TFrmDockableController.TabSet3Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  AllowChange := True;
  OnTabSetChange(TabSet3, NewTab);
end;

procedure TFrmDockableController.OnTabSetChange(Sender: TObject; NewTab: Integer);
var
  i: Integer;
  str: String;
begin
  if NewTab < 0 then
    Exit;
  if Sender = TObject(TabSet3) then
  begin
    Notebook3.PageIndex := NewTab;
  end;
end;

procedure TFrmDockableController.InitStringGrid();
var
  bmp: TBitmap;
  i: Integer;
  // GridRect: TGridRect;
begin
  try
    FCheck := TBitmap.Create;
    FNoCheck := TBitmap.Create;
    bmp := TBitmap.Create;
    bmp.Handle := LoadBitmap(0, PChar(OCR_CROSS));
    bmp.PixelFormat := pf32bit;
    bmp.HandleType := bmDIB;
    bmp.Transparent := True;
    bmp.TransparentColor := clWhite;
    // Bmp.Canvas.Brush.Color := clWhite;
    // Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));

    FNoCheck.PixelFormat := pf32bit;
    FNoCheck.HandleType := bmDIB;
    FNoCheck.Transparent := True;
    FNoCheck.TransparentColor := clWhite;
    with FNoCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Canvas.cliprect);
    end;
    with FCheck do
    begin
      Width := bmp.Width div 4;
      Height := bmp.Height div 3;
      Canvas.CopyRect(Canvas.cliprect, bmp.Canvas, Rect(Width, 0, 2 * Width, Height));
    end;
  finally
    DeleteObject(bmp.Handle);
    bmp.Free;
  end;

  StringGrid1.RowCount := 1000;
  StringGrid1.ColCount := 7;
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 50;
  StringGrid1.ColWidths[2] := 300;
  StringGrid1.ColWidths[3] := 32;
  StringGrid1.ColWidths[4] := 40;
  StringGrid1.ColWidths[5] := 40;
  StringGrid1.FixedCols := 2;
  StringGrid1.FixedRows := 1;

  StringGrid1.Cells[0, 0] := '字符';
  StringGrid1.Cells[1, 0] := '字节';
  StringGrid1.Cells[2, 0] := '待发送文本内容';

  StringGrid1.Cells[4, 0] := '循环';
  StringGrid1.Cells[5, 0] := '间隔';
  // StringGrid1.Cells[6, 0] := '解释说明';
  StringGrid1.Align := alClient;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := Format('%.04d ', [i]); // '0' + inttostr(i)
    StringGrid1.Cells[1, i] := Format('%.04x ', [i]);

    StringGrid1.Cells[CHECKCOL, i] := '0';
    StringGrid1.Cells[4, i] := '1';
    StringGrid1.Cells[5, i] := '10';
  end;
  { with GridRect do
    begin
    Top := 2;
    Left := 2;
    Bottom := 2;
    Right := 2;
    end;
    StringGrid1.Selection := GridRect; }

  // if Button1.Width > 240 then
  // StringGrid1.ColWidths[2] := 240 + (Button1.Width - 240) div 2
  // else
end;

procedure TFrmDockableController.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  try
    if ACol = CHECKCOL then
    begin
      // StringGrid1.BeginUpdate;
      // if not(gdFixed in State) then
      with TStringGrid(Sender).Canvas do
      begin
        Brush.Color := clWindow;
        fillRect(Rect);
        //if StringGrid1.Cells[ACol, ARow] = '1' then
          Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FCheck)
        //else
        //  Draw((Rect.Right + Rect.Left - FCheck.Width) div 2 - 2, (Rect.Bottom + Rect.Top - FCheck.Height) div 2, FNoCheck);
      end;
      // StringGrid1.EndUpdate;
    end;
  except
  end;
end;

procedure TFrmDockableController.StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
var
  GridRect: TGridRect;
  str: String;
  OcComPortObj: TOcComPortObj;
  buffer: array [0 .. 512] of byte;
  bLength: Integer;
  BytesWritten: Cardinal;
begin
  if ARow <= 0 then
    Exit;
  OcComPortObj := SettingPagesDlg.getCurrentDevice();
  if OcComPortObj = nil then
  begin
    MessageBox(Application.Handle, PChar('No device!! You need to open a device,please use F1 to see how to do that'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    Exit;
  end;

  StringGridSelectCell(ACol, ARow);

  str := GetStringGridValidStr(StringGrid1.Cells[2, ARow]);

  if ACol = 0 then
    OcComPortObj.FalconComSendData_Common(str, 0);
  if ACol = 1 then
    OcComPortObj.FalconComSendData_Common(str, 1);

end;

procedure TFrmDockableController.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (StringGrid1.Col = 4) or (StringGrid1.Col = 5) then
  begin
    if not(Key in ['0' .. '9', #8]) then
      Key := #0;
  end;
end;

procedure TFrmDockableController.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// var
// ww, c, r, i: Integer;
begin
  { c := 0;
    r := 0;
    ww := 0;
    for i := 0 to StringGrid1.ColCount - 1 do
    begin
    ww := ww + StringGrid1.ColWidths[i] + StringGrid1.BevelWidth;
    if (X > ww - StringGrid1.ColWidths[i]) and (X < ww) then
    c := i;
    end;

    ww := 0;
    for i := 0 to StringGrid1.RowCount - 1 do
    begin
    ww := ww + StringGrid1.RowHeights[i] + StringGrid1.BevelWidth;
    if (Y > ww - StringGrid1.RowHeights[i]) and (Y < ww) then
    r := i;
    end; }

  if (StringGrid1_Col = CHECKCOL) OR (StringGrid1_Col = 1) OR (StringGrid1_Col = 0) then
    StringGridSelectCell(StringGrid1_Col, StringGrid1_Row);
end;

procedure TFrmDockableController.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  with StringGrid1 do
  begin
    CanSelect := True;
    if ACol in [CHECKCOL] then
      Options := Options - [goEditing]
    else
      Options := Options + [goEditing];
  end;
end;

procedure TFrmDockableController.StringGridSelectCell(ACol, ARow: Integer);
var
  GridRect: TGridRect;
begin

  StringGrid1.BeginUpdate;
  if (ACol = CHECKCOL) and (ARow > 0) then
  begin
    if StringGrid1.Cells[ACol, ARow] = '1' then
      StringGrid1.Cells[ACol, ARow] := '0'
    else if StringGrid1.Cells[ACol, ARow] = '0' then
      StringGrid1.Cells[ACol, ARow] := '1'
    else
      StringGrid1.Cells[ACol, ARow] := '0'
  end;

  if (ACol = 1) OR (ACol = 0) then
  begin
    with GridRect do
    begin
      Top := ARow; // StringGrid1.Selection.Top;
      Left := 0;
      Bottom := ARow;
      Right := 6;
    end;
    StringGrid1.Selection := GridRect;
  end;
  StringGrid1.EndUpdate;

end;

procedure TFrmDockableController.StringGridSave;
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  if SettingPagesDlg = nil then
    Exit;
  //s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      Octopusini.WriteString('MyCustData', IntToStr(i) + '_2', StringGrid1.Cells[2, i]);
      // Octopusini.WriteString('MyCustData', IntToStr(i) + '_5', StringGrid1.Cells[5, i]);
    end;
  finally
    Octopusini.Free;
  end;
end;

procedure TFrmDockableController.StringGridLoad;
var
  Octopusini: TIniFile;
  s: String;
  i: Integer;
begin
  if SettingPagesDlg = nil then
    Exit;

  //s := SettingPagesDlg.OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  try
    Octopusini := TIniFile.Create(s);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[2, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_2', '');
      // StringGrid1.Cells[5, i] := Octopusini.ReadString('MyCustData', IntToStr(i) + '_5', '');
    end;
  finally
    Octopusini.Free;
  end;
end;

end.
