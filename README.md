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

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Articles are one file in `pages/articles/`,
markdown or HTML, and the house rule is HTML and CSS only — no JavaScript.

## Deploy

Pushing to `main` runs `.github/workflows/publish.yml`, which compiles the site
and deploys `./build` to GitHub Pages. The custom domain is pinned by
`pages/CNAME`, which compiles to `build/CNAME`.
