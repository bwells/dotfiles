function fish_right_prompt
  function _k8s_context
    if type -q kubectl
      set context (kubectl config current-context 2>&1)
      if test $status -eq 0
        echo $context
      end
    end
  end

  function _k8s_namespace
    if type -q kubectl
      set namespace (kubectl config view --minify --output 'jsonpath={..namespace}' 2>&1)
      if test $status -eq 0 -a -n "$namespace" -a "$namespace" != "default"
        echo $namespace
      end
    end
  end

  set -l grey (set_color -o grey)
  set k8s_context (_k8s_context)
  set k8s_namespace (_k8s_namespace)

  if [ $k8s_context ]
    set k8s_context (echo $k8s_context | sed 's/^\([^\.]*\).*/\1/')
    if [ $k8s_namespace ]
      set k8s_info "($k8s_context:$k8s_namespace)"
    else
      set k8s_info "($k8s_context)"
    end
    echo -n -s $grey$k8s_info
  end
end
