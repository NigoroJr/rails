module ApplicationHelper
  def get_title
    website_title = "NigoroJr"

    website_title = @page_title + " - " + website_title if @page_title

    return website_title
  end

  def get_login_status
    name = sprintf "%s (%s)", @logged_in_as.screen, @logged_in_as.username
  end

  def convert_to_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {
      fenced_code_blocks: true,
      tables: true,
      strikethrough: true,
      autolink: true,
    })
    return markdown.render(text);
  end

  def get_about_on(user)
    article = Article.where(category: ArticlesController::CATEGORY_ABOUT, posted_by: user.username)
    if session[:language].present?
      article = article.where(language: session[:language])
    end

    return article.first
  end
end
