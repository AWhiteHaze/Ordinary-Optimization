@echo off
title Otimizador PC Pro v2.0
color 0B
mode con cols=85 lines=40

:: Verifica admin
net session >nul 2>&1
if errorlevel 1 (
    color 0C
    echo.
    echo ===============================================================================
    echo    ERRO: Execute como ADMINISTRADOR
    echo ===============================================================================
    echo.
    pause
    exit
)

:INICIO
set "LOGDIR=C:\OtimizadorPC"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"

set s1=[ ]
set s2=[ ]
set s3=[ ]
set s4=[ ]
set s5=[ ]
set s6=[ ]
set s7=[ ]
set s8=[ ]
set s9=[ ]
set sA=[ ]
set sB=[ ]

:MENU
cls
color 0B
echo.
echo ===============================================================================
echo    OTIMIZADOR PC PRO v2.0 - Menu Interativo
echo ===============================================================================
echo.
echo    [LIMPEZA - Seguro]
echo    %s1% 1. Limpar arquivos temporarios
echo    %s2% 2. Limpeza de disco (CleanMgr)
echo    %s3% 3. Limpar cache DNS
echo.
echo    [REPAROS - Seguro]
echo    %s4% 4. Verificar integridade do sistema (SFC)
echo    %s5% 5. Reparar imagem do Windows (DISM)
echo    %s6% 6. Verificar disco no proximo reboot (CHKDSK)
echo.
echo    [PERFORMANCE - Cuidado]
echo    %s7% 7. Desativar hibernacao
echo    %s8% 8. Desativar Superfetch/SysMain
echo    %s9% 9. Ativar modo alto desempenho
echo    %sA% A. Otimizar uso de memoria
echo.
echo    [AVANCADO - Usuarios experientes]
echo    %sB% B. Otimizar configuracoes de boot
echo.
echo -------------------------------------------------------------------------------
echo    E. Executar otimizacoes selecionadas
echo    T. Selecionar TODAS as opcoes
echo    R. Resetar selecoes
echo    L. Ver logs
echo    S. Sair
echo ===============================================================================
echo.
set /p op=Digite sua opcao: 

if /i "%op%"=="1" goto OPT1
if /i "%op%"=="2" goto OPT2
if /i "%op%"=="3" goto OPT3
if /i "%op%"=="4" goto OPT4
if /i "%op%"=="5" goto OPT5
if /i "%op%"=="6" goto OPT6
if /i "%op%"=="7" goto OPT7
if /i "%op%"=="8" goto OPT8
if /i "%op%"=="9" goto OPT9
if /i "%op%"=="A" goto OPTA
if /i "%op%"=="B" goto OPTB
if /i "%op%"=="E" goto EXEC
if /i "%op%"=="T" goto TODOS
if /i "%op%"=="R" goto RESET
if /i "%op%"=="L" goto LOGS
if /i "%op%"=="S" exit
goto MENU

:OPT1
if "%s1%"=="[ ]" (set s1=[X]) else (set s1=[ ])
goto MENU

:OPT2
if "%s2%"=="[ ]" (set s2=[X]) else (set s2=[ ])
goto MENU

:OPT3
if "%s3%"=="[ ]" (set s3=[X]) else (set s3=[ ])
goto MENU

:OPT4
if "%s4%"=="[ ]" (set s4=[X]) else (set s4=[ ])
goto MENU

:OPT5
if "%s5%"=="[ ]" (set s5=[X]) else (set s5=[ ])
goto MENU

:OPT6
if "%s6%"=="[ ]" (set s6=[X]) else (set s6=[ ])
goto MENU

:OPT7
if "%s7%"=="[ ]" (set s7=[X]) else (set s7=[ ])
goto MENU

:OPT8
if "%s8%"=="[ ]" (set s8=[X]) else (set s8=[ ])
goto MENU

:OPT9
if "%s9%"=="[ ]" (set s9=[X]) else (set s9=[ ])
goto MENU

:OPTA
if "%sA%"=="[ ]" (set sA=[X]) else (set sA=[ ])
goto MENU

:OPTB
if "%sB%"=="[ ]" (set sB=[X]) else (set sB=[ ])
goto MENU

:TODOS
set s1=[X]
set s2=[X]
set s3=[X]
set s4=[X]
set s5=[X]
set s6=[X]
set s7=[X]
set s8=[X]
set s9=[X]
set sA=[X]
set sB=[X]
goto MENU

:RESET
set s1=[ ]
set s2=[ ]
set s3=[ ]
set s4=[ ]
set s5=[ ]
set s6=[ ]
set s7=[ ]
set s8=[ ]
set s9=[ ]
set sA=[ ]
set sB=[ ]
goto MENU

:EXEC
cls
color 0A
set LOGFILE=%LOGDIR%\log_%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%.txt
echo.
echo ===============================================================================
echo    EXECUTANDO OTIMIZACOES
echo ===============================================================================
echo.
echo Log: %LOGFILE%
echo.

echo ========== INICIO ========== > "%LOGFILE%"
echo Data: %date% %time% >> "%LOGFILE%"
echo. >> "%LOGFILE%"

if "%s1%"=="[X]" (
    echo [1] Limpando arquivos temporarios...
    del /q /f /s "%TEMP%\*" >nul 2>&1
    del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
    echo OK - Arquivos temporarios limpos >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s2%"=="[X]" (
    echo [2] Limpeza de disco...
    start /wait cleanmgr /sagerun:1
    echo OK - CleanMgr executado >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s3%"=="[X]" (
    echo [3] Limpando cache DNS...
    ipconfig /flushdns
    echo OK - Cache DNS limpo >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s4%"=="[X]" (
    echo [4] Verificando integridade do sistema (DEMORA)...
    sfc /scannow
    echo OK - SFC concluido >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s5%"=="[X]" (
    echo [5] Reparando imagem do Windows (DEMORA)...
    dism /online /cleanup-image /restorehealth
    echo OK - DISM concluido >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s6%"=="[X]" (
    echo [6] Agendando verificacao de disco...
    echo Y | chkdsk C: /f /r
    echo OK - CHKDSK agendado >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s7%"=="[X]" (
    echo [7] Desativando hibernacao...
    powercfg -h off
    echo OK - Hibernacao desativada >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s8%"=="[X]" (
    echo [8] Desativando Superfetch...
    sc config SysMain start=disabled
    sc stop SysMain
    echo OK - Superfetch desativado >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%s9%"=="[X]" (
    echo [9] Ativando modo alto desempenho...
    powercfg -setactive SCHEME_MIN
    echo OK - Alto desempenho ativado >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%sA%"=="[X]" (
    echo [A] Otimizando memoria...
    fsutil behavior set memoryusage 2
    echo OK - Memoria otimizada >> "%LOGFILE%"
    echo Concluido!
    echo.
)

if "%sB%"=="[X]" (
    echo [B] Otimizando boot...
    bcdedit /set useplatformtick yes
    bcdedit /set disabledynamictick yes
    echo OK - Boot otimizado >> "%LOGFILE%"
    echo Concluido!
    echo.
)

echo ========== FIM ========== >> "%LOGFILE%"
echo.
echo ===============================================================================
echo    OTIMIZACAO CONCLUIDA!
echo ===============================================================================
echo.
pause
goto MENU

:LOGS
cls
color 0B
echo.
echo ===============================================================================
echo    LOGS DE OTIMIZACAO
echo ===============================================================================
echo.
if exist "%LOGDIR%\*.txt" (
    echo Logs em: %LOGDIR%
    echo.
    dir /b /o-d "%LOGDIR%\*.txt"
    echo.
    echo Para ver um log, abra manualmente pelo Windows Explorer.
) else (
    echo Nenhum log encontrado!
)
echo.
pause
goto MENU
