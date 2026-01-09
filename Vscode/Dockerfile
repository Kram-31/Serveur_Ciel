# On part de la version officielle LinuxServer (très stable)
FROM lscr.io/linuxserver/code-server:latest

# --- 1. Installation des Compilateurs et Langages ---
# build-essential = GCC, Make, G++ (pour le C/C++)
# gdb = Le débugueur (indispensable pour les étudiants)
# python3 = Le langage Python
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    python3 \
    python3-pip \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# --- 2. Installation des Extensions VS Code ---
# On installe les extensions directement au niveau système pour tout le monde

# Extension C/C++ (IntelliSense, debugging)
RUN code-server --install-extension ms-vscode.cpptools

# Extension Python
RUN code-server --install-extension ms-python.python

# Pack de Langue Française (Optionnel, retirez la ligne si vous préférez l'anglais)
RUN code-server --install-extension MS-CEINTL.vscode-language-pack-fr

# Thème visuel (Optionnel, pour faire plus joli)
RUN code-server --install-extension pkief.material-icon-theme
