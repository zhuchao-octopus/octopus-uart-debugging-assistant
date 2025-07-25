program TitlebarPanelDemo;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {FrmMain},
  uSetting in 'uSetting.pas' {SettingPagesDlg},
  OcPcDeviceMgt in '..\OcPcDeviceMgt.pas',
  OcComPortObj in '..\OcComPortObj.pas',
  CPort in '..\ComPort\CPort.pas',
  CPortCtl in '..\ComPort\CPortCtl.pas',
  CPortEsc in '..\ComPort\CPortEsc.pas',
  CPortSetup in '..\ComPort\CPortSetup.pas' {ComSetupFrm},
  CPortTrmSet in '..\ComPort\CPortTrmSet.pas' {ComTrmSetForm},
  OcProtocol in '..\OcProtocol.pas',
  uControllerPanel in 'uControllerPanel.pas' {FrmControllerPanel},
  ClassTDockingHelper in 'DockForm\ClassTDockingHelper.pas',
  ClassTFormDockable in 'DockForm\ClassTFormDockable.pas',
  ClassTFormDockableBase in 'DockForm\ClassTFormDockableBase.pas' {FormDockableBase},
  ClassTFormDockHost in 'DockForm\ClassTFormDockHost.pas' {FormDockHost},
  ClassTFormDockHostJoin in 'DockForm\ClassTFormDockHostJoin.pas' {FormDockHostJoin},
  ClassTFormDockHostTabs in 'DockForm\ClassTFormDockHostTabs.pas' {FormDockHostTabs},
  ClassTFormMain in 'DockForm\ClassTFormMain.pas' {FormMain},
  ClassTTransparentDragDockObject in 'DockForm\ClassTTransparentDragDockObject.pas',
  ClassTTransparentForm in 'DockForm\ClassTTransparentForm.pas',
  DockExceptions in 'DockForm\DockExceptions.pas',
  IntfDockable in 'DockForm\IntfDockable.pas',
  uDockableControllerPanel in 'uDockableControllerPanel.pas' {FrmDockableController},
  uOctopusFunction in '..\uOctopusFunction.pas',
  CRC in '..\CRC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmControllerPanel, FrmControllerPanel);
  Application.CreateForm(TFrmDockableController, FrmDockableController);
  Application.Run;
end.
