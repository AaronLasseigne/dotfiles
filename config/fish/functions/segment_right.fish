function segment_right -a fg bg text -d "Add right prompt segment"
    set -l right_color $segment_right_color

    if test -z "$right_color"
        set right_color $bg
    end

    set -g segment_right_color $fg

    echo (set_color $bg)(set_color $segment_right_color -b $bg)"$text"(set_color $right_color)
end
