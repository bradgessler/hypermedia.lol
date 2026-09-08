require "redcarpet"
require "rouge"

# Renders every .md page. Fenced code blocks are highlighted on the server by
# Rouge, so the reader gets coloured code with zero client-side work.
class ApplicationMarkdown < MarkdownRails::Renderer::Rails
  include MarkdownRails::Helper::Rouge

  # Class-based output so the theme lives in the stylesheet and can follow
  # each page's treatment, rather than inline styles baked into the HTML.
  def rouge_formatter
    ::Rouge::Formatters::HTML.new
  end

  # Redcarpet only treats a fence as a fence when its info string is a single
  # token, so captions live in markup: wrap the fence in a <figure> with a
  # <figcaption>, separated by blank lines so the fence is still processed.
  def block_code(code, language)
    language = language.to_s.strip
    language = nil if language.empty?
    content_tag :pre, class: "highlight" do
      content_tag :code, raw(highlight_code(code, language)), class: language && "language-#{language}"
    end
  end

  # A paragraph beginning "Caption:" directly after a code block becomes its
  # <figcaption>, and the pair is wrapped in a <figure>. This runs on the
  # rendered HTML because Redcarpet passes a <figure> written in markdown
  # through raw, fence and all, so it can't be authored inline.
  def postprocess(html)
    html.gsub(%r{(<pre class="highlight">.*?</pre>)\s*<p>Caption:\s*(.*?)</p>}m) do
      %(<figure class="step step--code">#{$1}<figcaption>#{$2}</figcaption></figure>)
    end
  end

  # Every heading gets a stable id from its text and links to itself, so any
  # section can be deep-linked and the heading is the handle you copy.
  def header(text, level)
    plain = text.gsub(/<[^>]+>/, "")
    slug = plain.gsub(/&#?[a-z0-9]+;/i, "").downcase.gsub(/[^a-z0-9\s-]/, "").strip.gsub(/\s+/, "-")
    %(<h#{level} id="#{slug}"><a class="anchor" href="##{slug}">#{text}</a></h#{level}>)
  end

  def enable
    [:fenced_code_blocks, :tables, :no_intra_emphasis, :footnotes]
  end
end
