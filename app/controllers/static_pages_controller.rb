class StaticPagesController < ApplicationController
  def terms
    @content_html = render_markdown("terms.md")
  end

  def privacy
    @content_html = render_markdown("privacy.md")
  end

  private

  def render_markdown(filename)
    markdown_path = Rails.root.join("app/assets/content", filename)
    markdown = File.read(markdown_path)
    markdown_renderer.render(markdown).html_safe
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(with_toc_data: true),
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    )
  end
end
