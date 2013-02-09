Noted.helpers do
  def to_html(str)
    str = RDiscount.new(str)
    str.to_html
  end
end