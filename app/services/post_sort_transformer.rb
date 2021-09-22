class PostSortTransformer
  def initialize(sort_by:, direction:)
    # default sort by 'id' and direction is asc
    @sort_by = sort_by || 'id'
    @is_desc = direction == 'desc'
  end

  def transform(data)
    sort(data)
  end

  private

  def sort(data)
    response = data.sort_by { |post| post[@sort_by] }
    @is_desc ? response.reverse : response
  end
end
