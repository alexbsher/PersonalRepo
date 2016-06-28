function cd
  if set -q argv[1]
    builtin cd "$argv"
  else
    builtin cd ~
  end
  ls
end
