; Inno Setup Script for Unified ServVerse Windows Setup
; Generates ServVerse-setup.exe with component selection of the 16 Servverse microservices.

[Setup]
AppName=ServVerse
AppVersion=1.7.0
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={autopf}\ServVerse
DefaultGroupName=ServVerse
UninstallDisplayIcon={app}\bin\serv.exe
Compression=lzma2
SolidCompression=yes
OutputDir=dist
OutputBaseFilename=ServVerse-windows-setup
ChangesEnvironment=yes

[Types]
Name: "full"; Description: "Full installation (All 16 services & tools)"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "compiler"; Description: "Serv-lang CLI & Compiler Runtime"; Types: full custom; Flags: fixed
Name: "gateway"; Description: "ServGate API Gateway proxy"; Types: full custom
Name: "store"; Description: "ServStore S3 Object Storage engine"; Types: full custom
Name: "queue"; Description: "ServQueue STOMP Message Broker"; Types: full custom
Name: "cache"; Description: "ServCache REST caching service"; Types: full custom
Name: "mesh"; Description: "ServMesh Service Mesh service"; Types: full custom
Name: "console"; Description: "ServConsole Management Dashboard"; Types: full custom
Name: "trace"; Description: "ServTrace OpenTelemetry trace collector"; Types: full custom
Name: "auth"; Description: "ServAuth Identity & Security service"; Types: full custom
Name: "cron"; Description: "ServCron Distributed Scheduler"; Types: full custom
Name: "cloud"; Description: "ServCloud Cluster Orchestrator"; Types: full custom
Name: "trace"; Description: "ServTrace OpenTelemetry trace collector"; Types: full custom
Name: "flow"; Description: "ServFlow Saga Workflow engine"; Types: full custom
Name: "pool"; Description: "ServPool Connection Pooler proxy"; Types: full custom
Name: "mail"; Description: "ServMail Notification API Gateway"; Types: full custom
Name: "tunnel"; Description: "ServTunnel Secure Localhost Relay Tunnel"; Types: full custom
Name: "registry"; Description: "ServRegistry Package Module Registry"; Types: full custom
Name: "lock"; Description: "ServLock Distributed Locking service"; Types: full custom

[Dirs]
Name: "{app}\bin"
Name: "{app}\conf"
Name: "{app}\conf\servgate"
Name: "{app}\conf\servconsole"
Name: "{app}\logs"

[Files]
; Binaries
Source: "..\serv.exe"; DestDir: "{app}\bin"; Components: compiler; Flags: ignoreversion
Source: "..\servgate.exe"; DestDir: "{app}\bin"; Components: gateway; Flags: ignoreversion
Source: "..\servstore.exe"; DestDir: "{app}\bin"; Components: store; Flags: ignoreversion
Source: "..\servqueue.exe"; DestDir: "{app}\bin"; Components: queue; Flags: ignoreversion
Source: "..\servconsole.exe"; DestDir: "{app}\bin"; Components: console; Flags: ignoreversion
Source: "..\servmesh.exe"; DestDir: "{app}\bin"; Components: mesh; Flags: ignoreversion
Source: "..\servauth.exe"; DestDir: "{app}\bin"; Components: auth; Flags: ignoreversion
Source: "..\servcloud.exe"; DestDir: "{app}\bin"; Components: cloud; Flags: ignoreversion
Source: "..\servtrace.exe"; DestDir: "{app}\bin"; Components: trace; Flags: ignoreversion
Source: "..\servtunnel.exe"; DestDir: "{app}\bin"; Components: tunnel; Flags: ignoreversion
Source: "..\servflow.exe"; DestDir: "{app}\bin"; Components: flow; Flags: ignoreversion
Source: "..\servdb.exe"; DestDir: "{app}\bin"; Components: pool; Flags: ignoreversion
Source: "..\servmail.exe"; DestDir: "{app}\bin"; Components: mail; Flags: ignoreversion
Source: "..\servcache.exe"; DestDir: "{app}\bin"; Components: cache; Flags: ignoreversion
Source: "..\servcron.exe"; DestDir: "{app}\bin"; Components: cron; Flags: ignoreversion
Source: "..\servregistry.exe"; DestDir: "{app}\bin"; Components: registry; Flags: ignoreversion
Source: "..\servlock.exe"; DestDir: "{app}\bin"; Components: lock; Flags: ignoreversion

; Configuration Templates
Source: "..\ServGate\config.json"; DestDir: "{app}\conf\servgate"; Flags: onlyifdoesntexist
Source: "..\ServConsole\services.example.json"; DestName: "services.json"; DestDir: "{app}\conf\servconsole"; Flags: onlyifdoesntexist

[Registry]
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "Path"; ValueData: "{olddata};{app}\bin"; Flags: preservestringtype

[Icons]
Name: "{group}\ServConsole Dashboard"; Filename: "{app}\bin\servconsole.exe"; Components: console
Name: "{group}\Uninstall ServVerse"; Filename: "{uninstallexe}"
