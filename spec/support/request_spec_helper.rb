module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def values_from_json(field)
    json['posts'].map { |post| post[field] }
  end
end
