@echo off
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
set "LOGFILE=%LOGDIR%\log_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.txt"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"

:: Variáveis de opções
set opt_cleantemp=0
set opt_cleanmgr=0
set opt_sfc=0
set opt_dism=0
set opt_chkdsk=0
set opt_hibernate=0
set opt_boot=0
set opt_superfetch=0
set opt_performance=0
set opt_dns=0
set opt_memory=0

:MENU
cls
color 0B
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ⚡ OTIMIZADOR PC PRO v2.0 - Menu Interativo
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    [LIMPEZA - Seguro]
echo    [%opt_cleantemp%] 1. Limpar arquivos temporários
echo    [%opt_cleanmgr%] 2. Limpeza de disco (CleanMgr)
echo    [%opt_dns%] 3. Limpar cache DNS
echo.
echo    [REPAROS - Seguro]
echo    [%opt_sfc%] 4. Verificar integridade do sistema (SFC)
echo    [%opt_dism%] 5. Reparar imagem do Windows (DISM)
echo    [%opt_chkdsk%] 6. Verificar disco no próximo reboot (CHKDSK) ⚠️
echo.
echo    [PERFORMANCE - Cuidado]
echo    [%opt_hibernate%] 7. Desativar hibernação ⚠️
echo    [%opt_superfetch%] 8. Desativar Superfetch/SysMain ⚠️
echo    [%opt_performance%] 9. Ativar modo alto desempenho ⚠️
echo    [%opt_memory%] A. Otimizar uso de memória ⚠️
echo.
echo    [AVANÇADO - Apenas usuários experientes]
echo    [%opt_boot%] B. Otimizar configurações de boot ⚠️⚠️
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
set /p "opcao=    Digite sua opção: "

if /i "%opcao%"=="1" call :TOGGLE opt_cleantemp
if /i "%opcao%"=="2" call :TOGGLE opt_cleanmgr
if /i "%opcao%"=="3" call :TOGGLE opt_dns
if /i "%opcao%"=="4" call :TOGGLE opt_sfc
if /i "%opcao%"=="5" call :TOGGLE opt_dism
if /i "%opcao%"=="6" call :TOGGLE opt_chkdsk
if /i "%opcao%"=="7" call :TOGGLE opt_hibernate
if /i "%opcao%"=="8" call :TOGGLE opt_superfetch
if /i "%opcao%"=="9" call :TOGGLE opt_performance
if /i "%opcao%"=="A" call :TOGGLE opt_memory
if /i "%opcao%"=="B" call :TOGGLE opt_boot
if /i "%opcao%"=="E" goto EXECUTAR
if /i "%opcao%"=="T" goto SELECIONAR_TUDO
if /i "%opcao%"=="R" goto RESETAR
if /i "%opcao%"=="A" goto AGENDAR
if /i "%opcao%"=="L" goto VER_LOGS
if /i "%opcao%"=="S" exit

goto MENU

:TOGGLE
if !%1!==0 (set %1=X) else (set %1=0)
goto :eof

:SELECIONAR_TUDO
set opt_cleantemp=X
set opt_cleanmgr=X
set opt_sfc=X
set opt_dism=X
set opt_chkdsk=X
set opt_hibernate=X
set opt_boot=X
set opt_superfetch=X
set opt_performance=X
set opt_dns=X
set opt_memory=X
goto MENU

:RESETAR
set opt_cleantemp=0
set opt_cleanmgr=0
set opt_sfc=0
set opt_dism=0
set opt_chkdsk=0
set opt_hibernate=0
set opt_boot=0
set opt_superfetch=0
set opt_performance=0
set opt_dns=0
set opt_memory=0
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

echo [%date% %time%] ========== INICIO DA OTIMIZACAO ========== >> "%LOGFILE%"

:: Limpeza de arquivos temporários
if "%opt_cleantemp%"=="X" (
    echo    [1/11] Limpando arquivos temporários...
    del /q /f /s "%TEMP%\*" >nul 2>&1
    del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
    echo [%date% %time%] Arquivos temporarios limpos >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: CleanMgr
if "%opt_cleanmgr%"=="X" (
    echo    [2/11] Executando limpeza de disco...
    cleanmgr /sagerun:1 >nul 2>&1
    echo [%date% %time%] CleanMgr executado >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: Flush DNS
if "%opt_dns%"=="X" (
    echo    [3/11] Limpando cache DNS...
    ipconfig /flushdns >nul 2>&1
    echo [%date% %time%] Cache DNS limpo >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: SFC Scan
if "%opt_sfc%"=="X" (
    echo    [4/11] Verificando integridade do sistema (pode demorar)...
    sfc /scannow >nul 2>&1
    echo [%date% %time%] SFC scan concluido >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: DISM
if "%opt_dism%"=="X" (
    echo    [5/11] Reparando imagem do Windows (pode demorar)...
    dism /online /cleanup-image /restorehealth /quiet >nul 2>&1
    echo [%date% %time%] DISM repair concluido >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: CHKDSK
if "%opt_chkdsk%"=="X" (
    echo    [6/11] Agendando verificação de disco para próximo reboot...
    echo Y | chkdsk C: /f /r >nul 2>&1
    echo [%date% %time%] CHKDSK agendado para proximo reboot >> "%LOGFILE%"
    echo    ✓ Agendado para próximo reinício
    echo.
)

:: Desativar Hibernação
if "%opt_hibernate%"=="X" (
    echo    [7/11] Desativando hibernação...
    powercfg -h off >nul 2>&1
    echo [%date% %time%] Hibernacao desativada >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: Desativar Superfetch
if "%opt_superfetch%"=="X" (
    echo    [8/11] Desativando Superfetch/SysMain...
    sc config SysMain start=disabled >nul 2>&1
    sc stop SysMain >nul 2>&1
    echo [%date% %time%] Superfetch desativado >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: Modo Alto Desempenho
if "%opt_performance%"=="X" (
    echo    [9/11] Ativando modo alto desempenho...
    powercfg -setactive SCHEME_MIN >nul 2>&1
    echo [%date% %time%] Modo alto desempenho ativado >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: Otimizar Memória
if "%opt_memory%"=="X" (
    echo    [10/11] Otimizando uso de memória...
    fsutil behavior set memoryusage 2 >nul 2>&1
    echo [%date% %time%] Memoria otimizada >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

:: Otimizar Boot
if "%opt_boot%"=="X" (
    echo    [11/11] Otimizando configurações de boot...
    bcdedit /set useplatformtick yes >nul 2>&1
    bcdedit /set disabledynamictick yes >nul 2>&1
    echo [%date% %time%] Boot otimizado >> "%LOGFILE%"
    echo    ✓ Concluído
    echo.
)

echo [%date% %time%] ========== FIM DA OTIMIZACAO ========== >> "%LOGFILE%"
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ✅ OTIMIZAÇÃO CONCLUÍDA COM SUCESSO!
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    📁 Log salvo em: %LOGFILE%
echo.
pause
goto MENU

:AGENDAR
cls
color 0E
echo.
echo ═══════════════════════════════════════════════════════════════════════════
echo    ⏰ AGENDAR EXECUÇÃO AUTOMÁTICA
echo ═══════════════════════════════════════════════════════════════════════════
echo.
echo    Escolha o intervalo de execução:
echo.
echo    1. A cada 5 minutos
echo    2. A cada 30 minutos
echo    3. A cada 1 hora
echo    4. A cada 6 horas
echo    5. Diariamente às 3:00 AM
echo    6. Semanalmente (Domingo às 3:00 AM)
echo    7. Remover agendamento
echo    0. Voltar
echo.
set /p "intervalo=    Digite sua opção: "

if "%intervalo%"=="1" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc minute /mo 5 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução a cada 5 minutos.
)
if "%intervalo%"=="2" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc minute /mo 30 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução a cada 30 minutos.
)
if "%intervalo%"=="3" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc hourly /mo 1 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução a cada 1 hora.
)
if "%intervalo%"=="4" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc hourly /mo 6 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução a cada 6 horas.
)
if "%intervalo%"=="5" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc daily /st 03:00 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução diária às 3:00 AM.
)
if "%intervalo%"=="6" (
    schtasks /create /tn "OtimizadorPC_Auto" /tr "%~f0" /sc weekly /d SUN /st 03:00 /ru SYSTEM /rl HIGHEST /f >nul 2>&1
    echo.
    echo    ✅ Tarefa agendada! Execução semanal aos domingos às 3:00 AM.
)
if "%intervalo%"=="7" (
    schtasks /delete /tn "OtimizadorPC_Auto" /f >nul 2>&1
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
echo    📋 LOGS DE OTIMIZAÇÃO
echo ═══════════════════════════════════════════════════════════════════════════
echo.
if exist "%LOGDIR%\*.txt" (
    echo    Logs disponíveis em: %LOGDIR%
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
    echo    Execute uma otimização primeiro!
    echo.
    pause
)
goto MENU
