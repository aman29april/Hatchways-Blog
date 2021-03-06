require 'net/http'

class PostService
  attr_reader :posts, :error

  CACHE_POLICY = 1.days

  BASE_URL = 'https://hatchways.io'
  def initialize(tags:, transformer:)
    @tags = tags
    @transformer = transformer
    validate
  end

  def validate
    fail!(I18n.t('error.posts.params.tags')) if @tags.empty?
  end

  def call
    posts = {}
    @tags.map do |tag|
      # get result from cache or api
      json = Rails.cache.fetch(tag, expires: CACHE_POLICY) do
        get_posts_of_tag(tag)
      end

      add_posts_to_result(json, posts)
    end

    @posts = @transformer.transform(posts.values)
  end

  def success?
    @error.nil?
  end

  def failed?
    !success?
  end

  private

  def add_posts_to_result(json, posts)
    json['posts'].map do |post|
      id = post['id']
      next if posts.has_key? id

      posts[id] = post
    end
  end

  # get posts for a tag using an API Call
  def get_posts_of_tag(tag)
    get_url = "#{BASE_URL}/api/assessment/blog/posts"
    params = {
      tag: tag
    }
    uri = URI.parse(get_url)
    uri.query = URI.encode_www_form(params)

    Rails.logger.info "++++Calling API+++++++ params: #{params}"
    JSON.parse(Net::HTTP.get_response(uri).body)
  rescue Exception => e
    fail!(e.message)
  end

  def fail!(error)
    @error = error
  end
end
