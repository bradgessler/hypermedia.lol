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
    when "launch"   then launch_preview
    when "default"  then default_preview
    when "modalz"   then modalz_preview
    when "slope"    then slope_preview
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

    # A launch console: hazard stripes, six keys, one red lamp.
    def launch_preview
      <<~HTML
        <span class="pv pv--launch" aria-hidden="true">
          <span class="pv__hazard"></span>
          <span class="pv__keys"><i></i><i></i><i></i><i></i><i></i><i></i></span>
          <span class="pv__lamp"></span>
        </span>
      HTML
    end

    # The browser's default stylesheet, with a marker taken to it.
    def default_preview
      <<~HTML
        <span class="pv pv--default" aria-hidden="true">
          <span class="pv__h">Motherfucking Website</span>
          <span class="pv__p"></span><span class="pv__p pv__p--short"></span>
          <span class="pv__link"></span>
          <span class="pv__scrawl"></span>
        </span>
      HTML
    end

    # Modals all the way down: three stacked dialogs of different vintages.
    def modalz_preview
      <<~HTML
        <span class="pv pv--modalz" aria-hidden="true">
          <span class="pv__win pv__win--1"><i></i></span>
          <span class="pv__win pv__win--2"><i></i></span>
          <span class="pv__win pv__win--3"><i></i><b></b></span>
        </span>
      HTML
    end

    # A ski hill: trees, the ball, and the thing waiting at the bottom.
    def slope_preview
      <<~HTML
        <span class="pv pv--slope" aria-hidden="true">
          <span class="pv__bar"></span>
          <span class="pv__tree pv__tree--1"></span>
          <span class="pv__tree pv__tree--2"></span>
          <span class="pv__tree pv__tree--3"></span>
          <span class="pv__ball"></span>
          <span class="pv__yeti"></span>
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
