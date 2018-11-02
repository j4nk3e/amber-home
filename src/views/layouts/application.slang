doctype html
html
  head
    title Home using Amber
    meta charset="utf-8"
    meta http-equiv="X-UA-Compatible" content="IE=edge"
    meta name="viewport" content="width=device-width, initial-scale=1"
    link rel="stylesheet" href="/dist/main.bundle.css"
    link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"
    link rel="apple-touch-icon" href="/favicon.png"
    link rel="icon" href="/favicon.png"
    link rel="icon" type="image/x-icon" href="/favicon.ico"

  body
    nav.nav
      .nav-wrapper
        == render(partial: "layouts/_nav.slang")
    .container
      .row
        .col-sm
          - flash.each do |key, value|
            div class="alert alert-warning alert-#{key}"
              p = flash[key]
      .row
        .col-sm-12.main
          == content

    script src="/dist/main.bundle.js"
    script src="/dist/materialize.min.js"

    - if Amber.settings.auto_reload?
      script src="/js/client_reload.js"
