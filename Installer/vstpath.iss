
[Code]
////////////////// Custom Code /////////////////////////////
[CustomMessages]
PluginInstall_Caption=Install VST Plugin
PluginInstall_Description=Where should VST Plugin be installed?
PluginInstall_OtherDir=---- specify other directory ----
PluginInstall_CannotInstall=Cannot install VST Plugin to this directory.%n%nPlease specify a different installation path.
PluginInstall_BrowseFolder=Select VST Plugin folder:
[Code]
procedure InitVstPage();forward;
function VstNextButtonClick(Page: TWizardPage): Boolean;forward;
function vstpath(param:String):String;forward;
////////////////// Custom Code End /////////////////////////////

[CustomMessages]
PluginInstall_lbFolder_Caption0=Select the destination folder for VST Plugin, then click Next.
PluginInstall_lbFoundDirs_Caption0=Found VST Directories:
PluginInstall_lbExplicit_Caption0=Enter the explicit path to install VST Plugin to:
PluginInstall_insVST_Caption0=Install VST Plugin
PluginInstall_btnBrowse_Caption0=Browse...

[Code]
var
  lbFolder: TLabel;
  lbFoundDirs: TLabel;
  lbExplicit: TLabel;
  insVST: TCheckBox;
  lstVstDirs: TListBox;
  edPath: TEdit;
  btnBrowse: TButton;

{ PluginInstall_Activate }

procedure PluginInstall_Activate(Page: TWizardPage);
begin
  // enter code here...
end;

{ PluginInstall_ShouldSkipPage }

function PluginInstall_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
  Result := False;
end;

{ PluginInstall_BackButtonClick }

function PluginInstall_BackButtonClick(Page: TWizardPage): Boolean;
begin
  Result := True;
end;

{ PluginInstall_NextButtonClick }

function PluginInstall_NextButtonClick(Page: TWizardPage): Boolean;
begin
  Result := VstNextButtonClick(Page); ///////////////// MODIFIED
end;

{ PluginInstall_CancelButtonClick }

procedure PluginInstall_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
  // enter code here...
end;

{ PluginInstall_CreatePage }

function PluginInstall_CreatePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(
    PreviousPageId,
    ExpandConstant('{cm:PluginInstall_Caption}'),
    ExpandConstant('{cm:PluginInstall_Description}')
  );

{ lbFolder }
  lbFolder := TLabel.Create(Page);
  with lbFolder do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:PluginInstall_lbFolder_Caption0}');
    Left := ScaleX(0);
    Top := ScaleY(24);
    Width := ScaleX(290);
    Height := ScaleY(13);
  end;
  
  { lbFoundDirs }
  lbFoundDirs := TLabel.Create(Page);
  with lbFoundDirs do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:PluginInstall_lbFoundDirs_Caption0}');
    Left := ScaleX(0);
    Top := ScaleY(48);
    Width := ScaleX(109);
    Height := ScaleY(13);
  end;
  
  { lbExplicit }
  lbExplicit := TLabel.Create(Page);
  with lbExplicit do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:PluginInstall_lbExplicit_Caption0}');
    Left := ScaleX(0);
    Top := ScaleY(168);
    Width := ScaleX(223);
    Height := ScaleY(13);
  end;
  
  { insVST }
  insVST := TCheckBox.Create(Page);
  with insVST do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:PluginInstall_insVST_Caption0}');
    Left := ScaleX(0);
    Top := ScaleY(0);
    Width := ScaleX(265);
    Height := ScaleY(17);
    Checked := True;
    Font.Height := ScaleY(-11);
    Font.Name := 'Tahoma';
    Font.Style := [fsBold];
    State := cbChecked;
    TabOrder := 0;
    Enabled := False;
  end;
  
  { lstVstDirs }
  lstVstDirs := TListBox.Create(Page);
  with lstVstDirs do
  begin
    Parent := Page.Surface;
    Left := ScaleX(0);
    Top := ScaleY(64);
    Width := ScaleX(412);
    Height := ScaleY(97);
    TabOrder := 1;
  end;
  
  { edPath }
  edPath := TEdit.Create(Page);
  with edPath do
  begin
    Parent := Page.Surface;
    Left := ScaleX(0);
    Top := ScaleY(184);
    Width := ScaleX(412);
    Height := ScaleY(21);
    TabOrder := 2;
  end;
  
  { btnBrowse }
  btnBrowse := TButton.Create(Page);
  with btnBrowse do
  begin
    Parent := Page.Surface;
    Caption := ExpandConstant('{cm:PluginInstall_btnBrowse_Caption0}');
    Left := ScaleX(345);
    Top := ScaleY(204);
    Width := ScaleX(67);
    Height := ScaleY(18);
    TabOrder := 3;
  end;

  with Page do
  begin
    OnActivate := @PluginInstall_Activate;
    OnShouldSkipPage := @PluginInstall_ShouldSkipPage;
    OnBackButtonClick := @PluginInstall_BackButtonClick;
    OnNextButtonClick := @PluginInstall_NextButtonClick;
    OnCancelButtonClick := @PluginInstall_CancelButtonClick;
  end;

  Result := Page.ID;
end;

{ PluginInstall_InitializeWizard }

procedure InitializeWizard();
begin
    PluginInstall_CreatePage(wpSelectDir);
    InitVstPage(); ///////////////// MODIFIED
end;


///////////////////// Custom Code ////////////////////////////////
[Code]

var MainVstFolder:String;

function GetVstFolders():TArrayOfString;
var dirs,dirs2:TArrayOfString;
    atmp,testdirs:TArrayOfString;
    t,k:integer;
    m,tmpstr:String;
begin
    MainVstFolder:='';

    if RegQueryStringValue(
        HKEY_LOCAL_MACHINE,
        'Software\VST',
        'VstPluginsPath', tmpstr) then
    begin
        if DirExists(tmpstr) then
        begin
            SetArrayLength(dirs,GetArrayLength(dirs)+1);
            dirs[GetArrayLength(dirs)-1]:=tmpstr;
            MainVstFolder:=tmpstr;
        end;
    end;
    
    if RegQueryStringValue(
        HKEY_CURRENT_USER,
        'Software\VST',
        'VstPluginsPath', tmpstr) then
    begin
        if DirExists(tmpstr) then
        begin
            SetArrayLength(dirs,GetArrayLength(dirs)+1);
            dirs[GetArrayLength(dirs)-1]:=tmpstr;
            MainVstFolder:=tmpstr;
        end;
    end;
        
    if RegGetValueNames(
        HKEY_CURRENT_USER,
        'Software\Cakewalk Music Software\SONAR Producer\Cakewalk VST\Paths',
        atmp) then
    begin
        for t:=0 to GetArrayLength(atmp)-1 do
        begin
            if DirExists(atmp[t]) then
            begin
                SetArrayLength(dirs,GetArrayLength(dirs)+1);
                dirs[GetArrayLength(dirs)-1]:=atmp[t];
            end;
        end;
    end;
    
    testdirs := [
        'C:\vst',
        'C:\VstPlugins',
        '{pf}\VstPlugins',
        '{pf}\Steinberg\VstPlugins',
        '{pf}\Plogue\Bidule\VstPlugins'
    ];
    
    for t:=0 to GetArrayLength(testdirs)-1 do
    begin
        if DirExists(ExpandConstant(testdirs[t])) then
        begin
            SetArrayLength(dirs,GetArrayLength(dirs)+1);
            dirs[GetArrayLength(dirs)-1]:=ExpandConstant(testdirs[t]);
        end;
    end;
    
    // Sort directories
    for k:=0 to GetArrayLength(dirs)-2 do
    begin
        for t:=k+1 to GetArrayLength(dirs)-1 do
        begin
            if Uppercase(dirs[k])>Uppercase(dirs[t]) then
            begin 
                tmpstr:=dirs[k];
                dirs[k]:=dirs[t];
                dirs[t]:=tmpstr;
            end;
        end;
    end;

    tmpstr:='';

    // Remove duplicates

    for t:=0 to GetArrayLength(dirs)-1 do
    begin
        if Uppercase(dirs[t])<>Uppercase(tmpstr) then 
        begin
            SetArrayLength(dirs2,GetArrayLength(dirs2)+1);
            dirs2[GetArrayLength(dirs2)-1]:=dirs[t];
        end;
        tmpstr:=dirs[t];
    end;
       
    Result:=dirs2;
end;


procedure VstCheckState;
begin
    if insVST.Checked then
    begin
        lbFolder.Visible:=true;
        lbFoundDirs.Visible:=true;
        lstVstDirs.Visible:=true;
        if lstVstDirs.ItemIndex=lstVstDirs.Items.Count-1 then
        begin
            lbExplicit.Visible:=true;
            edPath.Visible:=true;
            btnBrowse.Visible:=true;

            if edPath.Text='' then 
                edPath.Text:=MainVstFolder;            

        end else
        begin
            lbExplicit.Visible:=false;
            edPath.Visible:=false;
            btnBrowse.Visible:=false;
        end;
    end else
    begin
        lbFolder.Visible:=false;
        lbFoundDirs.Visible:=false;
        lbExplicit.Visible:=false;
        lstVstDirs.Visible:=false;
        edPath.Visible:=false;
        btnBrowse.Visible:=false;
    end;
end;

procedure VstCbChecked(Sender: TObject);
begin
    VstCheckState();
end;

procedure VstListChanged(Sender: TObject);
begin
    VstCheckState();
end;

procedure VstBrowseClicked(Sender: TObject);
var s:String;
begin
    s:=edPath.Text;
    if (BrowseForFolder(ExpandConstant('{cm:PluginInstall_BrowseFolder}'),s,true)) then
        edPath.Text:=s;
    VstCheckState();
end;

function CompleteVstPage():Boolean;forward;

function VstNextButtonClick(Page: TWizardPage): Boolean;
begin
    if not CompleteVstPage() then
    begin
        MsgBox(ExpandConstant('{cm:PluginInstall_CannotInstall}'),mbError,MB_OK);
        Result:=false;
    end else
        Result:=true;
end;


procedure InitVstPage();
var dirs:TArrayOfString;
       t:integer;
  vs,omvs:String;
    page:TWizardPage;
begin
    dirs:=GetVstFolders();
    for t:=0 to GetArrayLength(dirs)-1 do
    begin
        lstVstDirs.Items.Add(dirs[t]);
    end;
    lstVstDirs.Items.Add(ExpandConstant('{cm:PluginInstall_OtherDir}'));

    lstVstDirs.ItemIndex:=0;

    vs:=ExpandConstant('{reg:HKCU\Software\VstInstall,LastDir|}');
    if vs='' then vs:=MainVstFolder;
    MainVstFolder:=vs;
    omvs:=MainVstFolder;

    for t:=0 to GetArrayLength(dirs)-1 do
    begin
        if dirs[t]=MainVstFolder then 
            lstVstDirs.ItemIndex:=t;
    end;

    if (lstVstDirs.Items[lstVstDirs.ItemIndex]<>MainVstFolder)and(omvs<>'') then
    begin
        MainVstFolder:=omvs;
        for t:=0 to GetArrayLength(dirs)-1 do
        begin
            if dirs[t]=MainVstFolder then 
                lstVstDirs.ItemIndex:=t;
        end;
    end;

    if (lstVstDirs.Items[lstVstDirs.ItemIndex]<>MainVstFolder) then
    begin
        MainVstFolder:=vs;
        lstVstDirs.ItemIndex:=lstVstDirs.Items.Count-1;
        edPath.Text:=vs;
    end;

    lstVstDirs.OnClick:=@VstListChanged;

    insVST.OnClick:=@VstCbChecked;

    btnBrowse.OnClick:=@VstBrowseClicked;

    VstCheckState();
end;

function CompleteVstPage():Boolean;
begin
    if not insVST.Checked then
    begin
        MainVstFolder:='';
        Result:=true;
        exit;
    end;

    if lstVstDirs.ItemIndex=lstVstDirs.Items.Count-1 then
    begin
        if not DirExists(edPath.Text) then
        begin
            Result:=false;
            exit;
        end;

        MainVstFolder:=edPath.Text;
        Result:=true;
    end else 
    begin
        if not DirExists(lstVstDirs.Items[lstVstDirs.ItemIndex]) then
        begin
            Result:=false;
            exit;
        end;
        MainVstFolder:=lstVstDirs.Items[lstVstDirs.ItemIndex];
        Result:=true;
    end;
    
    RegWriteStringValue(
        HKEY_CURRENT_USER,
        'Software\VstInstall',
        'LastDir',
        MainVstFolder);
end;

function instvst(param:String):boolean;
begin
    if MainVstFolder='' then Result:=false else
    if not insVst.Checked then Result:=false else
        Result:=true;
end;

function vstpath(param:String):String;
begin
    if instvst(param) then 
        Result:=MainVstFolder 
    else
        Result:=ExpandConstant('{app}\VstPlugins');
end;
