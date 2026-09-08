require "date"

module SiteHelper
  SITE_URL = "https://hypermedia.lol"
  SITE_NAME = "hypermedia.lol"
  SITE_DESCRIPTION = "The browser already does that. Short arguments for HTML and CSS over the JavaScript we keep reaching for first."

  # Open Graph Plus screenshots each page and serves the image from this host,
  # mirroring the site's own paths. See https://opengraphplus.com.
  OG_IMAGE_HOST = "https://qwaj1e37.ogplus.net"

  # Short tiles that fill the gaps in the wall. Each is a claim you should be
  # able to check yourself in about thirty seconds.
  APHORISMS = [
    { text: "&lt;details&gt; is an accordion.", note: "You wrote 200 lines for this.", accent: "mint", sprite: "cursor" },
    { text: "Your carousel is one scroll-snap away.", note: "overflow-x + scroll-snap-type", accent: "sky", sprite: "cursor" },
    { text: ":has() shipped.", note: "Delete the class-toggling.", accent: "amber", sprite: "brick" },
    { text: "The back button is a feature.", note: "You broke it.", accent: "hot", sprite: "cursor" },
    { text: "Forms validate themselves.", note: "required, pattern, type", accent: "acid", sprite: "key" },
    { text: "popover is an attribute.", note: "Not a dependency.", accent: "magenta", sprite: "dialog" },
    { text: "A link is a &lt;a href&gt;.", note: "Not an onClick.", accent: "mint", sprite: "cursor" },
    { text: "This page ships 0 bytes of JavaScript.", note: "So could yours.", accent: "sky", sprite: "floppy" },
  ].freeze


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

  def sprite_name(page = current_page)
    page.data.fetch("sprite", "brick")
  end

  def aphorisms
    APHORISMS
  end

  def articles
    site
      .glob("articles/*.html.*")
      .select { |page| page.data["date"] }
      .sort_by { |page| Date.parse page.data.fetch("date") }
      .reverse
  end

  # Interleaves essays and one-liners so the wall reads as a mix rather than
  # two stacked lists. Essays keep their order; aphorisms fill in around them.
  def wall
    essays = articles.map { |page| [:essay, page] }
    lines = aphorisms.map { |line| [:aphorism, line] }
    tiles = []
    until essays.empty? && lines.empty?
      tiles << essays.shift unless essays.empty?
      tiles << lines.shift unless lines.empty?
      tiles << lines.shift unless lines.empty?
    end
    tiles
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

  def canonical_url(page = current_page)
    URI.join(SITE_URL, page.request_path).to_s
  end

  def og_image_url(page = current_page)
    URI.join(OG_IMAGE_HOST, page.request_path).to_s
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

  def home?(page = current_page)
    page.request_path == "/"
  end
end
