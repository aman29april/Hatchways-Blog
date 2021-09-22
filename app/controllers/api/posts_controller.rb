class Api::PostsController < ApplicationController
  before_action :validate_request

  VALID_SORT_PARAMS = ['id', 'likes', 'popularity', 'reads', nil]
  ALLOWED_DIRECTION_PARAMS = [nil, 'asc', 'desc']

  def index
    return render_json({ error: @error }, :bad_request) if @error.present?

    transformer = PostSortTransformer.new(sort_by: params[:sortBy], direction: params[:direction])
    post_service = PostService.new(tags: params[:tags].split(','), transformer: transformer)
    post_service.call
    if post_service.success?
      render_json({ posts: post_service.posts })
    else
      render_json({ error: post_service.error }, :bad_request)
    end
  end

  private

  def validate_request
    return if params[:tags].blank? && @error = I18n.t('error.posts.params.tags')

    return if !VALID_SORT_PARAMS.include?(params['sortBy']) && @error = I18n.t('error.posts.params.sort')

    return if !ALLOWED_DIRECTION_PARAMS.include?(params['direction']) && @error = I18n.t('error.posts.params.direction')
  end

  def post_get_params
    params.permit(:tags, :sortBy, :direction)
  end
end
