require "date"

module SiteHelper
  SITE_URL = "https://hypermedia.lol"
  SITE_NAME = "hypermedia.lol"
  SITE_DESCRIPTION = "The browser already does that. Short arguments for HTML and CSS over the JavaScript we keep reaching for first."

  # Open Graph Plus screenshots each page and serves the image from this host,
  # mirroring the site's own paths. See https://opengraphplus.com.
  OG_IMAGE_HOST = "https://qwaj1e37.ogplus.net"

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
