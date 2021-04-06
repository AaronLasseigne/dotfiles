function segment -a fg bg text -d "Add prompt segment"
    if test -z "$segment_color"
        set segment_color normal
    end

    set -g segment (set_color $fg -b $bg)"$text"(set_color $bg -b $segment_color)"$segment"
    set -g segment_color $bg
end
