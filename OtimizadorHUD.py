import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import threading
import os
import time
import math
from datetime import datetime
import random

class HUDOtimizador:
    def __init__(self, root):
        self.root = root
        self.root.title("🚀 CABINE HOLOGRÁFICA - OTIMIZADOR v3.0")
        self.root.geometry("1200x800")
        self.root.configure(bg='black')
        self.root.resizable(False, False)
        
        self.log_file = "C:\\otimizar_log.txt"
        self.otimizando = False
        
        self.canvas = tk.Canvas(self.root, bg='black', highlightthickness=0)
        self.canvas.pack(fill=tk.BOTH, expand=True)
        
        self.create_hud()
        self.animate_hud()
    
    def create_hud(self):
        # Fundo estrelado
        for i in range(100):
            x, y = random.randint(0, 1200), random.randint(0, 800)
            self.canvas.create_oval(x, y, x+2, y+2, fill='white', outline='', tags='stars')
        
        # Moldura holográfica
        self.canvas.create_rectangle(20, 20, 1180, 780, outline='#00ff88', width=3, tags='frame')
        
        # Título holográfico piscante
        self.title_text = self.canvas.create_text(600, 60, text="OTIMIZADOR TOTAL PC - CABINE v3.0", 
                                                 fill='#00ff88', font=('Courier', 24, 'bold'), tags='title')
        
        # Status central (scanner)
        self.status_text = self.canvas.create_text(600, 200, text="🛰️  SISTEMA PRONTO  🛰️", 
                                                  fill='#ffaa00', font=('Courier', 28, 'bold'), tags='status')
        
        # Botões holográficos
        btn_y = 300
        self.btn_otimizar = self.canvas.create_text(300, btn_y, text="🔥 OTIMIZAR AGORA", 
                                                   fill='#ff4444', font=('Courier', 18, 'bold'), tags='btn')
        self.canvas.tag_bind(self.btn_otimizar, '<Button-1>', lambda e: self.otimizar_agora())
        
        self.btn_agendar = self.canvas.create_text(600, btn_y, text="⏰ AGENDAR 5MIN", 
                                                  fill='#44ff44', font=('Courier', 18, 'bold'), tags='btn')
        self.canvas.tag_bind(self.btn_agendar, '<Button-1>', lambda e: self.agendar_5min())
        
        self.btn_reverter = self.canvas.create_text(900, btn_y, text="↩️ REVERTER", 
                                                   fill='#ffaa00', font=('Courier', 18, 'bold'), tags='btn')
        self.canvas.tag_bind(self.btn_reverter, '<Button-1>', lambda e: self.reverter())
        
        # Barra de progresso circular
        self.progress_arc = self.canvas.create_arc(550, 450, 650, 550, start=0, extent=0, 
                                                  outline='#00ff88', width=8, tags='progress')
        
        # Log holográfico
        self.log_lines = []
        for i in range(10):
            self.canvas.create_text(50, 580 + i*25, text="SCAN COMPLETO...", 
                                   fill='#00ccff', font=('Courier', 12), anchor='w', tags='log')
    
    def animate_hud(self):
        # Animação estrelas
        stars = self.canvas.find_withtag('stars')
        for star in stars:
            x1, y1, x2, y2 = self.canvas.coords(star)
            self.canvas.move(star, random.randint(-1,1), random.randint(-1,1))
            if x1 < 0 or x1 > 1200: self.canvas.coords(star, random.randint(0,1200), random.randint(0,800))
        
        # Título piscante
        glow = 255 - int(100 * abs(math.sin(time.time() * 4)))
        color = f'#{glow:02x}ff88'
        self.canvas.itemconfig(self.status_text, fill=color)
        
        # Partículas de energia
        if random.randint(1, 20) == 1:
            x, y = random.randint(200,1000), random.randint(300,500)
            part = self.canvas.create_oval(x, y, x+4, y+4, fill='#00ff88', outline='', tags='particle')
            self.canvas.after(1000, lambda: self.canvas.delete(part))
        
        self.root.after(50, self.animate_hud)
    
    def log(self, msg):
        timestamp = datetime.now().strftime("%H:%M:%S")
        full_msg = f"[{timestamp}] {msg}"
        self.log_lines.append(full_msg)
        if len(self.log_lines) > 10:
            self.log_lines.pop(0)
        
        for i, line in enumerate(self.log_lines):
            color = '#00ff88' if 'OK' in line else '#ffaa00'
            self.canvas.itemconfig(f'log{i}', text=line, fill=color)
    
    def run_cmd(self, cmd):
        try:
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=30)
            return result.returncode == 0
        except:
            return False
    
    def otimizar_agora(self):
        if self.otimizando: return
        self.otimizando = True
        
        def run():
            self.canvas.itemconfig(self.status_text, text="🚀 OTIMIZAÇÃO INICIADA...")
            cmds = [
                "🧹 cleanmgr /sagerun:1",
                "🗑️ del /q /f /s %TEMP%\\*",
                "🔧 sfc /scannow /quiet",
                "🛠️ dism /online /cleanup-image /restorehealth /quiet",
                "💾 powercfg -h off",
                "⚡ bcdedit /set useplatformtick yes",
                "🎮 sc config SysMain start=disabled && sc stop SysMain",
                "🚀 powercfg -setactive SCHEME_MIN",
                "🌐 ipconfig /flushdns",
                "🧠 fsutil behavior set memoryusage 2"
            ]
            
            for i, (desc, cmd) in enumerate(cmds):
                self.canvas.itemconfig(self.status_text, text=desc)
                self.log(f"Executando: {cmd}")
                success = self.run_cmd(cmd)
                self.canvas.itemconfig('progress', extent=(i+1)*36)
                
            self.canvas.itemconfig(self.status_text, text="✅ OTIMIZAÇÃO CONCLUÍDA!")
            self.log("✅ SISTEMA OTIMIZADO!")
            self.otimizando = False
            
        threading.Thread(target=run, daemon=True).start()
    
    def agendar_5min(self):
        cmd = 'schtasks /create /tn "HUDOtimizador" /tr "python OtimizadorHUD.py" /sc minute /mo 5 /ru SYSTEM /rl HIGHEST /f'
        if self.run_cmd(cmd):
            self.log("⏰ Tarefa agendada: 5 minutos!")
            self.canvas.itemconfig(self.status_text, text="⏰ AGENDADO!")
        else:
            self.log("❌ Execute como Admin")
    
    def reverter(self):
        revert_cmds = ["powercfg -h on", "bcdedit /deletevalue useplatformtick", 
                      "sc config SysMain start=auto"]
        for cmd in revert_cmds:
            self.run_cmd(cmd)
        self.log("↩️ Configurações revertidas")
        self.canvas.itemconfig(self.status_text, text="↩️ REVERTIDO!")

if __name__ == "__main__":
    root = tk.Tk()
    app = HUDOtimizador(root)
    root.mainloop()
