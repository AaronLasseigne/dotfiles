function fish_prompt --description 'My custom prompt'
  set last_status $status

  # in a git directory
  if [ (git rev-parse --show-toplevel 2> /dev/null) ]
    set dirty_flag;
    if [ (git status --porcelain | head -n1) ]
      set dirty_flag '+ '
    end

    set ref (git symbolic-ref HEAD 2> /dev/null)
    if [ $status -ne 0 ]
      # print ref info
      set ref (git show-ref --head -s --abbrev | head -n1)
      segment 282828 d79921 " \uE0A0 $ref $dirty_flag"
    else
      # print branch info
      set ref (git branch --show-current)
      segment 282828 98971a " \uE0A0 $ref $dirty_flag"
    end
  end

  # current directory
  set current_dir (prompt_pwd)
  segment fbf1c7 504945 " $current_dir "

  # background jobs
  if [ (jobs -l | wc -l) -gt 0 ]
    segment fbf1c7 d65d0e ' %% '
  end

  # failed exit
  if [ $last_status -ne 0 ]
    segment fbf1c7 cc241d ' ! '
  end

  segment_close

  echo
  echo '➜ '
end
