function fish_prompt --description 'My custom prompt'
  set last_status $status

  set git_root (git rev-parse --show-toplevel ^/dev/null)
  if [ "$git_root" ]
    set ref (git symbolic-ref HEAD ^/dev/null)
    if [ $status -ne 0 ]
      set ref (git show-ref --head -s --abbrev | head -n1)
      segment 424242 fdd835 " \uE0A0 $ref "
    else
      set ref (echo -n $ref | sed "s#refs/heads/##")
      segment eee 1b5e20 " \uE0A0 $ref "
    end
  end

  set current_dir (prompt_pwd)
  segment bdbdbd 424242 " $current_dir "

  if [ (jobs -l | wc -l) -gt 0 ]
    segment eee ef6c00 ' %% '
  end

  if [ $last_status -ne 0 ]
    segment eee b71c1c ' ! '
  end

  segment_close

  echo
  echo '> '
end
