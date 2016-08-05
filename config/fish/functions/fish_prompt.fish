function fish_prompt --description 'My custom prompt'
  set last_status $status

  # in a git directory
  if [ (git rev-parse --show-toplevel ^/dev/null) ]
    set dirty_flag;
    if [ (git status --porcelain | head -n1) ]
      set dirty_flag '+ '
    end

    set ref (git symbolic-ref HEAD ^/dev/null)
    if [ $status -ne 0 ]
      # print ref info
      set ref (git show-ref --head -s --abbrev | head -n1)
      segment 424242 fdd835 " \uE0A0 $ref $dirty_flag"
    else
      # print branch info
      set ref (echo -n $ref | sed "s#refs/heads/##")
      segment eee 1b5e20 " \uE0A0 $ref $dirty_flag"
    end
  end

  # current directory
  set current_dir (prompt_pwd)
  segment bdbdbd 424242 " $current_dir "

  # background jobs
  if [ (jobs -l | wc -l) -gt 0 ]
    segment eee ef6c00 ' %% '
  end

  # failed exit
  if [ $last_status -ne 0 ]
    segment eee b71c1c ' ! '
  end

  segment_close

  echo
  echo '> '
end
