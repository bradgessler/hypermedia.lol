# Route .md and .markdown templates through ApplicationMarkdown.
MarkdownRails.handle :md, :markdown do
  ApplicationMarkdown.new
end
