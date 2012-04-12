
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "WireWorks3D"
!define PRODUCT_VERSION "1.01 Beta"
!define PRODUCT_PUBLISHER "Scenario Design, Inc."
!define PRODUCT_WEB_SITE "http://www.scenariodesign.com"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "WW3D_V1.exe"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
InstallDir "$PROGRAMFILES"
Icon "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
UninstallIcon "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
DirText "Setup will install $(^Name).$\r$\n$\r$\nTo install, click Browse and select the root of your 3DS Max directory."
LicenseText "If you accept all the terms of the agreement, choose I Agree to continue. You must accept the agreement to install $(^Name)."
LicenseData "License.txt"
LicenseForceSelection checkbox
ShowInstDetails show
ShowUnInstDetails show

Section "WW3D-3DSMAX PLUGIN" SEC01
  SetOutPath "$INSTDIR\Scripts\WW3D"
  SetOverwrite ifnewer
  File "Library.mse"
  File "WireWorks3D.mse"
  File "Splash.jpg"
  File "About.jpg"
  File "Instructions.txt"
  File "Manual.pdf"
  
SectionEnd

Section "WW3D-3DSMAX TOOLBAR" SEC02
  SetOutPath "$INSTDIR\ui\macroscripts"
  SetOverwrite ifnewer
  File "WW3D.mcr"
SectionEnd

Section "WW3D-3DSMAX ICONS" SEC03
  SetOutPath "$INSTDIR\ui\icons"
  SetOverwrite ifnewer
  File "CGsoldier_16i.bmp"
  File "CGsoldier_16a.bmp"
  File "CGsoldier_24i.bmp"
  File "CGsoldier_24a.bmp"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\WireWorks3D"
  CreateShortCut "$SMPROGRAMS\WireWorks3D\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\WireWorks3D\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\Scripts\WW3D\WireWorks3D.mse"
  Delete "$INSTDIR\Scripts\WW3D\Library.mse"
  Delete "$INSTDIR\Scripts\WW3D\Splash.jpg"
  Delete "$INSTDIR\Scripts\WW3D\About.jpg"
  Delete "$INSTDIR\Scripts\WW3D\Instructions.txt"
  Delete "$INSTDIR\Scripts\WW3D\Manual.pdf"
  
  Delete "$INSTDIR\ui\macroscripts\WW3D.mcr"
  
  Delete "$INSTDIR\ui\icons\CGsoldier_16i.bmp"
  Delete "$INSTDIR\ui\icons\CGsoldier_16a.bmp"
  Delete "$INSTDIR\ui\icons\CGsoldier_24i.bmp"
  Delete "$INSTDIR\ui\icons\CGsoldier_24a.bmp"

  Delete "$SMPROGRAMS\WireWorks3D\Uninstall.lnk"
  Delete "$SMPROGRAMS\WireWorks3D\Website.lnk"

  RMDir "$SMPROGRAMS\WireWorks3D"
  RMDir "$INSTDIR\Scripts\WW3D"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd