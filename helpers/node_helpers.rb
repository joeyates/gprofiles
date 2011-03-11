module NodeHelpers

  def render
    parent = @parent ? @parent.link_to : ''
    kids = @children.collect do | child |
      child.link_to
    end
    <<EOT
#{ parent }<br />
|<br />
v<br />
<h3>#{ info }</h3>
|<br />
v<br />
#{ kids.join( "&nbsp;") }<br />
EOT
  end

  def link_to
    "<a href='/#{ @nid }'>#{ info }</a>"
  end

end
