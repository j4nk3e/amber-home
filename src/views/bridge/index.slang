.row
  a.button href="/bridges" = "Try again"
- bridges.each do |b|
  .row
    form method="post" action="/bridge/#{b.id}"
      == csrf_tag
      button = "#{b.name} (#{b.internalipaddress})"