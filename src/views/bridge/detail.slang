- lights = bridge.request_lights
- b = bridge
- sce = scenes
- rooms.each do |id, g|
  .col.s12.m6.l4
    - has_active = g.lights.map { |id| lights[id] }.any?(&.state.reachable)
    ul.collection.with-header
      li.collection-header
        - if has_active
          - sce.to_a.select { |id, s| s.lights.to_set.intersects? g.lights.to_set }.each do |id, s|
            a href="/bridge/#{b.id}/scene/#{id}"
              - if g.action.scene == id
                span.badge.new data-badge-caption="" = s.name
              - else
                span.badge = s.name
        - color = has_active ? "" : "grey-text"
        h5 class=color = g.name
      - g.lights.sort_by { |lid| lights[lid].name }.each do |lid|
        - l = lights[lid]
        - lc = l.state.reachable ? "" : "grey-text"
        li class="collection-item #{lc}" = l.name
          - if l.state.reachable
            - color = l.state.on ? "" : "grey-text"
            a class="secondary-content #{color}" href="/bridge/#{b.id}/light/#{lid}/toggle"
              i.material-icons.right = l.state.on ? "toggle_on" : "toggle_off"
            - if bri = l.state.bri
              .progress
                .determinate.grey.darken-3 style="width:#{bri/2.55}%"
