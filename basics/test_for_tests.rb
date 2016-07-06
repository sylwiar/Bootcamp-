require 'minitest/autorun'
require 'tmpdir'

ISSUE = (ENV["ISSUE"] || 19).to_i

class TestsTest < Minitest::Test
  def self.define_test_for_test(test_name)
    define_method "test_#{test_name}" do
      assert_failed_test test_name
    end
  end

  def self.broken_example_output
    @output ||= Dir.mktmpdir do |dir|
      `cp ./broken_example.rb #{dir}/example.rb`
      `cp ./my_tests.rb #{dir}`
      Dir.chdir(dir) { `ruby my_tests.rb` }
    end
  end

  ARTICLE_TESTS = %w(
    ArticleTest#test_initialization
    ArticleTest#test_initialization_with_anonymous_author
    ArticleTest#test_liking
    ArticleTest#test_disliking
    ArticleTest#test_points
    ArticleTest#test_long_lines
    ArticleTest#test_truncate
    ArticleTest#test_truncate_when_limit_is_longer_then_body
    ArticleTest#test_truncate_when_limit_is_same_as_body_length
    ArticleTest#test_length
    ArticleTest#test_votes
    ArticleTest#test_contain
  )

  ARTICLE_FILE_SYSTEM_TESTS = %w(
    ArticlesFileSystemTest#test_saving
    ArticlesFileSystemTest#test_loading
  )

  WEB_PAGE_TESTS = %w(
    WebPageTest#test_new_article
    WebPageTest#test_longest_articles
    WebPageTest#test_best_articles
    WebPageTest#test_best_article
    WebPageTest#test_best_article_exception_when_no_articles_can_be_found
    WebPageTest#test_worst_articles
    WebPageTest#test_worst_article
    WebPageTest#test_worst_article_exception_when_no_articles_can_be_found
    WebPageTest#test_most_controversial_articles
    WebPageTest#test_votes
    WebPageTest#test_authors
    WebPageTest#test_authors_statistics
    WebPageTest#test_best_author
    WebPageTest#test_search
  )

  ARTICLE_TESTS.each             { |t| define_test_for_test(t) } if ISSUE >= 17
  ARTICLE_FILE_SYSTEM_TESTS.each { |t| define_test_for_test(t) } if ISSUE >= 18
  WEB_PAGE_TESTS.each            { |t| define_test_for_test(t) } if ISSUE >= 19

  private

  def assert_failed_test(test, msg = nil)
    msg ||= "Please improve #{test}"
    assert self.class.broken_example_output.include?("#{test} "), msg
  end
end