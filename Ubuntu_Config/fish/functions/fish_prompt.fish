function fish_prompt
	if contains "no git" (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
		printf '%s[ %s@%s  %s%s : %s%s ]%s $ ' (set_color red --bold) (whoami) (hostname|cut -d . -f 1) (set_color cyan) (prompt_pwd) (set_color red --bold) (date +%T) (set_color normal)
	else
		printf '%s[ %s@%s %s%s : %s%s ] %s( %s %s)%s $ ' (set_color red --bold) (whoami) (hostname|cut -d . -f 1) (set_color cyan) (prompt_pwd) (set_color red --bold) (date +%T) (set_color white) (parse_git_branch) (set_color white --bold) (set_color normal)
	end
end
