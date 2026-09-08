# hypermedia.lol

Short, over-the-top, well-sourced arguments for using what the browser already
does instead of rebuilding it in JavaScript. Live at [hypermedia.lol](https://hypermedia.lol).

- **Writing one?** Read [CONTRIBUTING.md](CONTRIBUTING.md) first, including the
  part about the dictator.
- **Working on it with an agent?** [AGENTS.md](AGENTS.md) is the brief.
  `CLAUDE.md` symlinks to it.
- **Rules for machines:** [/llms.txt](https://hypermedia.lol/llms.txt).

## Run it

```sh
bundle install
bundle exec sitepress server   # http://127.0.0.1:8080, live reload
bundle exec rake               # production build into ./build
```

## How it's put together

A [Sitepress](https://sitepress.cc) site. Articles are one markdown or HTML
file each in `pages/articles/`, rendered by `markdown/application_markdown.rb`
(Redcarpet + Rouge: server-side highlighting, footnotes, captioned code
figures, heading anchors). `helpers/site_helper.rb` owns treatments, bylines,
Open Graph, the wall and the modals-all-the-way-down transform;
`helpers/preview_helper.rb` draws the wall's cards. `pages/demos/` holds
pages that need their own chrome, rendered with `layouts/demo.html.erb`.

Pushing to `main` runs `.github/workflows/publish.yml`, which builds and
deploys `./build` to GitHub Pages in about thirty seconds. The custom domain
is written into the build by the Rakefile.

JavaScript on the site, in full: the six-box input the digits article argues
against (running so you can feel it break), a Copy button, a Share button, and
Plausible analytics. Each is annotated where it lives and disclosed in the
footer.
