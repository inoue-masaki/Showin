module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Lantern Lantern" # 自分のアプリ名
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end