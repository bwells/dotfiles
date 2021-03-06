function fish_right_prompt
  function _k8s_context
    if type -q kubectl
      set context (kubectl config current-context 2>&1)
      if test $status -eq 0
        echo $context
      end
    end
  end

  set -l grey (set_color -o grey)

  set k8s_context (_k8s_context)
  if [ $k8s_context ]
    set k8s_context \((echo $k8s_context | sed 's/^\([^\.]*\).*/\1/')\)
  end

  echo -n -s $grey$k8s_context
end
