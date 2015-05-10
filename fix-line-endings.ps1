<#
 # On Windows systems (when necessary) convert all Vim files
 # from Unix to DOS format in this and all child directories.
 #
 # Do this before linking or copying `vimrc.vim` to the home
 # directory in order to ensure it is correct first.
 #
 # dos2unix options used:
 #  -k  keepdate (don't change file's datestamp)
 #  -o  oldfile (simply overwrite)
 #>

Get-ChildItem -Recurse |
    Where-Object { $_.psIsContainer -eq $False } |
    ForEach-Object -Process { unix2dos -k -o $_.FullName }