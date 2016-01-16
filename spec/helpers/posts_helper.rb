def tags_to_s tags
  string = ""
  tags.each do |tag|
    string += tag.content
    string += ";" unless tags.last == tag
  end
  string
end
