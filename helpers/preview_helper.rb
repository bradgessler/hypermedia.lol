module PreviewHelper
  # A miniature of the page the card opens: the same palette, chrome and
  # furniture the article itself uses, drawn small. Pure markup and CSS, no
  # images, so a card costs nothing and can't go stale against its article.
  def preview(page)
    raw case treatment(page)
    when "form"     then form_preview
    when "spec"     then spec_preview
    when "terminal" then terminal_preview
    when "zine"     then zine_preview
    else plain_preview
    end
  end

  private
    # Six boxes struck through, and the one field that replaces them.
    def form_preview
      <<~HTML
        <span class="pv pv--form" aria-hidden="true">
          <span class="pv__boxes"><i></i><i></i><i></i><i></i><i></i><i></i>
            <span class="pv__strike"></span>
          </span>
          <span class="pv__field"><span class="pv__caret"></span></span>
        </span>
      HTML
    end

    # A standards document with a dialog floating over it.
    def spec_preview
      <<~HTML
        <span class="pv pv--spec" aria-hidden="true">
          <span class="pv__masthead"></span>
          <span class="pv__line"></span>
          <span class="pv__line pv__line--short"></span>
          <span class="pv__line"></span>
          <span class="pv__dialog"><i></i><i></i></span>
        </span>
      HTML
    end

    # A terminal window mid-deploy.
    def terminal_preview
      <<~HTML
        <span class="pv pv--terminal" aria-hidden="true">
          <span class="pv__chrome"></span>
          <span class="pv__cmd">$ rake publish<span class="pv__caret"></span></span>
          <span class="pv__out">uploading&hellip;</span>
          <span class="pv__scan"></span>
        </span>
      HTML
    end

    # A photocopied flyer, knocked askew.
    def zine_preview
      <<~HTML
        <span class="pv pv--zine" aria-hidden="true">
          <span class="pv__slab"></span>
          <span class="pv__line"></span>
          <span class="pv__line pv__line--short"></span>
        </span>
      HTML
    end

    def plain_preview
      <<~HTML
        <span class="pv pv--plain" aria-hidden="true">
          <span class="pv__block"></span>
          <span class="pv__line"></span>
          <span class="pv__line pv__line--short"></span>
        </span>
      HTML
    end
end
