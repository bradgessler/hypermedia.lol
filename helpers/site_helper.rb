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
    { text: "<details> is an accordion.", note: "You wrote 200 lines for this." },
    { text: "Your carousel is one scroll-snap away.", note: "overflow-x + scroll-snap-type" },
    { text: ":has() shipped.", note: "Delete the class-toggling." },
    { text: "The back button is a feature.", note: "You broke it." },
    { text: "Forms validate themselves.", note: "required, pattern, type" },
    { text: "popover is an attribute.", note: "Not a dependency." },
    { text: "A link is a <a href>.", note: "Not an onClick." },
    { text: "This page ships 0 bytes of JavaScript.", note: "So could yours." },
  ].freeze

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
end
