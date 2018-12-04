; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "��ܰ����ϵͳ"
!define PRODUCT_VERSION "1.0.3_��ʽ��"
!define PRODUCT_PUBLISHER "С�﹤����"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "SuperCollectingSilver\form.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��ʼ�˵�����ҳ��
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "��ܰ����ϵͳ"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "��ܰ����ϵͳ_${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\��ܰ����ϵͳ"
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR\*.*"
  SetOverwrite ifnewer
  File /r "SuperCollectingSilver\bin\x86\Debug\*.*"

; ������ʼ�˵���ݷ�ʽ
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  /*******��ӿ�ݷ�ʽ--start*******/
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\��ܰ����ϵͳ.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\${PRODUCT_NAME}.lnk" "$INSTDIR\��ܰ����ϵͳ.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\ж��.lnk" "$INSTDIR\uninst.exe"
  /*******��ӿ�ݷ�ʽ--end*******/
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  /*******����û�ע���--start*******/
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "footer" ""
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "header" ""
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "margin_bottom" "0"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "margin_left" "0"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "margin_right" "0"
  WriteRegStr HKCU "Software\Microsoft\Internet Explorer\PageSetup" "margin_top" "0"
  WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\��ܰ����ϵͳ.exe" "RUNASADMIN"  /**�Թ���Ա�������**/
  /*******����û�ע���--end*******/
SectionEnd

/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/

Section Uninstall
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\uninst.exe"

  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  
  Delete "$SMPROGRAMS\$ICONS_GROUP\ж��.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"

  RMDir "$SMPROGRAMS\$ICONS_GROUP"

  RMDir /r "$INSTDIR\*.*"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd
