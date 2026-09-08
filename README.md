# hypermedia.lol

A [Sitepress](https://sitepress.cc) static site published to GitHub Pages at
[hypermedia.lol](https://hypermedia.lol).

## Development

```sh
bundle install
bundle exec sitepress server
```

## Build

```sh
bundle exec rake   # cleans and compiles into ./build
```

## Deploy

Pushing to `main` runs `.github/workflows/publish.yml`, which compiles the site
and deploys `./build` to GitHub Pages. The custom domain is pinned by
`pages/CNAME`, which compiles to `build/CNAME`.
