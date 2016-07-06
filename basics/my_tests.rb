require 'minitest/autorun'
require './example'
require 'tmpdir'

class ArticleTest < Minitest::Test

  def setup
    @article = Article.new("titleexample", "bodyexample", "authorexample")
  end

  def test_initialization
    assert_equal "titleexample", @article.title
    assert_equal "bodyexample", @article.body
    assert_equal "authorexample", @article.author
    assert_in_delta Time.now, @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
  end

  def test_initialization_with_anonymous_author
    @article1 = Article.new("titleexample", "bodyexapmle")
    assert_equal "titleexapmle", @article1.title
    assert_equal "bodyexample", @article1.body
    assert_equal nil, @article1.author
    assert_in_delta Time.now, @article1.created_at
    assert_equal 0, @article1.likes
    assert_equal 0, @article1.dislikes
  end

  def test_liking
    @article.like!
    assert_equal 1, @article.likes
  end

  def test_disliking
    @article.dislike!
    assert_equal 1, @article.dislikes
  end

  def test_points
    6.times { @article.like! }
    4.times { @article.dislike! }
    assert_equal 2, @article.points
  end

  def test_long_lines
    @article1 = Article.new("titleexample", "text" * 80 + "\n" + "body" * 10)
    assert_equal ["text" * 80], @article1.long_lines
  end

  def test_truncate
    assert_equal '...', @article.truncate(3)
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal 'bodyexamp...', @article.truncate(13)
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal 'bodyexample...', @article.truncate(11)
  end

  def test_length
    assert_equal 11, @article.length
  end

  def test_votes
    6.times { @article.like! }
    2.times { @article.dislike! }
    assert_equal 8, @article.votes
  end

  def test_contain
    assert_equal true, @article.contain?('body')
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def setup
    @article = Article.new("titleexample", "bodyexample", "authorexample")
    @article1 = Article.new("titleexample1", "bodyexample1", "authorexample1")

    @directory = Directory.mktmpdir
    @articles_from_dir = ArticlesFileSystem.new(@directory)
    @articles = [@article, @article1]
  end

  def test_saving
    @articles_from_dir.save(@articles)
    assert File.exists?("#{@directory}/titleexample.article")
    assert File.exists?("#{@directory}/titleexample1.article")

    loaded_file = File.read("#{@directory}/titleexample.article")
    loaded_file1 = File.read("#{@directory}/titleexample1.article")

    assert_equal 'authorexample||0||0||bodyexample', loaded_file
    assert_equal 'authorexample1||0||0||bodyexample1', loaded_file1
  end

  def test_loading
    @articles_from_dir.save(@articles)
    loaded_articles = @articles_from_dir.load

    assert_equal "authorexample", loaded_articles[0].author
    assert_equal 0, loaded_articles[0].likes
    assert_equal 0, loaded_articles[0].dislikes
    assert_in_delta Time.now, loaded_articles[0].created_at
    assert_equal "bodyexample", loaded_articles[0].body
    assert_equal "titleexample", loaded_articles[0].title

    assert_equal "authorexample1", loaded_articles[1].author
    assert_equal 0, loaded_articles[1].likes
    assert_equal 0, loaded_articles[1].dislikes
    assert_in_delta Time.now, loaded_articles[1].created_at
    assert_equal "bodyexample1", loaded_articles[1].body
    assert_equal "titleexample1", loaded_articles[1].title
  end
end

class WebPageTest < Minitest::Test
  def setup
    @empty_article = Article.new(nil, nil)
    @article = Article.new("titleexample", "bodyexample", "authorexample")
    @articles = [@empty_article, @article]
  end

  def test_new_without_anything_to_load
    assert_nil @empty_article.title
    assert_nil @empty_article.body
    assert_nil @empty_article.author
  end

  def test_new_article
    assert @article.title
    assert @article.body
    assert @article.author
  end

  def test_longest_article
    assert_equal [@article, @empty_article], @articles.longest_articles
  end

  def test_best_articles
    assert_equal [@article, @empty_article], @articles.longest_articles
  end

  def test_best_article
    assert_equal [@article], @articles.best_article
  end

  def test_best_article_exception_when_no_articles_can_be_found
    @articles = []
    @articles.best_article
    assert_not @articles.errors.empty?
  end

  def test_worst_articles
    assert_equal [@empty_article, @article], @articles.worst_articles
  end

  def test_worst_article
    4.times { @empty_article.like! }
    assert_equal [@short_article], @articles.worst_article
  end

  def test_worst_article_exception_when_no_articles_can_be_found
    @articles = []
    @articles.worst_article
    assert_not @articles.errors.empty?
  end

  def test_most_controversial_articles
    5.times { @article.dislike! }
    4.times { @empty_article.dislike! }
    assert_equal [@article, @empty_article], @articles.most_controversial_articles
  end

  def test_votes
    assert_equal 4, @articles.votes
  end

  def test_authors
    assert_equal ["authorexample"], @articles.authors
  end

  def test_authors_statistics
    assert_equal "'authorexample' => 1", @articles.authors_statistics
  end

  def test_best_author
    assert_equal "authorexample", @articles.best_author
  end

  def test_search
    assert_equal [@article], @articles.search("example")
  end
end