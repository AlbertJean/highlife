[Setup]
AppName=discoDSP HighLife
AppVerName=discoDSP HighLife R3
DefaultDirName={reg:HKLM\SOFTWARE\VST,VSTPluginsPath|{pf}\Steinberg\VSTPlugins}\discoDSP
OutputBaseFilename=HighLife
Compression=lzma
SetupIconFile=setup.ico
InternalCompressLevel=ultra
DirExistsWarning=no
DefaultGroupName=discoDSP
WizardSmallImageFile=WizSmall.bmp
WizardImageFile=WizModernImage.bmp
AppPublisher=discoDSP
AppPublisherURL=http://www.discodsp.com
AppSupportURL=http://www.discodsp.com/contact
AppUpdatesURL=http://www.discodsp.com/highlife
LicenseFile=license.txt
SolidCompression=true
VersionInfoVersion=3
VersionInfoCompany=discoDSP
VersionInfoDescription=HighLife Open Source R3
VersionInfoCopyright=discoDSP
AppVersion=R3
AppID=HLOP

[Files]
Source: ..\HighLife\Release\HighLife.dll; DestDir: {app}
Source: ..\Manual\Manual.pdf; DestName: HighLife Users Manual.pdf; DestDir: {app}

[Run]
Filename: {app}\HighLife Users Manual.pdf; WorkingDir: {app}; Description: Open PDF Users Manual; Flags: postinstall unchecked

[Icons]
Name: {group}\HighLife Users Manual; Filename: {app}\HighLife Users Manual.pdf; IconFilename: {app}\HighLife Users Manual.pdf; Flags: runmaximized
Name: {group}\Uninstall HighLife; Filename: {uninstallexe}
