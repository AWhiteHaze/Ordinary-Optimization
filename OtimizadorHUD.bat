@echo off
setlocal enabledelayedexpansion
title Otimizador PC Pro v2.0 - Menu Interativo
mode con: cols=80 lines=35
chcp 65001 >nul 2>&1

:: Verifica privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo.
    echo ═══════════════════════════════════════════════════════════════════════════
    echo    ⚠️  ERRO: Execute como ADMINISTRADOR
    echo ═══════════════════════════════════════════════════════════════════════════
    echo.
    echo    Clique com botão direito no arquivo e selecione "Executar como administrador"
    echo.
    pause
    exit
)

:: Configuração de diretórios
set "LOGDIR=C:\OtimizadorPC"
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%b%%a)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set "LOGFILE=%LOGDIR%\log_%mydate%_%mytime%.txt"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"

:: Variáveis de opções
set opt1=0
set opt2=0
set opt3=0
set opt4=0
set opt5=0
set opt6=0
set opt7=0
set opt8=0
set opt9=0
set optA=0
set optB=0

:MENU
cls
color 0B
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ⚡ OTIMIZADOR PC PRO v2.0 - Menu Interativo
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    [LIMPEZA - Seguro]
echo    [!opt1!] 1. Limpar arquivos temporários
echo    [!opt2!] 2. Limpeza de disco (CleanMgr)
echo    [!opt3!] 3. Limpar cache DNS
echo.
echo    [REPAROS - Seguro]
echo    [!opt4!] 4. Verificar integridade do sistema (SFC)
echo    [!opt5!] 5. Reparar imagem do Windows (DISM)
echo    [!opt6!] 6. Verificar disco no próximo reboot (CHKDSK) ⚠️
echo.
echo    [PERFORMANCE - Cuidado]
echo    [!opt7!] 7. Desativar hibernação ⚠️
echo    [!opt8!] 8. Desativar Superfetch/SysMain ⚠️
echo    [!opt9!] 9. Ativar modo alto desempenho ⚠️
echo    [!optA!] A. Otimizar uso de memória ⚠️
echo.
echo    [AVANÇADO - Apenas usuários experientes]
echo    [!optB!] B. Otimizar configurações de boot ⚠️⚠️
echo.
echo ───────────────────────────────────────────────────────────────────────────
echo    E. Executar otimizações selecionadas
echo    T. Selecionar TODAS as opções
echo    R. Resetar seleções
echo    A. Agendar execução automática
echo    L. Ver logs
echo    S. Sair
echo ═══════════════════════════════════════════════════════════════════════════
echo.
set /p "opcao=    Digite sua opcao: "

if /i "%opcao%"=="1" (
    if "!opt1!"=="0" (set opt1=X) else (set opt1=0)
    goto MENU
)
if /i "%opcao%"=="2" (
    if "!opt2!"=="0" (set opt2=X) else (set opt2=0)
    goto MENU
)
if /i "%opcao%"=="3" (
    if "!opt3!"=="0" (set opt3=X) else (set opt3=0)
    goto MENU
)
if /i "%opcao%"=="4" (
    if "!opt4!"=="0" (set opt4=X) else (set opt4=0)
    goto MENU
)
if /i "%opcao%"=="5" (
    if "!opt5!"=="0" (set opt5=X) else (set opt5=0)
    goto MENU
)
if /i "%opcao%"=="6" (
    if "!opt6!"=="0" (set opt6=X) else (set opt6=0)
    goto MENU
)
if /i "%opcao%"=="7" (
    if "!opt7!"=="0" (set opt7=X) else (set opt7=0)
    goto MENU
)
if /i "%opcao%"=="8" (
    if "!opt8!"=="0" (set opt8=X) else (set opt8=0)
    goto MENU
)
if /i "%opcao%"=="9" (
    if "!opt9!"=="0" (set opt9=X) else (set opt9=0)
    goto MENU
)
if /i "%opcao%"=="A" (
    if "!optA!"=="0" (set optA=X) else (set optA=0)
    goto MENU
)
if /i "%opcao%"=="B" (
    if "!optB!"=="0" (set optB=X) else (set optB=0)
    goto MENU
)
if /i "%opcao%"=="E" goto EXECUTAR
if /i "%opcao%"=="T" goto SELECIONAR_TUDO
if /i "%opcao%"=="R" goto RESETAR
if /i "%opcao%"=="A" goto AGENDAR
if /i "%opcao%"=="L" goto VER_LOGS
if /i "%opcao%"=="S" exit

goto MENU

:SELECIONAR_TUDO
set opt1=X
set opt2=X
set opt3=X
set opt4=X
set opt5=X
set opt6=X
set opt7=X
set opt8=X
set opt9=X
set optA=X
set optB=X
goto MENU

:RESETAR
set opt1=0
set opt2=0
set opt3=0
set opt4=0
set opt5=0
set opt6=0
set opt7=0
set opt8=0
set opt9=0
set optA=0
set optB=0
goto MENU

:EXECUTAR
cls
color 0A
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ⚡ EXECUTANDO OTIMIZAÇÕES
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    Log: %LOGFILE%
echo.

echo ========== INICIO DA OTIMIZACAO ========== >> "%LOGFILE%"
echo Data/Hora: %date% %time% >> "%LOGFILE%"
echo. >> "%LOGFILE%"

set contador=0

:: Limpeza de arquivos temporários
if "!opt1!"=="X" (
    set /a contador+=1
    echo    [!contador!] Limpando arquivos temporarios...
    del /q /f /s "%TEMP%\*" >nul 2>&1
    del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
    echo [%date% %time%] Arquivos temporarios limpos >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: CleanMgr
if "!opt2!"=="X" (
    set /a contador+=1
    echo    [!contador!] Executando limpeza de disco...
    cleanmgr /sagerun:1
    echo [%date% %time%] CleanMgr executado >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: Flush DNS
if "!opt3!"=="X" (
    set /a contador+=1
    echo    [!contador!] Limpando cache DNS...
    ipconfig /flushdns
    echo [%date% %time%] Cache DNS limpo >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: SFC Scan
if "!opt4!"=="X" (
    set /a contador+=1
    echo    [!contador!] Verificando integridade do sistema (pode demorar)...
    sfc /scannow
    echo [%date% %time%] SFC scan concluido >> "%LOGFILE%"
    echo    ✓ Concluido
    echo.
)

:: DISM
if "!opt5!"=="X" (
    set /a contador+=1
    echo    [!contador!] Reparando imagem do Windows (pode demorar)...
    dism /online /cleanup-image /restorehealth
    echo [%date% %time%] DISM repair concluido >> "%LOGFILE%"
    echo    ✓ Concluido
    echo.
)

:: CHKDSK
if "!opt6!"=="X" (
    set /a contador+=1
    echo    [!contador!] Agendando verificacao de disco para proximo reboot...
    echo Y | chkdsk C: /f /r
    echo [%date% %time%] CHKDSK agendado para proximo reboot >> "%LOGFILE%"
    echo    ✓ Agendado para proximo reinicio
    timeout /t 2 >nul
    echo.
)

:: Desativar Hibernação
if "!opt7!"=="X" (
    set /a contador+=1
    echo    [!contador!] Desativando hibernacao...
    powercfg -h off
    echo [%date% %time%] Hibernacao desativada >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: Desativar Superfetch
if "!opt8!"=="X" (
    set /a contador+=1
    echo    [!contador!] Desativando Superfetch/SysMain...
    sc config SysMain start=disabled
    sc stop SysMain
    echo [%date% %time%] Superfetch desativado >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: Modo Alto Desempenho
if "!opt9!"=="X" (
    set /a contador+=1
    echo    [!contador!] Ativando modo alto desempenho...
    powercfg -setactive SCHEME_MIN
    echo [%date% %time%] Modo alto desempenho ativado >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: Otimizar Memória
if "!optA!"=="X" (
    set /a contador+=1
    echo    [!contador!] Otimizando uso de memoria...
    fsutil behavior set memoryusage 2
    echo [%date% %time%] Memoria otimizada >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

:: Otimizar Boot
if "!optB!"=="X" (
    set /a contador+=1
    echo    [!contador!] Otimizando configuracoes de boot...
    bcdedit /set useplatformtick yes
    bcdedit /set disabledynamictick yes
    echo [%date% %time%] Boot otimizado >> "%LOGFILE%"
    echo    ✓ Concluido
    timeout /t 1 >nul
    echo.
)

if !contador!==0 (
    echo    ⚠️  Nenhuma opcao foi selecionada!
    echo.
    echo [%date% %time%] Nenhuma opcao selecionada >> "%LOGFILE%"
) else (
    echo. >> "%LOGFILE%"
    echo ========== FIM DA OTIMIZACAO ========== >> "%LOGFILE%"
    echo.
    echo ═══════════════════════════════════════════════════════════════════════════
    echo    ✅ OTIMIZACAO CONCLUIDA COM SUCESSO!
    echo ═══════════════════════════════════════════════════════════════════════════
    echo.
    echo    Total de operacoes: !contador!
    echo    📁 Log salvo em: %LOGFILE%
    echo.
)
pause
goto MENU

:AGENDAR
cls
color 0E
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ⏰ AGENDAR EXECUCAO AUTOMATICA
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    Escolha o intervalo de execucao:
echo.
echo    1. A cada 5 minutos
echo    2. A cada 30 minutos
echo    3. A cada 1 hora
echo    4. A cada 6 horas
echo    5. Diariamente as 3:00 AM
echo    6. Semanalmente (Domingo as 3:00 AM)
echo    7. Remover agendamento
echo    0. Voltar
echo.
set /p "intervalo=    Digite sua opcao: "

if "%intervalo%"=="1" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc minute /mo 5 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao a cada 5 minutos.
)
if "%intervalo%"=="2" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc minute /mo 30 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao a cada 30 minutos.
)
if "%intervalo%"=="3" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc hourly /mo 1 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao a cada 1 hora.
)
if "%intervalo%"=="4" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc hourly /mo 6 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao a cada 6 horas.
)
if "%intervalo%"=="5" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc daily /st 03:00 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao diaria as 3:00 AM.
)
if "%intervalo%"=="6" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc weekly /d SUN /st 03:00 /ru SYSTEM /rl HIGHEST /f
    echo.
    echo    ✅ Tarefa agendada! Execucao semanal aos domingos as 3:00 AM.
)
if "%intervalo%"=="7" (
    schtasks /delete /tn "OtimizadorPC_Auto" /f
    echo.
    echo    ✅ Agendamento removido com sucesso!
)
if "%intervalo%"=="0" goto MENU

echo.
pause
goto MENU

:VER_LOGS
cls
color 0B
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    📋 LOGS DE OTIMIZACAO
echo ═══════════════════════════════════════════════════════════════════════════
echo.
if exist "%LOGDIR%\*.txt" (
    echo    Logs disponiveis em: %LOGDIR%
    echo.
    dir /b /o-d "%LOGDIR%\*.txt"
    echo.
    echo ───────────────────────────────────────────────────────────────────────────
    echo.
    set /p "verlog=    Digite o nome do arquivo para ver (ou Enter para voltar): "
    if not "!verlog!"=="" (
        if exist "%LOGDIR%\!verlog!" (
            cls
            echo.
            type "%LOGDIR%\!verlog!"
            echo.
            echo.
            pause
        )
    )
) else (
    echo    ⚠️  Nenhum log encontrado.
    echo.
    echo    Execute uma otimizacao primeiro!
    echo.
    pause
)
goto MENU
