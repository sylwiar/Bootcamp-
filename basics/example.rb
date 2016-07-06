class Article 
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

  def initialize(title, body, author = nil)
    @title = title
    @body = body
    @author = author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    self.likes += 1
  end

  def dislike!
    self.dislikes += 1
  end

  def points
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def long_lines
    body.lines.select { |line| line.length > 80}
  end

  def length
    body.length
  end

  def truncate(limit)
    if body.length > limit
      body.slice(0, limit - 3) + "..."
    else
      body
    end
  end

  def contain?(a)
    if body[a]
      return true
    else 
      false
    end
  end
end

class ArticlesFileSystem
  attr_reader :directory

  def initialize(directory)
    @directory = directory
  end

  def save(articles)
    articles.each do |article|
      file_name = article.title.downcase.gsub(' ', '_') + '.article'
      file_body = [article.author, article.likes, article.dislikes, article.body].join('||')
      path = @directory + '/' + file_name
      File.open(path, "w+") { |f| f.write(file_body) }
    end
  end
end