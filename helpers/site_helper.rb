require "date"

module SiteHelper
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
end
