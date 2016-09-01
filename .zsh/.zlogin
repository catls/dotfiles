# User-defined zlogin file for zsh login shells
# #
# # Typically contains external commands (biff, msgs, clear, fortune, etc.)
# # No tcsh or bash equivalent
# # Be aware that this is called for each interactive shell, including forked 
# # (non-login) shells
#
# # Examples:
# #clear
# #stty dec new cr0 -tabs
# #ttyctl -f  # freeze the terminal modes... can't change without a ttyctl -u
# #mesg y
# #uptime
# #fortune
# #log
# #from 2>/dev/null
# #msgs -fp

pwd && uptime
