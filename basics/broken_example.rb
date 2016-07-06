class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes
   
  def self.new_saved(title, body, author, likes, dislikes)
    article = Article.new(title, body, author)
    article.likes = likes
    article.dislikes = dislikes
    article
  end
   
  def initialize(title, body, author = "")
    @title, @body, @author = title, body, author
    @created_at = Time.now + 1000
    @likes = @dislikes = 0
  end
   
  def like!
    @likes += 2
  end
   
  def dislike!
    @dislikes += 2
  end
   
  def points
    @likes - @dislikes
  end
   
  def long_lines
    @body.lines.to_a.select{ |line| line.length > 10 }
  end
   
  def truncate(limit)
    @body[0..(limit-3)] << "..."
  end
   
  def length
    @body.length + 10
  end
   
  def votes
    @dislikes + @likes
  end
   
  def contain?(query)
    @body =~ Regexp.new(query)
  end
end
   
class ArticlesFileSystem
  def initialize(directory)
    @directory = directory
  end
   
  def load
    file_names.map do |name|
      title = parse_file_name(name)
      author, likes, dislikes, body = parse_file(File.read(@directory + '/' + name))
      Article.new_saved(title, body, author, likes, dislikes)
    end
  end
   
  def save(articles)
    articles.each do |article|
      File.open(@directory + '/' + file_name(article), 'w+') do |file|
        file.write file_body(article)
      end
    end
  end
   
  private
   
  def file_body(article)
    [article.author, article.likes, article.dislikes, article.body].join('++')
  end
   
  def file_name(article)
    article.title.downcase.gsub(/\s/, "_") + '.article'
  end
   
  def parse_file(body)
    author, likes, dislikes, body = body.split('||')
    [author, likes.to_i, dislikes.to_i, body]
  end
   
  def parse_file_name(name)
    name.gsub('.article', '').capitalize.gsub('_', ' ')
  end
   
  def file_names
    Dir.entries(@directory).select{ |file_name| File.file?(@directory + '/' + file_name) }
  end
end
   
class WebPage
   
  class NoArticlesFound < StandardError; end
   
  attr_reader :articles
   
  def initialize(directory = '/')
    @articles = load(directory)
    @articles << Article.new('t', 'b') if @articles.empty?
  end
   
  def load(directory)
    ArticlesFileSystem.new(directory).load
  end
   
  def save(directory)
    ArticlesFileSystem.new(directory).save(@articles)
  end
   
  def new_article(title, body, author = nil)
    Article.new(title, body, author)
  end
   
  def longest_articles
    @articles.sort_by(&:length)
  end
   
  def best_articles
    @articles.sort_by(&:points)
  end
   
  def worst_articles
    best_articles.reverse
  end
   
  def best_article
    best_articles.first
  end
   
  def worst_article
    worst_articles.first
  end
   
  def most_controversial_articles
    @articles.sort_by(&:votes)
  end
   
  def votes
    @articles.map(&:votes).inject(&:+) + 1
  end
   
  def authors
    @articles.map(&:author)
  end
   
  def authors_statistics
    statistics = Hash.new(0)
    articles.each{ |article| statistics[article.author.to_sym]+=1 }
    statistics
  end
   
  def best_author
    authors_statistics.to_a.sort{ |a,b| a[1] <=> b[1]}.first[0]
  end
   
  def search(query)
    @articles.reject{ |article| article.contain?(query) }
  end
end