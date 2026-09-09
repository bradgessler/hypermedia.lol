require "date"

module SiteHelper
  SITE_URL = "https://hypermedia.lol"
  SITE_NAME = "hypermedia.lol"
  SITE_DESCRIPTION = "The browser already does that. Short arguments for HTML and CSS over the JavaScript we keep reaching for first."

  # Open Graph Plus screenshots each page and serves the image from this host,
  # mirroring the site's own paths. See https://opengraphplus.com.
  OG_IMAGE_HOST = "https://qwaj1e37.ogplus.net"

  # Every accent is dark-text-safe against the ink, so a contributor picking a
  # colour can't accidentally ship something unreadable.
  ACCENTS = {
    "acid"    => "#d7f205",
    "magenta" => "#ff2d95",
    "sky"     => "#4cc9ff",
    "amber"   => "#ffb400",
    "mint"    => "#00e08a",
    "hot"     => "#ff3b1f",
  }.freeze

  DEFAULT_ACCENT = "acid"

  def accent(page = current_page)
    ACCENTS.fetch(page.data.fetch("accent", DEFAULT_ACCENT), ACCENTS.fetch(DEFAULT_ACCENT))
  end

  # A treatment is a whole visual world: colour, chrome, headline handling and
  # decoration. Prose face, size and measure are deliberately NOT part of it;
  # every treatment inherits the same reading settings so variety never costs
  # legibility.
  TREATMENTS = %w[plain spec terminal zine form launch default modalz stage].freeze

  # The colour each treatment leads with, so a tile on the wall previews the
  # page it opens.
  TREATMENT_ACCENTS = {
    "spec"     => "#1a4ed8",
    "terminal" => "#ffb000",
    "zine"     => "#d61f1f",
    "form"     => "#c0392b",
    "launch"   => "#ffb300",
    "default"  => "#0000ee",
    "modalz"   => "#000080",
    "stage"    => "#8b1a1a",
  }.freeze

  def tile_accent(page)
    TREATMENT_ACCENTS.fetch(treatment(page)) { accent(page) }
  end

  def treatment(page = current_page)
    name = page.data.fetch("treatment", "plain")
    TREATMENTS.include?(name) ? name : "plain"
  end

  def sprite_name(page = current_page)
    page.data.fetch("sprite", "brick")
  end

  def articles
    site
      .glob("articles/*.html.*")
      .select { |page| page.data["date"] }
      .sort_by { |page| Date.parse page.data.fetch("date") }
      .reverse
  end

  def date(value)
    Date.parse(value).strftime("%B %-d, %Y")
  end

  def page_title(page = current_page)
    page.data.fetch("title", SITE_NAME)
  end

  def page_description(page = current_page)
    page.data.fetch("description", SITE_DESCRIPTION)
  end

  # GitHub Pages serves these as directories and 301s the slashless form, so
  # emitting the slash ourselves saves every internal click and every shared
  # link a redirect, and keeps canonical pointing at the address that answers.
  def path_for(page = current_page)
    path = page.request_path
    path.end_with?("/") ? path : "#{path}/"
  end

  def canonical_url(page = current_page)
    URI.join(SITE_URL, path_for(page)).to_s
  end

  # Open Graph Plus currently fails to render any path below the root; nested
  # paths return 404/503 while the root screenshots fine, reproduced on
  # sitepress.cc as well as here. Until that's fixed every page shares the
  # homepage card, which renders, rather than a per-page card that doesn't.
  # Flip this to false to go back to per-page images.
  OG_IMAGE_ROOT_ONLY = true

  # A page can ship its own card by setting `og_image:` in front matter to a
  # path under pages/ (e.g. /images/og/one-textbox.png). Otherwise the card
  # comes from Open Graph Plus.
  def og_image_url(page = current_page)
    if (own = page.data["og_image"])
      return URI.join(SITE_URL, own).to_s
    end
    path = OG_IMAGE_ROOT_ONLY ? "/" : path_for(page)
    URI.join(OG_IMAGE_HOST, path).to_s
  end

  def article?(page = current_page)
    page.request_path.start_with? "/articles/"
  end

  def previous_article(page = current_page)
    i = articles.index(page)
    articles[i - 1] if i&.positive?
  end

  def next_article(page = current_page)
    i = articles.index(page)
    articles[i + 1] if i
  end

  # The site mark: a small box floated at the top right of the viewport.
  def site_mark
    raw <<~HTML
      <a class="mark" href="/" aria-label="hypermedia.lol, back to the collection">hypermedia.lol</a>
    HTML
  end

  # For the modalz treatment: every section of the rendered article becomes
  # its own modal, each in a different vintage, all the way down. OK scrolls
  # to the next one and Cancel goes back to the top. No script.
  MODAL_VINTAGES = %w[win95 macos9 winxp aqua bootstrap material ios cookie].freeze

  def modalize(html)
    html = html.to_s
    notes = ""
    if (i = html.index('<div class="footnotes">'))
      notes = html[i..]
      html = html[0...i]
    end
    chunks = html.split(/(?=<h2 id=)/)
    sections = chunks.each_with_index.map do |chunk, n|
      heading = chunk[/\A<h2 id="([^"]+)">.*?<\/h2>/m]
      id = $1 || "top"
      body = heading ? chunk.sub(heading, "") : chunk
      next_id = chunks[n + 1] && chunks[n + 1][/\A<h2 id="([^"]+)"/, 1]
      vintage = MODAL_VINTAGES[n % MODAL_VINTAGES.length]
      title_bar = heading || %(<h2 id="top" class="modal__untitled">#{page_title}</h2>)
      ok = next_id ? %(<a class="modal__btn modal__btn--ok" href="##{next_id}">OK</a>) : %(<a class="modal__btn modal__btn--ok" href="/">OK</a>)
      <<~HTML
        <section class="modal modal--#{vintage}" style="--n: #{n}">
          <div class="modal__bar">
            #{title_bar}
            <span class="modal__controls" aria-hidden="true"><i></i><i></i><i></i></span>
          </div>
          <div class="modal__body">#{body}</div>
          <div class="modal__buttons">
            <a class="modal__btn" href="#top">Cancel</a>
            #{ok}
          </div>
        </section>
      HTML
    end
    raw(sections.join + notes)
  end

  def home?(page = current_page)
    page.request_path == "/"
  end
end
