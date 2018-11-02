- bridges = context.request.path.starts_with? "/bridges" ? "active" : ""
- home = context.request.path == "/" ? "active" : ""
ul.left
  li
    a class="#{home}" href="/" Home
  li
    a class="#{bridges}" href="/bridges" Bridges