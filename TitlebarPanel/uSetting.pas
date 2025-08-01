unit uSetting;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  System.ImageList,
  Vcl.ImgList,
  OcComPortObj, Vcl.Mask;

type
  TSettingPagesDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    Panel19: TPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    ComboBox6: TComboBox;
    ComboBox5: TComboBox;
    ComboBox4: TComboBox;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ComboBox7: TComboBox;
    Panel3: TPanel;
    ComboBoxEx1: TComboBoxEx;
    Button4: TButton;
    DeviceIconList: TImageList;
    Button2: TButton;
    Panel11: TPanel;
    Label4: TLabel;
    CheckBox12: TCheckBox;
    Combobox_CodePage: TComboBox;
    ComboBox8: TComboBox;
    LabeledEdit1: TLabeledEdit;
    GroupBox4: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxEx1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
  public
    { Public declarations }
    OcComPortList: TStringList;
    OctopusCfgDir: String;
    OctopusCfgDir_LogFileName: String;
    VersionNumberStr: String;

    function getCurrentDeviceName(): String;
    function getDeciceByFullName(DeviceName: string): TOcComPortObj;
    function getCurrentDevice(): TOcComPortObj;

    function GetDeciceByPort(Port: string): TOcComPortObj;

    procedure updateSystemDevicesList(DevideName: String = ''; ActionType: Integer = $8000);
    procedure closeDevice(DeviceFullName: String);

    function openDevice(OcComPortObj: TOcComPortObj): Boolean; overload;
    function openDevice(DeviceFullName: String): TOcComPortObj; overload;
    function openDevice(DeviceFullName: String; LogMemo: TMemo; ParentPage: TPage): TOcComPortObj; overload;

    function openDeviceRandom(): TOcComPortObj;
    function getAvailableDevice(): TOcComPortObj;

    procedure FalconLoadCfg();
    procedure updateOcComPortObjAtrribute(OcComPortObj: TOcComPortObj = nil);
    procedure initSystemDevicesList();
  end;

var
  SettingPagesDlg: TSettingPagesDlg;

implementation

{$R *.dfm}

uses ocPcDeviceMgt, IniFiles, uOctopusFunction, CPort, CPortCtl;

function GetSystemDateTimeStampStr(): string;
var
  // lpSystemTime:TSystemTime;
  LocalSystemTime: _SYSTEMTIME;
begin
  Result := '';
  // Getsystemtime(lpSystemTime);
  GetLocalTime(LocalSystemTime);
  // Result:=Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',[lpSystemTime.wYear,lpSystemTime.wMonth,lpSystemTime.wDay,lpSystemTime.wHour,lpSystemTime.wMinute,lpSystemTime.wSecond]);
  Result := Format('%0.4d%0.2d%0.2d_%0.2d%0.2d%0.2d', [LocalSystemTime.wYear, LocalSystemTime.wMonth, LocalSystemTime.wDay, LocalSystemTime.wHour, LocalSystemTime.wMinute, LocalSystemTime.wSecond]);
end;

function FirstDriveFromMask(unitmask: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 25 do
  begin
    if Boolean(unitmask and 1) then
      Result := Result + Char(Integer('A') + i);
    unitmask := unitmask shr 1;
  end;
end;

function FalconGetComPort(DriverName: string): string;
// const
// pattern = 'COM +d';
var
  ss: string;
  i1, i2: Integer;
  pStr: PChar;
  // match: TMatch;
begin
  DriverName := Trim(DriverName);
  // match:=TRegEx.Match(str,pattern);
  // if match.Success then
  // ss:=match.Value;

  // pStr := StrRScan(Pchar(str), '(');
  pStr := StrRScan(PChar(DriverName), 'C');
  if (Pos('COM', pStr) > 0) then
  begin
    i1 := 1;
    i2 := Pos(')', pStr);
    if ((i2 - i1) > 1) then
    begin
      ss := Copy(pStr, i1, i2 - i1);
    end;
  end
  else if (Pos('PID', DriverName) > 0) then
    ss := Copy(DriverName, Pos('PID', DriverName), 10)
  else
    ss := '';

  Result := ss;
end;

procedure TSettingPagesDlg.WMDeviceChange(var Msg: TMessage);
var
  pHDR: PDEV_BROADCAST_HDR;
  pVOLUME: PDEV_BROADCAST_VOLUME;
  pOEM: PDEV_BROADCAST_OEM;
  pPORT: PDEV_BROADCAST_PORT;
  // dvName: string;
  DeviceType: string; // 设备类型，媒体设备，网络驱动器
  // DeviceAction: string; // 设备动作
  DeviceName: string; // 设备磁盘名
  // MCIO              : TMCI_Open_Parms;      //MMSystem
begin
  pPORT := nil;
  DeviceName := '';
  pHDR := PDEV_BROADCAST_HDR(Msg.LParam);
  if pHDR = nil then
    exit;
  // Log('Change= ' + inttostr(pHDR^.dbch_devicetype));
  case pHDR^.dbch_devicetype of
    DBT_DEVTYP_VOLUME:
      begin
        pVOLUME := PDEV_BROADCAST_VOLUME(pHDR);
        DeviceName := IntToHex(pVOLUME^.dbcv_unitmask, 8);
        if Boolean(pVOLUME^.dbcv_flags and DBTF_MEDIA) then
        begin
          DeviceType := '媒体设备 ';
        end
        else
        begin
          if Boolean(pVOLUME^.dbcv_flags and DBTF_NET) then
          begin
            DeviceType := '网络驱动器 ';
          end
          else
            DeviceType := '未知设备类型 0x' + IntToHex(pVOLUME^.dbcv_flags, 8) + ' ';
        end;

        DeviceName := FirstDriveFromMask(pVOLUME^.dbcv_unitmask) + ':';

        case GetDriveType(PChar(DeviceName)) of
          DRIVE_UNKNOWN:
            DeviceType := DeviceType + '未知类型';
          DRIVE_NO_ROOT_DIR:
            DeviceType := DeviceType + '根目录不存在';
          DRIVE_REMOVABLE:
            DeviceType := DeviceType + '可移除';
          DRIVE_FIXED:
            DeviceType := DeviceType + '不可移除';
          DRIVE_REMOTE:
            DeviceType := DeviceType + '网络';
          DRIVE_CDROM:
            DeviceType := DeviceType + 'CDROM';
          DRIVE_RAMDISK:
            DeviceType := DeviceType + 'RAM';
        end; // Case GetDriveType(PChar(DeviceName)) Of
      end; // DBT_DEVTYP_VOLUME
    DBT_DEVTYP_OEM:
      begin
        DeviceType := 'OEM- or IHV-defined device type. ';
        pOEM := PDEV_BROADCAST_OEM(pHDR);
        DeviceName := IntToHex(pOEM^.dbco_identifier, 8);
      end;
    DBT_DEVTYP_PORT:
      begin
        DeviceType := '端口设备（串并口） ';
        pPORT := PDEV_BROADCAST_PORT(pHDR);
        DeviceName := pPORT^.dbcp_name;
      end;
  end;

  case Msg.wParam of
    DBT_DEVNODES_CHANGED:
      begin
        // Log('Change.');
      end;
    DBT_DEVICEARRIVAL:
      begin
        if (pPORT <> nil) and (DeviceName <> '') then
        begin
          // Log0('Device ' + DeviceName + ' attached' + #13#10);
          updateSystemDevicesList(DeviceName, DBT_DEVICEARRIVAL);
        end;
      end;
    DBT_DEVICEREMOVECOMPLETE:
      begin
        if (pPORT <> nil) and (DeviceName <> '') then
        begin
          // Log0('Device ' + DeviceName + ' unattached');
          updateSystemDevicesList(DeviceName, DBT_DEVICEREMOVECOMPLETE);
        end;
      end;

    DBT_DEVICEREMOVEPENDING:
      begin

      end;

  end;
end;

procedure TSettingPagesDlg.ComboBoxEx1Change(Sender: TObject);
var
  sDriverName: string;
  i: Integer;
  OcComPortObj: TOcComPortObj;
begin
  if (ComboBoxEx1.Items.Count <= 0) or (ComboBoxEx1.Text = 'None') then
  begin
    exit;
  end;

  if ComboBoxEx1.ItemIndex < 0 then
    ComboBoxEx1.ItemIndex := 0;
  OcComPortObj := getDeciceByFullName(getCurrentDeviceName());
  if OcComPortObj = nil then
    exit;

  sDriverName := Trim(ComboBoxEx1.Items[ComboBoxEx1.ItemIndex]);
  sDriverName := FalconGetComPort(sDriverName);
  LabeledEdit1.EditText := (IntToStr(OcComPortObj.Timeouts.ReadInterval));
end;

procedure TSettingPagesDlg.initSystemDevicesList();
begin

end;

procedure TSettingPagesDlg.FormCreate(Sender: TObject);
var
  ComComboBox: TComComboBox;
  j: TRECEIVE_FORMAT;
  i: Integer;
begin
  if OcComPortList = nil then
    OcComPortList := TStringList.Create;

  updateSystemDevicesList();
  ComComboBox := TComComboBox.Create(self);
  ComComboBox.Parent := self;
  ComComboBox.Visible := false;

  ComComboBox.ComProperty := cpBaudRate;
  ComComboBox.Refresh;
  ComboBox1.Items := ComComboBox.Items;
  ComboBox1.Items.Add('1000000');
  ComboBox1.Items.Add('1152000');
  ComboBox1.Items.Add('1500000');
  ComboBox1.Items.Add('2000000');
  ComboBox1.Items.Add('2500000');
  ComboBox1.Items.Add('3000000');
  ComboBox1.Items.Add('3500000');
  ComboBox1.Items.Add('4000000');

  ComboBox1.ItemIndex := 13;

  ComComboBox.ComProperty := cpDataBits;
  ComComboBox.Refresh;
  ComboBox2.Items := ComComboBox.Items;
  ComboBox2.ItemIndex := 3; // Ord(OctopusComPort1.DataBits);

  ComComboBox.ComProperty := cpStopBits;
  ComComboBox.Refresh;
  ComboBox3.Items := ComComboBox.Items;
  ComboBox3.ItemIndex := 0; // Ord(OctopusComPort1.StopBits);

  ComComboBox.ComProperty := cpParity;
  ComComboBox.Refresh;
  ComboBox4.Items := ComComboBox.Items;
  ComboBox4.ItemIndex := 0; // Ord(OctopusComPort1.Parity.Bits);

  ComComboBox.ComProperty := cpFlowControl;
  ComComboBox.Refresh;
  ComboBox5.Items := ComComboBox.Items;
  ComboBox5.ItemIndex := 2;

  ComboBox7.Clear;
  // for j := Low(RECEIVE_FORMAT_String) to High(RECEIVE_FORMAT_String) do
  for j := ASCIIFormat to OctopusProtocol do
  begin
    ComboBox7.Items.Add(RECEIVE_FORMAT_String[j]);
  end;

  ComboBox7.ItemIndex := 0;

  OctopusCfgDir := ExtractFilePath(Application.Exename) + '\';

  SetCurrentDir(OctopusCfgDir);
  //OctopusCfgDir_LogFileName := OctopusCfgDir + LOG_DIR + GetSystemDateTimeStampStr();
  //if not DirectoryExists(OctopusCfgDir) then
  //  CreateDir(OctopusCfgDir);
  //if not DirectoryExists(OctopusCfgDir + CONFIGURATION_DIR) then
  //  CreateDir(OctopusCfgDir + CONFIGURATION_DIR);
  //if not DirectoryExists(OctopusCfgDir + LOG_DIR) then
  //  CreateDir(OctopusCfgDir + LOG_DIR);

  VersionNumberStr := GetBuildInfo(Application.Exename);
  ComboBoxEx1Change(self); // 刷新到默认串口设置界面
  { try
    CheckDeviceThreak := TCheckDeviceThreak.Create(True);
    CheckDeviceThreak.ApplicationFileName := Application.Exename;
    CheckDeviceThreak.ConfigFileName := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
    CheckDeviceThreak.Resume;
    finally
    end; }
end;

function TSettingPagesDlg.GetDeciceByPort(Port: string): TOcComPortObj;
var
  i: Integer;
  str: String;
begin
  Result := nil;
  if Port = '' then
    exit;
  for i := 0 to OcComPortList.Count - 1 do
  begin
    str := OcComPortList[i];
    if (Pos(Port, str) > 0) then
    begin
      Result := TOcComPortObj(OcComPortList.Objects[i]);
    end;
  end;
end;

procedure TSettingPagesDlg.updateSystemDevicesList(DevideName: String = ''; ActionType: Integer = $8000);
var
  imageId, i: Integer;
  DevideNameList: TStringList;
  OcComPortObj: TOcComPortObj;
  S: String;
  IniFile: TIniFile;
begin
  try
    DeviceIconList.Clear;
    if OcComPortList = nil then
      OcComPortList := TStringList.Create;

    DevideNameList := TStringList.Create;

    imageId := 0;
    OcComPortObj := nil;

    GetTheHardDevice('ports', DeviceIconList, DevideNameList, imageId);

    if DevideName <> '' then
      OcComPortObj := GetDeciceByPort(DevideName);

    if (OcComPortObj <> nil) and (ActionType = DBT_DEVICEREMOVECOMPLETE) then
    begin
      //if OcComPortObj.Connected then
      //  closeDevice(OcComPortObj.OcComPortObjPara.ComportFullName);
    end;

    if DevideNameList.Count = 0 then
    begin
      // ComboBoxEx1Change(self);
      exit;
    end;

    ComboBoxEx1.ItemsEx.BeginUpdate;
    ComboBoxEx1.Images := DeviceIconList;
    OcComPortList.BeginUpdate;
    for i := 0 to DevideNameList.Count - 1 do
    begin
      ComboBoxEx1.ItemsEx.AddItem(DevideNameList.Strings[i], imageId, imageId, imageId, -1, nil);
      ComboBoxEx1.ItemsEx.Items[i].ImageIndex := imageId;
      if (OcComPortList.IndexOf(DevideNameList.Strings[i])) < 0 then
      begin
        OcComPortObj := TOcComPortObj.Create(self, DevideNameList.Strings[i]);

       // S := OctopusCfgDir + CONFIGURATION_DIR + OcComPortObj.OcComPortObjPara.ComportFullName + '.ini';
        // 配置非全局信息
        if FileExists(S) then
        begin
          OcComPortObj.LoadSettings(stIniFile, S);
          try
            IniFile := TIniFile.Create(S);
            OcComPortObj.ReceiveFormat := IniFile.ReadInteger('', 'ReceiveFormat', 0);
            OcComPortObj.SendFormat := IniFile.ReadInteger('', 'SendFormat', 0);
            //OcComPortObj.BaudRateIndex := IniFile.ReadInteger('', 'BaudRateIndex', 13);
          finally
            IniFile.Free;
          end;
        end;
        OcComPortList.AddObject(DevideNameList.Strings[i], OcComPortObj);
      end;
    end;

    // for i := 0 to OcHIDDeviceList.Count - 1 do
    // begin
    // ComboBoxEx1.ItemsEx.AddItem(OcHIDDeviceList.Strings[i], 0, 0, 0, -1, nil);
    // end;
    ComboBoxEx1.ItemsEx.EndUpdate;
    OcComPortList.EndUpdate;
  finally
    DevideNameList.Free;
  end;
end;

function TSettingPagesDlg.getCurrentDevice(): TOcComPortObj;
begin
  Result := getDeciceByFullName(getCurrentDeviceName());
end;

function TSettingPagesDlg.getCurrentDeviceName(): String;
begin
  Result := '';
  if (ComboBoxEx1.Items.Count > 0) and (ComboBoxEx1.ItemIndex >= 0) then
    Result := ComboBoxEx1.Items[ComboBoxEx1.ItemIndex];
end;

function TSettingPagesDlg.getDeciceByFullName(DeviceName: string): TOcComPortObj;
var
  i: Integer;
begin
  Result := nil;
  if DeviceName = '' then
    exit;
  try
    i := OcComPortList.IndexOf(DeviceName);
    if i >= 0 then
      Result := TOcComPortObj(OcComPortList.Objects[i]);
  finally

  end;
end;

procedure TSettingPagesDlg.updateOcComPortObjAtrribute(OcComPortObj: TOcComPortObj = nil);
var
  CodePage: Integer;
begin
  if OcComPortObj = nil then
    OcComPortObj := getDeciceByFullName(getCurrentDeviceName());

  if OcComPortObj = nil then
  begin
    exit;
  end;

  OcComPortObj.OcComPortObjInit2('', '', ComboBox1.ItemIndex, ComboBox2.ItemIndex, ComboBox3.ItemIndex, ComboBox4.ItemIndex, ComboBox5.ItemIndex, ComboBox6.ItemIndex, ComboBox7.ItemIndex, nil,
    CheckBox3.Checked, CheckBox25.Checked, CheckBox4.Checked, CheckBox5.Checked, True);

  case ComboBox8.ItemIndex of
    0:
      OcComPortObj.HexModeFormatCount := 16;
    1:
      OcComPortObj.HexModeFormatCount := 32;
    2:
      OcComPortObj.HexModeFormatCount := 0;
  else
    OcComPortObj.HexModeFormatCount := 0;
  end;

  OcComPortObj.CompatibleUnicode := CheckBox12.Checked;
  if Trim(LabeledEdit1.Text) = '' then
    OcComPortObj.Timeouts.ReadInterval := 30
  else
    OcComPortObj.Timeouts.ReadInterval := StrToInt(LabeledEdit1.Text);

  case Combobox_CodePage.ItemIndex of
    0:
      CodePage := 0;
    1:
      CodePage := 1;
    2:
      CodePage := 2;
    3:
      CodePage := 42;
    4:
      CodePage := CP_UTF7;
    5:
      CodePage := CP_UTF8;
  else
    CodePage := 0;
  end;
  OcComPortObj.CodePage := CodePage;
end;

procedure TSettingPagesDlg.Button2Click(Sender: TObject);
begin
  updateOcComPortObjAtrribute();
end;

procedure TSettingPagesDlg.closeDevice(DeviceFullName: String);
var
  OcComPortObj: TOcComPortObj;
  i: Integer;
begin
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;
  i := OcComPortList.IndexOf(DeviceFullName);
  if i < 0 then
    exit;

  OcComPortObj := TOcComPortObj(OcComPortList.Objects[i]);
  if (OcComPortObj <> nil) and (OcComPortObj.Connected) then
  begin
    OcComPortObj.closeDevice();
    // OcComPortObj.ClearLog;
    // OcComPortObj.ClearInternalBuff();
    // OcComPortObj.LogMemo.Visible := false;
    // OcComPortObj.LogMemo.Parent := nil;
  end;

end;

function TSettingPagesDlg.openDevice(DeviceFullName: String): TOcComPortObj;
begin
  openDevice(DeviceFullName, nil, nil);
end;

function TSettingPagesDlg.openDevice(DeviceFullName: String; LogMemo: TMemo; ParentPage: TPage): TOcComPortObj;
var
  OcComPortObj: TOcComPortObj;
  // Memo: TMemo;
  i: Integer;
begin
  Result := nil;
  if OcComPortList = nil then
    exit;
  if DeviceFullName = '' then
    exit;

  OcComPortObj := getDeciceByFullName(DeviceFullName);
  if OcComPortObj = nil then
    exit;

  updateOcComPortObjAtrribute(OcComPortObj);

  if (OcComPortObj.LogMemo <> nil) then
  begin
    OcComPortObj.LogMemo.Parent := ParentPage;
    OcComPortObj.LogMemo.Align := alClient;
    // Memo.Font := Memo1.Font;
    // Memo.Color := Memo1.Color;
    OcComPortObj.LogMemo.HideSelection := false;
    OcComPortObj.LogMemo.Show;
    OcComPortObj.LogMemo.DoubleBuffered := True;
  end;
  if ParentPage <> nil then
    ParentPage.DoubleBuffered := True;
  // ParentPage.Tag := Integer(Memo);

  OcComPortObj.ClearLog;
  OcComPortObj.ClearInternalBuff();

  OcComPortObj.StringInternelCache.Parent := self; // 设置大量极限数据的缓冲MEMO
  OcComPortObj.StringInternelCache.DoubleBuffered := True;
  // OcComPortObj.CallBackFun := CallBackFun;
  // OcComPortObj.LogMemo.PopupMenu := self.PopupMenu1;

  // if (OcComPortObj.ReceiveFormat = Ord(Graphic)) and (OcComPortObj.FastLineSeries = nil) then
  // OcComPortObj.FastLineSeries := self.CharInitSeries(True);

  try
    OcComPortObj.Open;
    Result := OcComPortObj;
  Except
   // OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    Result := nil;
    // MessageBox(Application.Handle, PChar('Open device ' + DeviceFullName + ' failed, it may be in used.'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    //OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    Result := nil;
    exit;
  end;

  OcComPortObj.Log('');
  OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log'); // 打开的时候创建日志文件
  OcComPortObj.LogMemo.ReadOnly := True;
  OcComPortObj.Log('################################################');
  //OcComPortObj.Log(APPLICATION_TITLE + VersionNumberStr);
  // OcComPortObj.Log(VERSIONNAME); // 'Version  :2.00'
  //OcComPortObj.Log('Home Page :' + WEB_SITE + ' ');
  //OcComPortObj.Log('Function  :' + 'ESC、F1、F2、F3');
  //OcComPortObj.Log('################################################');
  //OcComPortObj.Log(OcComPortObj.OcComPortObjPara.ComportFullName);
  OcComPortObj.Log('');
end;

function TSettingPagesDlg.openDevice(OcComPortObj: TOcComPortObj): Boolean;
var
  i: Integer;
begin
  Result := false;
  if OcComPortObj = nil then
    exit;
  //if OcComPortObj.OcComPortObjPara.ComportFullName = '' then
 //   exit;

  { if (OcComPortObj.LogMemo <> nil) then
    begin
    OcComPortObj.LogMemo.ReadOnly := True;
    //OcComPortObj.LogMemo.Parent := ParentPage;
    OcComPortObj.LogMemo.Align := alClient;
    // Memo.Font := Memo1.Font;
    // Memo.Color := Memo1.Color;
    OcComPortObj.LogMemo.HideSelection := false;
    //OcComPortObj.LogMemo.Show;
    OcComPortObj.LogMemo.DoubleBuffered := True;
    end;
    //if ParentPage <> nil then
    //  ParentPage.DoubleBuffered := True;
    // ParentPage.Tag := Integer(Memo);
  }

  OcComPortObj.ClearLog;
  OcComPortObj.ClearInternalBuff();

  OcComPortObj.StringInternelCache.Parent := self; // 设置大量极限数据的缓冲MEMO
  OcComPortObj.StringInternelCache.DoubleBuffered := True;
  // OcComPortObj.CallBackFun := CallBackFun;
  // OcComPortObj.LogMemo.PopupMenu := self.PopupMenu1;

  // if (OcComPortObj.ReceiveFormat = Ord(Graphic)) and (OcComPortObj.FastLineSeries = nil) then
  // OcComPortObj.FastLineSeries := self.CharInitSeries(True);

  try
    OcComPortObj.Open;
    OcComPortObj.SaveLog(OctopusCfgDir_LogFileName + '_' + OcComPortObj.Port + '.log'); // 打开的时候创建日志文件
    Result := True;
    OcComPortObj.status := 1;
  Except
    // OcComPortObj.Log('Can not open  ' + OcComPortObj.OcComPortObjPara.ComportFullName);
    Result := false;
    OcComPortObj.status := 1;
    // MessageBox(Application.Handle, PChar('Open device ' + DeviceFullName + ' failed, it may be in used.'), PChar(Application.Title), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
  if not OcComPortObj.Connected then
  begin
    //OcComPortObj.Log('Wrong!!! open  ' + OcComPortObj.OcComPortObjPara.ComportFullName + ' has been opened');
    // Result := false;
    exit;
  end;

  { OcComPortObj.Log('');
    OcComPortObj.Log('################################################');
    OcComPortObj.Log(APPLICATION_TITLE + VersionNumberStr);
    // OcComPortObj.Log(VERSIONNAME); // 'Version  :2.00'
    OcComPortObj.Log('Home Page :' + WEB_SITE + ' ');
    OcComPortObj.Log('Function  :' + 'ESC、F1、F2、F3');
    OcComPortObj.Log('################################################');
    OcComPortObj.Log(OcComPortObj.OcComPortObjPara.ComportFullName);
    OcComPortObj.Log(''); }
end;

function TSettingPagesDlg.openDeviceRandom(): TOcComPortObj;
begin
  Result := getAvailableDevice();
  // Result := openDevice(Result);
end;

function TSettingPagesDlg.getAvailableDevice(): TOcComPortObj;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to OcComPortList.Count - 1 do
  begin
    if (OcComPortList.Objects[i] = nil) then
      continue;
    if not TOcComPortObj(OcComPortList.Objects[i]).Connected and (TOcComPortObj(OcComPortList.Objects[i]).status = 0) then
    begin
      Result := TOcComPortObj(OcComPortList.Objects[i]);
      break;
    end;
  end;
end;

procedure TSettingPagesDlg.FalconLoadCfg();
var
  Octopusini: TIniFile;
  S: string;
  i: Integer;

begin
  Octopusini := nil;
  if not DirectoryExists(OctopusCfgDir) then
    exit;
  //S := OctopusCfgDir + CONFIGURATION_DIR + 'Octopus.ini';
  if (not FileExists(S)) then
    exit;
  try
    Octopusini := TIniFile.Create(S);

  finally
    Octopusini.Free;
  end;
end;

end.
