function b
	if set -q argv[1]
		for x in (seq $argv[1])
			builtin cd ..
		end
	else
		builtin cd ..
	end
	ls
end
